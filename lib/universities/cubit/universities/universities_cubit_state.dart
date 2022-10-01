part of 'universities_cubit_cubit.dart';

@immutable
abstract class UniversitiesCubitState {}

class UniversitiesCubitInitial extends UniversitiesCubitState {}

class UniversitiesLoaded extends UniversitiesCubitState {
  UniversitiesLoaded(this.universities);

  final List<University> universities;
}

class UniversitiesLoading extends UniversitiesCubitState {
  UniversitiesLoading(this.oldUniversities, {this.isFirstFetch = false});

  final List<University> oldUniversities;
  final bool isFirstFetch;
}
