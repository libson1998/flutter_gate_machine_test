import 'package:flutter/cupertino.dart';

import 'app_database.dart';

class DatabaseClient {
  Future<AppDatabase> dbClient() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppDatabase database;

    database = await $FloorAppDatabase
        .databaseBuilder('buraq.db')
        .build();

    return database;
  }

  // final migration_1To2 = Migration(1, 2, (database) async {
  //   database.execute('ALTER TABLE hall ADD COLUMN hallColor TEXT');
  //   database.execute('ALTER TABLE restTable ADD COLUMN tableColor TEXT');
  // });
}
