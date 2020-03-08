import 'package:flutter/material.dart';

void onLoading(BuildContext context, String message) {
   showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          _progresIndicatorImage(),
          SizedBox(height: 15.0,),
          Text("Cargando $message ..."),
          ],
        ),
      );
    },
  );
}

Widget _progresIndicatorImage () {
  return SizedBox(
    child: CircularProgressIndicator(),
    width: 60.0,
    height: 60.0,
  );
}