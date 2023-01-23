import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/colors.dart';
import 'package:patient/features/reports_records/widgets/reports/category_reports.dart';
import 'package:patient/features/reports_records/widgets/reports/monthly_reports.dart';
import 'package:patient/info.dart';

class Reports extends ConsumerStatefulWidget {
  final String doctorUid;
  const Reports(this.doctorUid, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReportsState();
}

class _ReportsState extends ConsumerState<Reports> {
  int dropDownValue = 2;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 8),
            child: DropdownButton(
                menuMaxHeight: 150,
                value: dropDownValue,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('By Month')),
                  DropdownMenuItem(value: 2, child: Text('By Category')),
                ],
                onChanged: (val) {
                  dropDownValue = val ?? 1;
                  setState(() {});
                }),
          ),
          if (dropDownValue == 2)
            SizedBox(
              height: (category).length / 2 * 400,
              child: GridView.count(
                crossAxisCount: 2,
                children: (category)
                    .map((item) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              CategoryReports.routeName,
                              arguments: item,
                            );
                          },
                          child: GridTile(
                              footer: Text(
                                item,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                              child: const Icon(
                                Icons.folder,
                                size: 126,
                                color: Styles.appbarcolor,
                              )),
                        ))
                    .toList(),
              ),
            ),
          if (dropDownValue == 1)
            SizedBox(
              height: (months).length / 2 * 400,
              child: GridView.count(
                crossAxisCount: 2,
                children: (months)
                    .map((item) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                MonthlyReport.routeName,
                                arguments: item);
                          },
                          child: GridTile(
                              footer: Text(
                                item,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                              child: const Icon(
                                Icons.folder,
                                size: 126,
                                color: Styles.appbarcolor,
                              )),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
