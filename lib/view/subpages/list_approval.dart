import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imperial_approval_app/components/dropdown_date.dart';
import 'package:imperial_approval_app/components/dropdown_status.dart';
import 'package:imperial_approval_app/controller/approval_controller.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';
import 'package:intl/intl.dart';

class ListApproval extends StatefulWidget {
  const ListApproval({super.key});

  @override
  State<ListApproval> createState() => _ListApprovalState();
}

class _ListApprovalState extends State<ListApproval> {

  @override
  Widget build(BuildContext context) {

    DateFormat formatDate = DateFormat("EEEE, dd MMMM yyyy   HH:MM");
    ApprovalController controllerApproval = ApprovalController();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FutureBuilder(
                  future: controllerApproval.getApprovalList(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator.adaptive());
                    }
                    else if(snapshot.hasError){
                      print(snapshot.error);
                      return Text("Error");
                    }
                    else if (!snapshot.hasData){
                      return Text("No request found");
                    }
                    else if(snapshot.data!.isEmpty){
                      return Text("You have no ongoing approvals");
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
                                        TextButton(onPressed: (){Navigator.pushNamed(context, '/detail-approval', arguments: {"request": data, "isApproval": true});}, child: Text("Detail"))                                               
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