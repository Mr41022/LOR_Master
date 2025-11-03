import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:major_project/network/app_accounts.dart';
import 'package:major_project/network/send_lor_request.dart';
import 'package:major_project/screens/Student_flow/Student_homepage.dart';
import 'package:major_project/widgets/constants.dart';
import 'package:major_project/widgets/file_display_widget.dart';

class CreateLoRRequest extends StatefulWidget {
  const CreateLoRRequest({super.key});

  @override
  State<CreateLoRRequest> createState() => _CreateLoRRequestState();
}

class _CreateLoRRequestState extends State<CreateLoRRequest> {
  String? selectedDepartment;
  String? selectedProfessor;
  String? selectedLoRType;
  XFile? file;

  selectfile() async {
    file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {});
    }
  }

  _updateDepartment(String departmentName) {
    setState(() {
      selectedDepartment = departmentName;
    });
  }

  // _updateProfessor(String professorName) {
  //   setState(() {
  //     selectedProf = professorName;
  //   });
  // }

  _updateLoRType(String loRType) {
    setState(() {
      selectedLoRType = loRType;
    });
  }

  final universityNameController = TextEditingController();
  final lastDateController = TextEditingController();
  final phoneNumberController = TextEditingController();

  List<String> selectedProf = [];
  List<String> selectedProfEmail = [];
  String universityName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Request',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.inter().fontFamily,
            color: Color(0xFF231E3C),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            NormalDropdownExample(
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              boxHeight: 80,
              dropDownText: 'Department',
              onChanged: (val) {
                _updateDepartment(val);
              },
              dropDownList: [
                'Information Technology',
                'EXTC',
                'Computer Science',
                'Mechanical'
              ],
            ),
            SizedBox(
              height: 15,
            ),
            StreamBuilder(
                stream: AppAccount().getStaff(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Loading...'),
                    );
                  }
                  List<String> profNameList = List.generate(
                      snapshot.data!.length,
                      (index) => snapshot.data![index]["name"]);
                  List<String> profEmailList = List.generate(
                      snapshot.data!.length,
                      (index) => snapshot.data![index]["email"]);
                  return NormalDropdownExample(
                    horizontalPadding: 15,
                    verticalPadding: 15,
                    borderRadius: 30,
                    boxHeight: 80,
                    dropDownText: 'Professor Name',
                    onChanged: (val) {
                      // _updateProfessor(val);

                      if (!selectedProf.contains(val)) {
                        selectedProf.add(val);
                        final index = profNameList.indexOf(val);
                        selectedProfEmail.add(profEmailList[index]);
                      }
                    },
                    dropDownList: profNameList,
                  );
                }),
            Wrap(
              children: List.generate(
                  selectedProf.length,
                  (index) => Container(
                        margin: EdgeInsets.only(right: 6, bottom: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.withOpacity(0.25)),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(selectedProf[index]),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                                onTap: () {
                                  selectedProf.removeAt(index);
                                  selectedProfEmail.removeAt(index);
                                  setState(() {});
                                },
                                child: Icon(Icons.close))
                          ],
                        ),
                      )),
            ),
            SizedBox(
              height: 15,
            ),
            AuthTextField(
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              controller: universityNameController,
              boxHeight: 80,
              labelText: 'Unversity Name',
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 15,
            ),
            AuthTextField(
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              boxHeight: 80,
              labelText: 'Last Date of Submission',
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 15,
            ),
            NormalDropdownExample(
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              boxHeight: 80,
              dropDownText: 'Lor Type',
              onChanged: (val) {
                _updateLoRType(val);
              },
              dropDownList: ["Letter", "Link", "Both"],
            ),
            SizedBox(
              height: 16,
            ),
            if (selectedLoRType == "Letter" || selectedLoRType == "Both")
              file == null
                  ? UploadPdf(
                      onTap: () {
                        selectfile();

                        // Add PDF upload functionality here
                      },
                      pdftext: 'Upload Letter',
                    )
                  : FileDisplayWidget(
                      file: file,
                      onRemove: () {
                        setState(() {
                          file = null;
                        });
                      },
                    ),
            Button(
                width: 340,
                height: 60,
                borderRadius: 30,
                fontSize: 18,
                buttonText: 'Send Request',
                onTap: () {
                  print(selectedDepartment);
                  if (selectedDepartment != null) {
                    LorRequests().sendLorRequests(
                        file: file,
                        onSuccess: () {
                          Navigator.pop(context);
                        },
                        names: selectedProf,
                        emails: selectedProfEmail,
                        universityName: universityNameController.text,
                        department: selectedDepartment!,
                        lastDate: lastDateController.text,
                        phoneNumber: '');
                  }
                })
          ],
        ),
      ),
    );
  }
}

