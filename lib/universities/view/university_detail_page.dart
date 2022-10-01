import 'package:flutter/material.dart';
import 'package:universities_app/universities/universities.dart';

class UniversityPage extends StatefulWidget {
  const UniversityPage({super.key, required this.university});

  final University university;

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.university.name!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubTitle(text: 'Country code: '),
            Details(text: widget.university.alphaTwoCode!),
            const SubTitle(text: 'Country : '),
            Details(text: widget.university.country!),
            const SubTitle(text: 'Domains: '),
            Details(text: widget.university.domains![0]),
            const SubTitle(text: 'Web pages: '),
            Details(text: widget.university.webPages![0]),
            const SubTitle(text: 'State/Province: '),
            Details(text: widget.university.stateProvince ?? 'N/A'),
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(child: Text(text)),
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      child: Text(
        text,
        style: theme.textTheme.headline6,
      ),
    );
  }
}
