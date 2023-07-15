class HistoryModel {
  String? image;
  String? note;
  String? date;
  String? id;
  HistoryModel.fromJson(Map<String, dynamic>? json) {
    image = json!['image'];
    note = json['note'];
    date = json['date'];
    id = json['id'];
  }
}
