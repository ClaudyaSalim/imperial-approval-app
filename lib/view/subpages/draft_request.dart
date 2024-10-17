import 'package:flutter/material.dart';
import 'package:imperial_approval_app/components/dropdown_date.dart';
import 'package:imperial_approval_app/components/search_bar.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

class DraftRequest extends StatefulWidget {
  const DraftRequest({super.key});

  @override
  State<DraftRequest> createState() => _DraftRequestState();
}

class _DraftRequestState extends State<DraftRequest> {
  @override
  Widget build(BuildContext context) {
    
    List<Request>requestList = [
      // Request(type: "PO Proyek", approvers: ["Icha, Purchasing Manager"], status: "Pending"),
      // Request(type: "Invoice Utilitas", approvers: ["Andi, Manager Proyek", "William, CEO"], status: "Diterima")
    ];

    return Column(
      children: [

        // search bar
        CustomSearchBar(),
        SizedBox(height: 10,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DateDropdown()
          ],
        ),

        // list request
        Expanded(
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) { 
                return DataTable(
                  dataRowMinHeight: 120,
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
                        DataCell(Text((requestList.indexOf(data)+1).toString(), textWidthBasis: TextWidthBasis.longestLine,)),
                        DataCell(
                            SizedBox(
                              width: constraints.maxWidth - 85 - 20 - 50,
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.typeId!, overflow: TextOverflow.ellipsis),
                                Text("Approval berikutnya: " + data.approvals![0]!['user id'] + "fskjflskjdla", overflow: TextOverflow.ellipsis,)
                                ,
                                Text("Last Edited: " + data.status!, overflow: TextOverflow.ellipsis),
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