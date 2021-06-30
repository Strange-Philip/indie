import 'package:animated_splash/animated_splash.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indie/onboard.dart';
import 'package:indie/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

int intScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefences = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  intScreen = await prefences.getInt('intScreen');
  await prefences.setInt('intScreen', 1);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(EasyDynamicThemeWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //     primarySwatch: Colors.purple,
      //     primaryColor: Color(0xff9316ee),
      //     accentColor: Color(0xff3cdaac)),
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      home: SafeArea(
        child: Stack(
          children: [
            AnimatedSplash(
              imagePath: 'images/logo.jpg',
              home: intScreen == 0 || intScreen == null
                  ? OnboardingHome()
                  : HomePage(),
              duration: 2500,
              type: AnimatedSplashType.StaticDuration,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 500),
                  Center(
                    child: Text("Your Virtual friend",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                            fontSize: 20)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
