import 'package:evchargepoint/common/ui/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evchargepoint/common/routes.dart';
import 'package:evchargepoint/common/theme.dart';
import 'package:evchargepoint/common/utils/api_domain_sneak_spot.dart';
import 'package:evchargepoint/common/utils/logger.dart';
import 'package:evchargepoint/features/account_feature/services/signup_service.dart';
import 'package:evchargepoint/network/api_client.dart';
import 'features/account_feature/repository/account_repository.dart';
import 'features/stations_feature/bloc/stations_bloc.dart';
import 'features/stations_feature/bloc/stations_event.dart';
import 'features/stations_feature/repository/station_repository.dart';
import 'features/stations_feature/services/location_service.dart';
import 'features/stations_feature/services/stations_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger();

  // runApp(MaterialApp(home: MyCustomLoginUI()))
  runApp(const RepositoryHolder(child: EVChargePointsApp()));
}

class RepositoryHolder extends StatelessWidget {
  final Widget child;

  const RepositoryHolder({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => StationRepositoryImpl(
            stationApiService: StationsApiServiceImpl(
              ApiClientImpl(apiDomain: ApiDomainSneakSpot.apiDomain),
            ),
            locationService: LocationServiceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AccountRepositoryImpl(
            SignInServiceImpl(FirebaseAuth.instance),
          ),
        ),
      ],
      child: Builder(builder: (context) => child),
    );
  }
}

class EVChargePointsApp extends StatelessWidget {
  const EVChargePointsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StationsBloc(RepositoryProvider.of<StationRepositoryImpl>(context))..add(FetchStationsEvent()),
      child: MaterialApp(
        title: 'EV Charge Point',
        initialRoute: homeScreenPath,
        routes: routes,
        theme: lightTheme,
      ),
    );
  }
}
