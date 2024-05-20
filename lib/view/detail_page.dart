import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Request ID: RXXXXX"),
                  Text("Status: Pending")
                ],
              ),
              Text("Divisi - Objek yg direquest"),
              Text("Kepada: Pak Sunhie (Divisi & Jabatan)"),
              Text("Harga: Rp50.000"),
              Text("Tanggal: Selasa, 20 Februari 2024")
            ],
          ),
        ),
      ),
    );
  }
}