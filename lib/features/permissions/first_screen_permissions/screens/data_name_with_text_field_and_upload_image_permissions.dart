import 'package:flutter/cupertino.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/mobile_of_data_container_in_list_data_first_screen_permissions.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/web_of_data_container_in_list_data_first_screen_permissions.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';

class DataNameWithTextFieldAndUploadImagePermissions extends StatelessWidget {
  const DataNameWithTextFieldAndUploadImagePermissions({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return isMobile
        ? MobileOfDataContainerInListDataFirstScreenPermissions()
        : WebOfDataContainerInListDataFirstScreenPermissions();
  }
}
