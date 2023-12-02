class RegisterModel {
  String? kk;
  String? email;
  String? username;
  String? password;

  RegisterModel(
      {String? kk, String? email, String? username, String? password});

  factory RegisterModel.fromJson(Map<String, dynamic> json){
      return RegisterModel(
        kk: json['id'],
        email: json['email'],
        username: json['username'],
        password: json['password'],
      );
  }   

}

    // "id": "337",
    // "username": "nopa",
    // "email": "damimit@gmail.com",
    // "password": "nopa"
