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
    
    List<Request>requestList = [
      Request(judul: "Request 1", jenis: "PO Proyek", pemberi: "Budi, Purchasing SPV", penerima: ["Icha, Purchasing Manager"], status: "Ditolak"),
      Request(judul: "Request 2", jenis: "Invoice Utilitas", pemberi: "Anna, Finance Head", penerima: ["Andi, Manager Proyek", "William, CEO"], status: "Diterima")
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DataTable(
                  dataRowMinHeight: 120,
                  dataRowMaxHeight: 150,
                  horizontalMargin: 10, // margin diujung tabel
                  columnSpacing: 20, // spacing antara kolom
                  // sortColumnIndex: 0,
                  // sortAscending: true,
                  columns: <DataColumn> [
                    DataColumn(
                      label: Container(child: Text("No"), width: 25),
                    ),
                    DataColumn(
                      label: SizedBox(child: Text("Request")),
                    ),
                    // DataColumn(
                    //   label: SizedBox(child: Text("Status"), width: fullWidth*0.25,)
                    // ),
                  ], 
                      
                  rows: requestList.map(
                    (data) => DataRow(
                      cells: [
                        DataCell(Text((requestList.indexOf(data)+1).toString(), textWidthBasis: TextWidthBasis.longestLine,)),
                        DataCell(
                          SizedBox(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(child: Text(data.judul, overflow: TextOverflow.ellipsis)),
                              Text(data.jenis, overflow: TextOverflow.ellipsis),
                              Flexible(child: Text("Diajukan oleh: " + data.pemberi, overflow: TextOverflow.ellipsis)),
                              Flexible(child: Text("Approval berikutnya: " + data.penerima[0], overflow: TextOverflow.ellipsis, maxLines: 1,)),
                              Flexible(child: Text("Status: " + data.status, overflow: TextOverflow.ellipsis)),
                              Flexible(child: Text(DateTime.now().toString())),
                              TextButton(onPressed: (){Navigator.pushNamed(context, '/detail-request');}, child: Text("Detail"))                                               
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