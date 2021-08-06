import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_assignment/services/uploadPicture.dart';
// import 'im'

class ImagePickerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageState();
  }
}

class _ImageState extends State<ImagePickerScreen> {
  ImageSource? source;
  File? selectedImage;
  bool uploadingPhoto = false;

  Future<void> selectImage() async {
    PickedFile? file =
        await ImagePicker.platform.pickImage(source: source as ImageSource);
    if (file == null) return;
    File img = File(file.path);
    setState(() {
      selectedImage = img;
    });
  }

  Future<void> uploadPhoto() async {
    if (selectedImage == null){
      showSnackBar('Please select an Image First');
      return;
    }
    setState(() {
      uploadingPhoto = true;
    });
    bool uploaded =
        await UploadPicture.uploadProfilePicture(selectedImage as File);
    if (!uploaded)
      showSnackBar(
          'There was some error uploading the picture. Please try again');
    else {
      showSnackBar('Image Uploaded Successfully');
      // selectedImage = null;
    }
    setState(() {
      uploadingPhoto = false;
    });
  }

  void showSnackBar(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str, textAlign: TextAlign.center,), ));
  }

  void getImage() {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        children: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              setState(() {
                source = ImageSource.camera;
              });
              selectImage();
              Navigator.of(ctx).pop();
            },
            label: Text('Click From Camera'),
          ),
          TextButton.icon(
            icon: Icon(Icons.camera),
            onPressed: () {
              setState(() {
                source = ImageSource.gallery;
              });
              selectImage();
              Navigator.of(ctx).pop();
            },
            label: Text('Choose from Gallery'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Uploading Image',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.width * 0.8,
              width: size.width * 0.8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1),
                image: selectedImage == null
                    ? null
                    : DecorationImage(
                        image: FileImage(selectedImage as File),
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
              ),
              child: uploadingPhoto
                  ? showProgressIndicator()
                  : selectedImage == null
                      ? Text('Please select an image')
                      : Container(),
            ),
            SizedBox(
              height: 20,
            ),
            getButton('Select Image', getImage),
            getButton('Upload Image', uploadPhoto),
          ],
        ),
      ),
    );
  }

  Widget getButton(String text, Function onPressed) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () {
        onPressed();
      },
      color: Colors.black,
      minWidth: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 50,
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget showProgressIndicator() {
    return SizedBox(
      height: 50,
      width: 50,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
        ),
      ),
    );
  }
}
