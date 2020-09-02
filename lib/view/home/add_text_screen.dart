import 'package:ezberci/constants.dart';
import 'package:ezberci/models/user/text/text.dart';
import 'package:ezberci/services/db_helper.dart';
import 'package:flutter/material.dart';

class AddText extends StatefulWidget {
  UserText userText;
  AddText({this.userText});
  @override
  _AddTextState createState() => _AddTextState(userText: userText);
}

class _AddTextState extends State<AddText> {
  UserText userText;
  DbHelper _dbHelper;
  TextEditingController txtBaslik = TextEditingController();
  TextEditingController txtMetin = TextEditingController();

  _AddTextState({this.userText});
  @override
  void initState() {
    super.initState();
    _dbHelper = DbHelper();
    if (userText != null) {
      txtBaslik = TextEditingController(text: userText.baslik);
      txtMetin = TextEditingController(text: userText.metin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            userText != null ? Text("Metni Düzenle") : Text("Yeni Metin Ekle"),
      ),
      body: Column(
        children: <Widget>[
          buildHeaderField(),
          buildTxtField(),
          buildSaveButton(),
        ],
      ),
    );
  }

  TextField buildHeaderField() {
    return TextField(
      controller: txtBaslik,
      decoration: InputDecoration(
        labelText: "Başlık",
      ),
    );
  }

  TextField buildTxtField() {
    return TextField(
      controller: txtMetin,
      decoration: InputDecoration(labelText: "Metnin içeriği"),
      maxLines: null,
    );
  }

  RaisedButton buildSaveButton() {
    return RaisedButton(
      color: kPrimaryColor,
      onPressed: () {
        userText != null ? updateText() : addText();
      },
      child: Text("Kaydet", style: TextStyle(color: kSecondaryColor)),
    );
  }

  Future<void> addText() async {
    await _dbHelper.insertUserText(UserText(txtBaslik.text, txtMetin.text));
    Navigator.pop(context, true);
  }

  Future<void> updateText() async {
    await _dbHelper.updateUserText(
        UserText(txtBaslik.text, txtMetin.text), userText.id);
    Navigator.pop(context, true);
  }
}
