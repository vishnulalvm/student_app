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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Students'),
      ),
      body: ValueListenableBuilder<List<StudentModel>>(
        valueListenable: StudentRepo.studntListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studntList, Widget? child) {
          return ListView.builder(
              itemCount: studntList.length,
              itemBuilder: (context, index) {
                final data =studntList[index];
                return  StudentList(studentModel: data,);
              });
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
