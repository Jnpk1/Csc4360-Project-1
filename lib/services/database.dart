import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DatabaseService with ChangeNotifier {
  final _firestoreInstance = FirebaseFirestore.instance;

  DatabaseService();

  static const String USERS_COLLECTION = "users";
  static const String USER_FIRSTNAME_FIELD = "firstName";
  static const String USER_LASTNAME_FIELD = "lastName";
  static const String USER_EMAIL_FIELD = "email";

  
  static const String MSG_AUTHOR_FIELD = 'author';
  static const String MSG_CONTENT_FIELD = 'content';
  static const String MSG_DATE_FIELD = 'date';



  // // Should we use firebaseuser as arg or our own custom model?
  // void createUserInDatabaseWithEmail(auth.User firebaseUser) async {

  //   await _firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).set({
  //     NAME_FIELD : firebaseUser.displayName,
  //     EMAIL_FIELD: firebaseUser.email,
  //     PERSONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', content: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', content: 'Add your own message!').toJson()],
  //     SOCIAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', content: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', content: 'Add your own message!').toJson()],
  //     BUSINESS_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', content: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', content: 'Add your own message!').toJson()],
  //     FIRST_ADDITIONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', content: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', content: 'Add a new message!').toJson()],
  //     SECOND_ADDITIONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', content: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', content: 'Add a new message!').toJson()],
  //   }).whenComplete(() => print('Created user in database with email. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}'));

  // }



}
