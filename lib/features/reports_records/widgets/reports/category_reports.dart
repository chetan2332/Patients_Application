import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:patient/colors.dart';
import 'package:patient/info.dart';

class CategoryReports extends ConsumerWidget {
  static const routeName = '/category_report';
  final String val;
  const CategoryReports(this.val, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(val)),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(thickness: 0.7),
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(
              Icons.article,
              color: Styles.appbarcolor,
              size: 30,
            ),
            title: const Text(
              'prescription',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(DateFormat.yMMMEd().format(
                DateTime.now().subtract(Duration(hours: 24 * 7 * index)))),
            // contentPadding: EdgeInsets.symmetric(horizontal: 1),
          ),
          itemCount: decList.length,
        ),
      ),
    );
  }
}
