import 'package:flutter/material.dart';
import 'package:imperial_approval_app/components/dropdown_date.dart';
import 'package:imperial_approval_app/components/dropdown_status.dart';
import 'package:imperial_approval_app/components/search_bar.dart';
import 'package:imperial_approval_app/controller/list_request_controller.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  ListRequestController controllerList = ListRequestController();

  @override
  Widget build(BuildContext context) {

    DateFormat formatDate = DateFormat("EEEE, dd MMMM yyyy   HH:MM");

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
        SizedBox(height: 40,),

        // history request list from list request
        Expanded(
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FutureBuilder(
                  future: controllerList.getHistory(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator.adaptive();
                    }
                    else if(snapshot.hasError){
                      print(snapshot.error);
                      return Text("Error");
                    }
                    else if (!snapshot.hasData){
                      return Text("No request found");
                    }
                    else if(snapshot.data!.isEmpty){
                      return Text("You have no history yet");
                    }
                    else {
                      var requestList = snapshot.data!;

                      return DataTable(
                        dataRowMaxHeight: 250,
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
                              DataCell(Text(data.id!, textWidthBasis: TextWidthBasis.longestLine,)),
                              DataCell(
                                  SizedBox(
                                    width: constraints.maxWidth - 85 - 20 - 50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data.requestType.name!, overflow: TextOverflow.ellipsis),
                                        Text("Date requested: \n${formatDate.format(data.dateRequested!.toDate())}",),
                                        Flexible(child: Text("Status: " + data.status!, overflow: TextOverflow.ellipsis)),
                                        Text(
                                          "Date ${data.status=='Diterima'?'Approved' : 'Rejected'}: \n${formatDate.format(data.dateRequested!.toDate())}"),
                                        TextButton(onPressed: (){Navigator.pushNamed(context, '/detail-request', arguments: {"request": data, "isApproval": false});}, child: Text("Detail"))                                               
                                      ]),
                                  ),
                              ),
                            ]
                          )).toList()
                      );
                    }
                  },
                );
              },
            )
          ),
        ),
      ],
    );
  }
}