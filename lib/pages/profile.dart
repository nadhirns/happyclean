import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:happyclean/pages/login.dart';
import 'package:happyclean/pages/profile/anggota.dart';
import 'package:happyclean/pages/profile/kategori.dart';
import 'package:happyclean/pages/profile/tugas.dart';
import 'package:happyclean/controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int myid = 0;
  String name = "my name";
  String role = "my role";

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userdataget = userData.getString('login_data');
    if (userdataget != null) {
      final myUserData = json.decode(userdataget);
      myid = myUserData['id'];
      name = myUserData['name'];
      role = myUserData['roles_id'] == 1 ? 'orang tua' : 'anak';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, _) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 10),
          const Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/profile.png"),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 1,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          backgroundColor: Color(0xFFF5F6F9),
                          onPressed: null,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xFFA4A4A4),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(name,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))),
          ),
          Text(role,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 12))),
          const SizedBox(height: 10),
          cardProfile("Anggota", Icons.people_alt_rounded, const Anggota()),
          cardProfile(
              "Kategori Tugas", Icons.category_rounded, const Kategori()),
          cardProfile("Tugas-tugas", Icons.task_rounded, const Tugas()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: InkWell(
              onTap: () {
                ProfileControl.listJadwal(id: myid);
                Navigator.of(context).pushNamed('/jadwalkosong');
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 5),
                          color: Colors.black12,
                          spreadRadius: 3,
                          blurRadius: 12)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: ListTile(
                      leading: Icon(Icons.schedule_send_rounded),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      title: Text("Jadwal Kosong",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(fontSize: 14)))),
                ),
              ),
            ),
          ),
          cardProfile("Log Out", Icons.logout, const Login()),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  cardProfile(String name, var lead, var route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => route)));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 5),
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 12)
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: ListTile(
                leading: Icon(lead),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                title: Text(name,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(fontSize: 14)))),
          ),
        ),
      ),
    );
  }
}
