import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalPeople;
  final int? numOfPeople, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalPeople,
    this.numOfPeople,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Student",
    numOfPeople: 200,
    svgSrc: "assets/images/admission_icon.png",
    totalPeople: "150",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Teacher",
    numOfPeople: 17,
    svgSrc: "assets/images/joining_icon.png",
    totalPeople: "17",
    color: Color(0xFFFFA113),
    percentage: 100,
  ),
  CloudStorageInfo(
    title: "Attendance",
    numOfPeople: 200,
    svgSrc: "assets/images/admission_icon.png",
    totalPeople: "150",
    color: Color(0xFFA4CDFF),
    percentage: 75,
  ),
  CloudStorageInfo(
    title: "Exam",
    numOfPeople: 200,
    svgSrc: "assets/images/notice_icon.png",
    totalPeople: "150",
    color: IMColors.primaryColor,
    percentage: 75,
  ),
];
