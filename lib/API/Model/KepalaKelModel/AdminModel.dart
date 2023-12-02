class AdminModel {
  String? id;
  String? username;
  String? email;
  String? password;
  String? role;

  AdminModel({this.id, this.username, this.email, this.password, this.role});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        role: json['role']);
  }
}

// "id": "50008",
//         "username": "upin@gmail.com",
//         "email": "upin@gmail.com",
//         "password": "$2a$10$POnVoAq3Y43MKm43Lmex.OLEvU521pRcatcELWx9GCC2w5Xa7CbNu",
//         "role": "ADMIN",