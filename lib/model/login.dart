class LoginModel {
  Data? data;
  String? message;
  int status;

  LoginModel(this.data, this.message, this.status);

  factory LoginModel.fromJson(Map<String, dynamic> datas) {
    return LoginModel(
        Data.fromJson(datas["data"]), datas['message'], datas['status']);
  }
}

class Data {
  String? access_token;
  String? refresh_token;

  Data(this.access_token, this.refresh_token);

  factory Data.fromJson(Map<String, dynamic> tokenData) {
    return Data(tokenData['access_token'], tokenData['refresh_token']);
  }
}
