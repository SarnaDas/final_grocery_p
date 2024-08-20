//import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grocery_p/screens/util.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7Cw8atL3Modu50-P0FRxNgMg6gDH6R9bDAIT6huM6spIw_IzLyfuE6gKpvQ6NqqSdsKA&usqp=CAU')),
                Positioned(
                  child: IconButton(
                      onPressed: selectImage,
                       icon: Icon(Icons.add_a_photo)),
                  bottom: -10,
                  left: 160,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
