import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LearningAcceleratedFirebaseUser {
  LearningAcceleratedFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

LearningAcceleratedFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<LearningAcceleratedFirebaseUser>
    learningAcceleratedFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<LearningAcceleratedFirebaseUser>(
            (user) => currentUser = LearningAcceleratedFirebaseUser(user));
