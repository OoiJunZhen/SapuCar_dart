class Passenger {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? matricStaffNo;
  String? gender;

  Passenger(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.matricStaffNo,
      this.gender});

  Passenger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    matricStaffNo = json['matricStaffNo'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['matricStaffNo'] = matricStaffNo;
    data['gender'] = gender;
    return data;
  }
}
