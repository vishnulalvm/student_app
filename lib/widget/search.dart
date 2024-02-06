import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/models/student_model.dart';
import 'package:student_app/repository/student_repo.dart';
import 'package:student_app/screen/view_student.dart'; // Import your StudentModel

class CustomSearchDelegate extends SearchDelegate<StudentModel> {
  final List<StudentModel> studentList; // Your list of students

  CustomSearchDelegate(this.studentList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here based on the query
    List<StudentModel> searchResults = studentList
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final data = searchResults[index];
        return ListTile(
          trailing: 
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
                                  deleteStudent(context,data);
                                  Navigator.pop(context);
                                 
                                },
                                child: const Text('Yes'))
                          ],
                        ));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ViewStudent(studentModel: data)));
          },
          
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(File(data.imagepath)),
          ),
          
          subtitle: Text(data.contact),
          title: Text(data.name),
          // Implement your UI for the search results here
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<StudentModel> searchResults = studentList
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // You can provide suggestions as users type
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final data = searchResults[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ViewStudent(studentModel: data)));
          },
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(File(data.imagepath)),
          ),
          subtitle: Text(data.contact),
          title: Text(data.name),
          // Implement your UI for the search results here
        );
      },
    ); // You can customize this based on your needs
  }

   deleteStudent(BuildContext context ,StudentModel studentModel) async {
    await StudentRepo.deleteStudent(studentModel:studentModel)
        .then((e) {});
    StudentRepo.updateStudentList();
  }
}
