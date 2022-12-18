// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_tracker/models/notificationModel.dart';
import 'package:place_tracker/place_map_custom.dart';
import 'package:provider/provider.dart';

import 'notificationPage.dart';
import 'place.dart';
import 'place_list.dart';
import 'place_map.dart';
import 'stub_data.dart';

enum PlaceTrackerViewType {
  map,
  list,
}

class PlaceTrackerApp extends StatelessWidget {
  const PlaceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _PlaceTrackerHomePage(),
      routes: {
        '/notificationPage': (context) => const NotificationPage(),
      },
    );
  }
}

class _PlaceTrackerHomePage extends StatefulWidget {
  const _PlaceTrackerHomePage({super.key});

  @override
  State<_PlaceTrackerHomePage> createState() => _PlaceTrackerHomePageState();
}

class _PlaceTrackerHomePageState extends State<_PlaceTrackerHomePage> {
  int floor = 0;
  int location = 0;
  String content = "";

  @override
  void initState() {
    floor = 1;
    location = 1;
    content = "aaaaaa";
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const NotificationPage()),
    ) as NotificationModel;

    if (result != null && result.location != 0) {
      setState(() {
        floor = result.floor;
        location = result.location;
        content = result.content;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
              child: Icon(Icons.pin_drop, size: 24.0),
            ),
            Text('Place Tracker'),
          ],
        ),
        backgroundColor: Colors.green[700],
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Badge(
                position: BadgePosition.topEnd(top: 8, end: 1),
                badgeContent: Text('3'),
                child: IconButton(
                    icon: Icon(Icons.circle_notifications, size: 30),
                    onPressed: () {
                      _navigateAndDisplaySelection(context);
                    }),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
            child: IconButton(
              icon: Icon(
                state.viewType == PlaceTrackerViewType.map
                    ? Icons.list
                    : Icons.map,
                size: 32.0,
              ),
              onPressed: () {
                state.setViewType(
                  state.viewType == PlaceTrackerViewType.map
                      ? PlaceTrackerViewType.list
                      : PlaceTrackerViewType.map,
                );
              },
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: state.viewType == PlaceTrackerViewType.map ? 0 : 1,
        children: [
          PlaceMapCustom(floor: floor, location: location, content: content),
          PlaceList()
        ],
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  AppState({
    this.places = StubData.places,
    this.selectedCategory = PlaceCategory.favorite,
    this.viewType = PlaceTrackerViewType.map,
  });

  List<Place> places;
  PlaceCategory selectedCategory;
  PlaceTrackerViewType viewType;

  void setViewType(PlaceTrackerViewType viewType) {
    this.viewType = viewType;
    notifyListeners();
  }

  void setSelectedCategory(PlaceCategory newCategory) {
    selectedCategory = newCategory;
    notifyListeners();
  }

  void setPlaces(List<Place> newPlaces) {
    places = newPlaces;
    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState &&
        other.places == places &&
        other.selectedCategory == selectedCategory &&
        other.viewType == viewType;
  }

  @override
  int get hashCode => Object.hash(places, selectedCategory, viewType);
}
