import 'package:evchargepoint/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evchargepoint/features/stations_feature/bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/station_model.dart';

class FilterStationsBottomSheet extends StatefulWidget {
  @override
  State<FilterStationsBottomSheet> createState() => _FilterStationsBottomSheetState();
}

class _FilterStationsBottomSheetState extends State<FilterStationsBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  Border changeBorderColor(List<int> selectedChoices, id) {
    bool selected = false;
    for (var element in selectedChoices) {
      if (element == id) selected = true;
    }
    return selected
        ? Border.all(
            color: Colors.teal,
            width: 2,
          )
        : Border.all(
            color: greyWhite,
            width: 1,
          );
  }

  List<int> selectedChoices = [];

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
          SizedBox(width: 16),
          Text(
            'Connectors',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            color: Colors.blueGrey,
          ),
          const SizedBox(height: 5),
          // CONNECTOR FILTERS
          //----------------------------------------------
          Row(
            children: [
              const SizedBox(width: 5),
              _buildFilterIconBox(
                assetPath: 'assets/connectors/ccs1.png',
                id: 1,
              ),
              const SizedBox(width: 5),
              _buildFilterIconBox(
                assetPath: 'assets/connectors/ccs2.png',
                id: 2,
              ),
              const SizedBox(width: 5),
              _buildFilterIconBox(
                assetPath: 'assets/connectors/chademo.png',
                id: 3,
              ),
              const SizedBox(width: 5),
              _buildFilterIconBox(
                assetPath: 'assets/connectors/type2.png',
                id: 4,
              ),
              const SizedBox(width: 5),
              _buildFilterIconBox(
                assetPath: 'assets/connectors/type3.png',
                id: 5,
              ),
              const SizedBox(width: 5),
            ],
          ),
          //----------------------------------------------
          const SizedBox(height: 25),
          Text(
            'Providers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          // MARGIN
          //----------------------------------------------
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            color: Colors.blueGrey,
          ),
          const SizedBox(height: 30),

          // PROVIDER FILTERS
          //----------------------------------------------
          Wrap(
            children: [
              Row(
                children: [
                  const SizedBox(width: 5),
                  _buildFilterIconBox(
                    assetPath: 'assets/filter_logos/hotel.png',
                    id: 6,
                  ),
                  const SizedBox(width: 5),
                  _buildFilterIconBox(
                    assetPath: 'assets/filter_logos/mall.png',
                    id: 7,
                  ),
                  const SizedBox(width: 5),
                  _buildFilterIconBox(
                    assetPath: 'assets/filter_logos/public_road.png',
                    id: 8,
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 5),
                  _buildFilterIconBox(
                    assetPath: 'assets/filter_logos/restaurant.png',
                    id: 9,
                  ),
                  const SizedBox(width: 5),
                  _buildFilterIconBox(
                    assetPath: 'assets/filter_logos/service.png',
                    id: 10,
                  ),
                  const SizedBox(width: 5),
                  _buildFilterIconBox(
                    assetPath: 'assets/filter_logos/shop.png',
                    id: 11,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 15),

          //----------------------------------------------

          // APPLY BUTTON
          //----------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
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

  Widget _buildFilterIconBox({
    required int id,
    required String assetPath,
  }) {
    bool isSelected = false;

    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                // check already selected
                for (var element in selectedChoices) {
                  if (element == id) isSelected = true;
                }
                if (isSelected) {
                  selectedChoices.remove(id);
                } else {
                  selectedChoices.add(id);
                }
                // }
              });
            },
            child: Container(
              height: 60,
              width: 55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(assetPath),
                  fit: BoxFit.fill,
                ),
                border: changeBorderColor(selectedChoices, id),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Text(
          //   id,
          //   style: const TextStyle(
          //     fontSize: 16,
          //   ),
          // ),
        ],
      ),
    );
  }
}
