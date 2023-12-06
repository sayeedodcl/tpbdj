import 'dart:convert';

import 'package:tpbdj/Utilits/SharedPrefManager.dart';
import 'package:tpbdj/main.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerificationPage extends StatefulWidget {
  String mobile;
  VerificationPage({Key? key, required this.mobile}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController _phoneOTP = new TextEditingController();

  Future<void> _otpVeri() async {
    print(widget.mobile);
    var url = Uri.parse(apilink.serverapi() + "relative/login/otp/go");
    var response = await http
        .post(url, body: {'mobile': widget.mobile, 'otp': _phoneOTP.text});
    var jsonrespons = json.decode(response.body);
    print(jsonrespons);
    if (jsonrespons['message'] == "Sign In Successful") {
      Navigator.pop(context);
      // var dtass=json.decode(jsonrespons['data']);
      var tok = jsonrespons['data']['token'];
      var rid = jsonrespons['data']['relative']['id'];
      var phn = jsonrespons['data']['relative']['mobile'];
      var name = jsonrespons['data']['relative']['name'];

      print("Checking relative id " + rid.toString());

      await SharedPrefManager.saveText(tok);
      await SharedPrefManager.setUserLogedIn(true);
      await SharedPrefManager.saveRleativeid(rid.toString());
      await SharedPrefManager.saveRleativemobile(phn.toString());
      await SharedPrefManager.saveRleativename(name.toString());

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/Homepage', (Route<dynamic> route) => false);
    } else {
      Navigator.pop(context);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        backgroundColor: sheet.buttoncolor,
        confirmBtnColor: sheet.buttoncolor,
        text: sdata.get(62).toString(),
      );
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
                    padding: sheet.pads(15, 10),
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
                          height: MediaQuery.of(context).size.height * .32,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                              shape: sheet.cardborder(),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    Container(
                                      margin: sheet.pads(15, 5),
                                      child: Text(
                                        sdata.get(9).toString(),
                                        style: sheet.meduim(Colors.black87),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: sheet.pads(15, 5),
                                      child: Text(
                                        widget.mobile,
                                        style: sheet.meduimbold(Colors.black),
                                        textAlign: TextAlign.center,
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
                                        keyboardType: TextInputType.number,
                                        prefix: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.phone_android,
                                            size: sheet.appbariconSize,
                                          ),
                                        ),
                                        controller: _phoneOTP,
                                        placeholder: sdata.get(10).toString(),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: CupertinoButton(
                                          color: sheet.buttoncolor,
                                          child: Text(
                                            sdata.get(8).toString(),
                                            style:
                                                sheet.titleultra(Colors.white),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (_phoneOTP.text
                                                  .toString()
                                                  .isNotEmpty) {
                                                showdia();
                                                _otpVeri();
                                              } else {
                                                CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.warning,
                                                  backgroundColor:
                                                      sheet.warning,
                                                  confirmBtnColor:
                                                      sheet.buttoncolor,
                                                  text:
                                                      sdata.get(68).toString(),
                                                );
                                              }
                                            });
                                            // Navigator.pushNamed(context, '/Homepage');
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
