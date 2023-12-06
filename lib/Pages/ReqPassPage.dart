import 'dart:convert';
import 'dart:typed_data';

import 'package:tpbdj/Models/PassModel.dart';
import 'package:tpbdj/Models/Prisoners.dart';
import 'package:tpbdj/Utilits/SharedPrefManager.dart';
import 'package:tpbdj/Utilits/mobilepdf.dart';
import 'package:tpbdj/main.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

class ReqPassPage extends StatefulWidget {
  ReqPassPage({Key? key}) : super(key: key);

  @override
  _ReqPassPageState createState() => _ReqPassPageState();
}

class _ReqPassPageState extends State<ReqPassPage> {
  bool accept = false;
  String? _base64;
  late Prisoners prisoners;
  var tok;
  ScrollController _sc = new ScrollController(initialScrollOffset: .8);
  @override
  void initState() {
    super.initState();

    // String rid = await SharedPrefManager.getrelativeid();
    prisoners = new Prisoners();
    //  print('baler apps');
    //  print(prisoners.id.toString());
    //getoks();
  }

  Future<void> getoks() async {
    tok = await SharedPrefManager.getText();
  }

  Future<List<PassModel>> _getdatas() async {
    var token = await SharedPrefManager.getText();
    String rid = await SharedPrefManager.getrelativeid();
    var url =
        Uri.parse(apilink.serverapi() + "relative/visitorpass/by_relative_id");
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'relative_id': rid.toString(),
    });
    print("response");
    print(json.decode(response.body));
    var jsonResponse = json.decode(response.body);
    List<PassModel> pass = [];

    try {
      for (var i in jsonResponse) {
        PassModel data = PassModel(
          id: i['id'],
          prisonerId: i['prisoner_id'],
          relativeId: i['relative_id'],
          numberOfPeople: i['number_of_people'],
          prisonId: i['prison_id'],
          buildingId: i['building_id'],
          roomId: i['room_id'],
          requestedDate: i['requested_date'],
          requestedTime: i['requested_time'],
          approvedDate: i['approved_date'],
          approvedTimeFrom: i['approved_time_from'],
          approvedTimeTo: i['approved_time_to'],
          userId: i['user_id'],
          createdAt: i['created_at'],
          updatedAt: i['updated_at'],
        );
        pass.add(data);
      }
    } catch (e) {
      print(e);
    }
    return pass;
  }

  FutureBuilder<List<PassModel>> _listsRequest(BuildContext context) {
    return FutureBuilder(
      future: _getdatas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Expanded(
            child: Container(
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
            ),
          );
        } else if (snapshot.data.length == 0) {
          Center(
            child: Text(
              sdata.get(97).toString(),
              style: sheet.meduim(Colors.black),
            ),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height * .85,
            child: ListView.builder(
                itemCount: snapshot.data.length,
                controller: _sc,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding: sheet.pads(10, 10),
                      child: Card(
                        elevation: 1.5,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .99,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * .92,
                                    padding: sheet.pads(10, 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        pids(snapshot.data[index].prisonerId
                                            .toString()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        //Full Name

                                        fname(snapshot.data[index].prisonerId
                                            .toString()),
                                        // fname(snapshot.data[index].prisonerId.toString()),
                                        // getname(snapshot.data[index].toString()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    sdata.get(22).toString(),
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                  Text(
                                                    ":",
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .45,
                                              padding: sheet.pads(10, 0),
                                              child: Text(
                                                snapshot
                                                    .data[index].numberOfPeople
                                                    .toString(),
                                                style:
                                                    sheet.normal(Colors.black),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    sdata.get(54).toString(),
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                  Text(
                                                    ":",
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .45,
                                                padding: sheet.pads(5, 0),
                                                child: m.timesplite(snapshot
                                                    .data[index].requestedTime
                                                    .toString())),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    sdata.get(53).toString(),
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                  Text(
                                                    ":",
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .45,
                                                padding: sheet.pads(5, 0),
                                                child: m.datesplite(snapshot
                                                    .data[index].requestedDate
                                                    .toString())),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    sdata.get(65).toString(),
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                  Text(
                                                    ":",
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .45,
                                              padding: sheet.pads(5, 0),
                                              child: snapshot.data[index]
                                                          .approvedDate !=
                                                      null
                                                  ? m.datesplite(snapshot
                                                      .data[index].approvedDate
                                                      .toString())
                                                  : Text(
                                                      sdata.get(59).toString()),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    sdata.get(66).toString(),
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                  Text(
                                                    ":",
                                                    style: sheet
                                                        .normal(Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .45,
                                              padding: sheet.pads(5, 0),
                                              child: snapshot.data[index]
                                                          .approvedTimeFrom !=
                                                      null
                                                  ? m.timesplite(snapshot
                                                      .data[index]
                                                      .approvedTimeFrom
                                                      .toString())
                                                  : Text(
                                                      sdata.get(59).toString()),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 15,
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: _buttons(
                                              snapshot.data[index].approvedDate
                                                  .toString(),
                                              snapshot.data[index].id),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                }),
          );
        }
        return Text(snapshot.data.length.toString());
      },
    );
  }

// ..........................................BUTTONS .....................................
  Widget _buttons(String datas, int ids) {
    // print(datas);
    if (datas != 'null') {
      return GestureDetector(
        child: Container(
          color: sheet.buttoncolor,
          width: MediaQuery.of(context).size.width * .9,
          padding: sheet.pads(5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.cloud_done, size: 50, color: Colors.white),
              Text(sdata.get(16).toString(), style: sheet.meduim(Colors.white))
            ],
          ),
        ),
        onTap: () {
          _pdfrequest(ids);
        },
      );
    } else {
      return Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width * .9,
        padding: sheet.pads(5, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.cloud_done, size: 45, color: Colors.black38),
            Text(sdata.get(16).toString(), style: sheet.meduim(Colors.black38))
          ],
        ),
      );
    }
  }

// ..........................................SCAFFOLD ....................................................................................
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sheet.bg,
      appBar: m.bbars(context, _key, null),
      body: Scaffold(
        key: _key,
        drawer: m.drawers(context),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [_listsRequest(context)],
            ),
          ),
        ),
      ),
    );
  }

// ..........................................PDF Request Area .....................................
  Future<void> _pdfrequest(int id) async {
    var token = await SharedPrefManager.getText();

    var url = Uri.parse(apilink.serverapi() + "relative/visitorpass/download");
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'visitorpass_id': id.toString(),
    });
    // print(response.bodyBytes);

    Uint8List bytes = response.bodyBytes;
    print(bytes);

// ..........................................PDF NAME .....................................
    String fname = id.toString() + '.pdf'.toString();
    saveAndLaunchFile(bytes, fname);
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      backgroundColor: sheet.success,
      text: sdata.get(74).toString(),
      autoCloseDuration: Duration(seconds: 8),
    );
//Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowPdf(bytes: bytes)));

    // dias(bytes);
  }

  void dias(Uint8List b) {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
              title: Container(
            height: MediaQuery.of(context).size.height,
            child: b != null
                ? SfPdfViewer.memory(
                    b,
                  )
                : Container(
                    child: Text(''),
                  ),
          ));
        });
  }

// .........................................Getting Pisoner name .....................................
  Widget fname(String id) {
    if (id.isEmpty) {
      return Text(sdata.get(59).toString());
    } else {
      return FutureBuilder<dynamic>(
        future: getname(id, true),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sdata.get(38).toString(),
                        style: sheet.normal(Colors.black),
                      ),
                      Text(
                        ":",
                        style: sheet.normal(Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    snapshot.data != null ? snapshot.data.toString() : "empty",
                    style: sheet.meduim(Colors.black),
                  ),
                ),
              ],
            );
          }
          return Text("Await for data");
        },
      );
    }
  }

// ..........................................PRISONER PID .....................................
  Widget pids(String id) {
    if (id.isEmpty) {
      return Text(sdata.get(59).toString());
    } else {
      return FutureBuilder<dynamic>(
        future: getname(id, false),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sdata.get(40).toString(),
                        style: sheet.normal(Colors.black),
                      ),
                      Text(
                        ":",
                        style: sheet.normal(Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    snapshot.data != null ? snapshot.data.toString() : "empty",
                    style: sheet.meduim(Colors.black),
                  ),
                ),
              ],
            );
          }
          return Text("Await for data");
        },
      );
    }
  }

// ..........................................GETING NAME FROM  .....................................
  Future<dynamic> getname(String pid, givename) async {
    print("get" + pid.toString());
    var token = await SharedPrefManager.getText();

    var url = Uri.parse(apilink.serverapi() + "relative/prisoner");
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'prisoner_id': pid.toString(),
    });
    print('name from api' + response.body);
    var res = json.decode(response.body);
    if (givename == true) {
      if (res['prisoner'] == null) {
        var s = "Not found";
        return s;
      } else {
        return res['prisoner']['name'];
      }
    } else {
      if (res['prisoner'] == null) {
        var s = "Not found";
        return s;
      } else {
        return res['prisoner']['prisoner_id'];
      }
    }
  }
}
