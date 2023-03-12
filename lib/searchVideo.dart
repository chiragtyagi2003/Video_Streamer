import 'package:flutter/material.dart';

class searchVideo extends StatefulWidget {
  const searchVideo({Key? key, required this.dataList}) : super(key: key);

  final List<Map<String, dynamic>> dataList;
  @override
  State<searchVideo> createState() => _searchVideoState();
}

class _searchVideoState extends State<searchVideo> {

  TextEditingController _searchTitle = TextEditingController();

  void searchTitle() {

    for(var dataElt in widget.dataList)
      if(_searchTitle.text == dataElt['title'])
        {


        }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  child: TextField(
                    controller: _searchTitle,
                    decoration: InputDecoration(
                      //border: InputBorder.none,
                    ),
                  ),
                  width: 350.0,
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
