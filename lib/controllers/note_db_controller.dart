import 'package:note_getx/models/note.dart';
import 'package:note_getx/storage/db_getx.dart';
import 'package:note_getx/storage/db_operations.dart';
import 'package:sqflite/sqflite.dart';

class NoteDbController extends DbOperations<Note> {
  Database database = DbGetx().database;

  @override
  Future<int> create(Note object) async {
    int newRowId = await database.insert('notes', object.toMap());
    return newRowId;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeletedRows =
        await database.delete('notes', where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows > 0;
  }

  @override
  Future<List<Note>> read() async {
    List<Map<String, Object?>> data = await database.query('notes');
    return data.map((rowMap) => Note.fromMap(rowMap)).toList();
  }

  @override
  Future<Note?> show(int id) async {
    List<Map<String, Object?>> data =
        await database.query('notes', where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      return Note.fromMap(data.first);
    }
    return null;
  }

  @override
  Future<bool> update(Note object) async {
    int countOfUpdatedRows = await database.update(
      'notes',
      object.toMap(),
      where: 'id = ?',
      whereArgs: [object.id],
    );
    return countOfUpdatedRows > 0;
  }
}
