import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app/models/student_model.dart';

//this file for database save , edit ,delete functions


class StudentRepo {
 static ValueNotifier<List<StudentModel>>studntListNotifier =ValueNotifier([]);
  static const _dbName = 'student_db';
  static const _tableName = 'studentList';

  static Future<Database> _database() async {
    final database = openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        return db.execute(
      'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, name TEXT, contact TEXT, description TEXT, imagepath TEXT,)',
    );
      },
      version: 1,
    );
    return database;
  }
//recive the value from Student model class and insert to database

  static insert({required StudentModel studentModel}) async {
    final db = await _database();
    await db.insert(
      _tableName,
      studentModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
//convert the map from database to list student
  static Future<List<StudentModel>> getStudentDetails() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName,limit: 100,offset: 0);
    return List.generate(maps.length, (i) {
      return StudentModel(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        contact: maps[i]['contact'] as String,
        description: maps[i]['description'] as String,
        imagepath: maps[i]['imagepath'] as String,
        
      );
      
    });
    
  }

  static updateDetails({required StudentModel studentModel})async{
    final db = await _database();
  await db.update(
    _tableName,
    studentModel.toMap(),
    where: 'id = ?',
    whereArgs: [studentModel.id],
  );
  }

  static deleteStudent({required StudentModel studentModel})async{
    final db = await _database();
  await db.delete(
    _tableName,
    where: 'id = ?',
    whereArgs: [studentModel.id],
  );

  }

  static Future<void> updateStudentList() async {
    final List<StudentModel> updatedList = await getStudentDetails();
    studntListNotifier.value.clear();
    studntListNotifier.value.addAll(updatedList);
    studntListNotifier.notifyListeners();
  }


}
