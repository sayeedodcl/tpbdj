import 'dart:io';


import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:tpbdj/Utilits/SharedPrefManager.dart';
import 'package:tpbdj/main.dart';


class Methods {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool opendrawer = false;
  bool opendrawer2 = false;
  // // ..............................................OTHERS APPBAR ............................................................................
  AppBar bbars(context, key, ativiname) {
    _key = key;

    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      // backwardsCompatibility: true,
      leading: GestureDetector(
        child: Container(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        onTap: () {
          // Navigator.of(context).pop(ModalRoute.withName('/Homepage'));
          //// // ..............................................ACTIVITY BACK  ............................................................................
          if (ativiname == null) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/Homepage", (r) => false);
          } else if (ativiname == "0") {
            Navigator.pop(context);
          } else {
            Navigator.pushNamedAndRemoveUntil(context, ativiname, (r) => false);
          }
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .01,
          ),
          Center(
            child: Text(
              sdata.get(2).toString(),
              style: sheet.appbartitleultra(Colors.black),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 45,
              width: 45,
              child: Image.asset('assets/i.png'),
            ),
            onTap: () {
              // // ..............................................DRAWER OPEN ............................................................................
              if (_key.currentState!.isDrawerOpen) {
                Navigator.pop(context);
              } else {
                _key.currentState!.openDrawer();
              }
            },
          )
        ],
      ),
    );
  }

  void navcontext(context) {
    Navigator.pop(context);
  }

// // ..............................................HOMEPAGE APPBAR ............................................................................
  AppBar bbars2(context, key) {
    _key = key;
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Text(''),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .6,
            alignment: Alignment.topLeft,
            child: Center(
              child: Text(
                sdata.get(2).toString(),
                style: sheet.appbartitleultra(Colors.black),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .025,
          ),
          GestureDetector(
            onTap: () {
              if (_key.currentState!.isDrawerOpen) {
                Navigator.pop(context);
              } else {
                _key.currentState!.openDrawer();
              }
            },
            child: Container(
              child: Container(
                height: 45,
                width: 45,
                child: Image.asset('assets/i.png'),
              ),
            ),
          )
        ],
      ),
    );
  }

// // ..............................................LOGOUT DIALOGES  ............................................................................
  void dialogout(context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.custom,
        text: sdata.get(88).toString(),
        confirmBtnText: sdata.get(58).toString(),
        cancelBtnText: sdata.get(57).toString(),
        cancelBtnTextStyle: sheet.meduim(Colors.black),
        confirmBtnColor: sheet.buttoncolor,
        showCancelBtn: true,
        widget: Container(
          height: 30,
        ),
        backgroundColor: sheet.warning,
        onConfirmBtnTap: () async {
          //       // // ..............................................SHARED PREF RESET ............................................................................
          await SharedPrefManager.setUserLogedIn(false);
          await SharedPrefManager.saveText('');
          await SharedPrefManager.saveRleativeid('');
          await SharedPrefManager.saveRleativename('');
          await SharedPrefManager.saveRleativemobile('');
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/Login', (Route<dynamic> route) => false);
        },
        onCancelBtnTap: () {
          Navigator.pop(context);
        });
  }
  // // ..............................................POPUPMENU METHODS............................................................................

  int _value = 1;
  Widget _nomalPopMenu(context) {
    return new PopupMenuButton<int>(
        itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
              new PopupMenuItem<int>(
                  value: 1,
                  child: Center(
                    child: Container(
                      margin: sheet.pads(0, 10),
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              sheet.relativename.toString(),
                              style: sheet.meduim(Colors.grey.shade800),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              sheet.numbers.toString(),
                              style: sheet.meduim(Colors.grey.shade800),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              new PopupMenuItem<int>(
                  value: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: sheet.decinputfield(),
                    padding: sheet.pads(15, 10),
                    child: new Text(
                      sdata.get(64).toString(),
                      style: sheet.newbutton(Colors.black, 1.5),
                    ),
                  )),
            ],
        onSelected: (int value) {
          _value = value;
          // // ..............................................LOGOUT CODITIONS  ............................................................................
          if (_value == 2) {
            dialogout(context);
          }
          // setState(() {

          // });
        });
  }

// ......................................................................... TIME AND DATE SPLITE METHODS .............................................................

  Widget datesplite(String date) {
    var g;
    if (date.isNotEmpty) {
      g = date.toString().split('-');
      return Text(
          g[2].toString() + '-' + g[1].toString() + '-' + g[0].toString(),
          style: sheet.normal(Colors.black));
    } else {
      return Text(
        '',
        style: sheet.meduimbold(Colors.black),
      );
    }
  }

  Widget timesplite(String time) {
    if (time.isNotEmpty) {
      var g = time.toString().split(':');
      var t = int.parse(g[0]);
      var fg;
      if (t > 12) {
        fg = t - 12;
        fg = fg.toString();
        return Text(
            fg.toString() +
                ':' +
                g[1].toString() +
                ':' +
                g[2].toString() +
                ' PM'.toString(),
            style: sheet.normal(Colors.black));
      } else if (t == 12) {
        fg = 0;
        fg = fg.toString();
        return Text(
            fg.toString() +
                ':' +
                g[1].toString() +
                ':' +
                g[2].toString() +
                ' PM'.toString(),
            style: sheet.normal(Colors.black));
      } else if (t == 24) {
        fg = 0;
        fg = fg.toString();
        return Text(
            fg.toString() +
                ':' +
                g[1].toString() +
                ':' +
                g[2].toString() +
                ' AM'.toString(),
            style: sheet.normal(Colors.black));
      } else {
        fg = t.toString();
        return Text(
            fg.toString() +
                ':' +
                g[1].toString() +
                ':' +
                g[2].toString() +
                ' AM'.toString(),
            style: sheet.normal(Colors.black));
      }
    } else {
      return Text(
        '',
        style: sheet.meduimbold(Colors.black),
      );
    }
  }

// // ..............................................NAV DRAWER  ............................................................................
  Drawer drawers(context) {
    return Drawer(
      child: SafeArea(
          child: Container(
        color: Colors.white,
        // decoration: BoxDecoration(
        //   // image: DecorationImage(
        //   //     image: AssetImage("assets/bg.png"), fit: BoxFit.cover)
        //   color: Colors.white,
        // ),
        child: Column(
          children: [
            Container(
              padding: sheet.pads(15, 10),
              height: 150,
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 80,
                    child: Image.asset('assets/i.png'),
                  ),
                  Text(
                    sdata.get(1).toString(),
                    style: sheet.meduim(Colors.grey.shade700),
                  )
                ],
              ),
            ), // // ..............................................ACCOUNT INFO............................................................................
            Expanded(
              child: Container(
                margin: sheet.pads(25, 10),
                height: MediaQuery.of(context).size.height * .1,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      sheet.relativename.toString(),
                      style: sheet.meduim(Colors.grey.shade800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      sheet.numbers.toString(),
                      style: sheet.meduim(Colors.grey.shade800),
                    ),
                  ],
                ),
              ),
            ), // // ..............................................LOGOUT BUTTON ............................................................................
            GestureDetector(
              child: Card(
                shape: sheet.cardborder(),
                elevation: 1.5,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: sheet.pads(10, 10),
                    child: ListTile(
                      title: new Text(
                        sdata.get(64).toString(),
                        style: sheet.newbutton(Colors.black, 1.5),
                      ),
                      trailing: Icon(Icons.logout),
                    )),
              ),
              onTap: () {
                dialogout(context);
              },
            )
          ],
        ),
      )),
    );
  }
}
