import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class UserControl {
  static login(
      {String? username,
      String? password,
      required BuildContext context}) async {
    showToast(String msg,
        {int? duration,
        int? position,
        dynamic textStyle,
        required Color backgroundcolor}) {
      FlutterToastr.show(msg, context,
          duration: duration,
          position: position,
          textStyle: textStyle,
          backgroundColor: backgroundcolor);
    }

    final dio = Dio();
    try {
      final response = await dio.post('http://192.168.119.106:80/api/login',
          data: json.encode({
            "username": username,
            "password": password,
          }));
      if (response.statusCode == 200) {
        showToast("Berhasil Login",
            duration: FlutterToastr.lengthLong,
            position: FlutterToastr.top,
            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            backgroundcolor: Colors.greenAccent);
        Navigator.of(context).pushNamed('/navbar');
        print("success");
      } else {
        showToast("username atau password salah",
            duration: FlutterToastr.lengthLong,
            position: FlutterToastr.top,
            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            backgroundcolor: Colors.redAccent);
        print("fail");
      }
    } catch (e) {
      showToast("username atau password salah",
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.top,
          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
          backgroundcolor: Colors.redAccent);
    }
  }

  static register(
      {String? name,
      String? username,
      String? password,
      required BuildContext context
      // int? rolesId,
      }) async {
    showToast(String msg,
        {int? duration,
        int? position,
        dynamic textStyle,
        required Color backgroundcolor}) {
      FlutterToastr.show(msg, context,
          duration: duration,
          position: position,
          textStyle: textStyle,
          backgroundColor: backgroundcolor);
    }

    final dio = Dio();
    try {
      final response = await dio.post('http://192.168.119.106:80/api/register',
          data: json.encode({
            "name": name,
            "username": username,
            "password": password,
          }));
      if (response.statusCode == 200) {
        showToast("Berhasil Daftar",
            duration: FlutterToastr.lengthLong,
            position: FlutterToastr.top,
            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            backgroundcolor: Colors.greenAccent);
        Navigator.of(context).pushNamed('/login');
        print("success");
      } else {
        showToast("Data Harus Diisi dengan Benar!",
            duration: FlutterToastr.lengthLong,
            position: FlutterToastr.top,
            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            backgroundcolor: Colors.redAccent);
      }
    } catch (e) {
      print("Error: $e");
      showToast("Data Harus Diisi dengan Benar!",
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.top,
          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
          backgroundcolor: Colors.redAccent);
    }
  }
}
