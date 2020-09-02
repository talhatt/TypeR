import 'dart:convert';
import 'dart:io';
import 'package:ezberci/models/user/singin/signin_error.dart';
import 'package:ezberci/models/user/singin/signin_request.dart';
import 'package:ezberci/models/user/singup/signup_error.dart';
import 'package:ezberci/models/user/singup/signup_request.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String FIREBASE_AUTH_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAwQUwsBcLFO8dwRKxC0olt818y8Jj5rYM";
  static const String FIREBASE_SIGNUP_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAwQUwsBcLFO8dwRKxC0olt818y8Jj5rYM";
  static const String FIREBASE_URL =
      "https://ezberci-43285.firebaseio.com/texts.jsontexts.json";

  Future postUser(SigninRequest request) async {
    var jsonModel = json.encode(request.toJson());
    final response = await http.post(FIREBASE_AUTH_URL, body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        var errorJson = json.decode(response.body);
        var error = SigninError.fromJson(errorJson);
        return error;
    }
  }

  Future singupUser(SignupRequest request) async {
    var jsonModel = json.encode(request.toJson());
    final response = await http.post(FIREBASE_SIGNUP_URL, body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        var errorJson = json.decode(response.body);
        var error = SignupError.fromJson(errorJson);
        return error;
    }
  }

  //Future<List<UserText>> getTexts() async {
  //final response = await http.get(FIREBASE_URL);

  //switch (response.statusCode) {
  //case HttpStatus.ok:
  //final jsonModel = json.decode(response.body);
  //return
  //default:
  //return Future.error(response.statusCode);
  //}
}
//}
