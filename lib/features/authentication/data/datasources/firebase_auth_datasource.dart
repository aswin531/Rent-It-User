import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseDataSource({required this.firebaseAuth, required this.googleSignIn});

//------------------SignIn --Google ------------------------------------

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return (await firebaseAuth.signInWithCredential(credential)).user;
  }

//------------------SignIn --Email & Password ------------------------------------
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

//------------------SignUp --Email & Password ------------------------------------

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

//------------------SignOut ------------------------------------

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

//------------------SignUp --Get the User ------------------------------------

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  //------------------SignUp -- PhoneNumber ------------------------------------

  late String verificationId;

  Future<void> verifyPhonenumber(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException error) {
        print("Phone Number Verification Failed : $error");
      },
      codeSent: (String verificationId, forceResendingToken) {
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verificationId = verificationId;
      },
    );
  }

//-----Function to sign in with phone number using the SMS code

  Future<void> signInWithPhoneNumber(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await firebaseAuth.signInWithCredential(credential);
  }
}
