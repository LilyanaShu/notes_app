import 'package:flutter/material.dart';
import 'package:users_app/utils/get_color.dart';
import 'package:users_app/models/note.dart';
import 'package:users_app/utils/get_card.dart';
import 'package:users_app/pages/add_notes.dart';
import 'package:users_app/utils/notes_database.dart';
import 'package:users_app/pages/detail_notes.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
        id: 0,
        title: "English",
        detail: "verb",
        dateTime: DateTime.now()
    ),
    Note(
        id: 1,
        title: "Korean",
        detail: "passive voice",
        dateTime: DateTime.now()
    ),
    Note(
        id: 2,
        title: "Japanese",
        detail: "verb",
        dateTime: DateTime.now()
    ),
    Note(
        id: 3,
        title: "Spanish",
        detail: "aloha",
        dateTime: DateTime.now()
    ),
  ];

  bool isLoading = false;

  Future refreshNotes() async{
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    refreshNotes();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("List of Notes"),
        // backgroundColor: GetColor.primarySeedColor,
        // foregroundColor: GetColor.whiteTextColor,
        // titleTextStyle: TextStyle(
        //   fontSize: 22,
        //   letterSpacing: 5
        // ),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) : GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4
          ),
          itemBuilder: (context, index) {
            return
              GestureDetector(
                onTap: () async{
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context)
                  { return DetailNotes(note: notes[index]); }
                  ));
                  refreshNotes();
                },
                child: GetCard(index: index, note: notes[index]),
              );
          },
          itemCount: notes.length,
        //padding: EdgeInsets.only(left: 20, right: 20),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const AddNotes(note: null,);
            })
          );
          refreshNotes();
        },
        elevation: 6,
        tooltip: "Add new notes",
        backgroundColor: GetColor.secondarySeedColor,
        foregroundColor: GetColor.whiteTextColor,
        child: const Icon(Icons.add_rounded, size: 30,),
      ),
    );
  }
}
