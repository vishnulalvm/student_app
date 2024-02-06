import 'package:flutter/material.dart';
import 'package:student_app/models/student_model.dart';
import 'package:student_app/repository/student_repo.dart';
import 'package:student_app/screen/add_button_screen.dart';
import 'package:student_app/widget/grid_view.dart';
import 'package:student_app/widget/search.dart';
import 'package:student_app/widget/student_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool gridview = true;
  Icon customIcon = const Icon(Icons.search);
  Widget cusText = const Text('Student List');
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<StudentModel> studntList = StudentRepo.studntListNotifier.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: cusText,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              // Display the search bar
              StudentModel? selectedStudent = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(studntList),
              );

              // Handle the selected student (if needed)
              if (selectedStudent != null) {
                // Do something with the selected student
              }
            },
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
          final newfilteredList =
              filterList(_searchController.text, studntList);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Students : ${newfilteredList.length}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      
                        onPressed: () {
                          setState(() {
                            gridview == true
                                ? gridview = false
                                : gridview = true;
                          });
                        },
                        
                        icon: gridview ==true ? const Icon(Icons.grid_3x3,size: 30,): const Icon(Icons.list,size: 30,)
                        ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Expanded(
                  child: gridview
                      ? ListView.builder(
                          itemCount: newfilteredList.length,
                          itemBuilder: (context, index) {
                            final data = newfilteredList[index];
                            return StudentList(
                              studentModel: data,
                            );
                          },
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemCount: newfilteredList.length,
                          itemBuilder: (context, index) {
                            final data = newfilteredList[index];
                            return GridViewList(
                              studentModel: data,
                            );
                          },
                        )),
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

  List<StudentModel> filterList(
      String searchText, List<StudentModel> inputList) {
    if (searchText.isEmpty) {
      return inputList;
    }
    return inputList
        .where((student) =>
            student.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
