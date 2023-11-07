import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'buttonData.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'days.dart';
import 'firebase_options.dart';
import 'backend.dart';
import 'calendar.dart';
import 'months.dart';

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
	  		    body: Calendar(currentMonth: currentMonth,)
	  		    	);
          }
      }
    );
}
}

String monthIntToString(int month){
	String stringMonth = "";
	switch(month){
		case 1:
			stringMonth = "January";
	}

	return stringMonth;
}
