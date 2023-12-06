import 'dart:convert';
import 'dart:io';

import 'package:tpbdj/Models/Prisoners.dart';
import 'package:tpbdj/Pages/ProfileInfoPage.dart';
import 'package:tpbdj/Utilits/SharedPrefManager.dart';
import 'package:tpbdj/main.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileListPage extends StatefulWidget {
  ProfileListPage({Key? key}) : super(key: key);

  @override
  _ProfileListPageState createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  int _value = 1;
  Future<List<Prisoners>> _getdatas() async {
    var token = await SharedPrefManager.getText();

    var url = Uri.parse(apilink.serverapi() + "relative/dashboard");
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    print(json.decode(response.body));
    var jsonResponse = json.decode(response.body);

    List<Prisoners> prison = [];

    try {
      for (var i in jsonResponse['prisoners']) {
        Prisoners data = Prisoners(
          id: i['id'],
          pid: i['pid'].toString(),
          prisonerId: i['prisoner_id'].toString(),
          caseNo: i['case_no'].toString(),
          dob: i['dob'].toString(),
          name: i['name'].toString(),
          fatherName: i['father_name'].toString(),
          motherName: i['mother_name'].toString(),
          husbandName: i['husband_name'].toString(),
          wifeName: i['wife_name'].toString(),
          nationalId: i['national_id'].toString(),
          birthCertificateId: i['birth_certificate_id'].toString(),
          country: i['country'].toString(),
          division: i['division'].toString(),
          district: i['district'].toString(),
          subDistrict: i['sub_district'].toString(),
          address: i['address'].toString(),
          image: i['image'].toString(),
          identifier1: i['identifier_1'].toString(),
          identifier2: i['identifier_2'].toString(),
          identifier3: i['identifier_3'].toString(),
          identifier4: i['identifier_4'].toString(),
          identifier5: i['identifier_5'].toString(),
          locationInsidePrison: i['location_inside_prison'].toString(),
          relativeId: i['relative_id'],
          prisonId: i['prison_id'],
          userId: i['user_id'],
          createdAt: i['created_at'].toString(),
          updatedAt: i['updated_at'].toString(),
        );
        prison.add(data);
      }
    } catch (e) {
      print(e);
    }
    return prison;
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

  FutureBuilder<List<Prisoners>> _lists(BuildContext Context) {
    return FutureBuilder(
      future: _getdatas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
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
        } else {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext contex, int index) {
                    return GestureDetector(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .3,
                        padding: sheet.pads(5, 5),
                        child: Card(
                          shape: sheet.cardborder(),
                          elevation: 1.5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: sheet.pads(5, 5),
                                  width: MediaQuery.of(context).size.width * .3,
                                  child: snapshot.data[index].image != null
                                      ? Image.network(
                                          snapshot.data[index].image,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset('assets/i.png'),
                                ),
                                Container(
                                  padding: sheet.pads(10, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
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
                                                    .25,
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
                                                    .6,
                                                padding: sheet.pads(10, 0),
                                                child: Text(
                                                  snapshot.data[index].name !=
                                                          'null'
                                                      ? snapshot
                                                          .data[index].name
                                                          .toString()
                                                      : sdata
                                                          .get(59)
                                                          .toString(),
                                                  style: sheet
                                                      .normal(Colors.black),
                                                ),
                                              ),
                                            ],
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
                                                .25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  sdata.get(93).toString(),
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
                                                .6,
                                            padding: sheet.pads(10, 0),
                                            child: prisonname(snapshot
                                                .data[index].prisonId
                                                .toString()),
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
                                                .25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  sdata.get(92).toString(),
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
                                                .6,
                                            padding: sheet.pads(10, 0),
                                            child: Text(
                                              snapshot.data[index].caseNo !=
                                                      'null'
                                                  ? snapshot.data[index].caseNo
                                                      .toString()
                                                  : sdata.get(59).toString(),
                                              style: sheet.normal(Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileInfoPage(
                                id: snapshot.data[index].id,
                                pid: snapshot.data[index].pid,
                                prisonerId: snapshot.data[index].prisonerId,
                                caseNo: snapshot.data[index].caseNo,
                                dob: snapshot.data[index].dob,
                                name: snapshot.data[index].name,
                                fatherName: snapshot.data[index].fatherName,
                                motherName: snapshot.data[index].motherName,
                                husbandName: snapshot.data[index].husbandName,
                                wifeName: snapshot.data[index].wifeName,
                                nationalId: snapshot.data[index].nationalId,
                                birthCertificateId:
                                    snapshot.data[index].birthCertificateId,
                                country: snapshot.data[index].country,
                                division: snapshot.data[index].division,
                                district: snapshot.data[index].district,
                                subDistrict: snapshot.data[index].subDistrict,
                                prisonid:
                                    snapshot.data[index].prisonId.toString(),
                                image: snapshot.data[index].image,
                                locinprison:
                                    snapshot.data[index].locationInsidePrison,
                              ),
                            ));
                      },
                    );
                  }),
            ),
          );
        }
      },
    );
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();
//  .........................................................Scaffold...........................................
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                _lists(context),
              ],
            ),
          ),
        )),
      ),
    );
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
