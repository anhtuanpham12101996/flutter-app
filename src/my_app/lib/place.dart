// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String id;
  final LatLng latLng;
  final String name;
  final PlaceCategory category;
  final String? description;
  final int starRating;
  final String? path;

  const Place({
    required this.id,
    required this.latLng,
    required this.name,
    required this.category,
    this.description,
    this.starRating = 0,
    this.path
  }) : assert(starRating >= 0 && starRating <= 5);

  double get latitude => latLng.latitude;

  double get longitude => latLng.longitude;

  Place copyWith({
    String? id,
    LatLng? latLng,
    String? name,
    PlaceCategory? category,
    String? description,
    int? starRating,
    String? path
  }) {
    return Place(
      id: id ?? this.id,
      latLng: latLng ?? this.latLng,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      starRating: starRating ?? this.starRating,
      path: path ?? this.path
    );
  }
}

enum PlaceCategory {
  favorite,
  visited,
  wantToGo,
}
