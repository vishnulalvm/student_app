import 'package:flutter/material.dart';
import 'package:student_app/models/student_model.dart';
import 'package:student_app/repository/student_repo.dart';
import 'package:student_app/screen/add_button_screen.dart';

import 'package:student_app/widget/student_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool gridview =false;
  Icon customIcon = const Icon(Icons.search);
  Widget cusText = const Text('Friends List');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: cusText,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  cusText = const TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      hintText: 'Search Student',
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      fillColor: Colors.white, // Sets the background color
                      filled: true, // Enables background color filling
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),

                    //create a search feature when enter value in input field find the student form the  list
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  cusText = const Text('Student List');
                }
              });
            },
            icon: customIcon,
          ),
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Text('Logout'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.logout),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Text('Settings'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.settings),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'login', (route) => false);
                              },
                              child: const Text('Yes')),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    });
              }
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<StudentModel>>(
        valueListenable: StudentRepo.studntListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studntList, Widget? child) {
          return ListView(
            children:[ 
              ListView.builder(
                itemCount: studntList.length,
                itemBuilder: (context, index) {
                  final data = studntList[index];
                  return  StudentList(
                    studentModel: data,
                  );
                },
                ),
                ],
          );
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext ctx) => const AddButtonScreen(),
          ));

          // Check if the primaryKey is not null (meaning a student was added).
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      //
    );
  }
}
