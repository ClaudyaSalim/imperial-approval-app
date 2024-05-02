import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

    return Column(
      children: [

        // search bar
        SearchAnchor.bar(
          barHintText: "Cari request ...",
          isFullScreen: false,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double fullWidth = constraints.maxWidth-112;
                return DataTable(
                // sortColumnIndex: 0,
                // sortAscending: true,
                  columns: [
                    DataColumn(
                      label: SizedBox(child: Text("No"), width: fullWidth*0.1,),
                    ),
                    DataColumn(
                      label: SizedBox(child: Text("Request"), width: fullWidth*0.7,),
                    ),
                    DataColumn(
                      label: SizedBox(child: Text("Status"), width: fullWidth*0.25,)
                    ),
                  ], 
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(Text("1")),
                        DataCell(Text("Request Pertama")),
                        DataCell(Text("Pending")),
                      ]
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text("2")),
                        DataCell(Text("Request Kedua\nKepada:")),
                        DataCell(Text("Pending")),
                      ]
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}