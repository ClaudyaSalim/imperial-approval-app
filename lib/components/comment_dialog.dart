import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_approval_app/controller/approval_controller.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';

import '../model/request_class.dart';

class CommentDialog extends StatefulWidget {
  CommentDialog({super.key, this.request});

  Request? request;

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {

  TextEditingController controllerComment = TextEditingController();
  ApprovalController controllerApproval = ApprovalController();
  String comment = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Komentar"),
      content: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Masukkan alasan request di reject"),
            SizedBox(height: 20),
            TextField(controller: controllerComment, decoration: InputDecoration(hintText: "Komentar ..."),minLines: 5,
            maxLines: 5,keyboardType: TextInputType.multiline,textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {
              setState(() {comment = value;});
            },
            )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel", style: TextStyle(color: colorScheme.tertiary),)),
        SizedBox(width: 20,),
        TextButton(onPressed: comment==""? null : () async {
          // Navigator.pop(context);
          String? errorMessage = await controllerApproval.reject(widget.request!, controllerComment.text);
          if(errorMessage!=null){
            showDialog(context: context, builder: (context) => AlertDialog(title: Text("Fail to reject request"), content: Text(errorMessage), actions: [TextButton(onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/detail-approval')), child: Text("Retry"))],));
          }
          else {
            showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                title: Text("Request has been rejected"),
                content: Text("You will be directed to approval list page"),
                actions: [TextButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/app/approval', (route) => false), child: Text("OK"))],
              )
            );
          }
        }, child: Text("Next"), )
      ],
    );
  }
}