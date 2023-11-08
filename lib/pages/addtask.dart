import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:happyclean/components/navbar.dart';
import 'package:happyclean/components/textfield.dart';
import 'package:happyclean/controllers/task_controller.dart';
import 'package:happyclean/models/task_model.dart';
// import 'package:happyclean/pages/profile.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController taskName = TextEditingController();
  TextEditingController time = TextEditingController();

  addNewTask(TaskModel taskModel) async {
    await TaskController()
        .addTask(taskModel)
        .then((success) => {Navigator.pop(context)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF50CDD1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Ini akan kembali ke halaman sebelumnya
          },
        ),
        title: Text(
          'Task',
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldInput(
                        hintedtext: "task name here",
                        labeltext: "Task Name",
                        inputController: taskName),
                    TextFieldInput(
                        hintedtext: "task time here",
                        labeltext: "Task Time",
                        inputController: time),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    TaskModel tasksModel = TaskModel(
                      namaTugas: taskName.text,
                      durasi: time.text,
                    );
                    addNewTask(tasksModel);
                    taskName.clear();
                    time.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color(0xFF3F908B),
                    fixedSize: const Size(330, 40)),
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
