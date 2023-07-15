class DoctorModel {
  String? image;
  String? name;
  String? phone;
  String? address;
  String? email;

  DoctorModel.fromJson(Map<String, dynamic>? json) {
    image = json!['image'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
  }
}
