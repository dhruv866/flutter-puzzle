import 'package:flutter/material.dart';
import 'package:puzzle_game/functioning/login.dart';
import 'package:puzzle_game/screens/home_screen.dart';
import 'package:puzzle_game/ui/animations.dart';
import 'package:puzzle_game/ui/design.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1D1A1A),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalSpace(50),
              Center(
                child: Container(
                  width: size.width * 0.75,
                  height: 350,
                  child: RiveAnimation.asset(
                    'assets/animations/onboarding.riv',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              verticalSpace(150),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: TextField(
                      controller: controller,
                      textCapitalization: TextCapitalization.words,
                      style: boldTextStyle(20),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                        hintStyle: boldTextStyle(16)
                            .copyWith(color: offwhite.withOpacity(0.5)),
                        disabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.5)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.5)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(40),
                  GestureDetector(
                    onTap: () {
                      if (controller.text.isNotEmpty) {
                        set_login_data(true, controller.text);
                        Navigator.of(context).push(
                          navslideAnimation(
                            HomeScreen(
                              name: controller.text,
                            ),
                          ),
                        );
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Enter Your Name' , style: boldTextStyle(16),),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 120,
                      decoration: BoxDecoration(
                        color: mainblue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          containerboxshadow(),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Let\'s Go',
                          style: regularTextStyle(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
