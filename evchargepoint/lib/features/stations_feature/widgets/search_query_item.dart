import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evchargepoint/features/stations_feature/bloc/bloc.dart';

import '../models/station_model.dart';

class SearchQueryItem extends StatelessWidget {
  final Station station;

  const SearchQueryItem(this.station, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${station.chargePointId}',
                style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Power: ${station.power}',
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
              Text(
                'Status: ${station.status}',
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<StationsBloc>().add(AddToRecentSearchesEvent(station));
              Navigator.of(context).pop(station);
            },
            icon: const Icon(
              Icons.turn_right_outlined,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
