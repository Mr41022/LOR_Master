import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:major_project/screens/Examcell_flow/Transcript_form.dart';
import 'package:intl/intl.dart';

class TranscriptStatusCard extends StatelessWidget {
  final Map data;
  final bool isButtonActive = true;

  TranscriptStatusCard({required this.data});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM dd, yyyy – hh:mm a')
        .format(data['updated_at'].toDate());
    print(data);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status: ${data['status']}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (data['status'] == 'approved' && !data["is_form_filled"])
                ElevatedButton(
                  onPressed: isButtonActive
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TranscriptForm(
                                transcriptId: data['id'],
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 14, 85, 144),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child:
                      Text("Fill Form", style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Colors.blue),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              formattedDate,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
