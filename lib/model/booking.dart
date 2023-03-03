class Booking {
  String? bookingID;
  String? driverID;
  String? driverName;
  String? driverEmail;
  String? driverPhone;
  String? gender;
  String? carModel;
  String? carPlateNo;
  String? bookingDate;
  String? bookingTime;
  String? pickUp;
  String? dropOff;
  String? status;

  Booking(
      {this.bookingID,
      this.driverID,
      this.driverName,
      this.driverEmail,
      this.driverPhone,
      this.gender,
      this.carModel,
      this.carPlateNo,
      this.bookingDate,
      this.bookingTime,
      this.pickUp,
      this.dropOff,
      this.status,});

  Booking.fromJson(Map<String, dynamic> json) {
    bookingID = json['bookingID'];
    driverID = json['driverID'];
    driverName = json['driverName'];
    driverEmail = json['driverEmail'];
    driverPhone = json['driverPhone'];
    gender = json['gender'];
    carModel = json['carModel'];
    carPlateNo = json['carPlateNo'];
    bookingDate = json['bookingDate'];
    bookingTime = json['bookingTime'];
    pickUp = json['pickUp'];
    dropOff = json['dropOff'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingID'] = bookingID;
    data['driverID'] = driverID;
    data['driverName'] = driverName;
    data['driverEmail'] = driverEmail;
    data['driverPhone'] = driverPhone;
    data['gender'] = gender;
    data['carModel'] = carModel;
    data['carPlateNo'] = carPlateNo;
    data['bookingDate'] = bookingDate;
    data['bookingTime'] = bookingTime;
    data['pickUp'] = pickUp;
    data['dropOff'] = dropOff;
    data['status'] = status;
    return data;
  }
}
