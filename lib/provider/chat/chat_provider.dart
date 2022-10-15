import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/caht_model.dart';
import '../../models/user_model.dart';

class ChatProvider extends ChangeNotifier {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;



  Stream<List<ChatModel>> getChatStream() {
    return firestore
        .collection('chat')
        .orderBy("time", descending: true)
        .snapshots()
        .map((event) {
      return List<ChatModel>.from(
          event.docs.map((e) => ChatModel.fromJson(e.data())));
    });
  }

  sendMessage(ChatModel chatModel) {
    firestore.collection('chat').add(chatModel.toJson());
  }

  UserModel user = UserModel(
    name: "",
    email: "",
    image: "",
    userId: "",
  );

  getUser() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data()!);
      notifyListeners();
    });
  }
}
