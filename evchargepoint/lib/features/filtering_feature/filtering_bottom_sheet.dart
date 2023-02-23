import 'package:flutter/material.dart';

class FilteringBottomSheet extends StatefulWidget {
  const FilteringBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilteringBottomSheet> createState() => _FilteringBottomSheetState();
}

class _FilteringBottomSheetState extends State<FilteringBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 67,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              SizedBox(width: 16),
              Text(
                'Change Map Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            color: Colors.blueGrey,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 16),
              Text("data1"),
              const SizedBox(width: 16),
              Text("data2"),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            color: Colors.blueGrey,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                // TODO SELECTED ICON AFTER APPLY
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                child: const Text(
                  'Apply Filter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMapTypeBox({
    required String label,
    required bool selectableType,
  }) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                // selectedMapType = selectableType;
              });
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/connectors/ccs1.png',
                  ),
                  fit: BoxFit.cover,
                ),
                border: true
                    // selectedMapType == selectableType
                    ? Border.all(
                        color: Colors.lightBlueAccent,
                        width: 3,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
