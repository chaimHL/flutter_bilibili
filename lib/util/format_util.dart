// 数字转换 单位为“万”
String countFormat(int count) {
  String views = '';
  if (count > 9999) {
    views = '${(count / 10000).toStringAsFixed(2)}万';
  } else {
    views = count.toString();
  }
  return views;
}

// 时间转换 将 秒 转为 分钟:秒
String durationTransform(int seconds) {
  int m = (seconds / 60).truncate(); // truncate() 丢弃小数位后返回一个整数
  int s = seconds - m * 60;
  if (s < 10) {
    return '$m:0$s';
  }
  return '$m:$s';
}
