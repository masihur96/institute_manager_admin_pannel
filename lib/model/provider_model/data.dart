import 'package:flutter/foundation.dart';
import 'package:institute_manager_admin_pannel/model/data_model/student_model.dart';

class Data extends ChangeNotifier {
  List<StudentModel>? _students;

  List<StudentModel>? get students => _students;

  setStudents(List<StudentModel>? students) {
    _students = students;
    notifyListeners();
  }
}
