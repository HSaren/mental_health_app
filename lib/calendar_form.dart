import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/data_to_send_singleton.dart';
import 'backend.dart';

class CalendarForm extends StatefulWidget{
	final date;
  final text;
  final index;
	const CalendarForm(this.date, this.text, this.index, {super.key});

	@override
	State<CalendarForm> createState() => _CalendarFormState();
}

class _CalendarFormState extends State<CalendarForm>{
	var controller = TextEditingController();
	
	@override
	void dispose(){
		controller.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context){
    final format = DateFormat.yMMMd();
		final date = widget.date.date;
    controller.text = widget.date.note;
		return Column(
			children: <Widget>[
				TextField(
					controller: controller,
				),
				FloatingActionButton(
					onPressed: (){
            final id =  format.format(DateTime(date.year, date.month, date.day)).toString();
            DataToSendSingleton().dataToSend["Note"] = controller.text;
						Backend().saveDataToDb("Days", DataToSendSingleton().dataToSend, id);
            DataToSendSingleton().dataToSend = {};
            setState(() {
              widget.date.note = controller.text;
            });
					}
				)
			],
			
		);
	}
}