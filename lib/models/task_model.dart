// ignore_for_file: prefer_typing_uninitialized_variables

class TaskModel {
  final id;
  final namaTugas;
  final durasi;
  final keterangan;
  final category;

  TaskModel({
    this.id,
    this.namaTugas,
    this.durasi,
    this.keterangan,
    this.category,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      namaTugas: json['nama_tugas'],
      durasi: json['durasi'],
      keterangan: json['keterangan'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "nama_tugas": namaTugas,
      "durasi": durasi,
      "keterangan": keterangan,
      "category": category,
    };
  }

  Map<String, dynamic> toJsonDelete() {
    return {
      "id": id,
      "nama_tugas": namaTugas,
      "durasi": durasi,
      "keterangan": keterangan,
      "category": category,
    };
  }
}
