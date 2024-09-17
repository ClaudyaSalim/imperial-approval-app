import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imperial_approval_app/components/dropdown_date.dart';
import 'package:imperial_approval_app/components/dropdown_status.dart';
import 'package:imperial_approval_app/components/search_bar.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/model/status_class.dart';
import 'package:imperial_approval_app/model/status_filter.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

class ListRequest extends StatefulWidget {
  const ListRequest({super.key});

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {

  // FilterStatus filterStatus = FilterStatus();
  // var listFilter = ;

  @override
  Widget build(BuildContext context) {

    List<Request>requestList = [
      Request(type: "PO Proyek", approvers: ["Icha, Purchasing Manager"], status: "Pending", dateRequested: DateTime.timestamp()),
      Request(type: "Invoice Utilitas", approvers: ["Andi, Manager Proyek", "William, CEO"], status: "Diterima", dateRequested: DateTime.timestamp())
    ];

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
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) { 
                return DataTable(
                  dataRowMaxHeight: 150,
                  horizontalMargin: 10, // margin diujung tabel
                  columnSpacing: 20, // spacing antara kolom
                  headingTextStyle: textTheme.displayMedium,
                  dataTextStyle: textTheme.bodySmall,
                  // sortColumnIndex: 0,
                  // sortAscending: true,
                  columns: <DataColumn> [
                    DataColumn(
                      label: Container(child: Text("Request ID"), width: 85),
                    ),
                    DataColumn(
                      label: SizedBox(child: Text("Request")),
                    ),
                  ], 
                      
                  rows: requestList.map(
                    (data) => DataRow(
                      cells: [
                        DataCell(Text("RXXXXXX", textWidthBasis: TextWidthBasis.longestLine,)),
                        DataCell(
                            SizedBox(
                              width: constraints.maxWidth - 85 - 20 - 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.type, overflow: TextOverflow.ellipsis),
                                  Text(data.dateRequested.toString(), overflow: TextOverflow.ellipsis),
                                  Text("Approval berikutnya: " + data.approvers![0] + "fskjflskjdla", overflow: TextOverflow.ellipsis,)
                                  ,
                                  Flexible(child: Text("Status: " + data.status!, overflow: TextOverflow.ellipsis)),
                                  TextButton(onPressed: (){Navigator.pushNamed(context, '/detail-request');}, child: Text("Detail"))                                               
                                ]),
                            ),
                        ),
                      ]
                    )).toList()
                );
              },
            )
          ),
        ),
      ],
    );
  }
}