import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:twitter_clone/data/models/responser.dart';
import 'package:twitter_clone/repos/repos.dart';

class UserController extends ChangeNotifier {
  final authRepo = UserRepo();

  bool isLoading = false;

  User? get user => authRepo.auth.currentUser;

  Future<bool> checkIfUserExists(String email) {
    return authRepo.checkIfUserExists(email);
  }

  Future<Responser<User>> signUpUser(String email, String password) {
    return authRepo.signUpUser(email, password);
  }

  Future<Responser<User>> signInUser(String email, String password) {
    return authRepo.signInUser(email, password);
  }

  bool isUserLoggedIn() {
    return authRepo.isUserLoggedIn();
  }

  Future<bool> logout() async {
    isLoading = true;
    notifyListeners();
    var bool = await authRepo.logout();
    isLoading = false;
    notifyListeners();
    return bool;
  }
}
