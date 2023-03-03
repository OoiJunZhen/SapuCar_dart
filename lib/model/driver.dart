class Driver {
  String? id;
  String? name;
  String? ICno;
  String? email;
  String? phone;
  String? matricStaffNo;
  String? carModel;
  String? carPlateNo;
  String? licenseNo;
  String? stickerNo;
  String? gender;

  Driver({this.id, this.name, this.ICno, this.email, this.phone, this.matricStaffNo, this.carModel, this.carPlateNo, this.licenseNo, this.stickerNo, this.gender});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ICno = json['ICno'];
    email = json['email'];
    phone = json['phone'];
    matricStaffNo = json['matricStaffNo'];
    carModel = json['carModel'];
    carPlateNo = json['carPlateNo'];
    licenseNo = json['licenseNo'];
    stickerNo = json['stickerNo'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['ICno'] = ICno;
    data['email'] = email;
    data['phone'] = phone;
    data['matricStaffNo'] = matricStaffNo;
    data['carModel'] = carModel;
    data['carPlateNo'] = carPlateNo;
    data['licenseNo'] = licenseNo;
    data['stickerNo'] = stickerNo;
    data['gender'] = gender;
    return data;
  }
}
