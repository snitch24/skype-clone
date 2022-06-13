import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_clone/firebase/firebase_methods.dart';

class FirebaseRepository {
  final FirebaseMethods _methods = FirebaseMethods();

  Future<User?> getCurrentUser() => _methods.getCurrentUser();
}
