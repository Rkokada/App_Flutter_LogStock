class UserModel {
  String? uid;
  String? email;
  String? phone;
  String? firstName;
  String? secondName;

  UserModel(
      {this.uid, this.email, this.phone, this.firstName, this.secondName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      phone: map['phone'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    // deviceTokens = json['deviceTokens']?.cast<String>();
    phone=
    json['phone'];
    firstName=
    json['firstName'];
    secondName=
    json['secondName'];

    email = json['email'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['secondName'] = this.secondName;
    return data;
  }
  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phone': phone,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
