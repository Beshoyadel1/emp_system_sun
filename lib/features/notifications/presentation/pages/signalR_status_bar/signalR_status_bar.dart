import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../features/notifications/data/datasource/signalr_datasource/signalr_connection/signalr_connection.dart';
import '../../../../../../features/notifications/data/datasource/signalr_datasource/signalr_service/signalr_service.dart';

class SignalRStatusBar extends StatelessWidget {
  const SignalRStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: SignalRConnection.instance.connectionState,
      builder: (context, state, child) {
        Color color;
        String text;

        switch (state) {
          case HubConnectionState.connected:
            color = AppColors.greenColor;
            text = AppLanguageKeys.notificationConnected;
            break;

          case HubConnectionState.reconnecting:
            color = AppColors.orangeColor;
            text = AppLanguageKeys.notificationReconnecting;
            break;

          case HubConnectionState.connecting:
            color = AppColors.blueColor;
            text = AppLanguageKeys.notificationConnecting;
            break;

          default:
            color = Colors.red;
            text = AppLanguageKeys.notificationDisconnectedTapToReconnect;
        }

        return InkWell(
          onTap: state == HubConnectionState.disconnected
              ? () async {
            try {
              await SignalRService.instance.reconnect();
            } catch (e) {
              debugPrint("Reconnect Error => $e");
            }
          }
              : null,
          child: Container(
            height: 35,
            width: double.infinity,
            alignment: Alignment.center,
            color: color,
            child: TextInAppWidget(
              text: text,
              textSize: 15,
              textColor: AppColors.whiteColor,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            ),
          ),
        );
      },
    );
  }
}