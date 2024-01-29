import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/models/student_model.dart';
import 'package:student_app/repository/student_repo.dart';

class AddButtonScreen extends StatefulWidget {
  const AddButtonScreen({
    super.key,
  });

  @override
  State<AddButtonScreen> createState() => _AddButtonScreenState();
}

class _AddButtonScreenState extends State<AddButtonScreen> {
  String? pickedImage = 'image';
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New User',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),

              ElevatedButton.icon(
                label: const Text('Add a image'),
                onPressed: () async {
                  pickedImage = await pickImage();
                  setState(() {});
                },
                icon: pickedImage == 'image'
                    ? const Icon(
                        Icons.add,
                        size: 30,
                      )
                    : const Icon(Icons.check),
              ),

              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userContactController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Contact',
                    labelText: 'Contact',
                    errorText: _validateContact
                        ? 'Contact Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                    errorText: _validateDescription
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),

// Add button and Clear Button

              Row(
                children: [
                  //save student button
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () async {
                      setState(() {
                        _userNameController.text.isEmpty
                            ? _validateName = true
                            : _validateName = false;
                        _userContactController.text.isEmpty
                            ? _validateContact = true
                            : _validateContact = false;
                        _userDescriptionController.text.isEmpty
                            ? _validateDescription = true
                            : _validateDescription = false;
                      });
                      //this line is checking textfield is not empty and save to data base
                      if (_validateName == false &&
                          _validateContact == false &&
                          _validateDescription == false) {
                        insertStudent();
                        showSnackBar();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save Details'),
                  ),

                  const SizedBox(
                    width: 10.0,
                  ),
                  //clear button
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _userNameController.clear();
                        _userContactController.clear();
                        _userDescriptionController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    }
    if (pickedFile == null) {
      return 'image not piced';
    }
    return null;
  }

  //here is the value passing from textfield to database

  insertStudent() async {
    final student = StudentModel(
        name: _userNameController.text,
        contact: _userContactController.text,
        description: _userDescriptionController.text,
        imagepath: pickedImage!);

    await StudentRepo.insert(studentModel: student);
    StudentRepo.updateStudentList();
  }

  showSnackBar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('New student added')));
  }
}
