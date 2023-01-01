// 登录 输入框
import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/util/font.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final bool autofocus;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const LoginInput(
    this.title,
    this.hint, {
    super.key,
    this.autofocus = false,
    this.obscureText = false, // 是否是密码输入
    this.onChanged,
  });

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // lable
            Container(
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            // 输入框
            _input()
          ],
        ),
        const Divider(),
      ],
    );
  }

  _input() {
    return Expanded(
      child: TextField(
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        style: const TextStyle(fontSize: FontSizeDefalut),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: const TextStyle(fontSize: FontSizeSmall)),
      ),
    );
  }
}
