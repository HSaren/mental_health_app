import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:mental_health_app/main.dart';

import 'calendar_form.dart';
import 'package:flutter/material.dart';
import 'backend.dart';

class CalendarPopUp extends StatelessWidget{
	final title;
	final text;
	final date;
  final index;

	CalendarPopUp({this.text, this.date, this.title, this.index});
	var textController = TextEditingController();
	@override
	Widget build(BuildContext context){
    
		return AlertDialog(
			title: Text(title),
			content: text,
			actions: [
				Form(
              child: CalendarForm(date, date.note, index)
        ),
				TextButton(
					child: const Text("OK"),
					onPressed: () => {
            Navigator.pop(context),
          }
				)
			],
		);
	}
}