import 'package:ezberci/models/user/text/text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  String userText;
  GameScreen(this.userText);
  @override
  State<StatefulWidget> createState() {
    return _GameScreen(userText);
  }
}

class _GameScreen extends State<GameScreen> {
  int typedCharLength = 0;
  String userText;

  int step = 0;
  int lastTypedAt;

  _GameScreen(String userText) {
    this.userText =
        userText.toLowerCase().replaceAll(',', '').replaceAll('.', '');
  }

  void updateLastTypedAt() {
    this.lastTypedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void onType(String value) {
    updateLastTypedAt();
    String trimmedValue = userText.trimLeft();
    setState(() {
      if (trimmedValue.indexOf(value) != 0) {
        step = 2;
      } else {
        typedCharLength = value.length;
      }
    });
  }

  void resetGame() {
    setState(() {
      typedCharLength = 0;
      step = 1;
    });
  }

  void onStartClick() {
    setState(() {
      updateLastTypedAt();
      step++;
      print(userText.length);
    });
    var timer = Timer.periodic(new Duration(seconds: 1), (timer) async {
      int now = DateTime.now().millisecondsSinceEpoch;

      setState(() {
        if (step == 1 && now - lastTypedAt > 4000) {
          // GAME OVER
          step++;
        }
      });
      if (step != 1) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var shownWidget;

    if (step == 0)
      shownWidget = <Widget>[
        Text('Bakalım ne kadar hızlısın?'),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: RaisedButton(
            child: Text('BASLA!'),
            onPressed: onStartClick,
          ),
        ),
      ];
    else if (step == 1)
      shownWidget = <Widget>[
        Text('$typedCharLength'),
        Container(
          height: 30,
          child: Marquee(
            text: userText,
            style: TextStyle(fontSize: 24, letterSpacing: 1),
            scrollAxis: Axis.horizontal,
            blankSpace: 1000,
            numberOfRounds: 1,
            startPadding: 200.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            velocity: 100,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: TextField(
            autofocus: true,
            onChanged: onType,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Yaz bakalım',
            ),
          ),
        )
      ];
    else
      shownWidget = <Widget>[
        Text('Skor: $typedCharLength'),
        RaisedButton(
          child: Text('Yeniden dene!'),
          onPressed: resetGame,
        )
      ];

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TypeR')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: shownWidget,
        ),
      ),
    );
  }
}
