import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:trace_et/Pages/Init/Signin/SigninComponents/other_information.dart';
import 'package:trace_et/Utilities/show_messages.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isImageSelected = false;
  File profileImage;
  double _icon_size = 20;

  getProfileImage({ImageSource source}) async {
    final originalFile = await ImagePicker().getImage(source: source);
    File image = File(originalFile.path);
    if (image != null) {
      File croppedProfilePicture = await ImageCropper.cropImage(
          sourcePath: image.path,
          cropStyle: CropStyle.circle,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            showCropGrid: false,
            toolbarColor: header_text_background_color,
            toolbarTitle: "Crop Your Profile Picture",
            statusBarColor: Colors.white,
            backgroundColor: header_text_color,
          ));
      setState(() {
        profileImage = croppedProfilePicture;
      });
    }
  }

  Row image_selected() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Material(
              child: IconButton(
                icon: Icon(
                  Icons.camera,
                  color: header_text_color,
                  size: screenHeightExcludingToolbar(context,
                      dividedBy: _icon_size),
                ),
                onPressed: () {
                  print('change from camera');
                  getProfileImage(source: ImageSource.camera);
                },
              ),
            ),
            Material(
              child: IconButton(
                icon: Icon(
                  Icons.photo_size_select_actual,
                  color: header_text_color,
                  size: screenHeightExcludingToolbar(context,
                      dividedBy: _icon_size),
                ),
                onPressed: () {
                  print('change from gallery');
                  getProfileImage(source: ImageSource.gallery);
                },
              ),
            ),
          ],
        ),
        profileImage == null
            ? CircleAvatar(
                child: Icon(Icons.person, size: 60),
                radius: screenWidth(context, dividedBy: 6),
                backgroundColor: header_text_color,
                foregroundColor: header_text_background_color,
              )
            : CircleAvatar(
                child: ClipOval(
                  child: Image.file(profileImage),
                ),
                radius: screenWidth(context, dividedBy: 4),
              ),
        Material(
          child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: screenHeightExcludingToolbar(context,
                    dividedBy: _icon_size),
              ),
              onPressed: () {
                print('delete');
                setState(() {
                  isImageSelected = false;
                  profileImage = null;
                });
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: header_text_color,
          child: Icon(Icons.arrow_forward_ios),
          onPressed: () => {
                if (profileImage != null)
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherInformation(
                                  clipped_image: profileImage,
                                )))
                  }
                else
                  {ShowMessage(context: context, msg: 'Please select an image')}
              }),
      body: Container(
          margin: EdgeInsets.fromLTRB(
              0, screenHeight(context, dividedBy: 500), 0, 0),
          color: Colors.white,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isImageSelected
                  ? image_selected()
                  : RawMaterialButton(
                      onPressed: () {
                        print('image select');
                        setState(() {
                          isImageSelected = true;
                        });
                      },
                      elevation: 2.0,
                      fillColor: header_text_color,
                      child: Icon(
                        Icons.camera_alt,
                        size: 70.0,
                        color: header_text_background_color,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
            ],
          ))),
    );
  }
}
