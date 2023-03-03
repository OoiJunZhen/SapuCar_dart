class PBooking {
  String? bookingID;
  String? pID;
  String? passengerName;
  String? passengerPhone;
  String? passengerGender;
  String? bookingDate;
  String? bookingTime;
  String? pickUp;
  String? dropOff;
  String? status;

  PBooking(
      {this.bookingID,
      this.pID,
      this.passengerName,
      this.passengerPhone,
      this.passengerGender,
      this.bookingDate,
      this.bookingTime,
      this.pickUp,
      this.dropOff,
      this.status,});

  PBooking.fromJson(Map<String, dynamic> json) {
    bookingID = json['bookingID'];
    pID = json['pID'];
    passengerName = json['passengerName'];
    passengerPhone = json['passengerPhone'];
    passengerGender = json['passengerGender'];
    bookingDate = json['bookingDate'];
    bookingTime = json['bookingTime'];
    pickUp = json['pickUp'];
    dropOff = json['dropOff'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingID'] = bookingID;
    data['pID'] = pID;
    data['passengerName'] = passengerName;
    data['passengerPhone'] = passengerPhone;
    data['passengerGender'] = passengerGender;
    data['bookingDate'] = bookingDate;
    data['bookingTime'] = bookingTime;
    data['pickUp'] = pickUp;
    data['dropOff'] = dropOff;
    data['status'] = status;
    return data;
  }
}
