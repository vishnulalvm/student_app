import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_app/models/student_model.dart';

class GridViewList extends StatefulWidget {
  final StudentModel studentModel;
  const GridViewList({super.key, required this.studentModel});

  @override
  State<GridViewList> createState() => _GridViewListState();
}

class _GridViewListState extends State<GridViewList> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Text(widget.studentModel.name),
      child:CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(File(widget.studentModel.imagepath)),
          ),
       );
  }
}

