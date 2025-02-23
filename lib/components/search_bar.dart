import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/search_bar_theme.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
          barHintText: "Cari request ...",
          onChanged: (value) {
              // ...
          },
          // isFullScreen: false,
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            List searchHistory = ["a", "b", "a", "a"];
            int numHistory = searchHistory.length;
            if(numHistory>0) {
              return List.generate(numHistory, 
                (index) =>
                  ListTile(
                    tileColor: colorScheme.tertiaryContainer,
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
                ListTile(tileColor: colorScheme.tertiaryContainer, title: Text("Tidak ada pencarian terbaru",),)
              ];
            }
        });
  }
}