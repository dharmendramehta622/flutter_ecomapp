// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_project/Networks/models/clockin_model.dart';
import 'package:new_project/blocs/clockin_status_bloc/clockin_status_bloc.dart';
import 'package:new_project/blocs/login_bloc/login_bloc.dart';
import 'package:new_project/blocs/login_bloc/login_event.dart';
import 'package:new_project/resources/constants.dart';
import 'package:new_project/resources/routes.dart';
import 'package:new_project/resources/utils.dart';

import '../blocs/clockin_bloc/clockin_bloc.dart';
import '../blocs/location_bloc/location_bloc.dart';
import '../blocs/login_bloc/login_state.dart';
import '../resources/ui_utils.dart';
import '../widgets/custom_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        if (_seconds >= 60) {
          _seconds = 0;
          _minutes++;
        }
        if (_minutes >= 60) {
          _minutes = 0;
          _hours++;
        }
      });
    });
  }

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
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CancelButton(
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    CustomButton(
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
                color: kWhite, borderRadius: BorderRadius.circular(16)),
            width: 700,
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
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    CustomButton(
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
              context.read<ClockinStatusBloc>().add(CheckClockIn());
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
                                    const Gap(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        BoldText('John Doe', 16, kWhite),
                                        RegularText(
                                            'Flutter Developer', 14, kWhite),
                                      ],
                                    ),
                                  ],
                                ),
                                BlocListener<LoginBloc, LoginState>(
                                  listener: (context, state) {
                                    if (state is LogoutSuccessState) {
                                      context.go(Routes.login);
                                    }
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<LoginBloc>()
                                          .add(LogoutRequested());
                                    },
                                    child: Icon(Icons.logout, color: kWhite),
                                  ),
                                ),
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
                                      BoldText(DateTime.now().customFormat, 14,
                                          kGrey900),
                                      BoldText(DateTime.now().customTimeFormat,
                                          14, kGrey900),
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
                                      BlocBuilder<ClockinStatusBloc,
                                          ClockinStatusState>(
                                        builder: (context, state) {
                                          switch (state.status) {
                                            case ClockInStatus.clockedIn:
                                              return TimerWidget(
                                                  checkInTime:
                                                      state.data!.checkIn!);
                                            default:
                                              return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  _buildTimeContainer(
                                                      0, 'HOURS'),
                                                  const Gap(5),
                                                  _buildTimeContainer(
                                                      0, 'MINUTES'),
                                                  const Gap(5),
                                                  _buildTimeContainer(
                                                      0, 'SECONDS'),
                                                ],
                                              );
                                          }
                                        },
                                      ),
                                      const Gap(20),
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
                        SizedBox(height: 10),
                        Container(
                          height: 48,
                          padding: EdgeInsets.all(15),
                          color: kPrimary600,
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
                        // clock in items list view
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.zero,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Gap(12);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final e = state.data[index] as ClockInModel;
                                    return CustomCard(e: e);
                                  },
                                ),
                              );
                            default:
                              throw UnimplementedError('Not a valid state');
                          }
                        }),
                        //total hours text
                        Builder(builder: (context) {
                          switch (state.status) {
                            case ListStatus.initial:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case ListStatus.loading:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case ListStatus.loaded:
                              int hours = state.totalHours.floor();
                              int minutes =
                                  ((state.totalHours - hours) * 60).round();
                              return Container(
                                  width: 390,
                                  height: 48,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 72, vertical: 15),
                                  clipBehavior: Clip.antiAlias,
                                  decoration:
                                      BoxDecoration(color: Color(0xFFF2F4F7)),
                                  child: SemiBoldText(
                                      'Total Hours: $hours hrs $minutes mins',
                                      14,
                                      kGrey900));
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

Widget _buildTimeContainer(int value, String label) {
  return Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Color.fromRGBO(242, 244, 247, 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BoldText(value.toString().padLeft(2, '0'), 19, kGrey900),
        BoldText(label, 8, kGrey900),
      ],
    ),
  );
}

class TimerWidget extends StatefulWidget {
  final DateTime checkInTime;

  const TimerWidget({super.key, required this.checkInTime});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final difference = now.difference(widget.checkInTime);

      setState(() {
        _hours = difference.inHours;
        _minutes = difference.inMinutes % 60;
        _seconds = difference.inSeconds % 60;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimeContainer(_hours, 'HOURS'),
            SizedBox(width: 5),
            _buildTimeContainer(_minutes, 'MINUTES'),
            SizedBox(width: 5),
            _buildTimeContainer(_seconds, 'SECONDS'),
          ],
        ),
      ],
    );
  }
}
