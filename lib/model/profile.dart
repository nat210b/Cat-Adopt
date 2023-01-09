import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile {
  String? displayname;
  String? email;
  String? password;
  String? photo;
  String? tel;
  String? lname;
  String? id;
  String? gender;
  DateTime? dob;
  String? address;
  String? salary;
  String? IdCard;

  Profile({
    this.IdCard,
    this.email,
    this.password,
    this.displayname,
    this.photo,
    this.tel,
    this.lname,
    this.address,
    this.dob,
    this.gender,
    this.id,
    this.salary,
  });
}
