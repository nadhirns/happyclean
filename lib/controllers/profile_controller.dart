import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:happyclean/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

var jsonAnggotalist;
var jsonKategorilist;
var jsonTugaslist;
var jsonJadwallist;

class ProfileControl {
  // Anggota
  static listAnggota() async {
    final dio = Dio();
    try {
      // dio.options.headers['Authorization'] =
      //     'Bearer ${UserControl.getAccessToken()}';
      final response = await dio.get('$network/api/anggota');
      if (response.statusCode == 200) {
        jsonAnggotalist = response.data["anggota"];
        print(jsonAnggotalist);
      } else {
        print(response.statusCode);
        print("ada kesalahan");
      }
    } catch (e) {
      print(e);
      // print(UserControl.getAccessToken());
    }
  }

  static listKategori() async {
    final dio = Dio();
    try {
      // dio.options.headers['Authorization'] =
      //     'Bearer ${UserControl.getAccessToken()}';
      final response = await dio.get('$network/api/kategori');
      if (response.statusCode == 200) {
        jsonKategorilist = response.data["kategoriTugas"];
        print(jsonKategorilist);
      } else {
        print(response.statusCode);
        print("ada kesalahan");
      }
    } catch (e) {
      print(e);
    }
  }

  static listTugas() async {
    final dio = Dio();
    try {
      // dio.options.headers['Authorization'] =
      //     'Bearer ${UserControl.getAccessToken()}';
      final response = await dio.get('$network/api/tugas');
      if (response.statusCode == 200) {
        jsonTugaslist = response.data["task"];
        print(jsonTugaslist);
      } else {
        print(response.statusCode);
        print("ada kesalahan");
      }
    } catch (e) {
      print(e);
    }
  }

  static listJadwal({int? id}) async {
    var jadwalData = await SharedPreferences.getInstance();
    final dio = Dio();

    try {
      final response = await dio.get('$network/api/jadwal',
          data: json.encode({
            "user_id": id,
          }));
      if (response.statusCode == 200) {
        jadwalData.setString('jadwals', json.encode(response.data['jadwal']));
      } else {
        print("fail");
      }
    } catch (e) {
      print("kesalahan server $e");
    }
  }
}
