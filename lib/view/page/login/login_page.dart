import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/model/user.dart';
import 'package:iris_flutter/view/controller/login/login_controller.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = Get.put(LoginController());

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;

    // final OAuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleSignInAuthentication.accessToken,
    //     idToken: googleSignInAuthentication.idToken);

    // print('name = ${googleUser.displayName}');
    // print('email = ${googleUser.email}');
    // print('id = ${googleUser.id}');

    User data = User(id: googleUser.id, email: googleUser.email);
    if (googleUser.displayName != null) {
      data.displayName = googleUser.displayName;
    }
    if (googleUser.photoUrl != null) {
      data.photoUrl = googleUser.photoUrl;
    }

    controller.updateInfo(data);
    // 로그인 직후 페이지 뒤로가기 방지
    Get.offAll(() => const MainPage());

    // setState(() {
    //   _loginPlatform = google;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: CustomPadding.pageInsets,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "로그인/회원가입",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
            const SizedBox(
              height: 48,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 200,
            ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.loginGoogle,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.fitHeight),
                    const SizedBox(width: 6),
                    const Text(
                      "구글로 로그인하기",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.handleLogout,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                child: const Text("(임시) 로그아웃"),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
