import 'package:dashboard/bloc/cubit.dart';
import 'package:dashboard/bloc/states.dart';
import 'package:dashboard/components/colors.dart';
import 'package:dashboard/components/components.dart';
import 'package:dashboard/components/constants.dart';
import 'package:dashboard/components/new_components.dart';
import 'package:dashboard/data/exercise_data.dart';
import 'package:dashboard/storage/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  List? get editData1 => null;

  List? get editData2 => null;

  List? get editData3 => null;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDataMapValues(allValues: true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (_) => DashboardManager(),
              child: BlocConsumer<DashboardManager, DashboardState>(
                  listener: (_, s) {},
                  builder: (_, s) {
                    DashboardManager profile = DashboardManager().get(_);
                    Map<String, dynamic> cards = {
                      'Home': {
                        'icon': const Icon(Icons.account_circle,
                            color: Colors.grey, size: 35.0),
                        'name': 'Total users',
                        'total': 0,
                        'color': BackgroundColors.blueGradient
                      },
                      'Gym': {
                        'icon': Image.asset('images/gymIcon.png', width: 40.0),
                        'name': 'Total exercises',
                        'total': snapshot.data!.length,
                        'color': BackgroundColors.greenGradient
                      },
                      'Nutrition': {
                        'icon': Image.asset('images/nutritionIcon.png',
                            width: 40.0),
                        'name': 'Total meals',
                        'total': 0,
                        'color': BackgroundColors.redGradient
                      },
                    };
                    final List<Map> data = [
                      {'ID': '1', 'Name': 'John Doe', 'Age': '25'},
                      {'ID': '2', 'Name': 'Jane Smith', 'Age': '30'},
                      {'ID': '3', 'Name': 'Bob Johnson', 'Age': '35'},
                    ];
                    var cardValues = cards.values.toList();
                    return BlocProvider(
                      create: (context) => DashboardManager(),
                      child: BlocConsumer<DashboardManager, DashboardState>(
                          listener: (context, state) {
                        if (state is Filter) {
                          var filterList = state.filter!;
                        }
                      }, builder: (context, state) {
                        return FutureBuilder(
                            future: getDataMapValues(allValues: true),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                DashboardManager table =
                                    DashboardManager().get(context);
                                var filterList;
                                var tableData = table.filterOpened
                                    ? filterList
                                    : snapshot.data!;
                                var controller;
                                return SizedBox(
                                  width: width(context, 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 160,
                                              child: ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (_, i) =>
                                                      dashboardCard(
                                                          context: context,
                                                          icon: cardValues[i]
                                                              ['icon'],
                                                          nameTotal:
                                                              cardValues[i]
                                                                  ['name'],
                                                          total: cardValues[i]
                                                              ['total'],
                                                          backgroundColorGradient:
                                                              cardValues[i]
                                                                  ['color']),
                                                  separatorBuilder: (_, i) =>
                                                      const SizedBox(
                                                          width: 350.0),
                                                  itemCount: 3),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PaginatedDataTable(
                                        sortColumnIndex: 0,
                                        sortAscending: table.sort,
                                        header: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: TextField(
                                              controller: controller,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Enter something to filter"),
                                              onChanged: (value) {
                                                table.onFilter(
                                                    tableData, value);
                                              }),
                                        ),
                                        source: RowSource(
                                            myData: tableData,
                                            count: tableData.length,
                                            context: context),
                                        rowsPerPage: 8,
                                        columnSpacing: 8,
                                        columns: [
                                          const DataColumn(
                                            label: Text(
                                              "Actions",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          DataColumn(
                                              label: const Text(
                                                "Name",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              ),
                                              onSort: (columnIndex, ascending) {
                                                table.changeSort();
                                                table.onsortColum(columnIndex,
                                                    ascending, tableData);
                                              }),
                                          const DataColumn(
                                            label: Text(
                                              "Id",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              "Body Part",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              "Type",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              "Description",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              "Level",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              "Equipment",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              "Repetitions",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              "Sets",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const DataColumn(
                                            label: Text(
                                              "Image Url",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: titleText(
                                        text: 'error ${snapshot.error}'));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            });
                      }),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: titleText(
                    text: "Error fetching data ${snapshot.error}",
                    color: TextColors.blackText));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget userCard(
          {required BuildContext context,
          required Widget icon,
          required String name,
          required int total,
          required LinearGradient color}) =>
      dashboardCard(
          context: context,
          icon: icon,
          nameTotal: name,
          total: total,
          backgroundColorGradient: color);
}
