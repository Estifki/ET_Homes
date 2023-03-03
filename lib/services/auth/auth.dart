import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

///
import '../../const/const.dart';
import '/utility/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String? userId;
  String? token;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'profile',
    'email',
  ]);
  //
  //Check Then assign userId and token
  //
  Future getUserAndToken() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString("LocalToken") != null &&
        prefs.getString("LocalUserId") != null) {
      userId = prefs.getString("LocalUserId");
      token = prefs.getString("LocalToken");
      notifyListeners();
    } else {
      prefs.remove("LocalUserId");
      prefs.remove("LocalToken");
      prefs.remove("TokenExpireDate");
      userId = null;
      token = null;
      notifyListeners();
    }
  }

  //
  //Check token status
  //

  Future<bool> get tokenStatus async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString("LocalToken") != null &&
        prefs.getString("LocalUserId") != null) {
      return true;
    }
    return false;
  }

  //
  //Sign Up
  //
  Future<void> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password}) async {
    var url = "${AppConst.baseUrl}/auth/signup";
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phone": "251$phone",
          "password": password
        }),
      );
      var decodedBody = jsonDecode(response.body);

      if (response.statusCode != 201) {
        throw HttpException(errorMessage: decodedBody["message"]);
      } else {}
    } catch (e) {
      rethrow;
    }
  }

//
//Sign In
//
  Future<void> signIn({required int phone, required String password}) async {
    var url = "${AppConst.baseUrl}/auth/signin";
    // "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAPfot6P6WhQi1c6xyclmiJAMaURhUKBvM";
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "phone": "251$phone",
          "password": password,
        }),
      );

      var decodedBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(errorMessage: decodedBody["message"]);
      } else {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString("LocalUserId", decodedBody["result"]["_id"]);
        prefs.setString("LocalToken", decodedBody['token']);
        prefs.setString("TokenExpireDate",
            DateTime.now().add(const Duration(days: 60)).toString());
        await getUserAndToken();
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  //
  //SignOut
  //
  Future<void> signOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("LocalUserId");
    prefs.remove("LocalToken");
    prefs.remove("TokenExpireDate");
    userId = null;
    token = null;
    notifyListeners();
  }

  Future signInWithGoogle() async {
    try {
      await googleSignOut();
      GoogleSignInAccount? userSignIn = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await userSignIn!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        String url = "${AppConst.baseUrl}/auth/google";
        try {
          http.Response response = await http.post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              // "UserName": user.displayName,
              // "Phone": user.phoneNumber,
              "email": user.email,
              "password": "1252555553",
              // "Photo": user.photoURL,
            }),
          );

          var decodedBody = jsonDecode(response.body);

          if (response.statusCode != 200) {
            throw HttpException(errorMessage: decodedBody["message"]);
          } else {
            // var prefs = await SharedPreferences.getInstance();
            // prefs.setString("LocalUserId", decodedBody["result"]["_id"]);
            // prefs.setString("LocalToken", decodedBody['token']);
            // prefs.setString("TokenExpireDate",
            //     DateTime.now().add(Duration(days: 60)).toString());
            // await getUserAndToken();
            // notifyListeners();
          }
        } catch (e) {
          rethrow;
        }
      }
      // return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  googleSignOut() async {
    try {
      await firebaseAuth.signOut().then((_) async {
        googleSignIn.disconnect();
        var prefs = await SharedPreferences.getInstance();
        prefs.remove("LocalUserId");
        prefs.remove("LocalToken");
        prefs.remove("TokenExpireDate");
        userId = null;
        token = null;
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }
}
