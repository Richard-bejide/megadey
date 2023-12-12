import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  late SharedPreferences _sharedPreferences;
  late Database db;

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Directory dir = await getApplicationDocumentsDirectory();

    String path = dir.path + "megadey_mobile.db";

    db = await openDatabase(path, version: 1);
  }

  SharedPreferences get sharedPreferences => _sharedPreferences;
}

LocalDatabase database = LocalDatabase();
