import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
//import 'package:meta/meta.dart';
import 'package:universities_app/universities/universities.dart';

part 'universities_cubit_state.dart';

class UniversitiesCubitCubit extends Cubit<UniversitiesCubitState> {
  UniversitiesCubitCubit(this.repository) : super(UniversitiesCubitInitial());

  int page = 1;

  final UniversitiesRepository repository;

  void loadUniversities() {
    if (state is UniversitiesLoading) return;
    final currentState = state;
    var oldUniversities = <University>[];
    if (currentState is UniversitiesLoaded) {
      oldUniversities = currentState.universities;
    }
    emit(UniversitiesLoading(oldUniversities, isFirstFetch: page == 1));
    repository.fetchUniversities(page).then((newUniversities) {
      page++;
      final universities = (state as UniversitiesLoading).oldUniversities;
      _addNewUniversities(universities, newUniversities);
      emit(UniversitiesLoaded(universities));
    });
  }

  void _addNewUniversities(
    List<University> universities,
    List<University> newUniversities,
  ) =>
      universities.addAll(newUniversities);
}
