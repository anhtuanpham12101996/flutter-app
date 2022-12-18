// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:zoom_widget/zoom_widget.dart';

import 'place.dart';
import 'place_details.dart';
import 'place_tracker_app.dart';

class MapConfiguration {
  final List<Place> places;

  final PlaceCategory selectedCategory;

  const MapConfiguration({
    required this.places,
    required this.selectedCategory,
  });

  @override
  int get hashCode => places.hashCode ^ selectedCategory.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is MapConfiguration &&
        other.places == places &&
        other.selectedCategory == selectedCategory;
  }

  static MapConfiguration of(AppState appState) {
    return MapConfiguration(
      places: appState.places,
      selectedCategory: appState.selectedCategory,
    );
  }
}

class PlaceMapCustom extends StatefulWidget {
  const PlaceMapCustom(
      {super.key, this.floor = 0, this.location = 0, this.content = ''});

  final String content;
  final int floor;
  final int location;

  @override
  State<PlaceMapCustom> createState() => _PlaceMapCustomState();
}

class _PlaceMapCustomState extends State<PlaceMapCustom> {
  MapConfiguration? _configuration;
  bool isShowCoverFlow = false;
  int selectedMapIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context);

    return Builder(builder: (context) {
      // We need this additional builder here so that we can pass its context to
      // _AddPlaceButtonBar's onSavePressed callback. This callback shows a
      // SnackBar and to do this, we need a build context that has Scaffold as
      // an ancestor.
      final List<String> titles = [
        "Ground Floor",
        "1st Floor",
        "2nd Floor",
        "3rd Floor",
      ];

      List<Widget> floors = [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            "assets/GF.jpg",
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            "assets/1F.jpg",
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            "assets/2F.jpg",
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            "assets/3F.jpg",
            fit: BoxFit.cover,
          ),
        )
      ];
      if (isShowCoverFlow) {
        return Center(
            child: Stack(children: [
          SizedBox(
              height: 1000,
              child: VerticalCardPager(
                  titles: titles, // required
                  images: floors, // required
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold), // optional
                  onSelectedItem: (index) {
                    setState(() {
                      isShowCoverFlow = false;
                      selectedMapIndex = index;
                    });
                  },
                  initialPage: selectedMapIndex, // optional
                  align: ALIGN.CENTER)),
          _MapFabs(
            onToggleMapTypePressed: _onToggleMapTypePressed,
          )
        ]));
      } else {
        return Center(
            child: Stack(children: [
          Zoom(
              initTotalZoomOut: true,
              child: Stack(children: [
                Container(
                    child: Center(
                  child: floors[selectedMapIndex],
                )
                    //     child: Center(
                    //         child: InteractiveViewer(
                    //   child: Image.asset('assets/map/aeon_3f.jpg',
                    //       width: 500, height: 600, fit: BoxFit.contain),
                    // ))
                    ),
                widget.location == 1
                    ? Positioned(
                        left: MediaQuery.of(context).size.width * 0.10,
                        top: MediaQuery.of(context).size.height * 0.38,
                        bottom: 290,
                        child: Container(
                            width: 60,
                            child: IconButton(
                                color: Colors.blue,
                                onPressed: () {
                                  print("Area 1");
                                  String area =
                                      "${widget.floor}F_${widget.location}";
                                  _showMyDialog(area, 10, widget.content);
                                },
                                icon: Icon(Icons.person_pin_circle_sharp,
                                    size: 40,
                                    color: Color.fromARGB(207, 172, 0, 0)))))
                    : Text(""),
                widget.location == 2
                    ? Positioned(
                        left: MediaQuery.of(context).size.width * 0.51,
                        top: MediaQuery.of(context).size.height * 0.37,
                        child: Container(
                            width: 60,
                            child: IconButton(
                                color: Colors.blue,
                                onPressed: () {
                                  print("Area 2");
                                  String area =
                                      "${widget.floor}F_${widget.location}";
                                  _showMyDialog(area, 28, widget.content);
                                },
                                icon: Icon(Icons.person_pin_circle_sharp,
                                    size: 40,
                                    color: Color.fromARGB(207, 172, 0, 0)))),
                      )
                    : Text(""),
                widget.location == 3
                    ? Positioned(
                        left: MediaQuery.of(context).size.width * 0.8,
                        top: MediaQuery.of(context).size.height * 0.32,
                        child: Container(
                            width: 60,
                            child: IconButton(
                                color: Colors.blue,
                                onPressed: () {
                                  print("Area 1");
                                },
                                icon: Icon(Icons.person_pin_circle_sharp,
                                    size: 40,
                                    color: Color.fromARGB(207, 172, 0, 0)))))
                    : Text("")
              ])),
          _MapFabs(
            onToggleMapTypePressed: _onToggleMapTypePressed,
          )
        ]));
      }
    });
  }

  @override
  void didUpdateWidget(PlaceMapCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Zoom to fit the selected category.
    if (mounted) {
      // _zoomToFitSelectedCategory();
    }
  }

  void _showMyDialog(String area, int storeNumber, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            child: const Text('Thông tin chi tiết',
                style: TextStyle(fontSize: 15)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Vị trí gửi yêu cầu: $area',
                    style:
                        TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700)),
                Text('Số cửa hàng: $storeNumber',
                    style:
                        TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700)),
                Text('Nội dung: Điện bị chập chờn',
                    style:
                        TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Text('Tình trạng: ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    Text('Chưa được xử lý',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w700))
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Bỏ qua'),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('Xác nhận'),
              onPressed: () {},
            )
          ],
        );
      },
    );
  }

  /// Applies zoom to fit the places of the selected category
  void _onToggleMapTypePressed() {
    setState(() {
      isShowCoverFlow = true;
    });
  }

  static List<Place> _getPlacesForCategory(
      PlaceCategory category, List<Place> places) {
    return places.where((place) => place.category == category).toList();
  }
}

class _AddPlaceButtonBar extends StatelessWidget {
  final bool visible;

  final VoidCallback onSavePressed;
  final VoidCallback onCancelPressed;

  const _AddPlaceButtonBar({
    required this.visible,
    required this.onSavePressed,
    required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 14.0),
        alignment: Alignment.bottomCenter,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.blue),
              onPressed: onSavePressed,
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
              onPressed: onCancelPressed,
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryButtonBar extends StatelessWidget {
  final PlaceCategory selectedPlaceCategory;
  final bool visible;
  final ValueChanged<PlaceCategory> onChanged;

  const _CategoryButtonBar({
    required this.selectedPlaceCategory,
    required this.visible,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 14.0),
        alignment: Alignment.bottomCenter,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor:
                      selectedPlaceCategory == PlaceCategory.favorite
                          ? Colors.green[700]
                          : Colors.lightGreen),
              child: const Text(
                'Favorites',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              onPressed: () => onChanged(PlaceCategory.favorite),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor:
                      selectedPlaceCategory == PlaceCategory.visited
                          ? Colors.green[700]
                          : Colors.lightGreen),
              child: const Text(
                'Visited',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              onPressed: () => onChanged(PlaceCategory.visited),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor:
                      selectedPlaceCategory == PlaceCategory.wantToGo
                          ? Colors.green[700]
                          : Colors.lightGreen),
              child: const Text(
                'Want To Go',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              onPressed: () => onChanged(PlaceCategory.wantToGo),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapFabs extends StatelessWidget {
  final VoidCallback onToggleMapTypePressed;

  const _MapFabs({
    required this.onToggleMapTypePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.only(top: 12.0, right: 12.0),
      child: Visibility(
        visible: true,
        child: Column(
          children: [
            // FloatingActionButton(
            //   heroTag: 'add_place_button',
            //   onPressed: onAddPlacePressed,
            //   materialTapTargetSize: MaterialTapTargetSize.padded,
            //   backgroundColor: Colors.green,
            //   child: const Icon(Icons.add_location, size: 36.0),
            // ),
            // const SizedBox(height: 12.0),
            FloatingActionButton(
              heroTag: 'toggle_map_type_button',
              onPressed: onToggleMapTypePressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              mini: true,
              backgroundColor: Colors.green,
              child: const Icon(Icons.layers, size: 28.0),
            ),
          ],
        ),
      ),
    );
  }
}
