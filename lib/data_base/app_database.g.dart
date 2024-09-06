// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AddCartDao? _addCartDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `addCart` (`cartId` INTEGER PRIMARY KEY AUTOINCREMENT, `productId` INTEGER, `image` TEXT, `productName` TEXT, `price` REAL, `currency` TEXT, `quantity` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AddCartDao get addCartDao {
    return _addCartDaoInstance ??= _$AddCartDao(database, changeListener);
  }
}

class _$AddCartDao extends AddCartDao {
  _$AddCartDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _addCartInsertionAdapter = InsertionAdapter(
            database,
            'addCart',
            (AddCart item) => <String, Object?>{
                  'cartId': item.cartId,
                  'productId': item.productId,
                  'image': item.image,
                  'productName': item.productName,
                  'price': item.price,
                  'currency': item.currency,
                  'quantity': item.quantity
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AddCart> _addCartInsertionAdapter;

  @override
  Future<int?> delete(int intCartID) async {
    return _queryAdapter.query('delete From addCart where cartId=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [intCartID]);
  }

  @override
  Future<List<AddCart>> fetchAll() async {
    return _queryAdapter.queryList('SELECT * FROM addCart',
        mapper: (Map<String, Object?> row) => AddCart(
            row['cartId'] as int?,
            row['productId'] as int?,
            row['image'] as String?,
            row['productName'] as String?,
            row['price'] as double?,
            row['currency'] as String?,
            row['quantity'] as int?));
  }

  @override
  Future<int?> updateQty(
    int cartId,
    int quantity,
  ) async {
    return _queryAdapter.query(
        'UPDATE addCart SET quantity = ?2  WHERE cartId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cartId, quantity]);
  }

  @override
  Future<int?> updateProductPrice(
    int cartId,
    double price,
  ) async {
    return _queryAdapter.query(
        'UPDATE addCart SET price = ?2  WHERE cartId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cartId, price]);
  }

  @override
  Future<int?> updateTotPrice(
    int cartId,
    double totalPrice,
  ) async {
    return _queryAdapter.query(
        'UPDATE addCart SET totalPrice = ?2  WHERE cartId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cartId, totalPrice]);
  }

  @override
  Future<int?> deleteAll() async {
    return _queryAdapter.query('delete From addCart',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int> insertCart(AddCart addCart) {
    return _addCartInsertionAdapter.insertAndReturnId(
        addCart, OnConflictStrategy.abort);
  }
}
