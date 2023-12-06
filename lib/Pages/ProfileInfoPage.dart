import 'dart:convert';

import 'package:tpbdj/Models/HistoryModel.dart';
import 'package:tpbdj/Pages/SetTimePage.dart';
import 'package:tpbdj/Utilits/SharedPrefManager.dart';
import 'package:tpbdj/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileInfoPage extends StatefulWidget {
  int id;
  String? pid;
  String? prisonerId;
  String? caseNo;
  String? dob;
  String? name;
  String? fatherName;
  String? motherName;
  String? husbandName;
  String? wifeName;
  String? nationalId;
  String? birthCertificateId;
  String? country;
  String? division;
  String? district;
  String? subDistrict;
  String? prisonid;
  String? image;
  String? locinprison;
  ProfileInfoPage({
    Key? key,
    required this.id,
    required this.pid,
    required this.prisonerId,
    required this.caseNo,
    required this.dob,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.husbandName,
    required this.wifeName,
    required this.nationalId,
    required this.birthCertificateId,
    required this.country,
    required this.division,
    required this.district,
    required this.subDistrict,
    required this.prisonid,
    required this.image,
    required this.locinprison,
  }) : super(key: key);

  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  String? rids;
  @override
  void initState() {
    super.initState();
    getrids();
  }

  Future<void> getrids() async {
    rids = await SharedPrefManager.getrelativeid();
  }

  Future<List<HistoryModel>> _gethistory() async {
    var token = await SharedPrefManager.getText();
    print("cvallfrom get");
    print(widget.id.toString());
    var url = Uri.parse(apilink.serverapi() + "relative/prisoner");
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'prisoner_id': widget.id.toString(),
    });

    print(json.decode(response.body));
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    List<HistoryModel> history = [];

    try {
      for (var i in jsonResponse['transfers']) {
        HistoryModel data = HistoryModel(
          id: i['id'],
          typeCode: i['type_code'].toString(),
          prisonId: i['prison_id'],
          prisonerId: i['prisoner_id'],
          from: i['from'].toString(),
          to: i['to'].toString(),
          transferDate: i['transfer_date'].toString(),
          transferTime: i['transfer_time'].toString(),
          transferStatus: i['transfer_status'].toString(),
          userId: i['user_id'],
          createdAt: i['created_at'].toString(),
          updatedAt: i['updated_at'].toString(),
        );
        history.add(data);
      }
    } catch (e) {
      print(e);
    }
    return history;
  }

  FutureBuilder<List<HistoryModel>> _listshistory(BuildContext context) {
    return FutureBuilder(
      future: _gethistory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return SingleChildScrollView(
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
          ));
        }
         else {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .88,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext contex, int index) {
                    return Card(
                      shape: sheet.cardborder(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .32,
                        margin: sheet.pads(15, 15),
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(79).toString(),
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
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.dob != 'null'
                                            ? snapshot.data[index].typeCode
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(80).toString(),
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
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.dob != 'null'
                                            ? snapshot.data[index].from
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(81).toString(),
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
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.dob != 'null'
                                            ? snapshot.data[index].to
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(82).toString(),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        padding: sheet.pads(10, 0),
                                        child: _datesplite(snapshot
                                            .data[index].transferDate
                                            .toString())),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(83).toString(),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        padding: sheet.pads(10, 0),
                                        child: _timesplite(snapshot
                                            .data[index].transferTime
                                            .toString())),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(84).toString(),
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
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.dob != 'null'
                                            ? snapshot
                                                .data[index].transferStatus
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
      },
    );
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();
  // ....................................................Scaffold........................................
  @override
  Widget build(BuildContext context) {
    String ativname = "/Profilelist".toString();
    return Scaffold(
      backgroundColor: sheet.bg,
      appBar: m.bbars(context, _key, ativname),
      body: Scaffold(
        key: _key,
        drawer: m.drawers(context),
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Card(
                  shape: sheet.cardborder(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .85,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * .30,
                                    child: widget.image != null
                                        ? Image.network(widget.image.toString())
                                        : Image.asset('assets/i.png')),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .6,
                                  padding: sheet.pads(10, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .16,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  sdata.get(38).toString(),
                                                  style: sheet
                                                      .normal(Colors.black),
                                                ),
                                                Text(
                                                  ":",
                                                  style: sheet
                                                      .meduim(Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            padding: sheet.pads(10, 0),
                                            child: Text(
                                              widget.name.toString(),
                                              style:
                                                  sheet.normal(Colors.black),
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
                                                .16,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  sdata.get(39).toString(),
                                                  style: sheet
                                                      .normal(Colors.black),
                                                ),
                                                Text(
                                                  ":",
                                                  style: sheet
                                                      .meduim(Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            padding: sheet.pads(10, 0),
                                            child: Text(
                                              widget.prisonerId.toString(),
                                              style:
                                                  sheet.normal(Colors.black),
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
                                                .17,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  sdata.get(41).toString(),
                                                  style: sheet
                                                      .normal(Colors.black),
                                                ),
                                                Text(
                                                  ":",
                                                  style: sheet
                                                      .meduim(Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            padding: sheet.pads(10, 0),
                                            child: Text(
                                              widget.caseNo.toString(),
                                              style:
                                                  sheet.normal(Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Row(
                                      //  children: [
                                      //    Container(
                                      //      width: MediaQuery.of(context).size.width*.3,
                                      //      height: MediaQuery.of(context).size.height*.06,
                                      //      color: Colors.amber,
                                      //    ),
                                      //  ],
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: sheet.pads(10, 22),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(42).toString(),
                                            style: sheet.normal(Colors.black),
                                          ),
                                          Text(
                                            ":",
                                            style: sheet.meduim(Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.dob != 'null'
                                            ? widget.dob.toString()
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(43).toString(),
                                            style: sheet.normal(Colors.black),
                                          ),
                                          Text(
                                            ":",
                                            style: sheet.meduim(Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.fatherName != 'null'
                                            ? widget.fatherName.toString()
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(44).toString(),
                                            style: sheet.normal(Colors.black),
                                          ),
                                          Text(
                                            ":",
                                            style: sheet.meduim(Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.motherName != 'null'
                                            ? widget.motherName.toString()
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(47).toString(),
                                            style: sheet.normal(Colors.black),
                                          ),
                                          Text(
                                            ":",
                                            style: sheet.meduim(Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.country != 'null'
                                            ? widget.country.toString()
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(48).toString(),
                                            style: sheet.normal(Colors.black),
                                          ),
                                          Text(
                                            ":",
                                            style: sheet.meduim(Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.division != 'null'
                                            ? widget.division.toString()
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(49).toString(),
                                            style: sheet.normal(Colors.black),
                                          ),
                                          Text(
                                            ":",
                                            style: sheet.meduim(Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.district != 'null'
                                            ? widget.district.toString()
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(90).toString(),
                                            style: sheet.normal(Colors.black),
                                          ),
                                          Text(
                                            ":",
                                            style: sheet.meduim(Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: prisonname(
                                          widget.prisonid.toString()),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sdata.get(89).toString(),
                                            style: sheet.normal(Colors.black),
                                          ),
                                          Text(
                                            ":",
                                            style: sheet.meduim(Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      padding: sheet.pads(10, 0),
                                      child: Text(
                                        widget.locinprison != 'null'
                                            ? widget.locinprison.toString()
                                            : sdata.get(59).toString(),
                                        style: sheet.normal(Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                // ...................Calling History.........................................
                                GestureDetector(
                                  onTap: () {
                                    _showhistory();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .07,
                                    color: sheet.buttoncolor,
                                    margin: sheet.pads(8, 0),
                                    child: Center(
                                        child: Text(
                                      sdata.get(85).toString(),
                                      style: sheet.meduim(Colors.white),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //  Calling Set Time .......................................
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SetTimePage(
                                                id: widget.id.toString(),
                                                rid: rids.toString())));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .075,
                                    color: sheet.buttoncolor,
                                    margin: sheet.pads(8, 0),
                                    child: Center(
                                        child: Text(
                                      sdata.get(19).toString(),
                                      style: sheet.meduim(Colors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //   Bottombar(),
            ],
          ),
        )),
      ),
    );
  }

// ................................................ Date Time Function...............................................
  Widget _datesplite(String date) {
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

  Widget _timesplite(String time) {
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

// ......................................................History Data/...............................................................
  void _showhistory() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.grey.shade500,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                          ))),
                ),
                _listshistory(context)
              ],
            ),
          );
        });
  }

  Future<dynamic> getprisonname(String pid) async {
    print("get" + pid.toString());
    var token = await SharedPrefManager.getText();

    var url = Uri.parse(apilink.serverapi() + "relative/prison_by_id");
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'prison_id': pid.toString(),
    });
    print('name from api' + response.body);
    var res = json.decode(response.body);
    if (res['prison'] == null) {
      var s = "Not found";
      return s;
    } else {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["prison"];
      print(data[0]["name"]);
      return data[0]["name"];
    }
  }

  Widget prisonname(String id) {
    if (id.isEmpty) {
      return Text(sdata.get(59).toString());
    } else {
      return FutureBuilder<dynamic>(
        future: getprisonname(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    snapshot.data != null ? snapshot.data.toString() : "empty",
                    style: sheet.normal(Colors.black),
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
}
