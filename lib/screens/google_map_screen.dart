import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../blocs/clockin_bloc/clockin_bloc.dart';
import '../blocs/location_bloc/location_bloc.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _controller;

  void _onMapCreated(Position position) {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15,
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const  Text('Google Map'),),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          switch (state.status) {
            case ListStatus.initial:
              return const Center(child: CircularProgressIndicator());

            case ListStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ListStatus.loaded:
              // _controller?.animateCamera(
              //     CameraUpdate
              //         .newCameraPosition(
              //   CameraPosition(
              //     target: LatLng(
              //         state.data!.latitude,
              //         state.data!.longitude),
              //     zoom: 15,
              //   ),
              // ));
              return SizedBox(
                width: 410,
                height: 562,
                child: Column(
                  children: [
                    SizedBox(
                      width: 410,
                      height: 300, 
                      child: GoogleMap(
                        myLocationEnabled:true,
                        // onMapCreated: _onMapCreated(state.data!),
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              state.data!.latitude, state.data!.longitude),
                          zoom: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              throw UnimplementedError('Not a valid state');
          }
        },
      ),
    );
  }
}
