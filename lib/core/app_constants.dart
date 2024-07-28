import 'package:iconsax/iconsax.dart';

class AppConstants {
  static List<Map<String, dynamic>> appInfoList = [
    {'icon': Iconsax.user, 'label': "Welcome", 'route': ''},
    {'icon': Iconsax.info_circle, 'label': "About", 'route': ''},
    {'icon': Iconsax.arrow_right_1, 'label': "Next step", 'route': ''},
    {'icon': Iconsax.message_question, 'label': "FAQ's", 'route': ''},
  ];

  static List<String> categoryList = [
    'All',
    'Tablet',
    'Capsule',
    'Suppository',
    'Eyedrop'
  ];
}
