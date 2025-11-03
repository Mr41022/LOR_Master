import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocDisplay extends StatelessWidget {
  const DocDisplay({super.key, required this.doc, required this.onTap});

  final File doc;

  final VoidCallback onTap;

  String extractFileName(String path) {
    return path.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    final docSize = (doc.lengthSync() / 1024).toStringAsFixed(2);
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.filter,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          Text(extractFileName(doc.path)),
          SizedBox(width: 10),
          Text('${docSize} KB'),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(Icons.close),
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
