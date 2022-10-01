import 'dart:convert';

import 'package:flutter/services.dart';

class UniversitiesService {
  static const fetchLimit = 20;
  Future<List<dynamic>> fetchUniversities(int page) async {
    try {
      final response =
          await rootBundle.loadString('assets/data/universities.json');

      final subsUniversities = listEmpty;

      final universities = jsonDecode(response) as List<dynamic>;

      for (var i = 0; i < universities.length; i += fetchLimit) {
        subsUniversities.add(
          universities.sublist(
            i,
            i + fetchLimit > universities.length
                ? universities.length
                : i + fetchLimit,
          ),
        );
      }
      await Future.delayed(const Duration(milliseconds: 1000), () {});
      return subsUniversities.elementAt(page) as List<dynamic>;
    } catch (err) {
      return [];
    }
  }

  List<dynamic> get listEmpty => [];
}
