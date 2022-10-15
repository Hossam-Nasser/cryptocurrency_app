import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/chat/chat_provider.dart';
import '../../../provider/chat/photo_provider.dart';

class PhotoScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<PhotoProvider>(context
    ,listen: false);
    var chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Screen'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(chatProvider.user.image == "" ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png" :chatProvider.user.image),
            radius: 90,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                 provider.pickImage(ImageSource.gallery);
                },
                child: Text('add image from gallery'),
              ),
              ElevatedButton(
                onPressed: () {
                  provider.pickImage(ImageSource.camera);
                },
                child: Text('add image from camera'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
