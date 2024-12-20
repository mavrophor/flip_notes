import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

part 'local_db.g.dart';

@Riverpod(keepAlive: true)
class LocalDb extends _$LocalDb {
  static const String notesTable = 'notes';

  @override
  FutureOr<Database> build() async {
    Database db;
    sqfliteFfiInit();
    final path = await getDatabasesPath();
    databaseFactory = databaseFactoryFfi;
    db = await databaseFactory.openDatabase(
      join(path, 'local_db.db'),
      options: OpenDatabaseOptions(onConfigure: _configDB),
    );
    return db;
  }

  FutureOr<void> _configDB(db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS $notesTable (
          $notesTableColumns
        )
      ''');
  }

  static const String notesTableColumns = '''
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  contentFront TEXT NOT NULL,
  contentBack TEXT NOT NULL,
  color INTEGER NOT NULL,
  tags TEXT NOT NULL,
  createdAt INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL,
  deletedAt INTEGER
''';

  Future clearAllUserData() async {
    if (!state.hasValue) return;
    final db = state.value!;
    for (final table in [notesTable]) {
      await db.execute('DROP TABLE IF EXISTS $table');
    }
    await db.close();
    ref.invalidateSelf();
    return;
  }
}
