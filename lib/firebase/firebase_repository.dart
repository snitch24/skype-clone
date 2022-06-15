import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_clone/firebase/firebase_methods.dart';
import 'package:skype_clone/models/app_user.dart';

class FirebaseRepository {
  final FirebaseMethods _methods = FirebaseMethods();

   Future<User?> getCurrentUser() => _methods.getCurrentUser();
  Future<User?> signIn() => _methods.signIn();
  Future<bool> authenticateUser(User user) => _methods.authenticateUser(user);
  Future<void> addDataToDb(User user) => _methods.addDataToDb(user);
  Future<void> signOut() => _methods.signOut();
  Future<List<AppUser>> fetchAllUsers(User user) =>
      _methods.fetchAllUsers(user);
}
