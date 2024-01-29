//recive the value from the textflields and convert to map

class StudentModel {
  int? id;
  String name;
  String contact;
  String description;
  String imagepath;


  StudentModel({this.id,
  required this.name,
  required this.contact,
  required this.description,
  required this.imagepath,
  
   });
//converting class model to a map
   Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact': contact,
      'description': description,
      'imagepath': imagepath,
    };
  }

 
}
