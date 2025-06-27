import 'package:flutter/material.dart';
import 'package:flutter_application_1/day1/Alert_dialog_custom.dart';
import 'package:flutter_application_1/day1/Bottom_sheet_dialog.dart';
import 'package:flutter_application_1/day1/Fancy_container_row.dart';
import 'package:flutter_application_1/day1/bouns_task2.dart';
import 'package:flutter_application_1/day1/radio_button.dart';
import 'package:flutter_application_1/day1/scrollable_card.dart';
import 'package:flutter_application_1/day1/toggle_switch_checkboc.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: ListView(
        children: [
          SectionTitle("Toggle Switch & Checkbox"),
          ToggleSwitchCheckbox(),
          Divider(),
          SectionTitle("Dynamic Radio Buttons"),
          RadioButton(),
          Divider(),
          SectionTitle("Scrollable Cards"),
          ScrollableCard(),
          Divider(),
          SectionTitle("Custom ALert dialog"),
          Divider(),
          AlertDialogCustom(),
          Divider(),
          SectionTitle("Bottom Sheet dialog"),
          BottomSheetDialog(),
          Divider(),
          SectionTitle("Fancy Container Row"),
          FancyContainerRow(),
        ],
      ),
    );
  }
}
