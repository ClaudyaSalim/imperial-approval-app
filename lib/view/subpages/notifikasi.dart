import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imperial_approval_app/components/dropdown_date.dart';
import 'package:imperial_approval_app/components/dropdown_status.dart';
import 'package:imperial_approval_app/components/search_bar.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

class Notif extends StatefulWidget {
  const Notif({super.key});

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
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

        Gap(20),

        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: ((context, index) {
              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateTime.now().toString()),
                        Text("ID Request: RXXXXXX")
                      ],
                    ),
                    Text("Request kamu berhasil dibuat dan diteruskan ke ...", softWrap: true, style: textTheme.displayMedium,),
                    TextButton(onPressed: (){Navigator.pushNamed(context, '/detail-request');}, child: Text("Detail"))
                  ],
                ),
              );
            }),
            separatorBuilder: (context, index) {
              return Divider(height: 50, thickness: 1.5,);
            }),
        ),
      ]
    );
  }
}