import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as https;
import 'package:location/location.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/address_model.dart';
import 'package:wcycle_bd/widgets/address/navigator_map.dart';

class AddressLocationsUi extends StatefulWidget {
  const AddressLocationsUi(
      {super.key, required this.takeLocationsData, this.addressModel});
  final void Function(String? address, double? lat, double? long)
      takeLocationsData;
  final AddressModel? addressModel;

  @override
  State<AddressLocationsUi> createState() => _AddressLocationsUiState();
}

class _AddressLocationsUiState extends State<AddressLocationsUi> {
  Location location = Location();

  double lat = 37.42796133580664;
  double long = 37.42796133580664;
  String formatAddress = "Google Plex";

  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  Future<void> getLocationData() async {
    DialogsHelper.showProgressBar(context);
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (!mounted) return;
        Navigator.pop(context);
        return;
      }
    }

    locationData = await location.getLocation();

    setState(() {
      lat = locationData.latitude!;
      long = locationData.longitude!;
    });
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${Apis.googleMapKey}");
    final response = await https.get(url);
    final addresData = jsonDecode(response.body);

    setState(() {
      formatAddress = addresData["results"][0]["formatted_address"];
    });

    CameraPosition currentLocation = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(lat, long),
        tilt: 59.440717697143555,
        zoom: 10);

    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(currentLocation));
    widget.takeLocationsData(formatAddress, lat, long);
    if (!mounted) return;
    Navigator.pop(context);
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    if (widget.addressModel != null) {
      lat = widget.addressModel!.lat!;
      long = widget.addressModel!.long!;
      formatAddress = widget.addressModel!.mapAddress!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
    );

    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              width: DeviceSize.getDeviceWidth(context),
              height: 350,
              color: Colors.black,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: kGooglePlex,
                markers: <Marker>{
                  Marker(
                      markerId: const MarkerId("1"),
                      position: LatLng(lat, long),
                      infoWindow: InfoWindow(title: formatAddress)),
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Positioned(
                bottom: 10,
                child: SizedBox(
                  width: DeviceSize.getDeviceWidth(context),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: getLocationData,
                        child: Text(
                          "Use Current Location",
                          style: FontHelper().bodySmall(context),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigatorMap(),
                            )),
                        child: Text(
                          "Choose The Location",
                          style: FontHelper().bodySmall(context),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
        Container(
          padding: const EdgeInsets.all(csGap),
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black12)),
          child: Text(
            formatAddress,
            style: FontHelper().bodySmall(context),
          ),
        ),
      ],
    );
  }
}
