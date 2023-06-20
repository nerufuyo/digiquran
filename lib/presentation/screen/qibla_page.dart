import 'dart:async';
import 'dart:math';

import 'package:digiquran/common/color.dart';
import 'package:digiquran/common/font.dart';
import 'package:digiquran/common/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});
  static const routeName = '/qibla_page';

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  final deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => _locationStreamController.stream;
  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_left_rounded,
            size: 40,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Qiblah',
          style: firaSansH2.copyWith(
            color: secondaryColor,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: deviceSupport,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              } else if (snapshot.data == false) {
                return const Center(
                  child: Text('Device not supported'),
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 380,
                  padding: const EdgeInsets.all(20),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: StreamBuilder(
                          stream: stream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(
                                color: primaryColor,
                              );
                            } else if (snapshot.data!.enabled == true) {
                              switch (snapshot.data!.status) {
                                case LocationPermission.always:
                                case LocationPermission.whileInUse:
                                  return const QiblahCompassWidget();

                                case LocationPermission.denied:
                                  return const Text('Location service denied');
                                case LocationPermission.deniedForever:
                                  return const Text(
                                    'Location service denied forever, we cannot request permission',
                                  );
                                default:
                                  return const Text('Unknown Error');
                              }
                            } else {
                              return const Center(
                                child: Text('Location Service is disabled'),
                              );
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: 4,
                        child: Text(
                          'N',
                          style: firaSansH2.copyWith(color: Colors.red),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5.75,
                        right: 30,
                        child: Text(
                          'E',
                          style: firaSansH2.copyWith(color: secondaryColor),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5.75,
                        left: 28,
                        child: Text(
                          'W',
                          style: firaSansH2.copyWith(color: secondaryColor),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        child: Text(
                          'S',
                          style: firaSansH2.copyWith(color: secondaryColor),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Text(
                  'Qiblah Information',
                  style: firaSansH2.copyWith(color: secondaryColor),
                ),
                const VerticalGap10(),
                Text(
                  'The Qiblah is the direction that Muslims face during their prayers, towards the Kaaba in Mecca, Saudi Arabia. It can be determined using tools such as Qiblah compasses, smartphone apps, online locators, or mobile applications that utilize GPS technology. The Qiblah direction varies depending on the geographic location, and it is essential for various acts of worship, not just prayer.',
                  style: firaSansS2.copyWith(color: secondaryColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QiblahCompassWidget extends StatelessWidget {
  const QiblahCompassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }

        final qiblahDirection = snapshot.data!;

        return Transform.rotate(
          angle: (qiblahDirection.direction * (pi / 180) * -1),
          child: Image.asset('lib/assets/qibla.png'),
        );
      },
    );
  }
}
