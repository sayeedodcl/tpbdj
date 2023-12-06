import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:tpbdj/Models/Prisoners.dart';
import 'package:tpbdj/Utilits/SharedPrefManager.dart';
import 'package:tpbdj/main.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? tokes;
  String? rid;
  String? names;
  String? phns;
  int _value = 1;

  @override
  void initState() {
    super.initState();
    shareddata();
  }

  void setchagne() {
    setState(() {});
  }

  void shareddata() async {
    // // ..............................................GET DATA FROM SHARED PREF ............................................................................
    tokes = await SharedPrefManager.getText();
    rid = await SharedPrefManager.getrelativeid();
    phns = await SharedPrefManager.getrelativemobile();
    names = await SharedPrefManager.getrelativename();

    setState(() {
      sheet.relativename = names.toString();
      sheet.numbers = phns.toString();
    });
    print("this tokes value");
    print(tokes);
    // print("this Rid value");
    // print(rid);
    // print("this tokes value");
    // print(phns);
    // print("this Rid value");
    // print(names);
    _getdatas();
  }

// ..............................................GETIING DATA FROM DATABASE ............................................................................
  Future<List<Prisoners>> _getdatas() async {
    var url = Uri.parse(apilink.serverapi() + "relative/dashboard");
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $tokes'});

    print(json.decode(response.body));
    var jsonResponse = json.decode(response.body);

    List<Prisoners> prison = [];
// ..............................................INSERT DATA TO PRISONER MODEL ............................................................................
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

  GlobalKey<ScaffoldState> _key = GlobalKey();
// ..............................................mAIN  SCAFFOLD PROGRAM ENTRE POINT ............................................................................
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sheet.bg,
      appBar: m.bbars2(context, _key),
      // drawer: m.drawers(),

      body: Scaffold(
        drawer: m.drawers(
            context), // ..............................................EXTERNAL DRAWER FROM METHODS ............................................................................
        key: _key,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: sheet.pads(15, 17),
                    height: MediaQuery.of(context).size.height * .81,
                    // color: Colors.amberAccent,
                    child: Column(
                      children: [
                        // _imageslider(),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // // ..............................................PRISONER PROFILE  ............................................................................
                              GestureDetector(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .15,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    elevation: 1.5,
                                    shape: sheet.cardborder(),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: sheet.pads(10, 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .10,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .25,
                                          child: Image.asset(
                                            'assets/pref.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          sdata.get(12).toString(),
                                          style:
                                              sheet.meduimbold1(Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/Profilelist');
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .017,
                              ),
                              // // ..............................................REQUEST PASS ............................................................................
                              GestureDetector(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .15,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    elevation: 1.5,
                                    shape: sheet.cardborder(),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: sheet.pads(10, 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .10,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .25,
                                          child: Image.asset(
                                            'assets/pass.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          sdata.get(14).toString(),
                                          style:
                                              sheet.meduimbold1(Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/Reqpass');
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // // ..............................................PRISON.GOV.BD ............................................................................
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
            ),
          ),
        ),
      ),
    );
  }

// ..............................................IMAGE SLIDER AREA ............................................................................
  // Widget _imageslider() {
  //   return Card(
  //     child: Container(
  //       height: MediaQuery.of(context).size.height * .2,
  //       padding: sheet.pads(5, 5),
  //       child: Swiper(
  //         itemBuilder: (BuildContext context, int index) {
  //           return Image(
  //             image: AssetImage('assets/bt.jpg'),
  //             fit: BoxFit.fill,
  //           );
  //         },
  //         itemCount: 1,
  //         pagination: new SwiperPagination(),
  //         // control: new SwiperControl(),
  //       ),
  //     ),
  //   );
  // }
// // ..............................................GETIING DATA FROM DATABASE ............................................................................
//   void dias() {
//     CoolAlert.show(
//         context: context,
//         type: CoolAlertType.confirm,
//         text: 'Do you want to logout',
//         confirmBtnText: sdata.get(58).toString(),
//         cancelBtnText: sdata.get(57).toString(),
//         confirmBtnColor: Colors.green,
//         onConfirmBtnTap: () async {
//           await SharedPrefManager.setUserLogedIn(false);
//           await SharedPrefManager.saveText('');
//           await SharedPrefManager.saveRleativeid('');
//           exit(0);
//         },
//         onCancelBtnTap: () {
//           Navigator.pop(context);
//         });
//   }
}
