import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_approval_app/model/status_class.dart';
import 'package:imperial_approval_app/model/status_filter.dart';

class DateDropdown extends StatefulWidget {
  const DateDropdown({super.key});

  @override
  State<DateDropdown> createState() => _DateDropdownState();
}

class _DateDropdownState extends State<DateDropdown> {

  var listFilter = ["7 hari", "2 minggu", "1 bulan", "3 bulan"];
  String dropValue = "7 hari";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownMenu(
        label: Text("Pilih tanggal"),
        leadingIcon: Icon(Icons.date_range_rounded),
        // hintText: "7 hari",
        initialSelection: dropValue,
        dropdownMenuEntries: listFilter.map((date) => DropdownMenuEntry(
          value: date,
          label: date
        )).toList(), 
        onSelected: (date) {
          print(date);
          setState(() {
            dropValue = date!;
          });
        }
      ),
    );
  }
}