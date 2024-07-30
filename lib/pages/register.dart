import 'dart:developer';

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ลงทะเบียนสมาชิกใหม่'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('ชื่อ-นามสกุล'),
                      ],
                    ),
                    TextField(
                      controller: nameCtl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const Padding(
                   padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('หมายเลขโทรศัพท์'),
                        ],
                      ),
                    ),
                    TextField(
                      controller: nameCtl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const Padding(
                padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('อีเมล์'),
                        ],
                      ),
                    ),
                    TextField(
                      controller: nameCtl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const Padding(
                   padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('รหัสผ่าน'),
                        ],
                      ),
                    ),
                    TextField(
                      controller: nameCtl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const Padding(
              padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('ยืนยันรหัสผ่าน'),
                        ],
                      ),
                    ),
                    TextField(
                      controller: nameCtl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    Padding(
                   padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                              onPressed: register, child: const Text('สมัครสมาชิก'))
                        ],
                      ),
                    ),
                    Padding(
                   padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('หากมีบัญชีอยู่แล้ว'),
                          TextButton(
                              onPressed: login, child: const Text('เข้าสู่ระบบ'))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void register() {
    log('สมัครสมาชิก');
  }

  void login() {
    //  Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const LoginPage(),
    //     ));
    Navigator.pop(context);
  }
}
