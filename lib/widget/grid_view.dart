import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_app/models/student_model.dart';
import 'package:student_app/screen/view_student.dart';

class GridViewList extends StatefulWidget {
  final StudentModel studentModel;
  const GridViewList({super.key, required this.studentModel});

  @override
  State<GridViewList> createState() => _GridViewListState();
}

class _GridViewListState extends State<GridViewList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext ctx) => ViewStudent(
            studentModel: widget.studentModel,
          ),
        ));
      },
      child: GridTile(
        
        footer: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            widget.studentModel.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        child: CircleAvatar(
          
          radius: 40,
          backgroundImage: FileImage(
            File(widget.studentModel.imagepath),
          ),
        ),
      ),
    );
  }
}
