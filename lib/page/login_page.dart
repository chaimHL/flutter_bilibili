import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/util/string_util.dart';
import 'package:lbluebook_logistics/util/toast.dart';
import 'package:lbluebook_logistics/widget/login_button.dart';
import 'package:lbluebook_logistics/widget/login_input.dart';
import 'package:lbluebook_logistics/widget/appBar.dart';

import '../http/core/lb_error.dart';
import '../http/core/lb_net.dart';
import '../http/dao/login_dao.dart';
import '../http/request/application_configuration_request.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onJumpLanguage;
  final VoidCallback onSuccess;

  const LoginPage(
      {super.key, required this.onJumpLanguage, required this.onSuccess});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('登录',
          rightIcon: const Icon(Icons.g_translate),
          rightBtnClick: widget.onJumpLanguage),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            LoginInput(
              '帐号',
              '请输入帐号',
              onChanged: (val) {
                username = val;
                _checkInput();
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true,
              onChanged: (val) {
                password = val;
                _checkInput();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _loginButton(),
            )
          ],
        ),
      ),
    );
  }

  void _checkInput() {
    bool enable;
    if (isNotEmpty(username) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return LoginButton(
      '登录',
      enable: loginEnable,
      onPressed: _send,
    );
  }

  void _send() async {
    try {
      var result = await LoginDao.login(username, password);
      print('result:$result');
      if (result['error'] == null) {
        showSuccessToast('登录成功');
        widget.onSuccess();
      } else {
        showWarnToast('登录失败');
      }
      await LbNet.getInstance().fire(ApplicationConfigurationRequest());
    } on LbNetError catch (e) {
      print('eeeeee$e');
      showWarnToast(e.message);
    }
  }
}
