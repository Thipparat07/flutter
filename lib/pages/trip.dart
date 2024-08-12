import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/reqsponse/trips_idx_get_res.dart';
import 'package:http/http.dart' as http;

class TripPage extends StatefulWidget {
  int idx;
  TripPage({super.key, required this.idx});

  @override
  State<TripPage> createState() => _TripPage();
}

class _TripPage extends State<TripPage> {
  late TripidxGetResponse trip;
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    log(widget.idx.toString()); // ใช้ log แทน print
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Text(trip.name),
                Text(trip.country),
                Image.network(trip.coverimage),
                Row(
                  children: [
                    Text(trip.price.toString()),
                    Text(trip.destinationZone),
                  ],
                ),
                Text(trip.detail),
                Center(
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('จองทริปนี้'),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future loadDataAsync() async {
    var value = await Configuration.getConfig();
    var url = value['apiEndpoint'];

    var data = await http.get(Uri.parse('$url/trips/${widget.idx}'));
    trip = tripidxGetResponseFromJson(data.body);
  }
}
