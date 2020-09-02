import 'package:ezberci/constants.dart';
import 'package:ezberci/models/user/singin/signin_request.dart';
import 'package:ezberci/models/user/singin/signin_error.dart';
import 'package:ezberci/services/firebase_service.dart';
import 'package:ezberci/services/google_signin.dart';
import 'package:ezberci/view/authentication/signup_screen.dart';
import 'package:ezberci/view/home/home_screen.dart';
import 'package:flutter/material.dart';

class SingInScreen extends StatefulWidget {
  @override
  _SingInScreenState createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  var email;
  var password;
  FirebaseService service = FirebaseService();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Giriş Yap",
                        style: Theme.of(context).textTheme.display1,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ));
                          },
                          child: Text("Kaydol",
                              style: Theme.of(context).textTheme.button)),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 16),
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
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
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
                          decoration: InputDecoration(
                            hintText: "Şifre",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await GoogleSignHelper.instance.signIn();
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                            child: Icon(
                              Icons.outlined_flag,
                              color: Colors.white.withOpacity(.5),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(16),
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
                            var result = await service.postUser(SigninRequest(
                                email: this.email,
                                password: this.password,
                                returnSecureToken: true));

                            if (result is SigninError) {
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
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
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
