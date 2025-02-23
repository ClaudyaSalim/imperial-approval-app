import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_approval_app/model/status_class.dart';
import 'package:imperial_approval_app/model/status_filter.dart';

class StatusDropdown extends StatefulWidget {
  const StatusDropdown({super.key});

  @override
  State<StatusDropdown> createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {

  Status dropValue = FilterStatus().statusFilter[0];
  var listFilter = FilterStatus().statusFilter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: DropdownMenu(
        leadingIcon: Icon(Icons.filter_alt),
        hintText: dropValue.status,
        initialSelection: dropValue,
        dropdownMenuEntries: listFilter.map((status) => DropdownMenuEntry(
          leadingIcon: (status.status!="Semua")?Icon(Icons.circle, size: 10, color: status.colour,): Icon(Icons.circle, size: 10, color: Colors.transparent,),
          value: status,
          label: status.status
        )).toList(), 
        onSelected: (status) {
          print(status!.status);
          setState(() {
            dropValue = status;
          });
        }
      ),
    );
  }
}