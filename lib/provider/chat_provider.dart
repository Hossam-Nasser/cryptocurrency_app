import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/caht_model.dart';
import '../models/user_model.dart';

class ChatProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;


  Stream<List<UserModel>> getUserList() {
    return firestore
        .collection('users')
        .snapshots()
        .map((event) {
      return List<UserModel>.from(
          event.docs.map((e) => UserModel.fromJson(e.data())));
    });
  }




  Stream<List<ChatModel>> chatStream(
      String currentUserId)
       {
    return firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chat')
        .orderBy("time", descending: false)
        .snapshots()
        .map((event) {
      return List<ChatModel>.from(
          event.docs.map((e) => ChatModel.fromJson(e.data())));
    });
  }

  setChat(ChatModel chatModel) {
    firestore.collection('users').doc(chatModel.userId).collection('chat').add(chatModel.toJson());
  }
}
