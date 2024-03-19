import 'package:flutter/material.dart';

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

        // list request
        DataTable(
          columns: [], 
          rows: [],
        ),
      ],
    );
  }
}