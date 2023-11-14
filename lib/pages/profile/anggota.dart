import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happyclean/controllers/profile_controller.dart';

class Anggota extends StatefulWidget {
  const Anggota({super.key});

  @override
  State<Anggota> createState() => _AnggotaState();
}

class _AnggotaState extends State<Anggota> {
  @override
  void initState() {
    super.initState();
    ProfileControl.listAnggota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF50CDD1),
          leadingWidth: 50,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/bubbles2.png',
                  width: 35,
                  height: 35,
                ),
              ),
              Text(
                'Happy Clean',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Container(width: 50)
            ],
          ),
          centerTitle: true, // Center the title
        ),
        body: SizedBox(
            child: SafeArea(
                child: ListView(
          children: _buildAnggotaList(),
        ))));
  }

  List<Widget> _buildAnggotaList() {
    List<Widget> widgets = [];

    // Check if jsonlist is not null
    if (jsonAnggotalist != null) {
      for (var anggota in jsonAnggotalist) {
        widgets.add(
          Container(
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 236, 236, 236),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(
                      anggota["roles_id"] == 1
                          ? Icons.supervisor_account_rounded
                          : Icons.child_care_rounded,
                      color: Color(0xFF3F908B)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      anggota["name"],
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3F908B),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // Handle edit button press
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFF3F908B),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle delete button press
                    },
                    icon: const Icon(
                      Icons.delete_outlined,
                      color: Color(0xFF3F908B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }
}
