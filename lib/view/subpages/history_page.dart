import 'package:flutter/material.dart';
import 'package:imperial_approval_app/components/dropdown_date.dart';
import 'package:imperial_approval_app/components/dropdown_status.dart';
import 'package:imperial_approval_app/components/search_bar.dart';
import 'package:imperial_approval_app/model/request_class.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        // search bar
        CustomSearchBar(),
        SizedBox(height: 10,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatusDropdown(), DateDropdown()
          ],
        ),

        // list request
        Expanded(
          child: SingleChildScrollView(
            child: Text("To be copied from list request")
          ),
        ),
      ],
    );
  }
}