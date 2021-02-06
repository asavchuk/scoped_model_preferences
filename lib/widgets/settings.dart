import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_preferences/scoped_models/preference_model.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<PreferenceModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: GestureDetector(
          child: Icon(CupertinoIcons.back),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Dark Mode'),
                  model.brightness != null
                      ? Switch(
                          value: (model.brightness == Brightness.light) ? false : true,
                          onChanged: (bool value) {
                            value
                                ? model.setBrightness(Brightness.dark)
                                : model.setBrightness(Brightness.light);
                          },
                        )
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Primary Color'),
                  (model.primaryColor.index != null || model.primaryColor.name != null)
                      ? Slider(
                          value: model.primaryColor.index,
                          min: 0.0,
                          max: 3.0,
                          divisions: 3,
                          label: model.primaryColor.name,
                          onChanged: (double value) {
                            model.setPrimaryColor(model.indexToPrimaryColor(value));
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
