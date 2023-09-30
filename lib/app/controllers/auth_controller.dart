import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_get/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

//Awal Signup
  void signup(String emailAddress, String password) async {
    try {
  UserCredential myUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  await myUser.user!.sendEmailVerification();
  Get.defaultDialog(
    title: "Verifikasi Email",
    middleText: 
    "Kami telah mengirimkan verifikasi ke email $emailAddress",
  onConfirm: (){
    Get.back(); //close dialog
    Get.back(); //login dialog
  },
  textConfirm: "OK");
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }
//Akhir Signup

//Awal Login
  void login(String emailAddress, String password) async {
    try {
      UserCredential myUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password,
    );
    if (myUser.user!.emailVerified){
      //untuk routing
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.defaultDialog(
        title: "Verifikasi email",
        middleText: "Harap verifikasi email terlebih dahulu",
      );
    }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "No user found for that email");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Wrong password provided for that user");
        print('Wrong password provided for that user.');
      }
    }
  }
//Akhir Login

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
        title: "Berhasil",
        middleText: "Kami Telah mengirimkan reset password ke $email ",
        onConfirm : () {
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
        );
      } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat melakukan Reset Password");
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Email Tidak Valid");
    }
  }
}