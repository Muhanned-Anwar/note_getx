import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_getx/getx/note_getx_controller.dart';
import 'package:note_getx/helpers/helpers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with Helpers {
  NoteGetxController _noteGetxController = Get.put(NoteGetxController());

  List _itemMenu = ['Settings','About App'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.main_screen_app_bar_title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<String>(
            color: Colors.black,
            offset: Offset(-20,40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onSelected: (value) {
              if(value == _itemMenu[0]){
                Navigator.pushNamed(context, '/settings_screen');
              }else if(value == _itemMenu[1]){
                Navigator.pushNamed(context, '/about_app_screen');
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text(AppLocalizations.of(context)!.main_screen_settings),value: _itemMenu[0],textStyle: TextStyle(color: Colors.white),),
                PopupMenuItem(child: Text(AppLocalizations.of(context)!.main_screen_about_app),value: _itemMenu[1],textStyle: TextStyle(color: Colors.white),),
              ];
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_note_screen');
        },
        child: Icon(
          Icons.note_add,
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.black54,
                    Colors.black,
                  ],
                )),
          ),
          Obx(() {
            if (_noteGetxController.notes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    Text(
                      AppLocalizations.of(context)!.main_screen_no_data,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: _noteGetxController.notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey.shade800,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 2, left: 5, right: 5),
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            alignment: AlignmentDirectional.topEnd,
                            child: IconButton(
                              onPressed: () {
                                deleteNote(
                                    id: _noteGetxController.notes[index].id);
                              },
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/note_screen',
                                  arguments: index);
                            },
                            onLongPress: () {
                              deleteNote(
                                  id: _noteGetxController.notes[index].id);
                            },
                            child: Container(
                              height: 125,
                              width: double.infinity,
                              child: Text(
                                _noteGetxController.notes[index].content,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Container(
                            height: 20,
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              AppLocalizations.of(context)!.main_screen_note_date,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }

  Future<void> deleteNote({required int id}) async {
    bool deleted = await _noteGetxController.delete(id: id);
    String message = deleted ? 'Deleted successfully' : 'Delete failed';
    showSnackBar(context: context, message: message, error: !deleted);
  }
}
