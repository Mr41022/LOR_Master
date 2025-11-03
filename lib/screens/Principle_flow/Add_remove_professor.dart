import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/network/app_accounts.dart';
import 'package:major_project/screens/Principle_flow/Add_professor.dart';

class ManageProfessorsPage extends StatefulWidget {
  @override
  _ManageProfessorsPageState createState() => _ManageProfessorsPageState();
}

class _ManageProfessorsPageState extends State<ManageProfessorsPage> {
  final List<Map<String, String>> _professors = [];

  void _navigateToAddProfessorPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProfessorPage(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _professors.add(result);
      });
    }
  }

  void _removeProfessor(String email) {
    AppAccount().deleteUser(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Professors"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 10),
              child: SizedBox(
                height: 30,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Added Professors',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          color: Color(0xFF231E3C)),
                    )),
              ),
            ),
            SizedBox(height: 10),
            StreamBuilder(
                stream: AppAccount().getStaffRequests(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Center(
                        child: Text(
                          "No professors added yet.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    );
                  }
                  final data = snapshot.data;
                  return Expanded(
                      child: Column(
                    children: List.generate(
                      data!.length,
                      (index) {
                        final professor = data[index];
                        return Card(
                          child: ListTile(
                            title: Text(professor["name"] ?? ""),
                            subtitle: Text(
                                "${professor["email"] ?? ""} • ${professor["department"] ?? ""} • ${professor["role"] ?? ""}"),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _removeProfessor(professor["email"]),
                            ),
                          ),
                        );
                      },
                    ),
                  ));
                }),
            StreamBuilder(
                stream: AppAccount().getStaff(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Center(
                        child: Text(
                          "No professors added yet.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    );
                  }
                  final data = snapshot.data;
                  return Expanded(
                    child: Column(
                      children: List.generate(
                        data!.length,
                        (index) {
                          final professor = data[index];
                          return Card(
                            child: ListTile(
                              title: Text(professor["name"] ?? ""),
                              subtitle: Text(
                                  "${professor["email"] ?? ""} • ${professor["department"] ?? ""} • ${professor["role"] ?? ""}"),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _removeProfessor(professor["email"]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProfessorPage,
        child: Icon(Icons.person_add_alt_1),
        foregroundColor: Color.fromRGBO(126, 139, 205, 0.9),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
