// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:happyclean/models/task_model.dart';
// import 'package:happyclean/network.dart';

// class TaskController {
//   static const viewUrl = "http://192.168.1.2:8080/happyclean/view.php";
//   static const createUrl = "http://192.168.1.2:8080/happyclean/create.php";
//   static const deleteUrl = "http://192.168.1.2:8080/happyclean/delete.php";

//   List<TaskModel> tasksFromJson(String jsonstring) {
//     final data = jsonDecode(jsonstring);
//     return List<TaskModel>.from(data.map((item) => TaskModel.fromJson(item)));
//   }

//   Future<List<TaskModel>> getTask() async {
//     String viewIp = "$network/api/tugas";
//     final response = await http.get(Uri.parse(viewIp));
//     if (response.statusCode == 200) {
//       List<TaskModel> list = tasksFromJson(response.body);
//       return list;
//     } else {
//       return <TaskModel>[];
//     }
//   }

//   Future<String> addTask(TaskModel taskModel) async {
//     final response =
//         await http.post(Uri.parse(createUrl), body: taskModel.toJsonAdd());
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       return "Error";
//     }
//   }

//   Future<String> deleteTask(TaskModel taskModel) async {
//     final response =
//         await http.post(Uri.parse(deleteUrl), body: taskModel.toJsonDelete());
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       return "Error";
//     }
//   }
// }
