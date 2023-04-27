import 'package:flutter/material.dart';
import 'package:kuraklik_riskim/constants/colors.dart';
import 'package:kuraklik_riskim/views/login_view.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool isLeading;
  final BuildContext widgetContext;

  CustomAppBar({
    Key? key,
    required this.widgetContext,
    required this.isLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: ColorConstant.backgroundColor,
      centerTitle: true,
      actions: <Widget>[
        InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const LoginView();
                },
              ));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.person,
                size: 29,
              ),
            ))
      ],
      leading: isLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await Future.delayed(const Duration(milliseconds: 50));
                Navigator.of(widgetContext).pop();
              })
          : null,
      title: Column(
        children: [
          Image.asset(
            "lib/assets/images/logo.png",
            height: MediaQuery.of(widgetContext).size.width * 0.09,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        MediaQuery.of(widgetContext).size.height * 0.06,
      );
}
