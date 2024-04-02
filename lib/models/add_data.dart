import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData{
  Future<String> uploadImageToStorage(String childName , Uint8List file) async {
    
   Reference ref = _storage.ref().child(childName).child('id');
   UploadTask uploadTask = ref.putData(file);
   TaskSnapshot snapshot = await uploadTask;
   String downloadUrl = await snapshot.ref.getDownloadURL();
   return downloadUrl;
  }

  Future<String> saveData({
    required String username, 
    required String password , 
    required Uint8List file}) async {
      String resp = " Some Error Occurred" ;
      try{
        print("เข้า tryyyy");
        if(username.isNotEmpty || password.isNotEmpty){
                  String imageUrl = await uploadImageToStorage("ProfileImage", file);
        await _firestore.collection('userProfile').add({
          'username' : username,
          'password' : password,
          'imageProfile' : imageUrl,
        });
   
        resp = 'Success';

        }

      }catch(e){
        resp = e.toString();
        print('error = ${resp}');
      } return resp;
    }
}

