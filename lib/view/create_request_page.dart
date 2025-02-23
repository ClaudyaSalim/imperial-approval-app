 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imperial_approval_app/controller/create_request_controller.dart';
import 'package:imperial_approval_app/controller/list_request_controller.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/request_type_class.dart';

import '../model/user_class.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  CreateRequestController controllerCreate = CreateRequestController();
  UserController controllerUser = UserController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController toApprovalController = TextEditingController();

  var user = UserController().getCurrUserData();
  var selectedType; String? selectedId;
  List<DropdownMenuItem>requestTypes = [];

  void maptoDropdown(list) {
    requestTypes.clear();
    for (RequestType item in list) {
      requestTypes.add(DropdownMenuItem(child: Text(item.name!), value: item.id,));
      // print("Item: ${item}");
    }
  }

  Future<void>getApprovers() async {
    String approverNames = "";
    if(selectedType!=null){
      for (var approver in selectedType.approvers) {
        User? approverData = await controllerUser.getUserByID(approver);
        approverNames += '${approverData!.name!} (${approverData.position}); ';
      }
    }
    toApprovalController.text = approverNames;
  }

  Future<bool> validate(context) async{
    if(selectedType==null || descController.text=="" || priceController.text==""){
      await showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text('Request failed to send'), content: Text("Please fill all the fields"), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Retry"))],);
      });
      return false;
    }
    String? error = await controllerCreate.sendRequest(selectedType, descController.text, priceController.text);
    if(error!=null) {return false;}
    return true;
  }

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
                      return DropdownButtonFormField(items: requestTypes, onChanged: (value){
                        // value nya berupa id request, disimpan di selectedId, requestnya simpan di selectedType
                        setState(() {
                          for (var requestType in listRequestType) {
                            if(requestType.id==value){
                              selectedType = requestType;
                              selectedId = value;
                            }
                          }
                        });
                      }, hint: Text("Select request type"), value: selectedId);
                    }
                  } 
                ),
                Gap(30),
                TextField(
                  controller: descController..text,
                  minLines: 5,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    // labelText: "Keterangan",
                    hintText: "Masukkan keterangan"
                  ),
                ),
                Gap(30),
                TextField(
                  controller: priceController..text,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Harga",
                    helperText: "Jika tidak ada diisi dengan 0",
                    hintText: "Harga yang dikeluarkan untuk request"
                  ),
                ),
                Gap(30),
                FutureBuilder(
                  future: selectedType==null? null : getApprovers(),
                  builder: (context, snapshot) {
                    return TextField(
                      controller: toApprovalController..text,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Tujuan Request",
                      ),
                    );
                  }
                ),
                // Gap(30),
                // Row(
                //   children: [
                //     Text("File Pendukung"),
                //     Gap(20),
                //     FilledButton(onPressed: (){}, child: Text("Unggah"))
                //   ],
                // ),
                Gap(30),
                ElevatedButton(
                  onPressed: () async {
                    bool passed = await validate(context);
                    // print(descController.text);
                    // print(priceController.text);
                    // print(selectedType.approvers);
                    if(passed){
                      Navigator.pushNamed(context, '/app');
                    }
                  }, 
                child: Text("Kirim Request")),
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