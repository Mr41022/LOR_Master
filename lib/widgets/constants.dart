import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/network/auth.dart';
import 'package:major_project/network/profile_details.dart';
import 'package:major_project/network/registration_requests.dart';
import 'package:major_project/network/send_lor_request.dart';
import 'package:major_project/network/transcript_request.dart';
import 'package:major_project/screens/Principle_flow/Add_remove_professor.dart';
import 'package:major_project/screens/Professorstudentstatuscard_detail_page.dart';
import 'package:major_project/screens/Student_flow/Student_profile_page.dart';
import 'package:major_project/screens/home_screen/widgets/transcript_student_card.dart';
import 'package:major_project/screens/login_page.dart';
import 'package:major_project/screens/notifications/notification_page.dart';
import 'package:major_project/screens/studentstatuscard_detail_page.dart';
import 'package:major_project/widgets/transcript_tile.dart';
import 'package:major_project/widgets/university_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

//For logo of the application
class LogoWidget extends StatelessWidget {
  final double width;
  final double height;
  const LogoWidget({
    super.key,
    this.width = 90,
    this.height = 90,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/logo.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//this is the class for the textfield
class AuthTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final double boxHeight;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.borderRadius = 25,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.boxHeight,
    required this.keyboardType,
    this.hintText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: boxHeight),
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Color(0xff2E81FF),
                width: 1,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Color(0xff2E81FF),
                width: 1,
              )),
          hintMaxLines: 1,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
      ),
    );
  }
}

class NormalDropdownExample extends StatefulWidget {
  final String dropDownText;
  final List<String> dropDownList;
  final Function(String) onChanged;
  const NormalDropdownExample({
    super.key,
    required this.dropDownText,
    required this.onChanged,
    required this.dropDownList,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.borderRadius,
    required this.boxHeight,
  });
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double boxHeight;

  @override
  _NormalDropdownExampleState createState() => _NormalDropdownExampleState();
}

/// This is the stateful widget for dropdown
class _NormalDropdownExampleState extends State<NormalDropdownExample> {
  // List of dropdown items

  // Variable to hold the selected value
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: widget.boxHeight),
          labelText: widget.dropDownText,
          labelStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: Color(0xff2E81FF),
                width: 1,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: Color(0xff2E81FF),
                width: 1,
              )),
          hintMaxLines: 1,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            widget.onChanged(value!);
            selectedValue = value;
          });
        },
        items: widget.dropDownList.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}

//This the Class for the button
class Button extends StatelessWidget {
  final String buttonText;
  final void Function() onTap;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  const Button({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFF7E8BCD),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class studentHistoryAndHome extends StatefulWidget {
  final String requestText;
  // int requestType = 0;
  Function(int) onRequestTypeChanged;
  final bool isHistory;

  studentHistoryAndHome({
    super.key,
    required this.requestText,
    required this.onRequestTypeChanged,
    required this.isHistory,
  });

  @override
  State<studentHistoryAndHome> createState() => _studentHistoryAndHomeState();
}

class _studentHistoryAndHomeState extends State<studentHistoryAndHome> {
  int selectedIndex = 0;

  bool showTranscript({required String status}) {
    if (widget.isHistory) {
      if (status == "completed" || status == "rejected") {
        return true;
      } else {
        return false;
      }
    } else {
      if (status == "approved" || status == "pending") {
        return true;
      } else {
        return false;
      }
    }
  }

  bool showLoR({required String status}) {
    if (widget.isHistory) {
      if (status == "completed" || status == "rejected") {
        return true;
      } else {
        return false;
      }
    } else {
      if (status == "approved") {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 10),
            child: SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 340,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B3A3A),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: selectedIndex == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          width: 170,
                          height: 40,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                  // widget.requestType = 0;
                                });
                                widget.onRequestTypeChanged(selectedIndex);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "LoR Request's",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndex == 0
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                  // widget.requestType = 1;
                                });
                                widget.onRequestTypeChanged(selectedIndex);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Transcript",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndex == 1
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (selectedIndex == 0)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: 400,
                      child: StreamBuilder(
                          stream: LorRequests().getRequests(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: Text("No Requests"));
                            }
                            final data = snapshot.data;
                            return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: data!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemBuilder: (context, index) {
                                final reqData = data[index];
                                return showLoR(status: reqData["status"])
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: UniversityCard(
                                              data: reqData,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      )
                                    : Container();
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )
          else if (selectedIndex == 1)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: 400,
                      child: StreamBuilder(
                          stream: TranscriptRequest().getUserRequests(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData) {
                              return Center(child: Text("No Requests"));
                            }
                            final transcriptRequestData = snapshot.data;

                            return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: transcriptRequestData!
                                  .length, // Replace with actual count n
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemBuilder: (context, index) {
                                return showTranscript(
                                        status: transcriptRequestData[index]
                                            ["status"])
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: TranscriptStatusCard(
                                                data: transcriptRequestData[
                                                    index]),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      )
                                    : Container();
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class professorRequestAndHome extends StatefulWidget {
  final String requestText;
  final bool? showRegistration;
  final bool isHistory;

  const professorRequestAndHome({
    super.key,
    required this.requestText,
    this.showRegistration,
    required this.isHistory,
  });

  @override
  State<professorRequestAndHome> createState() =>
      _professorRequestAndHomeState();
}

class _professorRequestAndHomeState extends State<professorRequestAndHome> {
  bool showLoR({required String status}) {
    if (widget.isHistory) {
      if (status == "completed" || status == "rejected") {
        return true;
      } else {
        return false;
      }
    } else {
      if (status == "pending") {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          if (widget.showRegistration == true)
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 8),
              child: SizedBox(
                height: 20,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Student Registration Request',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Color(0xFF231E3C)),
                  ),
                ),
              ),
            ),
          if (widget.showRegistration == true)
            SizedBox(
              height: 10,
            ),
          if (widget.showRegistration == true)
            SizedBox(
              height: 102,
              child: FutureBuilder(
                future: RegistrationRequests().getRegistrationRequests(),
                builder: (BuildContext, val) {
                  if (val.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return StreamBuilder<List<Map<String, dynamic>>>(
                    stream: val.data,
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No Requests'),
                        );
                      }
                      return ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, int index) =>
                              const Divider(),
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> data =
                                snapshot.data![index];
                            return Container(
                              width: 300,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: StudentCard(
                                      // Replace with actual departments
                                      onAccept: () {
                                        if (mounted) {
                                          RegistrationRequests()
                                              .acceptRegistrationRequest(
                                            data: data,
                                          );
                                        }
                                      },
                                      onReject: () {
                                        if (mounted) {
                                          RegistrationRequests()
                                              .rejectRequest(data: data);
                                        }
                                      },
                                      data:
                                          data, // Replace with actual student IDs
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                ],
                              ),
                            );
                          });
                    },
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 10),
            child: SizedBox(
              height: 30,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.requestText,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Color(0xFF231E3C)),
                  )),
            ),
          ),
          StreamBuilder(
              stream: LorRequests().getRequests(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("NO requests");
                }
                final data = snapshot.data;
                return Column(
                    children: List.generate(
                  data!.length,
                  (index) => showLoR(status: data[index]['status'])
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: StudentCard(
                                onAccept: () {
                                  LorRequests().uploadLOR(
                                      docId: data![index]["doc_id"],
                                      studentEmail: data![index]["email"]);
                                },
                                onReject: () {
                                  LorRequests().removeLor(
                                      id: data![index]["doc_id"],
                                      studentEmail: data![index]["email"]);
                                },
                                data: data![index],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        )
                      : Container(),
                ));
              }),
        ],
      ),
    );
  }
}

class hodRequestAndHome extends StatefulWidget {
  final String requestText;

  const hodRequestAndHome({
    super.key,
    required this.requestText,
  });

  @override
  State<hodRequestAndHome> createState() => _hodRequestAndHomeState();
}

class _hodRequestAndHomeState extends State<hodRequestAndHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 22,
              ),
              child: SizedBox(
                height: 20,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Student Registration Request',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Color(0xFF231E3C)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 102,
                child: FutureBuilder(
                  future: RegistrationRequests().getRegistrationRequests(),
                  builder: (BuildContext, val) {
                    if (val.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return StreamBuilder<List<Map<String, dynamic>>>(
                      stream: val.data,
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No Requests'),
                          );
                        }
                        return ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            separatorBuilder: (context, int index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              final Map<String, dynamic> data =
                                  snapshot.data![index];
                              return Container(
                                width: 300,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: StudentCard(
                                        // Replace with actual departments
                                        onAccept: () {
                                          if (mounted) {
                                            RegistrationRequests()
                                                .acceptRegistrationRequest(
                                              data: data,
                                            );
                                          }
                                        },
                                        onReject: () {
                                          if (mounted) {
                                            RegistrationRequests()
                                                .rejectRequest(data: data);
                                          }
                                        },
                                        data:
                                            data, // Replace with actual student IDs
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                  ],
                                ),
                              );
                            });
                      },
                    );
                  },
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 22,
              ),
              child: SizedBox(
                height: 30,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.requestText,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          color: Color(0xFF231E3C)),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 400,
              child: ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 3, // Replace with actual count n
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  return Column(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ProfessorStudentStatusCard(
                          name:
                              'Vaibhav Kumar Sinha', // Replace with actual student names
                          universityName:
                              'Harvard University', // Replace with actual departments
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                // Add logic to remove this card from the list
                              });
                            }
                          },
                          status: 'Request Accepted',
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class professorHistory extends StatefulWidget {
  final String requestText;

  const professorHistory({
    super.key,
    required this.requestText,
  });

  @override
  State<professorHistory> createState() => _professorHistoryState();
}

class _professorHistoryState extends State<professorHistory> {
  final List<String> dropDownList = [
    '2000 - 2001',
    '2001 - 2002',
    '2002 - 2003',
    '2003 - 2004',
    '2004 - 2005',
    '2005 - 2006',
    '2006 - 2007',
    '2007 - 2008',
    '2008 - 2009',
    '2009 - 2010',
    '2010 - 2011',
    '2011 - 2012',
    '2012 - 2013',
    '2013 - 2014',
    '2014 - 2015',
    '2015 - 2016',
    '2016 - 2017',
    '2017 - 2018',
    '2018 - 2019',
    '2019 - 2020',
    '2020 - 2021',
    '2021 - 2022',
    '2022 - 2023',
    '2023 - 2024',
    '2024 - 2025'
  ];

  String selectedYear = '2023 - 2024';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 10),
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.requestText,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            color: Color(0xFF231E3C)),
                      )),
                  SizedBox(
                    width: 180,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (selectedYear == '2000 - 2001') {
                        selectedYear = '2024 - 2025';
                      } else {
                        int index = dropDownList.indexOf(selectedYear);
                        selectedYear = dropDownList[index - 1];
                      }
                    });
                  },
                  icon: Icon(Icons.chevron_left_rounded)),
              SizedBox(
                width: 200,
                child: Text(
                  selectedYear,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      color: Color(0xFF231E3C)),
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.chevron_right_rounded)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.chevron_left_rounded)),
            SizedBox(
              width: 200,
              child: Text(
                '2022-2023',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Color(0xFF231E3C)),
              ),
            ),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.chevron_right_rounded)),
          ]
              // Expanded(
              //   child: child,
              ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ExamcellRequestAndHome extends StatefulWidget {
  final String requestText;
  final bool isHistory;

  const ExamcellRequestAndHome(
      {super.key, required this.requestText, required this.isHistory});

  @override
  State<ExamcellRequestAndHome> createState() => _ExamcellRequestAndHomeState();
}

class _ExamcellRequestAndHomeState extends State<ExamcellRequestAndHome> {
  bool showTranscript({required String status}) {
    if (widget.isHistory) {
      if (status == "completed" || status == "rejected") {
        return true;
      } else {
        return false;
      }
    } else {
      if (status == "approved" || status == "pending") {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 22, top: 10),
            child: SizedBox(
              height: 30,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.requestText,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Color(0xFF231E3C)),
                  )),
            ),
          ),
          SizedBox(
            width: 400,
            child: StreamBuilder(
                stream: TranscriptRequest().getTranscriptRequest(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Requests"));
                  }
                  final transcriptRequestData = snapshot.data;

                  return ListView.separated(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: transcriptRequestData!
                        .length, // Replace with actual count n
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, index) {
                      return showTranscript(
                              status: transcriptRequestData[index]["status"])
                          ? Column(
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: TranscriptStudentCard(
                                    onAccept: () {
                                      if (mounted) {
                                        setState(() {
                                          // Add logic to remove this card from the list
                                        });
                                      }
                                    },
                                    onReject: () {
                                      if (mounted) {
                                        setState(() {
                                          // Add logic to remove this card from the list
                                        });
                                      }
                                    },
                                    data: transcriptRequestData[index],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            )
                          : Container();
                    },
                  );
                }),
          ),

          // Expanded(
          //   child: child,
          // ),
        ],
      ),
    );
  }
}

class ExamcellHistory extends StatefulWidget {
  final String requestText;

  ExamcellHistory({super.key, required this.requestText});

  @override
  State<ExamcellHistory> createState() => _ExamcellHistoryState();
}

class _ExamcellHistoryState extends State<ExamcellHistory> {
  final List<String> dropDownList = [
    '2000 - 2001',
    '2001 - 2002',
    '2002 - 2003',
    '2003 - 2004',
    '2004 - 2005',
    '2005 - 2006',
    '2006 - 2007',
    '2007 - 2008',
    '2008 - 2009',
    '2009 - 2010',
    '2010 - 2011',
    '2011 - 2012',
    '2012 - 2013',
    '2013 - 2014',
    '2014 - 2015',
    '2015 - 2016',
    '2016 - 2017',
    '2017 - 2018',
    '2018 - 2019',
    '2019 - 2020',
    '2020 - 2021',
    '2021 - 2022',
    '2022 - 2023',
    '2023 - 2024',
    '2024 - 2025'
  ];

  String selectedYear = '2023 - 2024';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 10),
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.requestText,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            color: Color(0xFF231E3C)),
                      )),
                  SizedBox(
                    width: 210,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (selectedYear == '2000 - 2001') {
                      selectedYear = '2024 - 2025';
                    } else {
                      int index = dropDownList.indexOf(selectedYear);
                      selectedYear = dropDownList[index - 1];
                    }
                  });
                },
                icon: Icon(Icons.chevron_left_rounded)),
            SizedBox(
              width: 200,
              child: Text(
                selectedYear,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Color(0xFF231E3C)),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (selectedYear == '2024 - 2025') {
                      selectedYear = '2000 - 2001';
                    } else {
                      int index = dropDownList.indexOf(selectedYear);
                      selectedYear = dropDownList[index + 1];
                    }
                  });
                },
                icon: Icon(Icons.chevron_right_rounded)),
          ]
              // Expanded(
              //   child: child,
              ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class profileAndNotifcation extends StatelessWidget {
  const profileAndNotifcation({
    super.key,
    required this.notificationCount,
  });

  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationPage(
                          userRole: 'Student',
                        ))); // Opens the drawer
          },
        ),
        if (notificationCount > 0)
          Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                '$notificationCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class professorDrawer extends StatelessWidget {
  const professorDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Auth().logout(onSuccess: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginpage(),
                  ),
                );
              });
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}

class principalDrawer extends StatelessWidget {
  const principalDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Auth().logout(onSuccess: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginpage(),
                  ),
                );
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1),
            title: Text('Add Professor'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageProfessorsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class UploadPdf extends StatelessWidget {
  const UploadPdf({
    super.key,
    required this.pdftext,
    required this.onTap,
  });
  final String pdftext;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 300,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(30),
            color: Color(0xff2E81FF),
            child: Container(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  pdftext,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const StudentCard({
    super.key,
    required this.onAccept,
    required this.onReject,
    required this.data,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.data);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfessorStudentStatusCardDetailsPage(
                    department: widget.data['department'] ?? "",
                    email: widget.data['email'] ?? "",
                    studentName: widget.data['name'] ?? "",
                    formStatus: true,
                    lastDate: widget.data['last_date'] ?? "",
                    phoneNumber: widget.data['phone_number'] ?? "",
                    universityName: widget.data['university_name'] ?? "",
                    lorRequestId: widget.data['doc_id'] ?? "",
                    fileUrl: widget.data['fileUrl'],
                  )),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Professor details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 340,
                    height: 25,
                    child: Text(
                      widget.data['name'] ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.data['student_id'] ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    widget.data['department'] ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Action buttons
            Positioned(
              top: 15,
              right: 0,
              child: Row(
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 18),
                    onPressed: widget.onReject,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const CircleBorder(),
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.upload, color: Colors.white, size: 18),
                    onPressed: widget.onAccept,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfessorStudentStatusCard extends StatefulWidget {
  final String name;
  final String universityName;
  final String status;
  final VoidCallback onPressed;

  const ProfessorStudentStatusCard({
    super.key,
    required this.name,
    required this.universityName,
    required this.onPressed,
    required this.status,
  });

  @override
  State<ProfessorStudentStatusCard> createState() =>
      _ProfessorStudentStatusCardState();
}

class _ProfessorStudentStatusCardState
    extends State<ProfessorStudentStatusCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfessorStudentStatusCardDetailsPage(
                      studentName: 'Vaibhav Kumar Sinha',
                      phoneNumber: '9876543214',
                      email: 'vaibhav@gmail.com',
                      department: 'Information Technology',
                      universityName: 'Harvard University',
                      formStatus: true,
                      lastDate: '20/04/2022',
                      lorRequestId: '',
                    )),
          );
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Professor details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 340),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.universityName,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Status:  ${widget.status}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Action buttons
            Positioned(
              top: 8,
              right: 0,
              child: Column(
                children: [
                  TextButton(
                    onPressed: widget.onPressed,
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFF7E8BCD),
                    ),
                    child: const Text(
                      'Download LoR',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'inter',
                          fontSize: 15),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const SizedBox(height: 4),
                  // Container(
                  //     height: 2,
                  //     decoration: BoxDecoration(
                  //       color: Colors.blueAccent,
                  //       borderRadius: BorderRadius.circular(10),
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfoTile({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class ProfessorTile extends StatelessWidget {
  ProfessorTile({required this.name, this.LOR});

  final String name;
  final String? LOR;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "Request Sent",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          if (LOR != null)
            IconButton(
                onPressed: () async {
                  launchUrl(Uri.parse(LOR!));
                },
                icon: Icon(Icons.download))
        ],
      ),
    );
  }
}
