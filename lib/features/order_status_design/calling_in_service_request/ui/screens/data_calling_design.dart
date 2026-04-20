import 'package:flutter/cupertino.dart';
import '../../../../../../../features/order_status_design/calling_in_service_request/ui/screens/container_call_in_data_calling_design.dart';
import '../../../../../../../features/order_status_design/calling_in_service_request/ui/screens/row_mute_sound_data_calling_design.dart';

class DataCallingDesign extends StatelessWidget {
  const DataCallingDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ContainerCallInDataCallingDesign(),
        RowMuteSoundDataCallingDesign()
      ],
    );
  }
}
