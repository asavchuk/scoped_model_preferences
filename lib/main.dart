import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_preferences/widgets/home.dart';

import 'scoped_models/preference_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PreferenceModel prefModel = PreferenceModel();
  await prefModel.loadPreferences();
  return runApp(MyApp(model: prefModel));
}

class MyApp extends StatelessWidget {
  final PreferenceModel model;
  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PreferenceModel>(
      model: model,
      child: ScopedModelDescendant<PreferenceModel>(
        builder: (context, child, model) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: model.primaryColor.color,
              brightness: model.brightness,
            ),
            home: Home(),
          );
        },
      ),
    );
  }
}
