import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'buttonData.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'days.dart';
import 'firebase_options.dart';
import 'backend.dart';
import 'calendar.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform
	);
	runApp(MentalHealthApp());
}


class MentalHealthApp extends StatelessWidget{
	@override
	Widget build(BuildContext context) {
	  return MaterialApp(
		title: "Mental Health App",
		home: FrontPage(),
	  );
	}
}

class FrontPage extends StatefulWidget{
  
	@override
	FrontPageState createState() => FrontPageState();
}

class FrontPageState extends State<FrontPage>{
	DateTime now = DateTime.now();
	DateTime currentMonth = DateTime.now();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Users').doc(Backend().userId).collection("Days").snapshots();
	
	@override
	void initState(){
		super.initState();
		days = setDays(now);
		currentMonth = DateTime(now.year, now.month);
		Backend().logIn();
	}

	@override
	Widget build(BuildContext context){
		var format = DateFormat.MMMM();
		
    return StreamBuilder(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        else if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading");
        }
        else {
          return Scaffold(
	  		    appBar: AppBar(
	  		    	title: const Text("Mental Health App"),
	  		    	backgroundColor: const Color.fromARGB(255, 116, 116, 116),
	  		    ),
	  		    backgroundColor: Colors.grey,
	  		    body: Column(children: <Widget>[
	  		    	Container(
	  		    		alignment: Alignment.bottomCenter,
	  		    		child: Text(DateFormat.y().format(currentMonth)),
	  		    	),
	  		    	Container(
	  		    		child: Row(
	  		    			mainAxisAlignment: MainAxisAlignment.center,
	  		    			children: [
	  		    				GestureDetector(
	  		    					onTap: () {
	  		    						setState(() {
	  		    							currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
	  		    							days = setDays(currentMonth);
	  		    						  });

	  		    					},
	  		    					child: Padding(
	  		    						padding: const EdgeInsets.all(0.2),
	  		    						child: ClipRRect(
	  		    							child: Container(
	  		    								alignment: Alignment.bottomRight,
	  		    								child: Text("< ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
	  		    							),
	  		    						)
	  		    					)
	  		    				),
	  		    				Container(
	  		    					alignment: Alignment.bottomCenter,
	  		    					child: Text(format.format(currentMonth)),
	  		    				),
	  		    				GestureDetector(
	  		    					onTap: () {
	  		    						setState(() {
	  		    							currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
	  		    							days = setDays(currentMonth);
	  		    						  });

	  		    					},
	  		    					child: Padding(
	  		    						padding: const EdgeInsets.all(0.2),
	  		    						child: ClipRRect(
	  		    							child: Container(
	  		    								alignment: Alignment.bottomRight,
	  		    								child: Text(" >", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
	  		    							),
	  		    						)
	  		    					)
	  		    				),
	  		    			],
	  		    		) 
	  		    	),
	  		    	Row(
	  		    		mainAxisAlignment: MainAxisAlignment.spaceBetween,
	  		    		children: [
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("   Mon"),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Tue"),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Wed"),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Thu"),
	  		    			),
	  		    				Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Fri  "),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Sat  "),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Sun   "),
	  		    			),
	  		    		],
	  		    	),
	  		    	Expanded(
	  		    		child: Calendar(days: days)
	  		    	)
	  		    ]
          ),
		    );
      }
    });
  }

}

List<ButtonData> setDays(DateTime now){
	DateTime currentDateBeingGenerated = DateTime(now.year, now.month, 1);
	DateTime lastDay = DateTime(now.year, now.month + 1, 0);
	String fetchedNote = "";
  var i = 0;
	List<ButtonData> days = <ButtonData>[];
	if (currentDateBeingGenerated.weekday != 1){
		while (currentDateBeingGenerated.weekday != 1){
			currentDateBeingGenerated = DateTime(currentDateBeingGenerated.year, currentDateBeingGenerated.month, currentDateBeingGenerated.day - 1);
		}
		days.add(ButtonData(currentDateBeingGenerated, fetchedNote, now, i));
    i++;
	}
	else{
		days.add(ButtonData(currentDateBeingGenerated, fetchedNote, now, i));
    i++;
	}
	while(currentDateBeingGenerated.isBefore(DateTime(now.year, now.month + 1, 0).add(Duration(days: 7 - lastDay.weekday)))){
		currentDateBeingGenerated = DateTime(currentDateBeingGenerated.year, currentDateBeingGenerated.month, currentDateBeingGenerated.day + 1);
		days.add(ButtonData(currentDateBeingGenerated, fetchedNote, now, i));
    i++;
	}
	return days;
}

String monthIntToString(int month){
	String stringMonth = "";
	switch(month){
		case 1:
			stringMonth = "January";
	}

	return stringMonth;
}
