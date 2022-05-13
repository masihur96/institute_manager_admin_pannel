import 'dart:html';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:institute_manager_admin_pannel/constants.dart';

class StudentTeacherList extends StatefulWidget {
  const StudentTeacherList({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentTeacherList> createState() => _StudentTeacherListState();
}

class _StudentTeacherListState extends State<StudentTeacherList> {
  bool selectStudent = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: IMColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectStudent = true;
                  });
                },
                child: Text("Student",
                    style: selectStudent
                        ? IMTextStyle.IMHeader
                        : IMTextStyle.IMSubHeaderWhite),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectStudent = false;
                  });
                },
                child: Text(
                  "Teacher",
                  style: selectStudent
                      ? IMTextStyle.IMSubHeaderWhite
                      : IMTextStyle.IMHeader,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: DataTable2(
          //     columnSpacing: defaultPadding,
          //     minWidth: 600,
          //     columns: const [
          //       DataColumn(
          //         label: Text("Name"),
          //       ),
          //       DataColumn(
          //         label: Text("Address"),
          //       ),
          //       DataColumn(
          //         label: Text("Phone"),
          //       ),
          //     ],
          //     rows: selectStudent == true
          //         ? List.generate(
          //             student_list_file.length,
          //             (index) => recentFileDataRow(student_list_file[index]),
          //           )
          //         : List.generate(
          //             teacher_list_file.length,
          //             (index) => recentFileDataRow(teacher_list_file[index]),
          //           ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// DataRow recentFileDataRow(InfoList infoList) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             SvgPicture.asset(
//               infoList.icon!,
//               height: 30,
//               width: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(infoList.name!),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(infoList.address!)),
//       DataCell(Text(infoList.phone!)),
//     ],
//   );
// }
