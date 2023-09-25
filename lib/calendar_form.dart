import 'package:flutter/material.dart';
import 'backend.dart';

class CalendarForm extends StatefulWidget{
	final date;
	const CalendarForm(this.date, {super.key});

	@override
	State<CalendarForm> createState() => _CalendarFormState();
}

class _CalendarFormState extends State<CalendarForm>{
	final controller = TextEditingController();
	
	@override
	void dispose(){
		controller.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context){
		final date = widget.date;
		return Column(
			children: <Widget>[
				TextField(
					controller: controller,
				),
				FloatingActionButton(
					onPressed: (){
						final dataToEnter = <String, dynamic>{
							"Note": controller.text,
							"Date": date.date.microsecondsSinceEpoch,
							"User id": ""
						};
						Backend().saveDataToDb("Days", dataToEnter);
					}
				)
			],
			
		);
	}
}