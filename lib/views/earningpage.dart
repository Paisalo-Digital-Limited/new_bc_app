import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'homevisitmappage.dart';
import 'leaderboard.dart';

class EarningPage extends StatefulWidget {
  const EarningPage({super.key});

  @override
  State<EarningPage> createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  List<dynamic> _ViewList = [

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB42C3B),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: double.maxFinite,
                  color: Color(0xFFB42C3B),
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CURRENT EARNINGS",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Visbyfregular',
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '₹ 15,000',
                              style: TextStyle(
                                  fontSize: 60,
                                  fontFamily: 'Visbybold',
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 58,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.down_arrow,
                                    size: 20,
                                  ),
                                  Text(
                                    "50%",
                                    style: TextStyle(fontSize: 20,fontFamily: 'Visbyfregular'),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Best month ₹30,000 (Feb)",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Visbyfregular',
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),

            Text("INVESTMENT RECOVERED",style: TextStyle(fontFamily: 'Visbyfregular',color: Colors.white,fontSize: 18),)

            ,SizedBox(height: 8,),
            Container(
              width: 250,
              height: 10, // Adjust the height of the progress bar
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), // Adjust the border radius for curved edges
                color: Colors.grey[300], // Background color of the progress bar
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: 0.4, // Set the progress value (0.0 to 1.0)
                  backgroundColor: Colors.transparent, // Set the background color of the indicator
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEE5565)), // Color of the progress indicator
                ),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('10%',style: TextStyle(fontFamily: 'Visbyfregular',color: Colors.white,fontSize: 13)),
                  Text('₹2,00,000',style: TextStyle(fontFamily: 'Visbyfregular',color: Colors.white,fontSize: 13))
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
             // Adjust the width as needed
              width: 340,
              height: 360,
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/card_bg.png'), // Replace with your SVG file path
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,
                  child: Row(
                    children: [
                      SizedBox(width: 40,),
                      Row(
                        children: [
                          Text('WEEKLY'),
                          SizedBox(width: 20,),
                          Text('MONTHLY')
                        ],
                      )
                    ],
                  ),),
                  Divider(
                    height: 40, // You can adjust the height of the divider
                    color: Colors.grey.shade400, // You can set the color of the divider
                    thickness: 1, // You can adjust the thickness of the divider
                    indent: 6, // You can set an indent for the divider (space from the left)
                    endIndent: 6, // You can set an end indent for the divider (space from the right)
                  ),
                ],
              ),
            ),
          ],
        ),

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
          setState(() {
            switch(index){
              case 0:
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeaderBoard(),
                  ),
                );
                break;
              case 2:
                /*Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeVisitMapPage(),
                  ),
                );*/
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EarningPage(),
                  ),
                );
                break;
              case 4:
                break;


            }

          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
