import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_quotes/models/bug.dart';
import 'package:daily_quotes/models/quotes.dart';
import 'package:daily_quotes/widgets/progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseService extends ChangeNotifier {
  CollectionReference quotes = FirebaseFirestore.instance.collection('quotes');
  CollectionReference bugs = FirebaseFirestore.instance.collection('reportedbugs');

  Future<void> addQuote(Quote quote, context) {
    // Call the quotes's CollectionReference to add a new user
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Add Quote to Library, Please wait...",);
        }
    );
    return quotes.add({
      'quote': quote.quote, // John Doe
      'author': quote.author, // Stokes and Sons
      'submitby': quote.submitby // 42
    }).then((value) {
      print("Quote Added");
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Quote Added");
    }).catchError((error){
      print("Failed to add quote: $error");
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Failed to add quote");
    });

  }

  Future<void> reportABug(Bug bug, context) {
    // Call the quotes's CollectionReference to add a new user
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Report the issue, Please wait...",);
        }
    );
    return bugs.add({
      'bugtitle': bug.title, // John Doe
      'bugdetail': bug.description,
    }).then((value) {
      print("Bug Report Added");
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Issue reported successfully..");
    }).catchError((error){
      print("Failed to add bug: $error");
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Failed to report bug..");
    });

  }
}
