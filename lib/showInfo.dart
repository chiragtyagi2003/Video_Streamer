import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class showInfo extends StatefulWidget {
  const showInfo({Key? key, required this.dataList, required this.videoList}) : super(key: key);

  final List<Map<String, dynamic>> dataList;
  final List<Map<String, dynamic>> videoList;

  @override
  State<showInfo> createState() => _showInfoState();
}

class _showInfoState extends State<showInfo> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
          child: Column(
            children: [
              Table(
                columnWidths: {
                  0: FixedColumnWidth(50.0),
                  1: FixedColumnWidth(100.0),
                  2: FixedColumnWidth(100.0),
                  3: FixedColumnWidth(100.0),
                },
                children: [
                  for(var dataElt in widget.dataList)
                    TableRow(
                        children: [
                          Text('Title: ' + dataElt['title']),
                          Text('Description: ' + dataElt['desc']),
                          Text('Category: ' + dataElt['category']),
                          Text('Address: ' + dataElt['address']),
                        ]
                    ),
                ],
              ),

              // ListView(
              //   children: widget.videoList.map((e) => GestureDetector(
              //       onTap: null,
              //       child: Image.network(e['url']))).toList(),
              // ),


            ],
          ),
        ),
      ),
    );
  }
}
