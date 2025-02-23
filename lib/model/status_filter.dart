import 'package:flutter/material.dart';
import 'package:imperial_approval_app/model/status_class.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';

class FilterStatus {

  List<Status>statusFilter = [
    Status("Semua", Colors.transparent),
    Status("Diterima", Colors.green),
    Status("Pending", Colors.white),
    Status("Ditolak", colorScheme.error)
  ];
  
}