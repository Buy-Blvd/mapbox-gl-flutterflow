import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:mapbox_gl_flutterflow/mapbox_gl_flutterflow.dart';

import 'main.dart';
import 'page.dart';
import 'dart:math';

class FullMapPage extends ExamplePage {
  FullMapPage() : super(const Icon(Icons.map), 'Full screen map');

  @override
  Widget build(BuildContext context) {
    return const FullMap();
  }
}

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMapController? mapController;
  var isLight = true;
  var symbols = new Map<String, String>();

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    mapController?.onSymbolTapped.add(_onSymbolTapped);
    mapController?.onFeatureTapped.add(_onFeatureTapped);
  }

  _onFeatureTapped(dynamic id, Point<double> point, LatLng coordinates) {
    debugPrint(id.toString());
  }

  _onSymbolTapped(Symbol symbol) {
    debugPrint(symbols[symbol.id] ?? 'Null, id: ${symbol.id}');
  }

  addSymbol() async {
    try {
      var symbol1 = await mapController!.addSymbol(
        SymbolOptions(
          geometry: LatLng(0, 0), // Replace with your coordinates
          iconImage: "basic-marker", // Replace with your marker icon
          iconSize: .5,
          iconAnchor: "bottom",
        ),
      );
      var symbol2 = await mapController!.addSymbol(
        SymbolOptions(
          geometry: LatLng(180, 0), // Replace with your coordinates
          iconImage: "basic-marker", // Replace with your marker icon
          iconSize: .5,
        ),
      );
      symbols[symbol1.id] = "symbol 1";
      symbols[symbol2.id] = "symbol 2";
    } catch (err) {
      if (!typeofEquals(err, "NoSuchMethodError")) {
        throw err;
      }
    }
  }

  final markers = {
    "type": "FeatureCollection",
    "features": [
      {
        "type": "Feature",
        "id": 2,
        "geometry": {
          "type": "Point",
          "coordinates": [90, 0]
        }
      },
      {
        "type": "Feature",
        "id": 3,
        "geometry": {
          "type": "Point",
          "coordinates": [-90, 0]
        }
      }
    ]
  };

  _onStyleLoadedCallback() {
    addSymbol();
    mapController?.addGeoJsonSource("markers", markers);
    mapController?.addSymbolLayer(
        "markers",
        "symbols_layer",
        SymbolLayerProperties(
          iconImage: "basic-marker",
          iconSize: .5,
        ));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(32.0),
          child: FloatingActionButton(
            child: Icon(Icons.swap_horiz),
            onPressed: () => setState(
              () => isLight = !isLight,
            ),
          ),
        ),
        body: MapboxMap(
          styleString: "mapbox://styles/buyblvdryan/clrff17o6004701re2j5thsbf",
          accessToken: MapsDemo.ACCESS_TOKEN,
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0.0, 0.0),
            zoom: 4,
          ),
          onStyleLoadedCallback: _onStyleLoadedCallback,
          tiltGesturesEnabled: false,
          pointerEventsEnabled: isLight,
        ));
  }
}
