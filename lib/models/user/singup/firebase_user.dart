class FirebaseUser {
  String kind;
  String idToken;
  String email;
  String refreshToken;
  String expiresIn;
  String localId;

  FirebaseUser(
      {this.kind,
      this.idToken,
      this.email,
      this.refreshToken,
      this.expiresIn,
      this.localId});

  FirebaseUser.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    idToken = json['idToken'];
    email = json['email'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
    localId = json['localId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['idToken'] = this.idToken;
    data['email'] = this.email;
    data['refreshToken'] = this.refreshToken;
    data['expiresIn'] = this.expiresIn;
    data['localId'] = this.localId;
    return data;
  }
}
