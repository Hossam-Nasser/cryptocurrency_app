import '../dbhelper/constant.dart';

class NoteModel{
    int? id;
    String title;
    String description;

  NoteModel({ this.id, required this.title, required this.description});

  Map<String, dynamic> toMap(){
    return {
      columnTitle: title,
      columnDescription: description
    };
  }

   factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
      id: map[columnId],
      title: map[columnTitle],
      description: map[columnDescription],
    );
  }

}