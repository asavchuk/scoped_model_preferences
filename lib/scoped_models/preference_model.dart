import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_preferences/models/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceModel extends Model {
  Brightness _brightness;
  ColorData _primaryColor;

  PreferenceModel();

  final List<ColorData> _colors = [
    ColorData(color: Colors.blue, index: 0.0, name: 'Blue'),
    ColorData(color: Colors.green, index: 1.0, name: 'Green'),
    ColorData(color: Colors.red, index: 2.0, name: 'Red'),
    ColorData(color: Colors.white, index: 3.0, name: 'White'),
  ];

  //Getters
  Brightness get brightness => _brightness;
  ColorData get primaryColor => _primaryColor;

  //Setters
  void setBrightness(Brightness brightness) async {
    _brightness = brightness;
    await savePreferences();
    notifyListeners();
  }

  void setPrimaryColor(ColorData colorData) async {
    _primaryColor = colorData;
    await savePreferences();
    notifyListeners();
  }

  indexToPrimaryColor(double index) {
    return _colors.firstWhere((x) => x.index == index);
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_brightness == Brightness.light) {
      await prefs.setBool('dark', false);
    } else {
      await prefs.setBool('dark', true);
    }

    await prefs.setDouble('colorIndex', _primaryColor.index);
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.get('dark');
    double colorIndex = prefs.get('colorIndex');

    if (darkMode != null) {
      print('darkMode == $darkMode');
      (darkMode == false) ? setBrightness(Brightness.light) : setBrightness(Brightness.dark);
    } else {
      print('darkMode == null');
      setBrightness(Brightness.light);
    }

    if (colorIndex != null) {
      setPrimaryColor(indexToPrimaryColor(colorIndex));
    } else {
      setPrimaryColor(ColorData(color: Colors.blue, index: 0.0, name: 'Blue'));
    }
  }
}
