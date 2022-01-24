import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NearbyMosques extends StatefulWidget {
  @override
  _NearbyMosquesState createState() => _NearbyMosquesState();
}

class _NearbyMosquesState extends State<NearbyMosques> {
  String googleAPiKey = kGoogleMapKey;

  Position coord;

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  CameraPosition currentPosition;
  Map<MarkerId, Marker> markers = {};
  bool check = false;

  void showMap() async {
    coord = await getNearbyMosques();
  }

  bool checkStatus = false;
  void checkStatusV() {
    if (coord != null) {
      checkStatus = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    waitForMap();
    checkStatusV();
    showMap();

    super.initState();
  }

  waitForMap() async {
    check = true;
    await Future.delayed(const Duration(seconds: 8), () {
      check = false;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("markers --> $markers");
    print("Cord --> $coord");
    return SafeArea(
      child: Scaffold(
        body: check
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                strokeWidth: 8,
              ))
            : Container(
                child: Stack(
                  children: [
                    coord != null
                        ? Container(
                            height: double.infinity,
                            child: GoogleMap(
                              markers: Set<Marker>.of(markers.values),
                              mapType: MapType.terrain,
                              zoomControlsEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(coord.latitude, coord.longitude),
                                zoom: 15.0,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                          )
                        : AlertDialog(
                            title: Text(
                              "Location service are disable, please enable to see nearby masjid",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.boxColors,
                                ),
                              )
                            ],
                          ),
                    Positioned(
                      top: 50,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(15)),
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.arrow_back_ios,
                                  color: AppColors.greenColors),
                            ),
                            SizedBox(width: 110),
                            Text(
                              "Masjid",
                              style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 25,
                      child: places == null
                          ? CupertinoActivityIndicator()
                          : Container(
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var item in places) mechDetails(item),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  mechDetails(Place place) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 15, right: 5, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        width: 200,
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 80,
              height: double.infinity,
              child: Image.network(
                place.image != null
                    ? "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" +
                        place.image +
                        "&key=$googleAPiKey"
                    : "https://images.pexels.com/photos/337901/pexels-photo-337901.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(
                //   height: getScreenHeight(10),
                // ),
                Text(
                  place.name,
                  style: kBodyStyle.copyWith(color: kPrimaryColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                // Spacer(),
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kPrimaryColor),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.my_location,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    place.vicinity,
                                    style: kCalloutStyle.copyWith(
                                        color: Colors.white, fontSize: 14),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),

                SizedBox(
                  height: getScreenHeight(5),
                ),
              ],
            )),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }

  List<Place> places;
  Future<Position> getNearbyMosques() async {
    Position _coordinates = await determinePosition();
    var uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=${_coordinates.latitude},${_coordinates.longitude}&type=mosque&rankby=distance&key=$googleAPiKey');
    print(uri.toString());
    var response = await http.get(uri);
    print(response.body);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    places = jsonResults.map((place) => Place.fromJson(place)).toList();

    setState(() {});
    return _coordinates;
  }
}

class Place {
  final String name;
  final double rating;
  final int userRatingCount;
  final String vicinity;
  final Geometry geometry;
  final String image;

  Place(
      {this.geometry,
      this.name,
      this.rating,
      this.userRatingCount,
      this.vicinity,
      this.image});

  Place.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        rating = (parsedJson['rating'] != null)
            ? parsedJson['rating'].toDouble()
            : null,
        userRatingCount = (parsedJson['user_ratings_total'] != null)
            ? parsedJson['user_ratings_total']
            : null,
        vicinity = parsedJson['vicinity'],
        image = parsedJson['photos'] == null
            ? null
            : parsedJson['photos'][0]["photo_reference"],
        geometry = Geometry.fromJson(parsedJson['geometry']);
}

class Geometry {
  final Location location;

  Geometry({this.location});

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
}

class Location {
  final double lat;
  final double lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<dynamic, dynamic> parsedJson)
      : lat = parsedJson['lat'],
        lng = parsedJson['lng'];
}
