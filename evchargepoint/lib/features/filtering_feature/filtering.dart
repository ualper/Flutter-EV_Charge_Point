import 'package:flutter/material.dart';

enum ExerciseFilter { CCS1, CCS2, TYPE2, TYPE3, CHADEMO }

void main() => runApp(const ChipApp());

class ChipApp extends StatelessWidget {
  const ChipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: const FilterChipExample(),
    );
  }
}

class FilterChipExample extends StatefulWidget {
  const FilterChipExample({super.key});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  bool favorite = false;
  final List<String> _filters = <String>[];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtering'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose the Types', style: textTheme.labelLarge),
            //---------------------
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 1,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 10),
            //---------------------
            Wrap(
              spacing: 5.0,
              children: ExerciseFilter.values.map((ExerciseFilter exercise) {
                return FilterChip(
                  label: Text(exercise.name),
                  selected: _filters.contains(exercise.name),
                  onSelected: (bool value) {
                    setState(() {
                      if (value) {
                        if (!_filters.contains(exercise.name)) {
                          _filters.add(exercise.name);
                        }
                      } else {
                        _filters.removeWhere((String name) {
                          return name == exercise.name;
                        });
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            Text('Looking for: ${_filters.join(', ')}')
          ],
        ),
      ),
    );
  }
}
