import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evchargepoint/common/theme.dart';
import 'package:evchargepoint/features/stations_feature/bloc/bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../models/station_model.dart';

const Map<String, Color> availabilityColors = {
  'busy': busyColor,
  'available': availableColor,
  'offline': offlineColor,
  'null': nullColor,
};

class SelectedStationModal extends StatelessWidget {
  final Station station;

  const SelectedStationModal({
    required this.station,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationBloc = context.watch<StationsBloc>();
    return Container(
      margin: const EdgeInsets.only(bottom: 24, top: 8),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: availabilityColors[station.status] ?? Colors.red,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      station.chargePointId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(' ${station.status}')
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    stationBloc.add(AddFavoriteEvent(station: station));
                  },
                  icon: Icon(
                    stationBloc.isFavorite(station) ? Icons.favorite : Icons.favorite_outline,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Coordinates'),
                  Text('${station.longitude.toStringAsFixed(6)} , ${station.latitude.toStringAsFixed(6)}'),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () => MapsLauncher.launchCoordinates(station.latitude, station.longitude),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: tealColor,
                        width: 2,
                      )),
                  child: Row(
                    children: const [
                      SizedBox(width: 6),
                      Icon(
                        Icons.assistant_direction_rounded,
                        size: 35,
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          const SizedBox(height: 16),
          _buildCard(),
        ],
      ),
    );
  }

  Widget _buildChargeChipAvailable({
    required double price,
    required String type,
    required double kWh,
    required bool isAvailable,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              const Icon(Icons.bolt, color: Colors.green),
              const SizedBox(width: 8),
              Text('$price \₺', style: const TextStyle(fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 8),
            Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$kWh kWh'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      foregroundColor: Colors.white,
                      backgroundColor: isAvailable ? Colors.green : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: isAvailable ? () {} : null,
                    child: isAvailable ? const Text('Available') : const Text('In use'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChargeChipOffline({
    required double price,
    required String type,
    required double kWh,
    required bool isAvailable,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              const Icon(Icons.bolt, color: Colors.green),
              const SizedBox(width: 8),
              Text('$price \₺', style: const TextStyle(fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 8),
            Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$kWh kWh'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      foregroundColor: Colors.white,
                      backgroundColor: isAvailable ? Colors.red : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: isAvailable ? () {} : null,
                    child: isAvailable ? const Text('Offline') : const Text('Offline'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return station.status == "offline"
        ? Row(
            children: [
              _buildChargeChipOffline(
                price: 0.15,
                type: 'Type 2(AC)',
                kWh: 3.7,
                isAvailable: true,
              ),
              const SizedBox(width: 8),
              _buildChargeChipOffline(
                price: 0.25,
                type: 'CHAdeMO',
                kWh: 7.4,
                isAvailable: true,
              ),
              const SizedBox(width: 8),
              _buildChargeChipOffline(
                price: 0,
                type: 'CCS 1',
                kWh: 7.4,
                isAvailable: true,
              ),
            ],
          )
        : Row(
            children: [
              _buildChargeChipAvailable(
                price: 0.15,
                type: 'Type 2(AC)',
                kWh: 3.7,
                isAvailable: true,
              ),
              const SizedBox(width: 8),
              _buildChargeChipAvailable(
                price: 0.25,
                type: 'CHAdeMO',
                kWh: 7.4,
                isAvailable: false,
              ),
              const SizedBox(width: 8),
              _buildChargeChipAvailable(
                price: 0,
                type: 'CCS 1',
                kWh: 7.4,
                isAvailable: true,
              ),
            ],
          );
  }
}
