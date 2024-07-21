import 'package:flutter/material.dart';
import 'pages/root.dart';
import 'pages/splash_screen.dart';
import 'theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate App',
      theme: ThemeData(
        primaryColor: AppColor.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColor.primary),
        highlightColor: AppColor.primary, // Change this to the color you want
        splashColor: AppColor.primary, // Change this to the color you want
      ),
      initialRoute: '/',
      routes: {
      '/': (context) => SplashScreen(),
      '/home': (context) => RootApp(),
    },
  );
  }
}
