import 'package:flutter/material.dart';

class Transaction {
  String content;
  double amount;
  DateTime buyDate;
  //define constructor
  Transaction({this.content, this.amount, this.buyDate});
}