import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/models/student_model.dart'; // Import your StudentModel

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

    return 
    
    ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final data = searchResults[index];
        return ListTile(
          onTap: (){
            
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
          onTap: (){
            
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
}
