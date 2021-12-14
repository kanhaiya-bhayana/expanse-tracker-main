import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<User?> signInWithGoogle();
  Future<void> signOut();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createAccountWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithGoogle() async {
    print("Google Sign In called");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    // final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["profile", "email"]);
    // default signin scopes already have "profile" and "email" scopes

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    print(googleSignInAccount.toString());
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      if (googleSignInAuthentication.idToken != null) {
        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(code: 'ERROR_MISSING_GOOGLE_ID_TOKEN', message: 'Missing Google ID Token');
      }
    } else {
      throw FirebaseAuthException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in process aborted by user');
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final UserCredential authUser = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return authUser.user;
  }

  @override
  Future<User?> createAccountWithEmailAndPassword(String email, String password) async {
    final UserCredential authUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return authUser.user;
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}

class SignInException extends FirebaseAuthException {
  final String code;
  final String? message;
  SignInException({required this.code, this.message})
      : super(
          code: code,
          message: message,
        );
}
