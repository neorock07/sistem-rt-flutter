class LoginModel {
  String? email;
  String? password;
  String? role;
  String? token;
  String? refreshToken;

  LoginModel(
      {this.email, this.password, this.role, this.token, this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        email: json["email"],
        password: json["password"],
        role: json["role"],
        token: json["token"],
        refreshToken: json["refreshToken"]);
  }
}


// {
//     "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW1pbWl0QGdtYWlsLmNvbSIsImlhdCI6MTcwMTI2MTk1NCwiZXhwIjoxNzAxMjY1NTU0fQ.OhUN6aMQW-c2Lxc1Hr6qFPya4vLBZg7ylwLZqJBdQDA",
//     "refreshToken": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW1pbWl0QGdtYWlsLmNvbSIsImlhdCI6MTcwMTI2MTk1NCwiZXhwIjoxNzAxMjY1NTU0fQ.OhUN6aMQW-c2Lxc1Hr6qFPya4vLBZg7ylwLZqJBdQDA"
// }