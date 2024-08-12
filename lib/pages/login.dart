import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/reqsponse/CustomersLoginPostResponse.dart';
import 'package:flutter_application_1/models/reqsponse/customers_login_post_req.dart';
import 'package:flutter_application_1/pages/register.dart';
import 'package:flutter_application_1/pages/showtrip.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorText = '';
  int count = 0;
  String phoneNo = '';
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  String url = '';

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then(
      (value) {
        log(value['apiEndpoint']);
        setState(() {
          url = value['apiEndpoint'];
        });
      },
    ).catchError((err) {
      log(err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/logo.png'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'หมายเลขโทรศัพท์',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: phoneCtl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'รหัสผ่าน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: passwordCtl,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: register,
                            child: const Text('ลงทะเบียนใหม่')),
                        FilledButton(
                            onPressed: login, child: const Text('เข้าสู่ระบบ')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              errorText,
              style: const TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }

  void register() {
    log('This is Register button');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ));
  }

  void login() async {
    var data = CustomersLoginPostRequest(
        phone: phoneCtl.text, password: passwordCtl.text);

    try {
      var response = await http.post(
        Uri.parse('$url/customers/login'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: customersLoginPostRequestToJson(data),
      );

      if (response.statusCode == 200) {
        CustomersLoginPostResponse customer =
            customersLoginPostResponseFromJson(response.body);
        log("idx ${customer.customer.idx}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowTrip(cid: customer.customer.idx),
          ),
        );
      } else {
        setState(() {
          errorText = 'หมายเลขโทรศัพท์หรือรหัสผ่านไม่ถูกต้อง!!!';
        });
      }
    } catch (error) {
      setState(() {
        errorText = 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ!!!';
      });
      log(error.toString());
    }
  }
}
