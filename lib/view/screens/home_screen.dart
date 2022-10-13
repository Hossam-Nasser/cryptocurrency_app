import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/caht_model.dart';
import '../../models/user_model.dart';
import '../../provider/chat_provider.dart';
import 'chat_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //whats app home screen
      appBar: AppBar(
        title: Text('WhatsApp'),
        backgroundColor: Colors.teal,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () async {
                    print("hossam");
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout,color: Colors.black,),
                      SizedBox(width: 10,),
                      Text('Logout'),
                    ],
                  ),
                ),
              ),
            ];
          })
        ],
      ),
      body: StreamBuilder(
        stream: Provider.of<ChatProvider>(context).getUserList(),
        builder: (context, snapshot) {
          List<UserModel> chatList = snapshot.data ?? [];
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()async{
                      final user =await FirebaseAuth.instance.currentUser;
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatScreen(
                            userId: chatList[index].userId,
                              name:chatList[index].name,
                            isMe: chatList[index].userId == user!.uid,
                            ValueKey:ValueKey("key"),
                          ))
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'),
                        ),
                        title: Text(chatList[index].name),

                      ),
                    ),
                  );
                });
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
