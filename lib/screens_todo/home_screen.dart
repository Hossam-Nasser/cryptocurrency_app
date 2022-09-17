
import 'package:flutter/material.dart';
import 'package:intro_flutter/dbhelper/database_helper.dart';
import 'package:intro_flutter/model/note_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = "";
  String description ="" ;
  bool flag = false;

  List<NoteModel> noteList = [];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Note app'),
        centerTitle: true,
      ),
      body:  FutureBuilder(
          future: getNoteList(),
          builder: (context, snapshot) {
            return createListView(context, snapshot);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
               openAlterDialog(null);
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {

    noteList = snapshot.data ?? [];



    if (noteList !=[]) {
      return ListView.builder(
          itemCount: noteList.length,
          itemBuilder: (context, index) {
            return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  DataBaseHelper.db.deleteNote(noteList[index].id!);
                },
                background: Container(
                  color: Colors.red[200],
                ),
                child: buildItem(noteList[index], index));
          });
    } else {
      return Container();
    }
  }

  buildItem(NoteModel noteModel,int index) {
    return Card(
      color: Colors.green[500],
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                noteModel.title.toString(),
                style: TextStyle(fontSize: 30),
              ),
              Text(noteModel.description.toString(),
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
                  openAlterDialog(noteModel);
          },
        ),
      ),
    );
  }


    openAlterDialog(NoteModel? noteModel) {
    if (noteModel != null) {
      title = noteModel.title;
      description = noteModel.description;
      flag = true;
    } else {
      title = '';
      description = '';
      flag = false;

    }

    showDialog(
     context: context,
     builder:(context) {
     return AlertDialog(
        content: Container(
          height: 200,
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Note',style: TextStyle(fontSize: 20),),
                TextFormField(
                  initialValue: title,
                  onSaved: (value) {
                    title = value!;
                  },
                  decoration: InputDecoration(hintText: 'title'),
                ),
                TextFormField(
                  initialValue: description,
                  onSaved: (value) {
                    description = value!;
                  },
                  decoration: InputDecoration(hintText: 'Enter note'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        flag  ? editNote(noteModel!.id) : addNote();
                      },
                      child: Text(flag ? 'Edit note' : 'Add Note')),
                )
              ],
            ),
          ),
        ),
     );
     }
   );
  }


  Future<List<NoteModel>> getNoteList() async {

    var db = DataBaseHelper.db;
    await db.getAllNote().then((value) {
      print(value);
      noteList = value;
    });

    return  noteList;
  }

  void addNote() {
    _formKey.currentState!.save();
    var db = DataBaseHelper.db;
    db
        .insertNote(NoteModel(title: title, description: description))
        .then((value) {
      print(value);
      print("inserted");
      Navigator.of(context).pop();
      setState(() {});
    });
  }

  void editNote(int? id) {
    _formKey.currentState!.save();

    var db = DataBaseHelper.db;
    NoteModel noteModel = NoteModel(
      id: id,
      title: title,
      description: description,
    );

    db.updateNote(noteModel)
        .then((value) {
      print(value);
      print("edited");
      Navigator.pop(context);
      setState(() {
        flag = false;
      });
    });
  }
}
