import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/pages/all_students.dart';
import 'package:institute_manager_admin_pannel/pages/all_teacher.dart';
import 'package:institute_manager_admin_pannel/pages/attendance.dart';
import 'package:institute_manager_admin_pannel/pages/exam.dart';
import 'package:institute_manager_admin_pannel/pages/sidebar_view/contact_info.dart';
import 'package:institute_manager_admin_pannel/pages/sidebar_view/staf_joining.dart';
import 'package:institute_manager_admin_pannel/pages/sidebar_view/teacher_joining_page.dart';
import 'package:institute_manager_admin_pannel/pages/sidebar_view/admission_page.dart';
import 'package:institute_manager_admin_pannel/pages/sidebar_view/settings_page.dart';
import 'package:institute_manager_admin_pannel/pages/sidebar_view/dashboard_page.dart';

class PublicProvider extends ChangeNotifier {
  String _category = '';
  String _subCategory = '';

  bool isWindows = false;

  String get category => _category;
  String get subCategory => _subCategory;

  set subCategory(String value) {
    _subCategory = value;
    notifyListeners();
  }

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  double pageWidth(Size size) {
    if (size.width < 1300)
      return size.width;
    else
      return size.width * .85;
  }

  String pageHeader() {
    if (_category.isNotEmpty && _subCategory.isNotEmpty)
      return '$_category  \u276D  $_subCategory';
    else if (_category.isEmpty && _subCategory.isNotEmpty)
      return '$_subCategory';
    else
      return 'Dashboard';
  }

  Widget pageBody() {
    if (_subCategory == 'Student Admission')
      return Admission();
    else if (_subCategory == 'Teacher Joining')
      return TeacherJoiningPage();
    else if (_subCategory == 'Staff Joining')
      return StaffJoining();
    else if (_subCategory == 'All Student')
      return AllStudent();
    else if (_subCategory == 'All Teacher')
      return AllTeacher();
    else if (_subCategory == 'Attendance')
      return Attendance();
    else if (_subCategory == 'Exam')
      return Exam();
    else if (_subCategory == 'Contact Info')
      return ContactInfo();
    else if (_subCategory == 'Settings') return SettingsPage();

    return DashBoardPage();
  }

  // Future<bool> validateAdmin(BuildContext context, String phone, String password)async{
  //   try{
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Admin')
  //         .where('phone', isEqualTo: phone).get();
  //     final List<QueryDocumentSnapshot> user = snapshot.docs;
  //     if(user.isNotEmpty && user[0].get('password')==password){
  //       return true;
  //     }else{
  //       return false;
  //     }
  //   }catch(error){
  //     showToast(error.toString());
  //     return false;
  //   }
  // }
}
