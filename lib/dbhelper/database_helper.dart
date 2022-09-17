import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note_model.dart';
import 'constant.dart';

class DataBaseHelper {

  DataBaseHelper._();

   Database? _database;

  static final DataBaseHelper db = DataBaseHelper._();

   Future<Database?> get database async {
     if (_database != null)
       return _database!;

       _database= await initDb();
       return _database!;
   }




  initDb() async {
    String path = join(await getDatabasesPath(), 'note.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
   CREATE TABLE $tableNote (
   $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
   $columnTitle TEXT NOT NULL,
   $columnDescription TEXT NOT NULL)
   ''').then((value) => print("table created /////////////////////")).catchError((error) => print("/////////////error in creating table $error"));
    });


  }

  //CURD

  //CREATE
  insertNote(NoteModel note) async {
    var db =await database;
    return await db!.insert(tableNote, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //update
  updateNote(NoteModel note) async {
    var dbClient = await database;
    return await dbClient!.update(
      tableNote,
      note.toMap(),
      where: '$columnId = ?',
      whereArgs: [note.id],
    );
  }


  //READ
  Future<List<NoteModel>> getAllNote() async {
    var dbClient = await database;
    List<Map<String, dynamic>> maps = await dbClient!.query(tableNote);
    return maps.isNotEmpty ?
      maps.map((e) => NoteModel.fromMap(e)).toList() : [];
  }


  //delete
  deleteNote (int id) async {
    var dbClient = await database;
    return await dbClient!.delete(
      tableNote,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }


}
