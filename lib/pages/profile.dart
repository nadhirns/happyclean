import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:happyclean/pages/homepage.dart';
import 'package:happyclean/pages/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
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
          child: Text("Name",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold))),
        ),
        Text("family: xxx",
            style:
                GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12))),
        const SizedBox(height: 10),
        cardProfile("Anggota", Icons.people_alt_rounded, null),
        cardProfile("Kategori Tugas", Icons.category_rounded, null),
        cardProfile("Tugas-tugas", Icons.task_rounded, null),
        cardProfile("Log Out", Icons.logout, const Login()),
      ],
    );
  }

  cardProfile(String name, var lead, var route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            padding: const EdgeInsets.symmetric(vertical: 8),
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
