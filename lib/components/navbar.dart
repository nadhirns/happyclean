// import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_toastr/flutter_toastr.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:happyclean/pages/homepage.dart';
import 'package:happyclean/pages/profile.dart';
// import 'package:happyclean/pages/addtask.dart';
// import 'package:happyclean/models/task_model.dart';
// import 'package:happyclean/controllers/task_controller.dart';
// import 'package:happyclean/components/textfield.dart';

class Task {
  final DateTime? selectedDate;
  final TimeOfDay? selectedStartTime;
  final TimeOfDay? selectedEndTime;
  int? userId;
  late DateTime combinedDateTimeStart;
  late DateTime combinedDateTimeEnd;

  Task({
    this.selectedDate,
    this.selectedStartTime,
    this.selectedEndTime,
    this.userId,
  }) {
    if (selectedDate != null && selectedStartTime != null) {
      combinedDateTimeStart = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedStartTime!.hour,
        selectedStartTime!.minute,
      );
    } else if (selectedDate != null) {
      combinedDateTimeStart = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
      );
    } else {
      combinedDateTimeStart = DateTime.now();
    }

    if (selectedDate != null && selectedEndTime != null) {
      combinedDateTimeEnd = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedEndTime!.hour,
        selectedEndTime!.minute,
      );
    } else if (selectedDate != null) {
      combinedDateTimeEnd = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
      );
    } else {
      combinedDateTimeEnd = DateTime.now();
    }
  }
}

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  // final _formKey = GlobalKey<FormState>();
  TextEditingController taskName = TextEditingController();
  TextEditingController time = TextEditingController();
  int userId = 0;

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userdataget = userData.getString('login_data');
    if (userdataget != null) {
      final myUserData = json.decode(userdataget);
      userId = myUserData['id'];
    }
    return null;
  }

  final List<Task> tasks = [];

  // DateTime selectDate = DateTime.now();

  // addNewTask(TaskModel taskModel) async {
  //   await TaskController()
  //       .addTask(taskModel)
  //       .then((success) => {Navigator.pop(context)});
  // }

  int _selTabIndex = 0;

  void _onTappedNav(int index) {
    setState(() {
      _selTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listPage = <Widget>[
      const HomePage(),
      const Profile(),
    ];

    final bottomNav = <Widget>[
      const Icon(
        Icons.home,
        color: Colors.white,
      ),
      const Icon(
        Icons.person_rounded,
        color: Colors.white,
      ),
    ];

    final bottomNavbar = CurvedNavigationBar(
        onTap: _onTappedNav,
        height: 60,
        backgroundColor: Colors.white,
        color: const Color(0xFF50CDD1),
        animationDuration: const Duration(milliseconds: 300),
        items: bottomNav);

    return FutureBuilder(
        future: getUserData(),
        builder: (context, _) => Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF50CDD1),
              leadingWidth: 0, // Set the width for the leading widget
              leading: Container(),
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
                ],
              ),
              centerTitle: true, // Center the title
            ),
            body: listPage[_selTabIndex],
            bottomNavigationBar: bottomNavbar,
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFF3F908B),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => TaskFormDialog(
                    onTaskAdded: (newTask) {
                      setState(() {
                        tasks.add(newTask);
                      });
                    },
                    getId: userId,
                  ),
                );
                // Navigator.push(
                //     context, MaterialPageRoute(builder: ((context) => AddTask())));
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked));
  }
}

class TaskFormDialog extends StatefulWidget {
  final Function(Task) onTaskAdded;
  final int getId;

  const TaskFormDialog(
      {Key? key, required this.onTaskAdded, required this.getId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TaskFormDialogState createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  bool isToday = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
          child: Text(
        "Tambah Jadwal Kosong",
        style: TextStyle(color: Color(0xFF3F908B)),
      )),
      // content: Form(
      //     key: _formKey,
      //     child: SizedBox(
      //       height: 200,
      //       child: ,
      //     )),
      content: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: isToday,
                      onChanged: (value) {
                        setState(() {
                          isToday = value!;
                          if (isToday) {
                            selectedDate = DateTime.now();
                          }
                        });
                      }),
                  const Text('Hari ini')
                ],
              ),
              Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: 'Hari/Tgl: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16, // Warna untuk 'Sampai Jam'
                        // Gaya teks lainnya seperti ukuran font, dll.
                      ),
                    ),
                    TextSpan(
                      text: selectedDate == null
                          ? '(None)'
                          : DateFormat.yMMMd().format(selectedDate!),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: selectedDate == null
                            ? Colors.grey
                            : Colors
                                .black, // Warna teks 'None' berwarna abu-abu
                        // Gaya teks lainnya
                      ),
                    ),
                  ])),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050));
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today_rounded))
                ],
              ),
              Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: 'Dari Jam: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16, // Warna untuk 'Sampai Jam'
                        // Gaya teks lainnya seperti ukuran font, dll.
                      ),
                    ),
                    TextSpan(
                      text: selectedStartTime == null
                          ? '(None)'
                          : selectedStartTime!.format(context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: selectedStartTime == null
                            ? Colors.grey
                            : Colors
                                .black, // Warna teks 'None' berwarna abu-abu
                        // Gaya teks lainnya
                      ),
                    ),
                  ])),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.access_alarms_rounded),
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (pickedTime != null &&
                          pickedTime != selectedStartTime) {
                        setState(() {
                          selectedStartTime = pickedTime;
                        });
                      }
                    },
                  )
                ],
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Sampai Jam: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16, // Warna untuk 'Sampai Jam'
                            // Gaya teks lainnya seperti ukuran font, dll.
                          ),
                        ),
                        TextSpan(
                          text: selectedEndTime == null
                              ? '(None)'
                              : selectedEndTime!.format(context),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: selectedEndTime == null
                                ? Colors.grey
                                : Colors
                                    .black, // Warna teks 'None' berwarna abu-abu
                            // Gaya teks lainnya
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //     'Sampai Jam: ${selectedEndTime == null ? 'None' : selectedEndTime!.format(context)}'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.access_alarms_rounded),
                    onPressed: () async {
                      final TimeOfDay? pickedTime2 = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (pickedTime2 != null &&
                          pickedTime2 != selectedEndTime) {
                        setState(() {
                          selectedEndTime = pickedTime2;
                        });
                      }
                    },
                  )
                ],
              )
            ]),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
            onPressed: () {
              // final newTask = Task(
              //     selectedDate: selectedDate,
              //     selectedStartTime: selectedStartTime,
              //     selectedEndTime: selectedEndTime,
              //     userId: widget.getId.toInt());
            },
            child: const Text('Add'))
      ],
    );
  }
}
