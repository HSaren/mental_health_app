import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'days.dart';



class Backend{
	var db = FirebaseFirestore.instance;
  var userId;

	Future checkDbForData(collection,data, dataName) async {
		var dbref = db.collection(collection);
		var isFound = await dbref.where(dataName, isEqualTo: data).get();

		return isFound;
	}

	Future fetchDataFromDb(collection, data, dataName) async{
		var dbref = db.collection(collection);
		var dataToReturn = await dbref.where(dataName, isEqualTo: data).get();

		return dataToReturn;
	}

	Future<void> saveDataToDb(collection, data, id) async{
		final userId = await fetchDataFromDb("Users", await getDeviceId(), "Device id");
    final collectionToEnter = "Users/" + userId.docs[0].id + "/" + collection;
		db.collection(collectionToEnter).doc(id).set(data).then((doc) => {
			print ("Data updated")
		});
	}

  Future<dynamic> fetchDaysFromDb(day) async{
    userId = await fetchDataFromDb("Users", await getDeviceId(), "Device id");
    var dbref = db.collection("Users").doc(userId.docs[0].id).collection("Days").doc(day);
    var dataFromDb = await dbref.get();
    if (dataFromDb.exists){
      var data = dataFromDb.data() as Map<String, dynamic>;
      var dataToReturn = data["Note"];
      return dataToReturn as String;
    }
    else {
      return null;
    }
    
  }

  Future<dynamic> fetchDataOnChange() async{
    var format = DateFormat.yMMMd();
    for(var i = 0; i < days.length; i++){
      var fetchedNote = await fetchDaysFromDb(format.format(days[i].date));
      if (fetchedNote != null){
        days[i].note = fetchedNote;
      }
      
    }
    
  }

	Future<void> logIn() async {
		
		var data = await getDeviceId();
		var userFound = await checkDbForData("Users", data, 'Device id');

		if (userFound.docs.length == 0){
			final user = <String, dynamic>{
				"Device id": data,

			};
			db.collection("Users").add(user).then((DocumentReference doc) => {
        print('DocumentSnapshot added with ID: ${doc.id}'),
        userId = doc.id
      }
				
			);
		}
		else  if (userFound.docs.isNotEmpty){
			print("User found");
		}
		else {
			print("Error damn");
		}
		
	}

	Future<String> getDeviceId() async {
		DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
		if (Platform.isIOS){
			IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
			return iosDeviceInfo.identifierForVendor.toString();
		}
		else if (Platform.isAndroid){
			AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
			return androidDeviceInfo.id;
		}
		else{
			return "";
		}
		
	}

}



