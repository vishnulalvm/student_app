import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/models/student_model.dart';
import 'package:student_app/repository/student_repo.dart';
import 'package:student_app/screen/edit_student.dart';
import 'package:student_app/screen/view_student.dart';

class StudentList extends StatefulWidget {
  final StudentModel studentModel;

  const StudentList({
    super.key,
    required this.studentModel,
  });

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext ctx) => ViewStudent(
            studentModel: widget.studentModel,
          ),
        ));
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: FileImage(File(widget.studentModel.imagepath)),
      ),
      title: Text(widget.studentModel.name),
      subtitle: Text(widget.studentModel.contact),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext ctx) => EditStudent(
                    studentModel: widget.studentModel,
                  ),
                ));
              },
              icon: const Icon(
                Icons.edit,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: const Text('Are you sure want to delete?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    deleteStudent(context);
                                    showSnackBar();
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text('Yes'))
                          ],
                        ));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

  deleteStudent(BuildContext context) async {
    await StudentRepo.deleteStudent(studentModel: widget.studentModel)
        .then((e) {});
    StudentRepo.updateStudentList();
  }

  showSnackBar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Student deleated')));
  }
}
