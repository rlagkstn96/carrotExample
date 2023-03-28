import 'package:beamer/beamer.dart';
import 'package:carrotexample/screens/home_screen.dart';
import 'package:carrotexample/screens/input/input_screen.dart';
import 'package:carrotexample/states/select_image_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../screens/input/category_input_screen.dart';
import '../states/category_notifier.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey('home'))];
  }

  @override
  List get pathBlueprints => ['/'];
}

class InputLocation extends BeamLocation {
  Widget builder(BuildContext context, Widget navigator) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: categoryNotifier),
          ChangeNotifierProvider(create: (context)=>SelectImageNotifier())
        ],
        child: super.builder(context, navigator));
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains('input'))
        BeamPage(key: ValueKey('input'), child: InputScreen()),
      if (state.pathBlueprintSegments.contains('category_input'))
        BeamPage(key: ValueKey('category_input'), child: CategoryInputScreen())
    ];
  }

  @override
  List get pathBlueprints => ['/input', '/input/category_input'];
}
