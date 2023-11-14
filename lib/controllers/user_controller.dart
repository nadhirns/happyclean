import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:happyclean/network.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserControl {
  // static String? accessToken;

  static login(
      {String? username,
      String? password,
      required BuildContext context}) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
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
      final response = await dio.post('$network/api/login',
          data: json.encode({
            "username": username,
            "password": password,
          }));
      if (response.statusCode == 200) {
        userData.setString('login_data', json.encode(response.data['user']));
        // token
        // accessToken = response.data['token'];
        // print('Bearer Token: $accessToken');
        // dio.options.headers['Authorization'] = 'Bearer $accessToken';

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
      final response = await dio.post('$network/api/register',
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
      showToast("Data Harus Diisi dengan Benar!",
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.top,
          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
          backgroundcolor: Colors.redAccent);
    }
  }

  static logout(BuildContext context) async {
    final dio = Dio();
    try {
      // dio.options.headers['Authorization'] =
      //     'Bearer ${UserControl.getAccessToken()}';
      final response = await dio.get('$network/api/logout');
      if (response.statusCode == 200) {
        Navigator.of(context).pushNamed('/navbar');
        // clearAccessToken();
      } else {
        print(response.statusCode);
        print("ada kesalahan");
      }
    } catch (e) {
      print(e);
    }
  }

  // static String? getAccessToken() {
  //   return accessToken;
  // }

  // static void clearAccessToken() {
  //   accessToken = null;
  // }
}
