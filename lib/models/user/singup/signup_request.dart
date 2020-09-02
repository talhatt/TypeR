class SignupRequest {
  String email;
  String password;
  bool returnSecureToken;

  SignupRequest({this.email, this.password, this.returnSecureToken});

  SignupRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    returnSecureToken = json['returnSecureToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['returnSecureToken'] = this.returnSecureToken;
    return data;
  }
}
