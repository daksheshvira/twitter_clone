import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:twitter_clone/data/models/responser.dart';
import 'package:twitter_clone/repos/repos.dart';

class UserController extends ChangeNotifier {
  final authRepo = UserRepo();

  bool isLoading = false;

  User? get user => authRepo.auth.currentUser;

  Future<bool> checkIfUserExists(String email) async {
    isLoading = true;
    notifyListeners();
    var data = await authRepo.checkIfUserExists(email);
    isLoading = false;
    notifyListeners();
    return data;
  }

  Future<Responser<User>> signUpUser(String email, String password) {
    isLoading = true;
    notifyListeners();
    var data = authRepo.signUpUser(email, password);
    isLoading = false;
    notifyListeners();
    return data;
  }

  Future<Responser<User>> signInUser(String email, String password) {
    isLoading = true;
    notifyListeners();
    var data = authRepo.signInUser(email, password);
    isLoading = false;
    notifyListeners();
    return data;
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
