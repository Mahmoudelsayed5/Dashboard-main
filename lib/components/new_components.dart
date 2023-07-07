import 'package:dashboard/components/colors.dart';
import 'package:dashboard/components/components.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget dashboardCard(
        {required BuildContext context,
        required Widget icon,
        required String nameTotal,
        required int total,
        LinearGradient? backgroundColorGradient}) =>
    Container(
      width: width(context, .15),
      decoration: BoxDecoration(
          gradient: backgroundColorGradient,
          borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          titleText(text: nameTotal, color: TextColors.blackText),
          subTitleText(text: total.toString(), color: TextColors.blackText)
        ],
      ),
    );

Widget databaseTable(context, List data, {double? w}) => SizedBox(
      width: width(context, 1),
      child: DataTable(
        columns: buildColumns(data, context).cast<DataColumn>(),
        rows: buildRows(data, context, w: w ?? .15).cast<DataRow>(),
      ),
    );
List buildColumns(List data, context) {
  return data.isNotEmpty
      ? data.first.keys
          .map((key) => DataColumn(
              label: SizedBox(
                  width: width(context, .1),
                  child: titleText(text: key, color: TextColors.blackText))))
          .toList()
      : [];
}

List buildRows(List data, context, {double? w}) {
  return data.map((row) {
    return DataRow(
      cells: row.values
          .map((value) {
            return DataCell(SizedBox(
              width: width(context, w ?? .15),
              child: value,
            ));
          })
          .cast<DataCell>()
          .toList(),
    );
  }).toList();
}

Widget actionButton({
  required Function() function,
  required IconData icon,
  Function(bool)? onHover,
  Color? color,
  Color? iconColor,
}) =>
    Container(
      color: color,
      child: TextButton(
        onHover: onHover,
        onPressed: function,
        child: Icon(icon, color: iconColor),
      ),
    );
