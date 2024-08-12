import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/reqsponse/CustomersRegisterPostRequest.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String errorText = '';
  TextEditingController nameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passwordCtl1 = TextEditingController();
  TextEditingController passwordCtl2 = TextEditingController();

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
                      controller: phoneCtl,
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
                      controller: emailCtl,
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
                      controller: passwordCtl1,
                      obscureText: true,
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
                      controller: passwordCtl2,
                      obscureText: true,
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
                              onPressed: register,
                              child: const Text('สมัครสมาชิก'))
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
                              onPressed: login,
                              child: const Text('เข้าสู่ระบบ'))
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

  void register() async {
    // log('สมัครสมาชิก')
    if (nameCtl.text.isEmpty ||
        phoneCtl.text.isEmpty ||
        emailCtl.text.isEmpty ||
        passwordCtl1.text.isEmpty ||
        passwordCtl2.text.isEmpty) {
      setState(() {
        errorText = 'กรุณาใส่ข้อมูลให้ครบทุกช่อง';
      });
      return;
    }

    if (passwordCtl1.text != passwordCtl2.text) {
      setState(() {
        errorText = 'รหัสผ่านและการยืนยันรหัสผ่านไม่ตรงกัน!';
      });
      return;
    }

    var data = CustomersRegisterPostRequest(
        fullname: nameCtl.text,
        phone: phoneCtl.text,
        email: emailCtl.text,
        image: '',
        password: passwordCtl1.text);

    try {
      var value = await http.post(
          Uri.parse("http://10.34.40.116:3000/customers"),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode(data));
      CustomersRegisterPostRequest customer =
          customersRegisterPostRequestFromJson(value.body);
      log("");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    } catch (eeee) {
      setState(() {
        errorText = 'Phone no or Password Incorrect';
      });
    }
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
