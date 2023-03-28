import 'package:furniture_app/constants/images.dart';

List<IconModel> iconsList = [
  IconModel(icon: ICONS.all),
  IconModel(icon: ICONS.office),
  IconModel(icon: ICONS.livingRoom),
  IconModel(icon: ICONS.kitchen),
  IconModel(icon: ICONS.bedroom),
  IconModel(icon: ICONS.dining),
  IconModel(icon: ICONS.kids),
];

class IconModel {
  String? icon;
  IconModel({required this.icon});
}
