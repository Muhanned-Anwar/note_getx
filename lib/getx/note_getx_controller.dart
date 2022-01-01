import 'package:get/get.dart';
import 'package:note_getx/controllers/note_db_controller.dart';
import 'package:note_getx/models/note.dart';

class NoteGetxController extends GetxController {
  RxList<Note> notes = <Note>[].obs;

  RxString name = ''.obs;
  final NoteDbController _noteDbController = NoteDbController();

  static NoteGetxController get to => Get.find();

  @override
  void onInit() {
    read();
    super.onInit();
  }

  Future<bool> create({required Note note}) async {
    int newRowId = await _noteDbController.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
    }
    return newRowId != 0;
  }

  Future<void> read() async {
    notes.value = await _noteDbController.read();
  }

  Future<bool> updateNote({required Note note}) async {
    bool updated = await _noteDbController.update(note);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if (index != -1) {
        notes[index] = note;
      }
    }
    return updated;
  }

  Future<bool> delete({required int id}) async {
    bool deleted = await _noteDbController.delete(id);
    if (deleted) {
      notes.removeWhere((element) => element.id == id);
    }
    return deleted;
  }
}
