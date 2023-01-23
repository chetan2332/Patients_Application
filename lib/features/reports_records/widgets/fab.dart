import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:patient/colors.dart';

class Fab extends StatelessWidget {
  const Fab({super.key, required this.open, required this.close});

  final Function open;
  final Function close;

  // final ValueNotifier<bool> isDialOpen;

  // Future showToast(String message) async {
  //   await Fluttertoast.cancel();
  //   Fluttertoast.showToast(msg: message, fontSize: 18);
  // }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Styles.appbarcolor,
      overlayColor: Colors.black,
      overlayOpacity: 0,
      spacing: 12,
      spaceBetweenChildren: 4,
      childrenButtonSize: const Size(60, 60),
      onOpen: () {
        open();
      },
      onClose: () {
        close();
      },
      children: [
        SpeedDialChild(
            child: const Icon(Icons.create_new_folder_rounded),
            label: 'Add Category',
            onTap: () {}),
        SpeedDialChild(
            child: const Icon(Icons.article),
            label: 'Upload Report',
            onTap: () {}),
      ],
      icon: Icons.add,
      activeIcon: Icons.close,
    );
  }
}
