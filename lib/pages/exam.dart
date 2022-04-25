import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/controller/public_provider.dart';
import 'package:provider/provider.dart';

class Exam extends StatefulWidget {
  const Exam({Key? key}) : super(key: key);

  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Container(
      width: publicProvider.pageWidth(size),
      child: Center(child: Text("Exam")),
    );
  }
}
