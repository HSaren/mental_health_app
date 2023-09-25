import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';



class Backend{
	var db = FirebaseFirestore.instance;

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

	Future<void> saveDataToDb(collection, data) async{
		final userId = await fetchDataFromDb("Users", await getDeviceId(), "Device id");
		final dataToEnter = <String, dynamic>{
			"User id": userId.docs[0].id
		};
		
		db.collection(collection).add(data).then((DocumentReference doc) => {
			db.collection(collection).doc(doc.id).update(dataToEnter),
			print ("Data updated")
		});
	}


	Future<void> logIn() async {
		
		var data = await getDeviceId();
		var userFound = await checkDbForData("Users", data, 'Device id');

		if (userFound.docs.length == 0){
			final user = <String, dynamic>{
				"Device id": data,

			};
			db.collection("Users").add(user).then((DocumentReference doc) => 
				print('DocumentSnapshot added with ID: ${doc.id}')
			);
		}
		else  if (userFound.docs.length != 0){
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



