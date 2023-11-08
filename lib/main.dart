import 'package:flutter/material.dart';
import 'package:happyclean/pages/splash.dart';
import 'package:happyclean/router.dart';

void main() {
  runApp(const MyApp(
    page: SplashScreen(),
  ));
}

class MyApp extends StatefulWidget {
  final Widget? page;
  const MyApp({Key? key, this.page}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        onGenerateRoute: generateRoute,
        title: "Happy Clean",
        theme: ThemeData(),
        home: widget.page,
      ),
    );
  }
}
