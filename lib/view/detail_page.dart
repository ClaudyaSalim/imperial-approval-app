import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Request",),
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
                  Text("Request ID: RXXXXX", style: textTheme.displayMedium,),
                  Row(
                    children: [
                      Text("Status: ", style: textTheme.displayMedium,),
                      Text("Pending", style: textTheme.displayMedium!.copyWith(color: colorScheme.tertiary))
                    ],
                  ),
                ],
              ),
              Gap(50),
              Text("Divisi - Objek yg direquest", style: textTheme.displayLarge,),
              Gap(50),
              Text("Kepada: Pak Sunhie (Divisi & Jabatan)", style: textTheme.displayMedium,),
              Gap(50),
              Text("Harga: Rp50.000", style: textTheme.displayMedium!.copyWith(color: colorScheme.primary),),
              Gap(50),
              Text("Tanggal: Selasa, 20 Februari 2024", style: textTheme.bodyMedium,),
              Gap(50),
              Text("Keterangan", style: textTheme.bodySmall,),
              Text("Quidam alii sunt, et non est in nostra potestate. Quae omnia in nostra sententia, pursuit, cupiditatem.", style: textTheme.bodySmall,),
              Gap(50),
              Row(
                children: [
                  Text("File pendukung:", style: textTheme.bodyMedium,),
                  Gap(20),
                  Flexible(child: Text("Nama File", style: textTheme.displayMedium), fit: FlexFit.tight,),
                  IconButton(
                    onPressed: () {}, 
                    icon: Icon(Icons.visibility)
                  )
                ],
              ),
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
    );
  }
}