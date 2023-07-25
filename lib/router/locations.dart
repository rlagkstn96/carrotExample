import 'package:beamer/beamer.dart';
import 'package:carrotexample/screens/home_screen.dart';
import 'package:carrotexample/screens/input/input_screen.dart';
import 'package:carrotexample/states/select_image_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../item/item_detail_screen.dart';
import '../screens/input/category_input_screen.dart';
import '../states/category_notifier.dart';

const LOCATION_HOME = 'home';
const LOCATION_INPUT = 'input';
const LOCATION_CATEGORY_INPUT = 'category_input';
const LOCATION_ITEM = 'item';
const LOCATION_ITEM_ID = 'item_id';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey(LOCATION_HOME))];
  }

  @override
  List get pathBlueprints => ['/'];
}

class InputLocation extends BeamLocation {
  Widget builder(BuildContext context, Widget navigator) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: categoryNotifier),
      ChangeNotifierProvider(create: (context) => SelectImageNotifier())
    ], child: super.builder(context, navigator));
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains(LOCATION_INPUT))
        BeamPage(key: ValueKey(LOCATION_INPUT), child: InputScreen()),
      if (state.pathBlueprintSegments.contains(LOCATION_CATEGORY_INPUT))
        BeamPage(
            key: ValueKey(LOCATION_CATEGORY_INPUT),
            child: CategoryInputScreen())
    ];
  }

  @override
  List get pathBlueprints =>
      ['/$LOCATION_INPUT', '/$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT'];
}

class ItemLocation extends BeamLocation {
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathParameters.containsKey(LOCATION_ITEM_ID))
        BeamPage(
            key: ValueKey(LOCATION_ITEM_ID),
            child:
                ItemDetailScreen(state.pathParameters[LOCATION_ITEM_ID] ?? "")),
    ];
  }

  @override
  List get pathBlueprints => ['/$LOCATION_ITEM/:$LOCATION_ITEM_ID'];
}
