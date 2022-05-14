import 'package:flutter/material.dart';

class Variables {
  ///This is the entire multi-level list displayed by this app
  static List<Entry> sideBarMenuList() {
    final List<Entry> data = <Entry>[
      Entry('Joining', Icons.category_outlined, <Entry>[
        Entry('Student Admission'),
        Entry('Teacher Joining'),
        Entry('Staff Joining'),
      ]),
      Entry('Transaction', Icons.category_outlined, <Entry>[
        Entry('Tuition Fee'),
        Entry('Salary'),
        Entry('Income Expenses'),
      ]),
      Entry('Class', Icons.category_outlined, <Entry>[
        Entry('Class'),
        Entry('Exam'),
        Entry('Result'),
      ]),
      Entry('News', Icons.category_outlined, <Entry>[
        Entry('Hot News'),
        Entry('Notice'),
      ]),
      // Entry('Deposit', Icons.category_outlined, <Entry>[
      //   Entry('Deposit'),
      //   Entry('Insurance'),
      // ]),
      // Entry('Transaction', Icons.category_outlined, <Entry>[
      //   Entry('Withdraw'),
      //   Entry('Add Amount'),
      // ]),
    ];
    return data;
  }

  int? productIndex;
}

class Entry {
  final String title;
  final IconData? iconData;
  final List<Entry>
      children; //Since this is an expansion list...children can be another list of entries.

  Entry(this.title, [this.iconData, this.children = const <Entry>[]]);
}
