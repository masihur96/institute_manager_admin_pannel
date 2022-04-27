import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:institute_manager_admin_pannel/constants.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/public_provider.dart';
import 'package:institute_manager_admin_pannel/model/MyFiles.dart';
import 'package:provider/provider.dart';

class FileInfoCard extends StatefulWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  State<FileInfoCard> createState() => _FileInfoCardState();
}

class _FileInfoCardState extends State<FileInfoCard> {
  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: IMColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: widget.info.color!.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Image.asset(
                  widget.info.svgSrc!,
                  color: widget.info.color,
                  fit: BoxFit.fill,
                ),
              ),
              Icon(Icons.more_vert, color: widget.info.color)
            ],
          ),
          InkWell(
            onTap: () {
              if (widget.info.title == 'Student') {
                setState(() {
                  publicProvider.subCategory = 'All Student';
                  publicProvider.category = '';
                });
              } else if (widget.info.title == 'Teacher') {
                setState(() {
                  publicProvider.subCategory = 'All Teacher';
                  publicProvider.category = '';
                });
              } else if (widget.info.title == 'Attendance') {
                setState(() {
                  publicProvider.subCategory = 'Attendance';
                  publicProvider.category = '';
                });
              } else if (widget.info.title == 'Exam') {
                setState(() {
                  publicProvider.subCategory = 'Exam';
                  publicProvider.category = '';
                });
              }
            },
            child: Text(
              widget.info.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ProgressLine(
            color: widget.info.color,
            percentage: widget.info.percentage,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.info.numOfPeople} people",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: widget.info.color),
              ),
              Text(
                widget.info.totalPeople!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: widget.info.color),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
