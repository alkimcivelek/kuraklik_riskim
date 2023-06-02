import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kuraklik_riskim/components/app_bar.dart';
import 'package:kuraklik_riskim/constants/application_constants.dart';
import 'package:kuraklik_riskim/constants/colors.dart';
import 'package:kuraklik_riskim/model/response_model.dart';
import 'package:kuraklik_riskim/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel _viewModel = HomeViewModel();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<BoxShadow> shadowList = [
      const BoxShadow(
          blurRadius: 12,
          color: Colors.black,
          spreadRadius: -10,
          offset: Offset(0, 0))
    ];
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        widgetContext: context,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18)),
                  color: Colors.white,
                  boxShadow: shadowList),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 90,
                          color: ColorConstant.backgroundColor,
                        ),
                        Column(
                          children: [
                            Text(
                              "İSTANBUL",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Toplam Doluluk: %78",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: ColorConstant.backgroundColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(18),
                                    bottomLeft: Radius.circular(18))),
                            child: Center(
                              child: DatePickerDialog(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2039)),
                              //     child: DropdownButtonFormField(
                              //   isExpanded: true,
                              //   menuMaxHeight:
                              //       MediaQuery.of(context).size.height * 0.2,
                              //   decoration: const InputDecoration(
                              //       border: InputBorder.none,
                              //       prefixIcon: Icon(Icons.location_pin)),
                              //   items: [],
                              //   value: null,
                              //   onChanged: (value) {
                              //     setState(() {
                              //       // _dropDownValue = value ?? "";
                              //     });
                              //   },
                              // )),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    ));
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
                    hintText: "Tarih giriniz...",
                    prefixIcon: Icon(icon),
                    suffixIcon: Observer(
                      builder: (_) {
                        return GestureDetector(
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ResponseModel response = await _viewModel
                                .getPrediction(_textEditingController.text);
                            final snackBar = SnackBar(
                              content: Text(response.message),
                              action: SnackBarAction(
                                label: 'Tamam',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Icon(
                            Icons.check,
                            color: Colors.green[300],
                          ),
                        );
                      },
                    ),
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
}
