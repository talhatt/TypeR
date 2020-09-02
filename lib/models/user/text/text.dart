class UserText {
  int id;
  String baslik;
  String metin;

  UserText(this.baslik, this.metin);
  UserText.withId(this.id, this.baslik, this.metin);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["baslik"] = baslik;
    map["metin"] = metin;

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  UserText.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"].toString());
    this.baslik = o["baslik"];
    this.metin = o["metin"];
  }
}
