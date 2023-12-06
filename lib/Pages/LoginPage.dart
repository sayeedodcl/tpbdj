import 'dart:convert';

import 'package:tpbdj/Pages/HomePage.dart';
import 'package:tpbdj/Pages/VerificationPage.dart';
import 'package:tpbdj/Utilits/SharedPrefManager.dart';
import 'package:tpbdj/main.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phone = new TextEditingController();
  bool? lodings = false;

  var newuser;

  Future<void> _login() async {
    var url = Uri.parse(apilink.serverapi() + "relative/login");
    var response = await http.post(url, body: {'mobile': _phone.text});
    var jsonrespons = json.decode(response.body);
    print(jsonrespons);
    if (jsonrespons['success'] == "OTP Send") {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationPage(mobile: _phone.text)));

      //Navigator.of(context).pushNamedAndRemoveUntil('/Verification', (Route<dynamic> route) => false);
    } else if (jsonrespons['error'] == "Number not found") {
      Navigator.pop(context);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        backgroundColor: sheet.buttoncolor,
        confirmBtnColor: sheet.buttoncolor,
        text: sdata.get(60).toString(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  // ignore: non_constant_identifier_names
  void check_if_already_login() async {
    newuser = await SharedPrefManager.isUserLogedIn();
    //newuser = (logindata.get('isuser') ?? true);
    print(newuser);
    if (newuser == true) {
      //Navigator.pop(context,this);
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sheet.bg,
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .92,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),
                        Container(
                          alignment: Alignment.center,
                          height: 100,
                          child: Image.asset('assets/i.png'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              sdata.get(2).toString(),
                              style: sheet.signupTextBold(Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .3,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                              shape: sheet.cardborder(),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .02,
                                    ),
                                    Container(
                                      margin: sheet.pads(15, 5),
                                      child: Text(
                                        sdata.get(15).toString(),
                                        style: sheet.meduim(Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .002,
                                    ),
                                    Container(
                                      margin: sheet.pads(15, 5),
                                      child: CupertinoTextField(
                                        padding: sheet.pads(5, 15),
                                        prefix: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              
                                              Icon(
                                                Icons.phone_android,
                                                size: sheet.appbariconSize,
                                              ),Text('+88',style: sheet.meduim(Colors.black),),
                                            ],
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: _phone,
                                        maxLength: 11,
                                        placeholder: sdata.get(17).toString(),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .02,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: CupertinoButton(
                                          color: sheet.buttoncolor,
                                          child: Text(
                                            sdata.get(8).toString(),
                                            style: sheet.newbutton(
                                                Colors.white, 1.5),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              lodings = true;

                                              if (_phone.text
                                                  .toString()
                                                  .isNotEmpty) {
                                                showdia();
                                                _login();
                                              } else {
                                                CoolAlert.show(
                                                  context: context,
                                                  confirmBtnColor:
                                                      sheet.buttoncolor,
                                                  type: CoolAlertType.warning,
                                                  backgroundColor:
                                                      sheet.warning,
                                                  text: sdata
                                                      .get(67)
                                                      .toString(),
                                                );
                                              }
                                            });

                                            // Navigator.pushNamed(context, '/Verification');
                                          }),
                                    )
                                  ])),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sdata.get(0).toString(),
                        style: sheet.normal(Colors.grey.shade700),
                      ),
                      Text(
                        sdata.get(1).toString(),
                        style: sheet.meduim(Colors.grey.shade700),
                      ),
                    ],
                  )
                  // Container(

                  //   height: 55,
                  //   child: Bottombar())
                ],
              ),
            )),
      ),
    );
  }

  void showdia() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: Text(
                        sdata.get(63).toString(),
                        style: sheet.lodingText(Colors.grey.shade700),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
