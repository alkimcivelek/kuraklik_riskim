import 'package:flutter/material.dart';
import 'package:kuraklik_riskim/constants/colors.dart';
import 'package:kuraklik_riskim/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
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
      automaticallyImplyLeading: false,
      actions: <Widget>[
        InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (prefs.containsKey("token")) {
                prefs.remove("token");
              }
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginView();
                  },
                ),
                (route) => false,
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.logout,
                size: 29,
              ),
            ))
      ],
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
