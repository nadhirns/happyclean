import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Jadwal extends StatefulWidget {
  const Jadwal({super.key});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  var jsonJadwallist;

  Future<Map<String, dynamic>?> getJadwalData() async {
    SharedPreferences jadwalData = await SharedPreferences.getInstance();
    String? jadwalDataget = jadwalData.getString('jadwals');
    if (jadwalDataget != null) {
      jsonJadwallist = jsonDecode(jadwalDataget);
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getJadwalData(),
      builder: (context, _) => Scaffold(
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
            children: _buildJadwalList(),
          )))),
    );
  }

  List<Widget> _buildJadwalList() {
    List<Widget> widgets = [];

    // Check if jsonlist is not null
    if (jsonJadwallist != null) {
      for (var jadwal in jsonJadwallist) {
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
                  const Icon(Icons.more_time_rounded, color: Color(0xFF3F908B)),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          DateFormat.MMMEd()
                              .format(DateTime.parse(jadwal["start_time"])),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3F908B),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "${DateFormat.jm().format(DateTime.parse(jadwal["start_time"]))} - ${DateFormat.jm().format(DateTime.parse(jadwal["end_time"]))}",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF3F908B),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${jadwal['duration']} mnt",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
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
