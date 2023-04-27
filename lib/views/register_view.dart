import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuraklik_riskim/model/register_model.dart';
import 'package:kuraklik_riskim/view_model/register_view_model.dart';
import 'package:kuraklik_riskim/views/login_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../constants/colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  File? imageFile;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ppController = TextEditingController();

  final _viewModel = RegisterViewModel();
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
                padding: const EdgeInsets.only(top: 28.0, bottom: 28.0),
                child: Image.asset("lib/assets/images/logo.png", width: 150),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4, bottom: 20, left: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kayıt Ol",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              getFormField(
                  false, "Ad", false, _nameController, null, Icons.person),
              getFormField(false, "Soyad", false, _surnameController, null,
                  Icons.person),
              getFormField(
                  false, "E-mail", false, _emailController, null, Icons.email),
              Observer(
                builder: (_) {
                  return getFormField(false, "Şehir", false, _cityController,
                      null, Icons.location_pin);
                },
              ),
              getFormField(
                  true, "Fotoğraf", false, _ppController, null, Icons.image,
                  isReadOnly: true),
              getFormField(
                  false, "Şifre", true, _passwordController, 6, Icons.password),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 24),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(CupertinoPageRoute(
                          builder: (context) => const LoginView(),
                        ));
                      },
                      child: const Text(
                        "Zaten kayıt oldunuz mu? Giriş yapın.",
                        style: TextStyle(
                            fontSize: 12, decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              getButton("Kayıt Ol", 0.05, 1, 24, 15)
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
                onTap: callbackFunc != false ? _showDialogContent : () {},
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

  Future<void> _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _ppController.text = "Fotoğraf seçildi.";
      });
    }
  }

  Future<void> _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _ppController.text = "Fotoğraf seçildi.";
      });
    }
  }

  void deletePhoto() {
    setState(() {
      imageFile = null;
      _ppController.text = "";
    });
  }

  Future<Widget?> _showDialogContent() {
    return showDialog<Widget>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Fotoğraf Seç",
                style: TextStyle(fontSize: 15),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        "Bir fotoğraf çekebilir veya galeriden bir fotoğraf seçebilirsiniz.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    imageFile != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () async {
                              await _getFromCamera();
                              setState(
                                () {},
                              );
                            },
                            child:
                                getButton("Fotoğraf çek", 0.04, 0.19, 0, 10)),
                        InkWell(
                            onTap: () async {
                              await _getFromGallery();
                              setState(
                                () {},
                              );
                            },
                            child:
                                getButton("Fotoğraf seç", 0.04, 0.19, 0, 10)),
                        InkWell(
                            onTap: () {
                              deletePhoto();
                              setState(
                                () {},
                              );
                            },
                            child: getButton("Fotoğrafı Sil", 0.04, 0.19, 0, 10,
                                buttonColor: ColorConstant.deleteColor)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
