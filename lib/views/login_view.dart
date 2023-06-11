import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kuraklik_riskim/constants/application_constants.dart';
import 'package:kuraklik_riskim/helpers/storage_helper.dart';
import 'package:kuraklik_riskim/services/services.dart';
import 'package:kuraklik_riskim/views/home_view.dart';
import 'package:kuraklik_riskim/views/register_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final StorageHelper _storageHelper = StorageHelper();
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 34.0, bottom: 34.0),
                child: Image.asset("lib/assets/images/logo.png", width: 150),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4, bottom: 34, left: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              getFormField(
                  false, "E-mail", false, _emailController, null, Icons.email),
              getFormField(
                false,
                "Şifre",
                true,
                _passwordController,
                6,
                Icons.password,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 0, left: 24),
                    child: Text(
                      "Şifremi unuttum",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.4),
                    child: const Text(
                      "Beni hatırla",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 12),
                      child: Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 1.0, color: Colors.grey),
                        ),
                        activeColor: Colors.transparent,
                        checkColor: Colors.black,
                        splashRadius: 0,
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = !_rememberMe;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 24),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(CupertinoPageRoute(
                          builder: (context) => const RegisterView(),
                        ));
                      },
                      child: const Text(
                        "Henüz bir hesabınız yok mu? Kayıt olun.",
                        style: TextStyle(
                            fontSize: 12, decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                  onTap: () async {
                    try {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (prefs.containsKey("token")) {
                        prefs.remove("token");
                      }
                      dynamic result = await Service.postService(
                          {
                            "email": _emailController.text,
                            "password": _passwordController.text
                          },
                          ApplicationConstant.API_URL +
                              ApplicationConstant.LOGIN_URL);
                      debugPrint(result.toString());
                      if (_rememberMe) {
                        _storageHelper.setValue(
                            "token", result["token"].toString());
                      }
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                          (route) => true);
                    } catch (e) {
                      if (kDebugMode) {
                        print("hata: $e");
                      }
                    }
                  },
                  child: getButton("Giriş Yap", 0.05, 1, 24, 15))
            ],
          ),
        ),
      ),
    );
  }

  Widget getFormField(bool callbackFunc, String label, bool obscureText,
      TextEditingController controller, double? paddingBottom, IconData icon,
      {bool? isReadOnly, double? fontSize}) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              label,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 24, right: 24, bottom: paddingBottom ?? 10, top: 10),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0XFFF0EEED)),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                textAlignVertical: TextAlignVertical.center,
                obscureText: obscureText,
                autocorrect: false,
                readOnly: isReadOnly ?? false,
                autofocus: false,
                style: TextStyle(
                    decorationThickness: 0,
                    fontSize: fontSize ?? 13,
                    decoration: TextDecoration.none,
                    decorationColor: Colors.transparent),
                cursorColor: Colors.grey[600],
                decoration: InputDecoration(
                    prefixIcon: Icon(icon),
                    helperStyle:
                        const TextStyle(decoration: TextDecoration.none),
                    errorStyle:
                        const TextStyle(decoration: TextDecoration.none),
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: InputBorder.none,
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 0)),
              )),
        ),
      ],
    );
  }

  Widget getButton(
      String text, double height, double width, double padding, double fontsize,
      {Color? buttonColor}) {
    return Padding(
      padding: EdgeInsets.only(top: padding, left: padding, right: padding),
      child: Container(
          height: MediaQuery.of(context).size.height * height,
          width: MediaQuery.of(context).size.width * width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: buttonColor ?? ColorConstant.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: fontsize, color: Colors.black87),
          )),
    );
  }
}
