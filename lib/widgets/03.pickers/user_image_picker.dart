import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  final void Function(File pickImage) imagePickerFn;
  
  UserImagePicker(this.imagePickerFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  final ImagePicker imagePicker = ImagePicker();
  File imagePickerFile;
 
  void pickImage(src) async{
    final temp = await imagePicker.getImage(source: src, imageQuality: 50, maxWidth: 200);
    if(temp != null){
      setState(() {
      imagePickerFile = File(temp.path);   
      });
      
      widget.imagePickerFn(imagePickerFile);
     }
     else{
       print("no iamge selected");
     }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: imagePickerFile!=null? FileImage(imagePickerFile): null,
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton.icon(textColor: Theme.of(context).primaryColor ,onPressed:()=>pickImage(ImageSource.camera), icon: Icon(Icons.camera), label: Text("add image\n from Camera"))
          ,FlatButton.icon(textColor: Theme.of(context).primaryColor ,onPressed:()=>pickImage(ImageSource.gallery), icon: Icon(Icons.image), label: Text("add image\n from Gallery"))
          
          ],
        ),

      ],
    );
  }
}