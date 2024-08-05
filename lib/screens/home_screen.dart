// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_project/Networks/models/clockin_model.dart';
import 'package:new_project/blocs/clockin_status_bloc/clockin_status_bloc.dart';
import 'package:new_project/resources/constants.dart';
import 'package:new_project/resources/utils.dart';

import '../blocs/clockin_bloc/clockin_bloc.dart';
import '../blocs/location_bloc/location_bloc.dart';
import '../resources/ui_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void showClockInDialog(BuildContext context, LocationState state) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: kGrey25, borderRadius: BorderRadius.circular(16)),
            width: 512,
            height: 512,
            child: Column(
              children: [
                // Login info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText('Login info', 16, kBlack),
                    const SizedBox(height: 6),
                    RegularText('Status: Sign in', 14, kGrey500),
                    RegularText('Check-in: ${DateTime.now().formatDateFull}',
                        14, kGrey500),
                    RegularText(
                        'Latitude: ${state.data?.latitude}', 14, kGrey500),
                    RegularText(
                        'Longitude: ${state.data?.longitude}', 14, kGrey500),
                  ],
                ),
                const SizedBox(height: 12),
                // Google Map
                SizedBox(
                  width: 410,
                  height: 300,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target:
                          LatLng(state.data!.latitude, state.data!.longitude),
                      zoom: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CancelButton(
                      title: 'Cancel',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    CustomButton(
                      title: 'Confirm',
                      onTap: () {
                        context
                            .read<ClockinBloc>()
                            .add(CreateClockIn(state.data!));
                        context.pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showClockOutDialog(BuildContext context, ClockinStatusState state) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: kGrey25, borderRadius: BorderRadius.circular(16)),
            width: 512,
            height: 150,
            child: Column(
              children: [
                // Login info
                BoldText('Are you sure want to Check Out?', 16, kBlack),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CancelButton(
                      title: 'Cancel',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    CustomButton(
                      title: 'Confirm',
                      onTap: () {
                        context
                            .read<ClockinBloc>()
                            .add(CreateClockOut(state.data!));
                        context.pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: BlocConsumer<ClockinBloc, ClockinListState>(
        listener: (context, state) {
          switch (state.status) {
            case ListStatus.success:
              // showSuccessMessage(state.message);
              break;
            case ListStatus.failure:
              showErrorMessage(state.message);
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 410,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 207,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(60)),
                              color: Color.fromRGBO(105, 56, 239, 1)),
                        ),
                      ),
                      Positioned(
                        top: 65,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                                      child: Image.asset(
                                        'assets/images/image1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'John Doe',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            letterSpacing: -0.6,
                                          ),
                                        ),
                                        Text(
                                          'Flutter Developer',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Image.asset('assets/icons/notification.png'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 140,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              // height: 278,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateTime.now().customFormat,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(16, 24, 40, 1),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      Text(
                                        DateTime.now().customTimeFormat,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(16, 24, 40, 1),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color.fromRGBO(
                                                  242, 244, 247, 1),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '00',
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color.fromRGBO(
                                                        16, 24, 40, 1),
                                                  ),
                                                ),
                                                Text(
                                                  'HOURS',
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        16, 24, 40, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color.fromRGBO(
                                                  242, 244, 247, 1),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '00',
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color.fromRGBO(
                                                        16, 24, 40, 1),
                                                  ),
                                                ),
                                                Text(
                                                  'MINUTES',
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        16, 24, 40, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color.fromRGBO(
                                                  242, 244, 247, 1),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '00',
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color.fromRGBO(
                                                        16, 24, 40, 1),
                                                  ),
                                                ),
                                                Text(
                                                  'SECONDS',
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        16, 24, 40, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'General 10:00 AM to 06:00 PM',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(152, 162, 179, 1),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      BlocBuilder<LocationBloc, LocationState>(
                                        builder: (context, locationState) {
                                          switch (state.status) {
                                            case ListStatus.loaded:
                                              return BlocBuilder<
                                                  ClockinStatusBloc,
                                                  ClockinStatusState>(
                                                builder: (context, state) {
                                                  bool clockedIn = (state
                                                          .status ==
                                                      ClockInStatus.clockedIn);
                                                  final Color color = clockedIn
                                                      ? kRed600
                                                      : kGreen600;
                                                  final String text = clockedIn
                                                      ? 'Check out'
                                                      : 'Check in ';
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (clockedIn) {
                                                        showClockOutDialog(
                                                            context, state);
                                                      } else {
                                                        showClockInDialog(
                                                            context,
                                                            locationState);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 44,
                                                      width: 259,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: color),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                              'assets/icons/tabler_line-scan.png'),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            text,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );

                                            default:
                                              return RegularText(
                                                  'Loading..', 16, kBlack);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'View Full Day Tracking',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromRGBO(16, 24, 40, 1),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                              'assets/icons/chevron-back.png'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: 753,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Attendance',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color.fromRGBO(16, 24, 40, 1)),
                              ),
                              Container(
                                height: 36,
                                width: 109,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(31),
                                  color: Color.fromRGBO(242, 244, 247, 1),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/icons/filter-sharp.png'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Weekly',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color.fromRGBO(16, 24, 40, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 48,
                          padding: EdgeInsets.all(15),
                          color: Color.fromRGBO(105, 56, 239, 1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                              Text(
                                'Check in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                              Text(
                                'Check out',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                              Text(
                                'Status',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            ],
                          ),
                        ),
                        Builder(builder: (context) {
                          switch (state.status) {
                            case ListStatus.initial:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case ListStatus.loading:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case ListStatus.loaded:
                              return Expanded(
                                child: ListView.separated(
                                  itemCount: state.data.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Gap(12);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final e = state.data[index] as ClockInModel;
                                    return Container(
                                      width: 358,
                                      height: 58.75,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: kGreen200)),
                                      child: Row(
                                        children: [
                                          RegularText(
                                              e.id.toString(), 12, kBlack),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            default:
                              throw UnimplementedError('Not a valid state');
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
