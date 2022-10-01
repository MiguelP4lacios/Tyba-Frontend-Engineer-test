import 'package:universities_app/universities/universities.dart';

class UniversitiesRepository {
  UniversitiesRepository(this.service);

  final UniversitiesService service;

  Future<List<University>> fetchUniversities(int page) async {
    final universities = await service.fetchUniversities(page);
    return universities
        .map((e) => University.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
