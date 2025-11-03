import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FileDisplayWidget extends StatelessWidget {
  final XFile? file;
  final VoidCallback? onRemove;

  const FileDisplayWidget({
    Key? key,
    this.file,
    this.onRemove,
  }) : super(key: key);

  String getFileSize(int bytes) {
    if (bytes < 1024) return "$bytes B";
    final kb = bytes / 1024;
    if (kb < 1024) return "${kb.toStringAsFixed(2)} KB";
    final mb = kb / 1024;
    return "${mb.toStringAsFixed(2)} MB";
  }

  @override
  Widget build(BuildContext context) {
    if (file == null) return SizedBox.shrink();

    final fileName = file!.name;
    final filePath = file!.path;
    final fileSize = File(filePath).lengthSync();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.insert_drive_file_rounded, size: 32, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  getFileSize(fileSize),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
