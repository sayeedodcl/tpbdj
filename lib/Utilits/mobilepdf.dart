import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';


Future<void> saveAndLaunchFile(List<int> bytes,String fname)async{
  final  path=(await getTemporaryDirectory()).path;
  final file=File('$path/$fname');
  await file.writeAsBytes(bytes,flush: true);
  OpenFile.open('$path/$fname');
}