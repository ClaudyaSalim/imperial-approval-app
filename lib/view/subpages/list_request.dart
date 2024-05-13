import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imperial_approval_app/components/search_bar.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/model/status_class.dart';
import 'package:imperial_approval_app/model/status_filter.dart';

class ListRequest extends StatefulWidget {
  const ListRequest({super.key});

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {

  // FilterStatus filterStatus = FilterStatus();
  // var listFilter = ;
  Status dropValue = FilterStatus().statusFilter[0];

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    List<Request>requestList = [
      Request(judul: "Request 1", jenis: "PO Proyek", pemberi: "Budi, Purchasing SPV", penerima: ["Icha, Purchasing Manager"], status: "Pending"),
      Request(judul: "Request 2", jenis: "Invoice Utilitas", pemberi: "Anna, Finance Head", penerima: ["Andi, Manager Proyek", "William, CEO"], status: "Diterima")
    ];

    var listFilter = FilterStatus().statusFilter;

    return Column(
      children: [

        // search bar
        CustomSearchBar(),
        SizedBox(height: 50,),

        Row(
          children: [
            DropdownMenu(
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
            )
          ],
        ),

        // list request
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DataTable(
                  dataRowMinHeight: 120,
                  dataRowMaxHeight: 150,
                  // sortColumnIndex: 0,
                  // sortAscending: true,
                  columns: const <DataColumn> [
                    DataColumn(
                      label: SizedBox(child: Text("No"), width: 25,),
                    ),
                    DataColumn(
                      label: SizedBox(child: Text("Request"),),
                    ),
                    // DataColumn(
                    //   label: SizedBox(child: Text("Status"), width: fullWidth*0.25,)
                    // ),
                  ], 
                      
                  rows: requestList.map(
                    (data) => DataRow(
                      cells: [
                        DataCell(Text(requestList.indexOf(data).toString())),
                        DataCell(
                          SizedBox(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.judul, overflow: TextOverflow.ellipsis, textWidthBasis: TextWidthBasis.parent,),
                              Text(data.jenis, overflow: TextOverflow.ellipsis),
                              Text("Diajukan oleh: " + data.pemberi, overflow: TextOverflow.ellipsis),
                              Text("Approval berikutnya: " + data.penerima[0], overflow: TextOverflow.ellipsis, maxLines: 1,),
                              Text("Status: " + data.status, overflow: TextOverflow.ellipsis),
                              TextButton(onPressed: (){}, child: Text("Detail"))                                               
                            ]),
                          )
                        ),
                      ]
                    )).toList()
                ),
              ]
            )
          ),
        ),
      ],
    );
  }
}