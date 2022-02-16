import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_game/controllers/custom_game_state.dart';
import 'package:puzzle_game/controllers/game_elements_state.dart';
import 'package:puzzle_game/controllers/game_state.dart';
import 'package:puzzle_game/controllers/home_state.dart';
import 'package:puzzle_game/functioning/image_cache.dart';
import 'package:puzzle_game/screens/home_screen.dart';
import 'package:puzzle_game/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeState(),
        ),
        ChangeNotifierProvider(
          create: (_) => GameState(),
        ),
        ChangeNotifierProvider(
          create: (_) => GameElementsState(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomGameState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? islogin;
  String? name;

  @override
  void initState() {
    get_data();
    cacheLocalImage(context);
    super.initState();
  }

  Future get_data() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('islogin')) {
        setState(() {
          islogin = prefs.getBool('islogin');
          name = prefs.getString('name');
        });
      } else {
        setState(() {
          islogin = null;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: islogin == null
          ? StartScreen()
          : HomeScreen(
              name: name,
            ),
    );
  }
}
