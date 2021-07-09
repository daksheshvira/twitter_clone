import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/data/models/responser.dart';
import 'package:twitter_clone/utils/error_handler.dart';

class UserRepo {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> checkIfUserExists(String email) async {
    var signInMethodList = await auth.fetchSignInMethodsForEmail(email);
    return signInMethodList.isNotEmpty;
  }

  Future<Responser<User>> signUpUser(String email, String password) async {
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        return Responser(
          message: 'User registered successfully',
          isSuccess: true,
          data: userCredential.user,
        );
      } else {
        return Responser(
          message: 'Login failed',
          isSuccess: false,
        );
      }
    } catch (e) {
      return ErrorHandler.error(e);
    }
  }

  Future<Responser<User>> signInUser(String email, String password) async {
    try {
      var userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return Responser(
          message: 'Welcome back',
          isSuccess: true,
          data: userCredential.user,
        );
      } else {
        return Responser(
          message: 'Login failed',
          isSuccess: false,
        );
      }
    } catch (e) {
      return ErrorHandler.error(e);
    }
  }

  bool isUserLoggedIn() {
    try {
      if (auth.currentUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
