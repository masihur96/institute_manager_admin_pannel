import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/public_provider.dart';
import 'package:provider/provider.dart';

class AllTeacher extends StatefulWidget {
  const AllTeacher({Key? key}) : super(key: key);

  @override
  _AllTeacherState createState() => _AllTeacherState();
}

class _AllTeacherState extends State<AllTeacher> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Container(
      width: publicProvider.pageWidth(size),
      child: Center(
        child: Text("All Teacher"),
      ),
    );
  }
}
