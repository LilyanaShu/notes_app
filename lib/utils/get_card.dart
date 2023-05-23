import 'package:users_app/models/note.dart';
import 'package:users_app/utils/get_color.dart';
import 'package:flutter/material.dart';

class GetCard extends StatelessWidget {
  final int index;
  final Note note;
  const GetCard({Key? key,
    required this.index, required this.note
  }) : super(key: key);

  double GetMinHeight(int index){
    switch(index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      case 4:
        return 100;
      default:
        return 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = cardColor[index % 4];
    final minHeight = GetMinHeight(index);
    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeight,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(note.title, style: TextStyle(
              color: GetColor.blackTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}
