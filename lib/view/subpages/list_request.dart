import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imperial_approval_app/model/request_class.dart';

class ListRequest extends StatefulWidget {
  const ListRequest({super.key});

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    List<Request>requestList = [
      Request(judul: "Request 1", jenis: "PO Proyek", pemberi: "Budi, Purchasing SPV", penerima: ["Icha, Purchasing Manager"], status: "Pending"),
      Request(judul: "Request 2", jenis: "Invoice Utilitas", pemberi: "Anna, Finance Head", penerima: ["Andi, Manager Proyek", "William, CEO"], status: "Diterima")
    ];

    return Column(
      children: [

        // search bar
        SearchAnchor.bar(
          barHintText: "Cari request ...",
          // isFullScreen: false,
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            List searchHistory = [];
            int numHistory = searchHistory.length;
            if(numHistory>0) {
              return List.generate(numHistory, 
                (index) =>
                  ListTile(
                    title: Text(searchHistory[index]),
                    onTap: () {
                      if(numHistory>0){
                        setState(() {
                          controller.closeView(searchHistory[index]);
                        });
                      }
                    },
                  ),
              );
            } else {
              return <Widget> [
                ListTile(title: Text("Tidak ada pencarian terbaru", style: TextStyle(color: colorScheme.tertiary),),)
              ];
            }
        }),
        SizedBox(height: 50,),

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
                              Text(data.judul, overflow: TextOverflow.ellipsis,),
                              Text(data.jenis, overflow: TextOverflow.ellipsis),
                              Text("Diajukan oleh: " + data.pemberi, overflow: TextOverflow.ellipsis),
                              Text("Approval berikutnya: " + data.penerima[0], overflow: TextOverflow.ellipsis),
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