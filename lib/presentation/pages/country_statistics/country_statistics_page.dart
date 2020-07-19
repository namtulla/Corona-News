import 'package:flutter/material.dart';
import '../../../utils/constants/language_keys.dart';

class CountryStatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageKeys.statistics),
      ),
    );
  }
}
