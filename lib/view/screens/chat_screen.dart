import 'package:flutter/material.dart';
import 'package:intro_flutter/provider/chat_provider.dart';
import 'package:provider/provider.dart';

import '../../models/caht_model.dart';



class ChatScreen extends StatelessWidget {

  String userId;
  String name;

  bool isMe;
  Key ValueKey;

  ChatScreen({required this.userId,required this.name,required this.isMe,required this.ValueKey});


  var message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text(name),
      ),
      body: StreamBuilder(
        stream: Provider.of<ChatProvider>(context).chatStream(
          userId,
        ),
        builder: (context, snapshot) {
          List<ChatModel> chatList = snapshot.data ?? [];
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: isMe ? MainAxisAlignment.end: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: isMe
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),

                                    ),
                                    child: Text(chatList[index].message,
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(chatList[index].message,
                                        style: TextStyle(color: Colors.white)),
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
                      child: TextFormField(
                        controller: message,
                        decoration: InputDecoration(
                          hintText: 'Enter Message',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .setChat(
                          ChatModel(
                            message: message.text,
                            userId: userId,
                            name: name,
                            avatarUrl: "",
                            time: DateTime.now().toString(),
                          ),
                        );
                        message.clear();
                        FocusScope.of(context).unfocus();
                      },
                      icon: Icon(Icons.send),
                    ),
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
