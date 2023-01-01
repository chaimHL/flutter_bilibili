//登录按钮
import 'package:flutter/material.dart';

import '../util/color.dart';
import '../util/font.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;
  const LoginButton(this.title, {Key? key, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 46,
        color: ColorPrimary,
        disabledColor: ColorPrimary[50],
        onPressed: enable ? onPressed : null,
        child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontSize: FontSizeDefalut),
        ),
      ),
    );
    ;
  }
}
