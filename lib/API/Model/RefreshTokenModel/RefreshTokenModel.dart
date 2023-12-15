class RefreshTokenModel{

  String? token;
  String? refreshToken;

  RefreshTokenModel({
    this.token,
    this.refreshToken
  });

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json){
    return RefreshTokenModel(
      token: json['token'],
      refreshToken: json['refreshToken']
    );
  }



}