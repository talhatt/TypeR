import 'package:ezberci/constants.dart';
import 'package:ezberci/models/user/singup/signup_error.dart';
import 'package:ezberci/models/user/singup/signup_request.dart';
import 'package:ezberci/services/firebase_service.dart';
import 'package:ezberci/view/authentication/signin_screen.dart';
import 'package:ezberci/view/home/home_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupScreen();
  }
}

class _SignupScreen extends State {
  FirebaseService service = FirebaseService();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  var email;
  var password;
  var password2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background.gif"),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingInScreen(),
                              ));
                        },
                        child: Text(
                          "Giriş Yap",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      Text("Kaydol",
                          style: Theme.of(context).textTheme.display1),
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.alternate_email,
                          color: kPrimaryColor,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "E-mail",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          decoration: InputDecoration(hintText: "Şifre"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(Icons.lock, color: kPrimaryColor),
                      ),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password2 = value;
                            });
                          },
                          decoration: InputDecoration(hintText: "Şifre"),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(.5),
                              )),
                          child: Icon(
                            Icons.android,
                            color: Colors.white.withOpacity(.5),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(.5),
                            ),
                          ),
                          child: Icon(
                            Icons.chat,
                            color: Colors.white.withOpacity(.5),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            if (password == password2) {
                              var result = await service.singupUser(
                                  SignupRequest(
                                      email: this.email,
                                      password: this.password,
                                      returnSecureToken: true));
                              if (result is SignupError) {
                                scaffold.currentState.showSnackBar(SnackBar(
                                  content: Text(result.error.message),
                                ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ));
                              }
                            } else {
                              scaffold.currentState.showSnackBar(SnackBar(
                                content: Text("Şifreler uyuşmuyor!"),
                              ));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: kSecondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
