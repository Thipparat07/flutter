import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/reqsponse/customers_idx_get_res.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  int idx = 0;
  ProfilePage({super.key, required this.idx});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<void> loadData;
  late CustomersIdxGetResponse customerIdxGetResponse;

  TextEditingController fullnameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController imageCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    log('Customer id: ${widget.idx}');
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'ยืนยันการยกเลิกสมาชิก?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('ปิด')),
                            FilledButton(
                                onPressed: () => delete(context),
                                child: const Text('ยืนยัน')),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('ยกเลิกสมาชิก'),
                ),
              ],
            ),
          ],
          title: const Text('ข้อมูลส่วนตัว'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: FutureBuilder(
          future: loadData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(imageCtl.text),
                      onBackgroundImageError: (exception, stackTrace) {
                        log('Image load error: $exception');
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: fullnameCtl,
                      decoration: const InputDecoration(
                        labelText: 'ชื่อ-นามสกุล',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: phoneCtl,
                      decoration: const InputDecoration(
                        labelText: 'หมายเลขโทรศัพท์',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: emailCtl,
                      decoration: const InputDecoration(
                        labelText: 'อีเมล์',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: imageCtl,
                      decoration: const InputDecoration(
                        labelText: 'รูปภาพ URL',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: update,
                      child: const Text('บันทึกข้อมูล'),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  void update() async {
    var json = {
      "fullname": fullnameCtl.text,
      "phone": phoneCtl.text,
      "email": emailCtl.text,
      "image": imageCtl.text,
    };
    var value = await Configuration.getConfig();
    var url = value['apiEndpoint'];

    try {
      var response = await http.put(
        Uri.parse('$url/customers/${widget.idx}'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(json),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result['message']);

        // แสดง dialog เมื่อบันทึกข้อมูลสำเร็จ
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('สำเร็จ'),
            content: const Text('บันทึกข้อมูลเรียบร้อย'),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'),
              ),
            ],
          ),
        );
      } else {
        log('Failed to update data');
      }
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];
    var res = await http.get(Uri.parse('$url/customers/${widget.idx}'));
    log(res.body);
    customerIdxGetResponse = customersIdxGetResponseFromJson(res.body);

    setState(() {
      fullnameCtl.text = customerIdxGetResponse.fullname;
      phoneCtl.text = customerIdxGetResponse.phone;
      emailCtl.text = customerIdxGetResponse.email;
      imageCtl.text = customerIdxGetResponse.image;
    });
  }

  void delete(BuildContext context) async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var res = await http.delete(Uri.parse('$url/customers/${widget.idx}'));
    log(res.statusCode.toString());

    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('สำเร็จ'),
          content: const Text('ลบข้อมูลสำเร็จ'),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                },
                child: const Text('ปิด'))
          ],
        ),
      ).then((s) {
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
      });
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ผิดพลาด'),
          content: const Text('ลบข้อมูลไม่สำเร็จ'),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'))
          ],
        ),
      );
    }
  }
}
