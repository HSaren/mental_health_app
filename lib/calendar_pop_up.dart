import 'dart:ffi';
import 'calendar_form.dart';
import 'package:flutter/material.dart';
import 'backend.dart';

class CalendarPopUp extends StatelessWidget{
	final title;
	final text;
	final date;

	CalendarPopUp({this.text, this.date, this.title});
	var textController = TextEditingController();
	@override
	Widget build(BuildContext context){
		return AlertDialog(
			title: Text(title),
			content: text,
			actions: [
				Form(
					child: CalendarForm(date)
				),
				TextButton(
					child: const Text("OK"),
					onPressed: () => Navigator.pop(context),
				)
			],
		);
	}
}