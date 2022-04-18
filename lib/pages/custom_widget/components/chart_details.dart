import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/constants.dart';

import 'chart.dart';

class ChartDetails extends StatelessWidget {
  const ChartDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: IMColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "Attendance Chart",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: IMColors.greyColor),
                ),
                SizedBox(height: defaultPadding),
                Chart(
                  currentAmount: "150",
                  totalAmount: "200",
                ),
              ],
            ),
          ),

          IntrinsicHeight(
            child: VerticalDivider(
              width: 5,
              color: IMColors.primaryColor,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Fees Chart",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: IMColors.greyColor),
                ),
                SizedBox(height: defaultPadding),
                Chart(
                  currentAmount: "50,000",
                  totalAmount: "1,50,000",
                ),
              ],
            ),
          ),

          // StorageInfoCard(
          //   svgSrc: "assets/icons/Documents.svg",
          //   title: "Documents Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/media.svg",
          //   title: "Media Files",
          //   amountOfFiles: "15.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/folder.svg",
          //   title: "Other Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/unknown.svg",
          //   title: "Unknown",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 140,
          // ),
        ],
      ),
    );
  }
}
