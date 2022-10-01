import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/universities/universities.dart';

class UniversitiesPage extends StatelessWidget {
  const UniversitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = UniversitiesRepository(UniversitiesService());
    return BlocProvider(
      create: (_) => UniversitiesCubitCubit(repository),
      child: const UniversitiesView(),
    );
  }
}

class UniversitiesView extends StatefulWidget {
  const UniversitiesView({
    super.key,
  });

  @override
  State<UniversitiesView> createState() => _UniversitiesViewState();
}

class _UniversitiesViewState extends State<UniversitiesView> {
  final scrollController = ScrollController();

  bool listViewToggle = true;

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);
    context.read<UniversitiesCubitCubit>().loadUniversities();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universities'),
        actions: [
          SizedBox(
            child: IconButton(
              icon: Icon(listViewToggle ? Icons.grid_view : Icons.view_list),
              onPressed: _onToggleView,
            ),
          )
        ],
      ),
      body: listViewToggle ? _universitiesList() : _universitiesGird(),
    );
  }

  void _onToggleView() {
    setState(() {
      listViewToggle = !listViewToggle;
    });
  }

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<UniversitiesCubitCubit>().loadUniversities();
        }
      }
    });
  }

  Widget _universitiesGird() {
    return BlocBuilder<UniversitiesCubitCubit, UniversitiesCubitState>(
      builder: (context, state) {
        if (state is UniversitiesLoading && state.isFirstFetch) {
          return const LoadingIndicator();
        }

        var universities = <University>[];
        var isLoading = false;

        if (state is UniversitiesLoading) {
          universities = state.oldUniversities;
          isLoading = true;
        } else if (state is UniversitiesLoaded) {
          universities = state.universities;
        }

        return GridView.builder(
          controller: scrollController,
          itemCount: universities.length + (isLoading ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            if (index < universities.length) {
              return CardUniversity(university: universities[index]);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });

              return const Center(child: LoadingIndicator());
            }
          },
        );
      },
    );
  }

  Widget _universitiesList() {
    return BlocBuilder<UniversitiesCubitCubit, UniversitiesCubitState>(
      builder: (context, state) {
        if (state is UniversitiesLoading && state.isFirstFetch) {
          return const LoadingIndicator();
        }

        var universities = <University>[];
        var isLoading = false;

        if (state is UniversitiesLoading) {
          universities = state.oldUniversities;
          isLoading = true;
        } else if (state is UniversitiesLoaded) {
          universities = state.universities;
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: universities.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < universities.length) {
              return CardUniversity(university: universities[index]);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });

              return const LoadingIndicator();
            }
          },
        );
      },
    );
  }
}

class CardUniversity extends StatelessWidget {
  const CardUniversity({
    required this.university,
    super.key,
  });

  final University university;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          _onGoToUniversityDetail(),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.5),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${university.name!}.',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                university.webPages![0],
                overflow: TextOverflow.fade,
              ),
            )
          ],
        ),
      ),
    );
  }

  MaterialPageRoute<dynamic> _onGoToUniversityDetail() {
    return MaterialPageRoute(
      builder: (context) => UniversityPage(
        university: university,
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
