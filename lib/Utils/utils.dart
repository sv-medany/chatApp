import 'package:flutter/material.dart';
void showLoading(BuildContext context,String text){
  showDialog(context: context, builder: (context){
    return
    AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 5,),
            Text('$text'),
          ],
        ),
      ),
    );
  });
}
void hideLoading(BuildContext context){
  Navigator.pop(context);
}
void showMessage(BuildContext context , String message , String positiveaction,Function PosAction,
{String? negativeaction,Function? negative}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Text('$message'),
      actions: [
        TextButton(onPressed: (){
          PosAction(context);
        }, child: Text('${positiveaction}'))
      ],
    );

  });
}
