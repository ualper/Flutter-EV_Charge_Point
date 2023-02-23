import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evchargepoint/common/ui/widgets/bottom_bar_item.dart';
import '../screens/home_screen/home_bloc.dart';
import '../screens/home_screen/home_event.dart';
import '../screens/home_screen/home_state.dart';

class ApplicationBottomBar extends StatelessWidget {
  const ApplicationBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context, listen: true);
    return BottomAppBar(
      elevation: 30,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomBarItem(
            icon: Icons.map_rounded,
            label: 'MAP',
            isSelected: homeBloc.state.currentScreen == AppScreen.map,
            onPressed: () {
              homeBloc.add(SwitchTabEvent(AppScreen.map));
            },
          ),
          BottomBarItem(
            icon: Icons.favorite,
            label: 'FAVORITES',
            isSelected: homeBloc.state.currentScreen == AppScreen.favorites,
            onPressed: () {
              homeBloc.add(SwitchTabEvent(AppScreen.favorites));
            },
          ),
          const SizedBox(width: 42),
          BottomBarItem(
            icon: Icons.ev_station,
            label: "Add Station",
            isSelected: homeBloc.state.currentScreen == AppScreen.addstation,
            onPressed: () {
              homeBloc.add(SwitchTabEvent(AppScreen.addstation));
            },
          ),
          BottomBarItem(
            icon: Icons.account_circle_rounded,
            label: 'ACCOUNT',
            isSelected: homeBloc.state.currentScreen == AppScreen.account,
            onPressed: () {
              homeBloc.add(SwitchTabEvent(AppScreen.account));
            },
          ),
        ],
      ),
    );
  }
}
