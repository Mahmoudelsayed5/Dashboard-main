import 'dart:convert';

import 'package:dashboard/bloc/cubit.dart';
import 'package:dashboard/components/colors.dart';
import 'package:dashboard/components/components.dart';
import 'package:dashboard/components/constants.dart';
import 'package:dashboard/components/new_components.dart';
import 'package:dashboard/data/exercise_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Saving the list
void saveExerciseData(List exercise) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonList = jsonEncode(exercise);
  prefs.setString('exerciseData', jsonList);
  print(prefs);
}

// Retrieving the list
Future<List<dynamic>> getExerciseData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonList = prefs.getString('exerciseData')!;
  if (jsonList.isNotEmpty) {
    return List<dynamic>.from(jsonDecode(jsonList));
  }
  return [];
}

class RowSource extends DataTableSource {
  List myData;
  final int count;
  final BuildContext context;
  RowSource({required this.myData, required this.count, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context);
    } else
      return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(var data, context) {
  TextEditingController nameController = TextEditingController();
  List<Map> editData1 = [
    {
      'name': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseName,
      ),
      'ID': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseId.toString(),
      ),
      'body part': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseBodyPart.toString(),
      ),
      'type': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseType.toString(),
      ),
    }
  ];
  List<Map> editData2 = [
    {
      'level': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseLevel.toString(),
      ),
      'equipment': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseEquipment.toString(),
      ),
      'repititions': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseRepetition.toString(),
      ),
      'sets': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseSets.toString(),
      ),
    }
  ];
  List<Map> editData3 = [
    {
      'description': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseDescription.toString(),
      ),
      'images': defaultTextFormField(
        controller: nameController,
        hint: data.exerciseImage.toString(),
      ),
    }
  ];
  return DataRow(
    cells: [
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          actionButton(
              function: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      print('object click');

                      return Dialog(
                        backgroundColor: BackgroundColors.dialogBG,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            databaseTable(context, editData1),
                            databaseTable(context, editData2),
                            databaseTable(context, editData3, w: .3),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  DefaultButton(function: () {}, text: 'save'),
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: Icons.edit,
              iconColor: BackgroundColors.whiteBG,
              color: DashboardManager().editColor,
              onHover: (isHovered) {
                DashboardManager().editHover();
              }),
          actionButton(
              function: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      print('object click');
                      return AlertDialog(
                        actions: [
                          // const Text(
                          //   'Are you sure you want to delete this exercise ?',
                          //   selectionColor: Colors.white,
                          //   textAlign: TextAlign.center,
                          // ),
                          DefaultButton(function: () {}, text: 'Yes'),
                          DefaultButton(
                            function: () {},
                            text: 'No',
                            backgroundColor: Colors.red,
                          ),
                        ],
                      );
                    });
              },
              icon: Icons.delete,
              iconColor: BackgroundColors.whiteBG,
              color: DashboardManager().deleteColor,
              onHover: (isHovered) {
                DashboardManager().deleteHover();
              }),
        ],
      )),
      DataCell(Text(data.exerciseName ?? "Name")),
      DataCell(Text(data.exerciseId.toString())),
      DataCell(Text(data.exerciseBodyPart.toString())),
      DataCell(Text(data.exerciseType.toString())),
      DataCell(Text(data.exerciseDescription.toString())),
      DataCell(Text(data.exerciseLevel.toString())),
      DataCell(Text(data.exerciseEquipment.toString())),
      DataCell(Text(data.exerciseRepetition.toString())),
      DataCell(Text(data.exerciseSets.toString())),
      DataCell(Text(data.exerciseImage.toString())),
    ],
  );
}
