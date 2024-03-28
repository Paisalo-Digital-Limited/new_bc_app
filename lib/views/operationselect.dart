import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OperationSelect extends StatefulWidget {
  const OperationSelect({super.key});

  @override
  State<OperationSelect> createState() => _OperationSelectState();
}

class _OperationSelectState extends State<OperationSelect> {

  final List<String> cardList = [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
  ];

  @override
  Widget build(BuildContext context) {
    return CardStack(cardList: cardList);
  }
}
class CardStack extends StatefulWidget {
  final List<String> cardList;

  const CardStack({required this.cardList});

  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.cardList.reversed.map((card) {
        final index = widget.cardList.indexOf(card);
        final isTopCard = index == currentIndex;

        final cardItem = Positioned(
          top: isTopCard ? 0.0 : 20.0 * (index - currentIndex),
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                setState(() {
                  currentIndex = (currentIndex - 1).clamp(0, widget.cardList.length - 1);
                });
              } else if (details.primaryVelocity! < 0) {
                setState(() {
                  currentIndex = (currentIndex + 1).clamp(0, widget.cardList.length - 1);
                });
              }
            },
            child: Card(
              elevation: isTopCard ? 4.0 : 0.0,
              child: Container(
                width: 200,
                height: 200,
                alignment: Alignment.center,
                child: Text(
                  card,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
        );

        return isTopCard ? cardItem : SizedBox.shrink();
      }).toList(),
    );
  }
}

