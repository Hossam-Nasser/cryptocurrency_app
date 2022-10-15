import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_flutter/provider/chat/chat_provider.dart';
import 'package:intro_flutter/view/screens/chat/photo_screen.dart';
import 'package:provider/provider.dart';

import '../../../models/caht_model.dart';
import '../../../provider/auth/auth_provider.dart';
import '../auth/login_screen.dart';

class ChatScreen extends StatelessWidget {


  final user = FirebaseAuth.instance.currentUser;



var message = TextEditingController();

@override
Widget build(BuildContext context) {
  Provider.of<ChatProvider>(context,listen: false).getUser();
  var provider = Provider.of<ChatProvider>(context);
  return Scaffold(
    // color whats app
    appBar: AppBar(
      backgroundColor: Color(0xff075E54),
      title: GestureDetector(
        onTap: () {
          Get.to(PhotoScreen());
        },
        child: Row(
          children: [
            CircleAvatar(
             backgroundImage: NetworkImage(provider.user.image == "" ?"https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png":provider.user.image),
            ),
            SizedBox(
              width: 10,
            ),
            Text(provider.user.name),
          ],
        ),
      ),
      actions: [
        PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Logout'),
                ],
              ),
            ),
          ];
        })
      ],
    ),
    body: StreamBuilder(
      stream: Provider.of<ChatProvider>(context).getChatStream(),
      builder: (context, snapshot) {
        List<ChatModel> chatList = snapshot.data ?? [];
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    bool isMe = chatList[index].userId == user!.uid;
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: isMe
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [
                                Text(chatList[index].name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(chatList[index].message,
                                    style:
                                    TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 40
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  chatList[index].avatarUrl == "" ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png" : chatList[index].avatarUrl),
                            ),
                          ),
                        ],
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 40
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  chatList[index].avatarUrl == "" ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png" : chatList[index].avatarUrl),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(chatList[index].name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(chatList[index].message,
                                    style:
                                    TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: message,
                        decoration: InputDecoration(
                          hintText: 'Enter Message',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: ()async {
                      await Provider.of<ChatProvider>(context,listen: false)
                          .sendMessage(ChatModel(
                        userId: user!.uid,
                        name: provider.user.name ,
                        message: message.text,
                        time: DateTime.now().toString(),
                        avatarUrl: provider.user.image,
                      ));
                      message.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: Icon(Icons.send ,size: 30,),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
}











}
