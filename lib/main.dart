import 'package:flutter/material.dart';
import 'package:safe2biz/app/modules/init/app.dart';
import 'package:safe2biz/app/global/core/injection/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(const Safe2BizApp());
}
