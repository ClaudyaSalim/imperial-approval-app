import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imperial_approval_app/components/dropdown_date.dart';
import 'package:imperial_approval_app/components/dropdown_status.dart';
import 'package:imperial_approval_app/components/search_bar.dart';
import 'package:imperial_approval_app/controller/list_request_controller.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/model/status_class.dart';
import 'package:imperial_approval_app/model/status_filter.dart';
import 'package:imperial_approval_app/model/user_class.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';
import 'package:intl/intl.dart';

class ListRequest extends StatefulWidget {
  ListRequest({super.key});

  // User? user;

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {

  // DateFormat formatDate = DateFormat("EEEE, dd MMMM yyyy   HH:MM");

  // FilterStatus filterStatus = FilterStatus();
  // var listFilter = ;
  ListRequestController controllerList= ListRequestController();

  @override
  Widget build(BuildContext context) {

    // List<Request>requestList = [
    //   Request(type: "PO Proyek", approvals: ["Icha, Purchasing Manager"], status: "Pending", dateRequested: DateTime.timestamp()),
    //   Request(type: "Invoice Utilitas", approvals: ["Andi, Manager Proyek", "William, CEO"], status: "Diterima", dateRequested: DateTime.timestamp())
    // ];
    DateFormat formatDate = DateFormat("EEEE, dd MMMM yyyy   HH:MM");

    // print(widget.user?.id);

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

        // list request
        Expanded(
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FutureBuilder(
                  future: controllerList.getRequests(),
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
                      return Text("You have no ongoing request");
                    }
                    else {
                      var requestList = snapshot.data!;
                      var nextApproval;

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
                              DataCell(Text(data.id!, textWidthBasis: TextWidthBasis.longestLine,)),
                              DataCell(
                                  SizedBox(
                                    width: constraints.maxWidth - 85 - 20 - 50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data.requestType.name!, overflow: TextOverflow.ellipsis),
                                        Text(formatDate.format(data.dateRequested!.toDate())),
                                        // Text("Approval berikutnya: " + data.key.approvals![0]!["user id"] + "fskjflskjdla", overflow: TextOverflow.ellipsis,), // liat nanti masih bisa ga
                                        Flexible(child: Text("Status: " + data.status!, overflow: TextOverflow.ellipsis)),
                                        TextButton(onPressed: (){Navigator.pushNamed(context, '/detail-request', arguments: data);}, child: Text("Detail"))                                               
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