 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imperial_approval_app/controller/create_request_controller.dart';
import 'package:imperial_approval_app/controller/list_request_controller.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  String requestTypeName= "";
  CreateRequestController controllerCreate = CreateRequestController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Request",),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: controllerCreate,
                child: DropdownButtonFormField(items: , onChanged: (value){
                  setState(() {
                    requestTypeName = value;
                  });
                }),
              )
              Gap(30),
              TextField(
                decoration: InputDecoration(
                  labelText: "Keterangan",
                  hintText: "Masukkan keterangan"
                ),
              ),
              Gap(30),
              TextField(
                decoration: InputDecoration(
                  labelText: "Harga",
                  helperText: "Jika tidak ada diisi dengan 0",
                  hintText: "Harga yang dikeluarkan untuk request tersebut"
                ),
              ),
              Gap(30),
              TextField(
                decoration: InputDecoration(
                  labelText: "Tujuan Request",
                  hintText: "Orang yang dituju untuk request tersebut"
                ),
              ),
              Gap(30),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("File Pendukung"),
                  Gap(20),
                  FilledButton(onPressed: (){}, child: Text("Unggah"))
                ],
              ),
              Gap(30),
              ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/app');}, child: Text("Kirim Request")),
              Gap(30),
              OutlinedButton(onPressed: (){Navigator.pushNamed(context, '/app/draft', );}, child: Text("Simpan sebagai Draft")),
            ],
          ),
        ),
      ),
    );
  }
}