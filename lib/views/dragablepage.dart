import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DragablePage extends StatelessWidget {
  const DragablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GestureDetector(
        onVerticalDragEnd: (DragEndDetails details) {

            // User swiped up, perform your action here
            _performSwipeUpAction(context);

        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Text('Swipe up to perform an action'),
        ),
      ),
    );
  }

  void _performSwipeUpAction(BuildContext context) {
    // Implement your logic to handle the swipe-up action
    // For example, show a dialog or navigate to another page
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Swipe Up Action'),
          content: Text('You performed a swipe-up action!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}