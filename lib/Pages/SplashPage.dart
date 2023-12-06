import 'dart:io';

import 'package:tpbdj/Pages/LoginPage.dart';
import 'package:tpbdj/main.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplashScreenTimer() async {
    Future.delayed(Duration(seconds: 3)).then((v) {
      Navigator.pop(context, this);
      // Navigator.popAndPushNamed(context, '/IntroPage');

      Navigator.push(context, CupertinoPageRoute(builder: (_) => LoginPage()));
    });
  }

  void _checkmetheod() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      startSplashScreenTimer();
    } else {
      CoolAlert.show(
          context: context,
          backgroundColor: Colors.green.shade50,
          type: CoolAlertType.confirm,
          title: sdata.get(76).toString(),
          text: sdata.get(75).toString(),
          confirmBtnText: sdata.get(77).toString(),
          confirmBtnColor: Colors.green,
          cancelBtnText: sdata.get(78).toString(),
          onConfirmBtnTap: () {
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, "/SplashPage");
            // startSplashScreenTimer();
          },
          onCancelBtnTap: () {
            exit(0);
          });
      // CoolAlert.show(
      //     context: context,
      //     type: CoolAlertType.show,
      //     title: sdata.get(76).toString(),
      //     text: sdata.get(75).toString(),

      //     confirmBtnText:sdata.get(77).toString(),
      //     confirmBtnColor: Colors.green,
      //     cancelBtnText: sdata.get(78).toString(),
      //     onConfirmBtnTap: (){
      //       Navigator.pop(context);
      //       startSplashScreenTimer();
      //     }

      //   );

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkmetheod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sheet.bg,
        body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/mj.png"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .25,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .5,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .20,
                              width: MediaQuery.of(context).size.width * .35,
                              child: Image.asset(
                                "assets/i.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              sdata.get(2).toString(),
                              style: sheet.title(Colors.black),
                            )
                          ],
                        ),
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
              )),
        ));
  }
}

// child: Center(child: FlareActor("assets/logointro.flr",
//               animation: "logointro",
//               alignment: Alignment.center,
//               fit: BoxFit.contain,),),)
