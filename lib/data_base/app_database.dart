
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_gate/data_base/master/AddCart.dart';
import 'package:flutter_gate/data_base/master/AddCartDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [
  AddCart,
 ])
abstract class AppDatabase extends FloorDatabase {
  AddCartDao get addCartDao;
 }
