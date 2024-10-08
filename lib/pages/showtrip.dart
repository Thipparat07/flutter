import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/request/Trips_Get_Res.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/trip.dart';
import 'package:http/http.dart' as http;

class ShowTrip extends StatefulWidget {
  final int cid;
  const ShowTrip({super.key, required this.cid});

  @override
  State<ShowTrip> createState() => _ShowTripState();
}

class _ShowTripState extends State<ShowTrip> {
  List<TripsGetRequest> trips = [];
  late Future<void> loadData;
  String url = '';

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการทริป'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              log(value);
              if (value == 'profile') {
                log('Profile page called with idx: ${widget.cid}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      idx: widget.cid,
                    ),
                  ),
                );
              } else if (value == 'logout') {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('ข้อมูลส่วนตัว'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('ออกจากระบบ'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ปลายทาง',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 95,
                          child: FilledButton(
                            onPressed: all,
                            child: const Text('ทั้งหมด'),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        SizedBox(
                          width: 95,
                          child: FilledButton(
                            onPressed: asia,
                            child: const Text('เอเชีย'),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        SizedBox(
                          width: 95,
                          child: FilledButton(
                            onPressed: eu,
                            child: const Text('ยุโรป'),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        SizedBox(
                          width: 120,
                          child: FilledButton(
                            onPressed: southeastAsia,
                            child: const Text(
                              'เอเชียตะวันออกเฉียงใต้',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        SizedBox(
                          width: 110,
                          child: FilledButton(
                            onPressed: thai,
                            child: const Text('ประเทศไทย'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: trips
                            .map((trip) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        width: 380,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 236, 229, 246),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                18, 13, 18, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  trip.name,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        height: 120,
                                                        width: 160,
                                                        child: trip.coverimage
                                                                .isNotEmpty
                                                            ? (Image.network(
                                                                trip.coverimage,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return const Center(
                                                                      child: Text(
                                                                          'ไม่มีรูปภาพ'));
                                                                },
                                                              ))
                                                            : (const Center(
                                                                child: Text(
                                                                    'ไม่มีรูปภาพ'))),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ประเทศ${trip.country}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          Text(
                                                            'ระยะเวลา ${trip.duration} วัน',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          Text(
                                                            'ราคา ${trip.price} บาท',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          FilledButton(
                                                            onPressed: () =>
                                                                goToTripPage(
                                                                    trip.idx),
                                                            child: const Text(
                                                                'รายละเอียดเพิ่มเติม'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> loadDataAsync() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];

    var data = await http.get(Uri.parse('$url/trips'));
    trips = tripsGetRequestFromJson(data.body);
    log(data.body);
    trips = tripsGetRequestFromJson(data.body);
    log(trips.length.toString());
  }

  void getTrips(String? zone) {
    http.get(Uri.parse('$url/trips')).then(
      (value) {
        trips = tripsGetRequestFromJson(value.body);
        List<TripsGetRequest> filteredTrips = [];
        if (zone != null) {
          for (var trip in trips) {
            if (trip.destinationZone == zone) {
              filteredTrips.add(trip);
            }
          }
          trips = filteredTrips;
        }
        setState(() {});
      },
    ).catchError((err) {
      log(err.toString());
    });
  }

  void all() {
    http.get(Uri.parse('$url/trips')).then(
      (value) {
        log(value.body);
        setState(() {
          trips = tripsGetRequestFromJson(value.body);
          log(trips.length.toString());
        });
      },
    ).catchError((err) {
      log(err.toString());
    });
  }

  void asia() {
    log('เอเชีย');
    getTrips('เอเชีย'); // ส่งค่าโซน "Asia" ไปยัง getTrips เพื่อกรองข้อมูลทริป
  }

  void eu() {
    log('ยุโรป');
    getTrips('ยุโรป'); // ส่งค่าโซน "Europe" ไปยัง getTrips เพื่อกรองข้อมูลทริป
  }

  void southeastAsia() {
    log('เอเชียตะวันออกเฉียงใต้');
    getTrips(
        'เอเชียตะวันออกเฉียงใต้'); // ส่งค่าโซน "Asean" ไปยัง getTrips เพื่อกรองข้อมูลทริป
  }

  void thai() {
    log('ประเทศไทย');
    getTrips(
        'ประเทศไทย'); // ส่งค่าโซน "Asean" ไปยัง getTrips เพื่อกรองข้อมูลทริป
  }

  void goToTripPage(int idx) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripPage(idx: idx),
      ),
    );
  }

  void goToProfilePage(int idx) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(idx: idx),
      ),
    );
  }
}
