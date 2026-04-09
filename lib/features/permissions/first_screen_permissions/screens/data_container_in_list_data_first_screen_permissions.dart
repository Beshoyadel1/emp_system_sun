import 'package:flutter/cupertino.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/permissions_and_services_provided_to_the_user_text.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/select_permissions_and_services_provided_to_the_user_with_image.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/part_user_select_permissions.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/user_permissions_settings_text_container.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/data_name_with_text_field_and_upload_image_permissions.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/title_with_sub_title_add_new_user.dart';

class DataContainerInListDataFirstScreenPermissions extends StatelessWidget {
  const DataContainerInListDataFirstScreenPermissions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleWithSubTitleAddNewUser(),
          DataNameWithTextFieldAndUploadImagePermissions(),
          UserPermissionsSettingsTextContainer(),
          PartUserSelectPermissions(),
          PermissionsAndServicesProvidedToTheUserText(),
          SelectPermissionsAndServicesProvidedToTheUserWithImage()
        ],
      ),
    );
  }
}
