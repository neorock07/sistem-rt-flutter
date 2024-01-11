class TokenModel{
  String? token;

  TokenModel({
    this.token
  });

  factory TokenModel.fromJson(Map<String, dynamic> map){
    return TokenModel(
      token:map['token']
    );
  }

}