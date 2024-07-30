import 'dart:developer';
import 'package:flutter/material.dart';

class ShowTrip extends StatefulWidget {
  const ShowTrip({super.key});

  @override
  State<ShowTrip> createState() => _ShowTripState();
}

class _ShowTripState extends State<ShowTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการทริป'),
      ),
      body: Center(
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
                      width: 95,
                      child: FilledButton(
                        onPressed: asean,
                        child: const Text('อาเซียน'),
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 200,
                          width: 380,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 229, 246),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 13, 18, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'ภูทับเบิก',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/images/Landscape.png',
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'จังหวัดเพชรบูรณ์',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const Text(
                                            'ระยะเวลา 10 วัน',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const Text(
                                            'ราคา 8000 บาท',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          FilledButton(
                                            onPressed: detail,
                                            child: const Text(
                                                'รายละเอียดเพิ่มเติม'),
                                          ),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 200,
                          width: 380,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 229, 246),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 13, 18, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'เกาะล้าน',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/images/korlan.png',
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'จังหวัดชลบุรี',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const Text(
                                            'ระยะเวลา 10 วัน',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const Text(
                                            'ราคา 7500 บาท',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          FilledButton(
                                            onPressed: detail,
                                            child: const Text(
                                                'รายละเอียดเพิ่มเติม'),
                                          ),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 200,
                          width: 380,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 229, 246),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 13, 18, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'เสม็ดนางชี',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/images/samet.png',
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'จังหวัดพังงา',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const Text(
                                            'ระยะเวลา 8 วัน',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const Text(
                                            'ราคา 12000 บาท',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          FilledButton(
                                            onPressed: detail,
                                            child: const Text(
                                                'รายละเอียดเพิ่มเติม'),
                                          ),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 200,
                          width: 380,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 229, 246),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 13, 18, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'เมืองเก่าภูเก็ต',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/images/old_puket.png',
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'จังหวัดภูเก็ต',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const Text(
                                            'ระยะเวลา 9 วัน',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const Text(
                                            'ราคา 9500 บาท',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          FilledButton(
                                            onPressed: detail,
                                            child: const Text(
                                                'รายละเอียดเพิ่มเติม'),
                                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void all() {
    log('ทั้งหมด');
  }

  void asia() {
    log('เอเชีย');
  }

  void eu() {
    log('ยุโรป');
  }

  void asean() {
    log('อาเซียน');
  }

  void detail() {
    log('รายละเอียดเพิ่มเติม');
  }
}
