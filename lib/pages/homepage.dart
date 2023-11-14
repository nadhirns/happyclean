import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:happyclean/pages/addtask.dart';
// import 'package:happyclean/controllers/task_controller.dart';
import 'package:happyclean/models/task_model.dart';
// import 'package:flutter_toastr/flutter_toastr.dart';
// import 'package:happyclean/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> days = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"];
  int current = 0;

  List<TaskModel> tasklist = [];
  final StreamController _streamController = StreamController();
  // Future getAllTask() async {
  //   tasklist = await TaskController().getTask();
  //   _streamController.sink.add(tasklist);
  // }

  // deleteTaskData(TaskModel taskModel) async {
  //   await TaskController()
  //       .deleteTask(taskModel)
  //       .then((success) => {
  //             FlutterToastr.show("Task Deleted Successfully", context,
  //                 duration: FlutterToastr.lengthLong,
  //                 position: FlutterToastr.top,
  //                 backgroundColor: Colors.greenAccent)
  //           })
  //       .onError((error, stackTrace) => {
  //             FlutterToastr.show("Task is Not Deleted", context,
  //                 duration: FlutterToastr.lengthLong,
  //                 position: FlutterToastr.top,
  //                 backgroundColor: Colors.red)
  //           });
  // }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // getAllTask();
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView.builder(
                itemCount: days.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(4),
                        height: 80,
                        width: 45,
                        decoration: BoxDecoration(
                            color: current == index
                                ? const Color(0xFF3F908B)
                                : const Color(0xFF7EE3E1),
                            borderRadius: current == index
                                ? BorderRadius.circular(10)
                                : BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            days[index],
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ));
                }),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  days[current],
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3F908B))),
                )),
          ),
          SizedBox(
              height: 450,
              width: double.infinity,
              child: SafeArea(
                child: StreamBuilder(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: tasklist.length,
                          itemBuilder: ((context, index) {
                            TaskModel task = tasklist[index];
                            return Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 6, right: 8),
                              width: double.infinity,
                              height: 75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 236, 236, 236)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // deleteTaskData(task);
                                        },
                                        icon: const Icon(
                                          Icons.circle_outlined,
                                          color: Color(0xFF3F908B),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(task.namaTugas,
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF3F908B)))),
                                    ),
                                    const Spacer(),
                                    Text(
                                        task.durasi.substring(
                                                0, task.durasi.length) +
                                            "mnt",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF3F908B))))
                                  ],
                                ),
                              ),
                            );
                          }));
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF7EE3E1),
                      ),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
