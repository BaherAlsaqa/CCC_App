
import 'package:flutter/material.dart';
import 'AppLocalization.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context).translate(key).toString();
}