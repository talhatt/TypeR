import 'package:ezberci/constants.dart';
import 'package:ezberci/models/user/text/text.dart';
import 'package:ezberci/services/db_helper.dart';
import 'package:flutter/material.dart';

import 'add_text_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  Future<List<UserText>> texts;
  DbHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DbHelper();
    getTexts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "TypeR",
            style: TextStyle(color: kSecondaryColor),
          ),
        ),
      ),
      body: buildTextList(texts),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddText(),
              )).then((value) => {
                if (value) {getTexts()}
              });
        },
        child: Icon(Icons.add, color: kSecondaryColor),
        tooltip: "Yeni bir metin ekle",
      ),
    );
  }

  buildTextList(Future<List<UserText>> texts) {
    return FutureBuilder(
      future: texts,
      builder: (context, AsyncSnapshot<List<UserText>> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        if (snapshot.data.isEmpty)
          return Center(child: Text("Metin listeniz boş görünüyor..."));
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: kPrimaryColor,
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(snapshot.data[index].id.toString()),
                  ),
                  title: Text(snapshot.data[index].baslik),
                  subtitle: Text(
                    snapshot.data[index].metin,
                    maxLines: 2,
                  ),
                  trailing: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteUserText(snapshot, index);
                            }),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              editUserText(context, snapshot, index);
                            }),
                        IconButton(
                            icon: Icon(Icons.play_circle_outline),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  void editUserText(
      BuildContext context, AsyncSnapshot<List<UserText>> snapshot, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddText(
            userText: snapshot.data[index],
          ),
        )).then((value) {
      if (value) {
        getTexts();
      }
    });
  }

  void deleteUserText(AsyncSnapshot<List<UserText>> snapshot, int index) {
    _dbHelper
        .deleteUserText(snapshot.data[index].id)
        .then((value) => getTexts());
  }

  void getTexts() async {
    setState(() {
      texts = _dbHelper.getUserTexts();
    });
  }
}
