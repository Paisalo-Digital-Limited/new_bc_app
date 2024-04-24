import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:new_bc_app/const/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_service.dart';


class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    "assets/images/leaderboardbanner.gif",
    "assets/images/leaderboardbanner.gif",
    "assets/images/leaderboardbanner.gif"
  ];
  Widget buildDot({required int index}) {
    return Container(
      width: 7,
      height: 7,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _current == index ? Colors.white : Colors.grey,
      ),
    );
  }
  @override
  void initState() {

    super.initState();
  }
  AppColors appColors=AppColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB42C3B),
      body: Center(
        child: Column(
         children: [
           SizedBox(height: 40,),
           Text("BHARAT",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
           Text("LEADER BOARD",style: TextStyle(color: Colors.white),),

           SizedBox(height: 20),
           CarouselSlider.builder(
             itemCount: 3, // Replace '3' with the total number of items
             itemBuilder: (BuildContext context, int index, int realIndex) {
               return  Card(
                   elevation: 4,
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15.0),
               ),
               child: SizedBox(// Adjust the width as needed// Adjust the height as needed
               child: ClipRRect(
               borderRadius: BorderRadius.circular(15.0),
               child: Image.asset(imgList.elementAt(0).toString(), // Replace with your image URL
               fit: BoxFit.cover, // Adjust the fit as needed (contain, cover, fill, etc.)
               ),
               ),
               )
               );
             },
             options: CarouselOptions(
               height: 120.0, // Adjust the height as needed
               viewportFraction: 1.0, // Set to 1.0 to display only one item at a time
               enableInfiniteScroll: true, // Enable infinite scroll if needed
               reverse: false, // Set true/false for reversing the items
               autoPlay: false, // Set true/false for autoplay
               autoPlayInterval: Duration(seconds: 3), // Autoplay interval if needed
               autoPlayAnimationDuration: Duration(milliseconds: 800), // Autoplay animation duration
               pauseAutoPlayOnTouch: true,
               // Pause autoplay on touch

               onPageChanged: (index, reason) {
                 setState(() {
                   print("page index $index");
                   _current = index;
                 });
               },
             ),
           ),
           SizedBox(height: 10),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: List.generate(
               3, // Replace '3' with the total number of items
                   (index) => buildDot(index: index),
             ),
           ),
           SizedBox(height: 20),

           Stack(
             alignment: Alignment.topCenter,
             children: [
               Container(

                 alignment: Alignment.center,

                 height: 530,
                 child: null
               ),

               Positioned(
              top: 50,
                 child: Card(
                   clipBehavior: Clip.antiAlias,
                   elevation: 20, // Adjust the elevation for the shadow effect
                   shadowColor: Colors.black, // Shadow color
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15.0),
                   ),// Adjust the elevation for the shadow effect
                   child: Container(


                     color: Color(0xFFA92F3D),
                     alignment: Alignment.bottomCenter,
                     width: 350,
                     height: 420,
                     child: Text(
                       'Container 2',
                       style: TextStyle(fontSize: 18.0, color: Colors.white),
                     ),
                   ),
                 ),
               ),

               Positioned(


                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.white38,
                     borderRadius: BorderRadius.circular(50.0),
                   ),
                   alignment: Alignment.center,
                   width: 100,
                   height: 100,
                   child:Image.asset('assets/images/trophy_ic.png') ,
                 ),
               ),
             ],
           ),
         ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        backgroundColor: Colors.white70,
        shape: CircleBorder(),
        child: Icon(CupertinoIcons.bars,color: Colors.white,),

      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        items: const <Widget>[
          Icon(CupertinoIcons.home, size: 25, color: Color(0xFFC2C2C2)),
          Icon(CupertinoIcons.add, size: 25, color: Color(0xFFC2C2C2)),
          Icon(CupertinoIcons.location_solid,
              size: 25, color: Color(0xFFC2C2C2)),
          Icon(CupertinoIcons.money_dollar_circle,
              size: 25, color: Color(0xFFC2C2C2)),
          Icon(CupertinoIcons.profile_circled,
              size: 25, color: Color(0xFFC2C2C2)),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color(0xFFB42C3B),
        animationCurve: Curves.easeInOut,

        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {});
        },
        letIndexChange: (index) => true,
      ),
    );
  }



}
