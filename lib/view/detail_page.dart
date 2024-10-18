import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key, required this.request});

  // bool isDraft;
  Request request;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  DateFormat formatDate = DateFormat("EEEE, dd MMMM yyyy   HH:MM");

  @override
  Widget build(BuildContext context) {
    Request request = widget.request;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Request",),
        actions: [
          if(widget.request.draftId==null) Icon(Icons.delete_rounded)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Request ID: ${request.id}", style: textTheme.displayMedium,),
                  Row(
                    children: [
                      Text("Status: ", style: textTheme.displayMedium,),
                      Text(request.status!, style: textTheme.displayMedium!.copyWith(color: colorScheme.tertiary))
                    ],
                  ),
                ],
              ),
              Gap(50),
              Text(request.requestType.name!, style: textTheme.displayLarge,),
              Gap(50),
              // Text("Kepada: Pak Sunhie (Divisi & Jabatan)", style: textTheme.displayMedium,),
              Gap(50),
              Text("Harga: ${request.price}", style: textTheme.displayMedium!.copyWith(color: colorScheme.primary),),
              Gap(50),
              Text("Tanggal: ${formatDate.format(request.dateRequested!.toDate())}", style: textTheme.bodyMedium,),
              Gap(50),
              Text("Keterangan", style: textTheme.bodySmall,),
              Text(request.description!, style: textTheme.bodySmall,),
              Gap(50),
              // Row(
              //   children: [
              //     Text("File pendukung:", style: textTheme.bodyMedium,),
              //     Gap(20),
              //     Flexible(child: Text("Nama File", style: textTheme.displayMedium), fit: FlexFit.tight,),
              //     IconButton(
              //       onPressed: () {}, 
              //       icon: Icon(Icons.visibility)
              //     )
              //   ],
              // ),
              Gap(50),
              Text("Riwayat sebelumnya:"),
              Column(
                children: [
                  Text("Diterima oleh: ..."),
                  Text("Komentar: -")
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: (request.draftId==null)? null:
        FloatingActionButton(
          onPressed: (){Navigator.pushNamed(context, '/create-request');},
          child: Icon(Icons.edit_rounded),
        ),
    );
  }
}