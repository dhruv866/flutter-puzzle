import 'package:flutter/material.dart';
import 'package:puzzle_game/ui/animations.dart';
import 'package:puzzle_game/ui/design.dart';

import 'login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1D1A1A),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: boldTextStyle(36),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      navfadeAnimation(
                        LoginScreen(),
                      ),
                    );
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
                      child: Icon(Icons.arrow_forward_rounded , color: offwhite, size: 40,)
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
