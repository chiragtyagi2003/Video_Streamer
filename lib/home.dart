import 'dart:io';
import 'package:blackcoffer/showVideos.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String videoURL = "";
  // String loc = "";
  var userCity;
  var userState;
  var userCountry;
  var userFinalAddress;
  var lat;
  var long;
  TextEditingController videoTitle = TextEditingController();
  TextEditingController videoDesc= TextEditingController();
  TextEditingController videoCategory= TextEditingController();

  loc.LocationData? locationData;
  late List<geo.Placemark> userAddress;

   FirebaseFirestore db = FirebaseFirestore.instance;

   void storeData() {

     final userData = <String, String>{
       "title" : videoTitle.text,
       "desc"  : videoDesc.text,
       "category" : videoCategory.text,
       // "location" : loc,
       "userAddress" : userFinalAddress,
       "url" : videoURL,
       "latitude": lat,
       "longitude":long,
     };

     db.collection('videos').add(userData).then(
             (documentSnapshot) =>
                 print('Added data with ID : ${documentSnapshot.id}'));
   }


  Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  // function to get permission
  void getPermission() async {
     if (await Permission.location.isGranted)
       {
         // get location
         getLocation();
       }

     else
       {
         Permission.location.request();
       }
  }

  void getLocation() async {

     locationData = await loc.Location.instance.getLocation();
     setState(() {
        lat = locationData!.latitude!.toString();
        long = locationData!.longitude!.toString();
     });

     getAddress();
  }

  void getAddress() async{
     if(locationData != null)
       {
          userAddress = await geo.placemarkFromCoordinates(
             locationData!.latitude!,
             locationData!.longitude!);
       }

     // userCurrentAddress = userAddress[0].toString();

     setState(() {
       userCity = userAddress[0]!.street;
       userState = userAddress[0]!.locality;
       userCountry = userAddress[0]!.country;

       userFinalAddress = userCity + " " + userState + " " + userCountry;
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25.0, right: 25.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                controller: videoTitle,
                decoration: InputDecoration(
                  labelText: 'Video Title',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                  ),
                ),
              ),


              SizedBox(height: 10.0,),

              TextField(
                controller: videoDesc,
                decoration: InputDecoration(
                  labelText: 'Video Description',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                  ),
                ),
              ),

              SizedBox(height: 10.0,),

              TextField(
                controller: videoCategory,
                decoration: InputDecoration(
                  labelText: 'Video Category',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                  ),
                ),
              ),

              SizedBox(height: 10.0,),

              ElevatedButton(
                  onPressed: () async {

                    // getUserLocation().then((value){
                    //   print(value);
                    //   setState(() {
                    //     loc = value.toString();
                    //   });
                    // });
                    //

                    getPermission();


                    //instance for picking video
                    ImagePicker videoPicker = ImagePicker();

                    //
                    XFile? videoFile = await videoPicker.pickVideo(source: ImageSource.camera);

                    print('${videoFile?.path}');

                    if(videoFile == null) return;
                    String uniqueVideoName = DateTime.now().millisecondsSinceEpoch.toString();


                    //Get a reference to storage
                    Reference  referenceRoot = FirebaseStorage.instance.ref();

                    // creating a video folder and
                    // getting reference to the videos folder
                    Reference referenceDirVideos = referenceRoot.child('vidoes');

                    // reference for the video to be stored
                    Reference referenceVideoToUpload = referenceDirVideos.child(uniqueVideoName);


                    try{
                      // uploading the video to firebase
                      await referenceVideoToUpload.putFile(File(videoFile!.path));

                      // if uploaded, get the URL
                      videoURL = await referenceVideoToUpload.getDownloadURL();
                      setState(() {
                        videoTitle.text = "";
                        videoDesc.text = "";
                        videoCategory.text = "";
                      });
                      toast('Video Uploaded');
                    }
                    catch(e)
                    {

                    }

                    storeData();


                    },
                  child: Text('Record and Post Video'),),

              ElevatedButton(
                onPressed: () async {

                  // //instance for picking video
                  // ImagePicker videoPicker = ImagePicker();
                  //
                  // //
                  // XFile? videoFile = await videoPicker.pickVideo(source: ImageSource.gallery);
                  //
                  // print('${videoFile?.path}');

                  getPermission();


                  //instance for picking video
                  ImagePicker videoPicker = ImagePicker();

                  //
                  XFile? videoFile = await videoPicker.pickVideo(source: ImageSource.gallery);

                  print('${videoFile?.path}');

                  if(videoFile == null) return;
                  String uniqueVideoName = DateTime.now().millisecondsSinceEpoch.toString();


                  //Get a reference to storage
                  Reference  referenceRoot = FirebaseStorage.instance.ref();

                  // creating a video folder and
                  // getting reference to the videos folder
                  Reference referenceDirVideos = referenceRoot.child('vidoes');

                  // reference for the video to be stored
                  Reference referenceVideoToUpload = referenceDirVideos.child(uniqueVideoName);


                  try{
                    // uploading the video to firebase
                    await referenceVideoToUpload.putFile(File(videoFile!.path));

                    // if uploaded, get the URL
                    videoURL = await referenceVideoToUpload.getDownloadURL();
                    setState(() {
                      videoTitle.text = "";
                      videoDesc.text = "";
                      videoCategory.text = "";
                    });
                    toast('Video Uploaded');
                  }
                  catch(e)
                  {

                  }

                  storeData();
                },
                child: Text('Post a Video from gallery'),),


              ElevatedButton(
                onPressed: () {

                  Navigator.pushNamed(context, 'show');
                },
                child: Text('Videos'),),


            ],
          ),
        ),
      ),
    );
  }
}
