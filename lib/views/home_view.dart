import 'package:flutter/material.dart';
import 'package:kuraklik_riskim/components/app_bar.dart';
import 'package:kuraklik_riskim/constants/colors.dart';
import 'package:kuraklik_riskim/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel _viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    List<BoxShadow> shadowList = [
      BoxShadow(
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
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
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
}
