import 'package:doctor_appointment/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

//import 'package:image_picker/image_picker.dart';


class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  File _image;
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: CustomizeColors.iconGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Anuradha S'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://icon-library.com/images/person-image-icon/person-image-icon-6.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('02-12-1998'),
                      Text('PC - MD'),
                      Text(
                        'Anuradha S Dharwad',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('(Female 128)'),
                      Text('Dictation Pending'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Is Stat File',
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    onChanged: toggleSwitch,
                    value: isSwitched,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blue,
                    inactiveThumbColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: FlatButton(
                    child: Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  height: 60,
                  width: 60,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                ),
                SizedBox(width: 40),
                Container(
                  child: FlatButton(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      final action = CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, color: Colors.blue),
                                Text("Camera"),
                              ],
                            ),
                            onPressed: () {
                            // openCamera();
                              //print("Camera clicked");
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Icon(Icons.photo_library_outlined,
                                  color: Colors.blue),
                                Text("Photo Library"),
                              ],
                            ),
                            onPressed: () {
                            // openGallery();
                              //print("Photo Library clicked");
                            },
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      );

                      showCupertinoModalPopup(
                          context: context, builder: (context) => action);
                    },
                  ),
                  height: 60,
                  width: 60,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                child: Card(
                 // color: CustomizeColors.iconGreyColor,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date of Birth',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '02-11-1998',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Case No',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Y2133434545',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PC - NO',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Checked Out',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Card(
                child: Container(
                  color: CustomizeColors.lightBlue,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.library_books_sharp,
                        size: 30,
                        color: CustomizeColors.ThemeColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Super Bill',
                        style: TextStyle(
                            fontSize: 18, color: CustomizeColors.ThemeColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: Card(
                child: Container(
                  color: CustomizeColors.lightBlue,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.library_books_sharp,
                        size: 30,
                        color: CustomizeColors.ThemeColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'All Dictations',
                        style: TextStyle(
                            fontSize: 18, color: CustomizeColors.ThemeColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // //Open the phone camera
  // Future openCamera() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = image;
  //   });
  // }
  //
  // //Open the phone gallery
  // Future openGallery() async {
  //   var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = picture;
  //   });
  // }
}
