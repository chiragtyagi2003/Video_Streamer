
import 'package:blackcoffer/playVideo.dart';
import 'package:blackcoffer/searchVideo.dart';
import 'package:blackcoffer/showInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class showVideos extends StatefulWidget {
  const showVideos({Key? key}) : super(key: key);

  @override
  State<showVideos> createState() => _showVideosState();
}

class _showVideosState extends State<showVideos> {

   FirebaseFirestore db = FirebaseFirestore.instance;
   late String videoUrl;
   late String videoTitle;
   late String videoDesc;
   late String videoCategory;
   late String videoLocation;


   late List<String> urls = [];
   late List<String> titles = [];
   late List<String> addresses = [];
   late List<String> cats = [];
   late List<String> descs = [];
   late List<Map<String, dynamic>> dataList = [];
   late List<Map<String, dynamic>> videoList = [];

   void fetchData() async {

      db.collection("videos").get().then(
             (querySnapshot) {
            print("Successfully completed");
            for (var docSnapshot in querySnapshot.docs) {
               //print('${docSnapshot.id} => ${docSnapshot.data()}');
               print(docSnapshot.get('url'));
               videoUrl = docSnapshot.get('url');
               videoTitle = docSnapshot.get('title');
               videoDesc = docSnapshot.get('desc');
               videoCategory = docSnapshot.get('category');
               videoLocation = docSnapshot.get('userAddress');

               urls.add(videoUrl);
               titles.add(videoTitle);
               descs.add(videoDesc);
               cats.add(videoCategory);
               addresses.add(videoLocation);

               dataList.add({'title': videoTitle, 'desc' : videoDesc, 'category': videoCategory, 'address': videoLocation, 'url': videoUrl});
               videoList.add({'title': videoTitle, 'url': videoUrl});


            }

            // print(urls);
            // print(titles);
            // print(descs);
            // print(cats);
            // print(addresses);

               print(dataList);
         },
         onError: (e) => print("Error completing: $e"),
      );
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

              ElevatedButton(onPressed: () {
                fetchData();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => showInfo(dataList: dataList)));
              },
                  child: Text('Browse Video List'),

              ),

              ElevatedButton(onPressed: () {
                //fetchData();
                Navigator.push(context, MaterialPageRoute(builder: (context) => showInfo(dataList: dataList, videoList: videoList)));
              },
                child: Text('Show Video List'),

              ),

              // ElevatedButton(onPressed: () {
              //   //fetchData();
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => searchVideo(dataList: dataList,)));
              // },
              //   child: Text('Search Video'),
              //
              // ),
              SizedBox(height: 20.0,),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Container(
              //     child: Table(
              //       columnWidths: {
              //         0: FixedColumnWidth(50.0),
              //         1: FixedColumnWidth(100.0),
              //         2: FixedColumnWidth(100.0),
              //         3: FixedColumnWidth(100.0),
              //       },
              //       children: [
              //         for(var dataElt in dataList)
              //           TableRow(
              //               children: [
              //                 Text('Title: ' + dataElt['title']),
              //                 Text('Description: ' + dataElt['desc']),
              //                 Text('Category: ' + dataElt['category']),
              //                 Text('Address: ' + dataElt['address']),
              //               ]
              //           ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),

    );
  }
}
