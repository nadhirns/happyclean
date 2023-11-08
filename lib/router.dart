import 'package:flutter/material.dart';
import 'package:happyclean/components/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'dart:js';
import 'package:happyclean/pages/login.dart';
import 'package:happyclean/pages/register.dart';
import 'package:happyclean/colors.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case "/navbar":
      return MaterialPageRoute(builder: (context) => const Navbar());
    case "/login":
      return MaterialPageRoute(builder: (context) => const Login());
    case "/register":
      return MaterialPageRoute(builder: (context) => const Register());
    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Image(
                        image: AssetImage("assets/bubbles.png"),
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        'Halaman',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: scColor)),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Tidak Ditemukan!',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: scColor)),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
