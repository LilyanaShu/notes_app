import 'package:flutter/material.dart';
import 'package:users_app/utils/get_color.dart';
import 'package:users_app/utils/notes_database.dart';
import 'package:users_app/models/note.dart';

class AddNotes extends StatefulWidget {
  final Note? note;
  const AddNotes({Key? key, this.note}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _form = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  void initState(){
    if (widget.note != null){
      titleController.text = widget.note!.title;
      detailController.text = widget.note!.detail;
    }
    super.initState();
  }

  Future addNote() async{
    final note = Note(
      title: titleController.text,
      detail: detailController.text,
      dateTime: DateTime.now(),
    );
    await NotesDatabase.instance.create(note);
    //Navigator.of(context).pop();
  }

  Future editNote() async{
    final note = widget.note!.copyWith(
      title: titleController.text,
      detail: detailController.text
    );

    await NotesDatabase.instance.update(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.note != null) ? const Text("Update Notes") : const Text("Add New Notes") ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: ListView(
          children: [
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return "Entry note title";
                      }
                      return null;
                    },
                    autofocus: true,
                    controller: titleController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: "Title",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: GetColor.secondarySeedColor)
                        )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty ){
                        return "Entry note details";
                      }
                      return null;
                    },
                    controller: detailController,
                    maxLines: 8,
                    decoration: InputDecoration(
                        hintText: "Detail notes",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: GetColor.secondarySeedColor)
                        )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  SizedBox(
                      width: 270,
                      child: ElevatedButton(
                        child: Text(widget.note != null ? "Update" : "Save"),
                        onPressed: () async{
                          if ( _form.currentState!.validate() ){
                            if (widget.note != null) {
                              editNote();
                            }
                            else {
                              addNote();}
                          }
                          Navigator.of(context).pop();
                        }
                        ,)
                  ),

                ],
              )
            )
          ],
        ),
      )
    );
  }
}
