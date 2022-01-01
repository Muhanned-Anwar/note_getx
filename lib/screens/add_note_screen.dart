import 'package:flutter/material.dart';
import 'package:note_getx/getx/note_getx_controller.dart';
import 'package:note_getx/helpers/helpers.dart';
import 'package:note_getx/models/note.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> with Helpers {
  late TextEditingController _contentTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.add_note_title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black54,
                  Colors.white70,
                  Colors.white60,
                  Colors.black54,
                  Colors.black87,
                  Colors.black54,
                ])),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: [
              TextField(
                controller: _contentTextController,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.add_note_hint_text,
                    hintStyle: TextStyle(color: Colors.black54)),
                minLines: 1,
                maxLines: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  perFormSave();
                },
                child: Text(AppLocalizations.of(context)!.add_note_save),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> perFormSave() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (_contentTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data', error: true);
    return false;
  }

  Future<void> save() async {
    bool created = await NoteGetxController.to.create(note: note);
    if (created) clear();
    String message = created ? 'Created successfully' : 'Create failed';
    showSnackBar(context: context, message: message, error: !created);
  }

  Note get note {
    Note newNote = Note();
    newNote.content = _contentTextController.text;
    return newNote;
  }

  void clear() {
    _contentTextController.text = '';
  }
}
