import 'package:flutter/material.dart';
import 'package:major_project/widgets/constants.dart';

class UniversityCard extends StatelessWidget {
  UniversityCard({required this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data["university_name"],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Divider(),
          ProfessorTile(
            name: data["professor_name"],
            LOR: data["lor_url"],
          ),
        ],
      ),
    );
  }
}
