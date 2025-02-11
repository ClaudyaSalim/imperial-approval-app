 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imperial_approval_app/controller/create_request_controller.dart';
import 'package:imperial_approval_app/controller/list_request_controller.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/request_type_class.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  String requestTypeName= "";
  CreateRequestController controllerCreate = CreateRequestController();
  List<DropdownMenuItem>requestType = [];

  void maptoDropdown(list) {
    requestType.clear();
    // requestType.add(DropdownMenuItem(child: Text(""), value: "",));
    for (var item in list) {
      print(item);
      String requestName = item.name!;
      requestType.add(DropdownMenuItem(child: Text(requestName), value: requestName,));
    }
  }

  var user = UserController().getCurrUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Request",),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // hapus company
                FutureBuilder(
                  future: controllerCreate.getRequestTypeByUser(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting || snapshot.data == null){
                      return CircularProgressIndicator();
                    }
                    else {
                      var listRequestType = snapshot.data;
                      maptoDropdown(listRequestType!);
                      for (var element in requestType) {
                        print("List of dropdowns: ${element.value}");
                      }
                      return DropdownButtonFormField(items: requestType, onChanged: (value){
                        setState(() {
                          requestTypeName = value;
                        });
                      }, hint: Text("Select request type"), value: requestTypeName!=""? requestTypeName: null);
                    }
                  } 
                ),
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
      ),
    );
  }
}