import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

 final FirebaseAuth _authPriv = FirebaseAuth.instance; 

 User? get currentUser => _authPriv.currentUser;

 Stream<User?> get authStateChanges => _authPriv.authStateChanges();

//Sign In with email & password
 Future<void> signInEmailAndPassword({
  required String email,
  required String password,
}) async {

  await _authPriv.signInWithEmailAndPassword(
    email: email,
    password: password);
}

//Register with email & password
Future<void> createUser({
  required String email,
  required String password,
}) async{
  await _authPriv.createUserWithEmailAndPassword(
    email: email, 
    password: password);
}

//Sign out

Future<void> signOut() async{
  await _authPriv.signOut();
}

  //authenticate the user first

  //Delete account

  
}