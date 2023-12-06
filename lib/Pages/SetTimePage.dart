import 'dart:convert';

import 'package:tpbdj/Pages/HomePage.dart';
import 'package:tpbdj/Utilits/SharedPrefManager.dart';
import 'package:tpbdj/main.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SetTimePage extends StatefulWidget {
  String id;
  String rid;
  SetTimePage({Key? key, required this.id, required this.rid})
      : super(key: key);

  @override
  _SetTimePageState createState() => _SetTimePageState();
}

class _SetTimePageState extends State<SetTimePage> {
  TextEditingController _numberVistor = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();
  String prisonerTime = '';
  String prisonerDate = '';

  bool date = false;
  bool time = false;
  bool time1 = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2111));

    if (picked != null)
      setState(() {
        date = true;
        selectedDate = picked;
        print(selectedDate);
      });
  }

  Future<void> _request() async {
    var token = await SharedPrefManager.getText();

    print(widget.rid.toString());
    print(widget.id.toString());
    print(dropdownValue.toString());
    print(prisonerDate);
    print(prisonerTime + ':00');

    var url = Uri.parse(apilink.serverapi() + "relative/visitorpass/send");
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'relative_id': widget.rid.toString(),
      'prisoner_id': widget.id,
      'number_of_people': dropdownValue,
      'requested_date': prisonerDate.toString(),
      'requested_time': prisonerTime.toString()
    });
    var jsonrespons = json.decode(response.body);
    print(jsonrespons['success']);
    print(jsonrespons);

    if (jsonrespons['success'] == "Visitor Pass Requested Successfully") {
      Navigator.pop(context);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        backgroundColor: sheet.success,
        confirmBtnColor: sheet.buttoncolor,
        text: sdata.get(70).toString(),
        autoCloseDuration: Duration(seconds: 3),
      );

      //  startSplashScreenTimer();
      //warning: You can not request for pass. You have to wait atleast 15 days to request again.
    } else if (jsonrespons['warning'] != null) {
      Navigator.pop(context);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        backgroundColor: sheet.warning,
        confirmBtnColor: sheet.buttoncolor,
        text: jsonrespons['warning'].toString(),
        autoCloseDuration: Duration(seconds: 6),
      );
    } else {
      Navigator.pop(context);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        confirmBtnColor: sheet.buttoncolor,
        text: sdata.get(73).toString(),
        autoCloseDuration: Duration(seconds: 4),
      );
    }
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();
  /////////////// ................................................Scaffold...................................
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sheet.bg,
      appBar: m.bbars(context, _key, "0"),
      body: Scaffold(
        key: _key,
        drawer: m.drawers(context),
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                margin: sheet.pads(15, 5),
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: sheet.pads(5, 5),
                      child: Text(
                        sdata.get(94).toString(),
                        style: sheet.meduim(Colors.black),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .08,
                      child: GestureDetector(
                        child: Card(
                          shape: sheet.cardborder(),
                          child: Row(
                            children: [
                              Container(
                                  padding: sheet.pads(8, 0),
                                  width: MediaQuery.of(context).size.width * .1,
                                  child: Icon(
                                    Icons.date_range,
                                    size: sheet.appbariconSize,
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Center(
                                    child: date
                                        ? _datesplite()
                                        : Text(
                                            sdata.get(20).toString(),
                                            style: sheet.placeholderstyle(),
                                          )),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: sheet.pads(15, 5),
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: sheet.pads(5, 5),
                      child: Text(
                        sdata.get(95).toString(),
                        style: sheet.meduim(Colors.black),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .08,
                      child: GestureDetector(
                        child: Card(
                          shape: sheet.cardborder(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: sheet.pads(8, 0),
                                  width: MediaQuery.of(context).size.width * .1,
                                  child: Icon(
                                    Icons.timelapse,
                                    size: sheet.appbariconSize,
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width * .7,
                                child: date
                                    ? _times1splite()
                                    : Text(
                                        sdata.get(21).toString(),
                                        style: sheet.placeholderstyle(),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _selectTime(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: sheet.pads(15, 5),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: sheet.pads(5, 5),
                      child: Text(
                        sdata.get(96).toString(),
                        style: sheet.meduim(Colors.black),
                      ),
                    ),
                    _dorpdown(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  margin: sheet.pads(20, 1),
                  color: Colors.green[900],
                  alignment: Alignment.center,
                  child: Text(
                    sdata.get(14).toString(),
                    style: sheet.meduimbold(Colors.white),
                  ),
                ),
                onTap: () {
                  if (prisonerTime.toString().isEmpty ||
                      prisonerDate.toString().isEmpty) {
                    CoolAlert.show(
                      context: context,
                      backgroundColor: sheet.warning,
                      confirmBtnColor: sheet.buttoncolor,
                      type: CoolAlertType.warning,
                      text: sdata.get(72).toString(),
                    );
                  } else {
                    _confirmbutton(context);
                  }
                },
              )
            ],
          ),
        )),
      ),
    );
  }

  void _confirmbutton(context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.custom,
        text: sdata.get(69).toString(),
        confirmBtnText: sdata.get(58).toString(),
        cancelBtnText: sdata.get(57).toString(),
        cancelBtnTextStyle: sheet.meduim(Colors.black),
        confirmBtnColor: sheet.buttoncolor,
        showCancelBtn: true,
        widget: Container(
          height: 30,
        ),
        backgroundColor: sheet.success,
        onConfirmBtnTap: () async {
          Navigator.pop(context);
          showdia();
          _request();
        },
        onCancelBtnTap: () {
          Navigator.pop(context);
        });
  }

  String dropdownValue = '1';
  Widget _dorpdown() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: sheet.pads(5, 5),
      padding: sheet.pads(7, 5),
      decoration: sheet.indec(),
      child: Column(
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 36,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              width: MediaQuery.of(context).size.width * .5,
              // color: sheet.appointbg,
            ),
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items:
                sheet.visitorss.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                    height: 50,
                    margin: sheet.pads(5, 5),
                    padding: sheet.pads(5, 10),
                    decoration: sheet.inputdec(),
                    width: MediaQuery.of(context).size.width * .64,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16),
                    )),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _datesplite() {
    if (selectedDate != null) {
      var g = selectedDate.toString().split(' ');
      prisonerDate = g[0].toString();
      return Text(g[0].toString(), style: sheet.meduimbold(Colors.black));
    } else {
      return Text(
        sdata.get(20).toString(),
        style: sheet.meduimbold(Colors.black),
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: selectedTime1,
    );

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        time1 = true;
        // print(selectedTime1);
      });
  }

  Widget _times1splite() {
    if (selectedTime != null) {
      var g = selectedTime.toString().split('(');
      var g0 = g[1].toString().split(')');
      prisonerTime = g0[0].toString();
      return Text(g0[0].toString(), style: sheet.meduimbold(Colors.black));
    } else {
      return Text(
        sdata.get(21).toString(),
        style: sheet.meduimbold(Colors.black),
      );
    }
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

  startSplashScreenTimer() async {
    Future.delayed(Duration(seconds: 4)).then((v) {
      // Navigator.popAndPushNamed(context, '/IntroPage');
      Navigator.pop(context, this);
      Navigator.push(context, CupertinoPageRoute(builder: (_) => HomePage()));
    });
  }
}
