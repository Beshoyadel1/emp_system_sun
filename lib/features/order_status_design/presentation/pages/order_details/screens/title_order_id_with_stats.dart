import 'package:flutter/cupertino.dart';
import '../../../../../../../../features/order_status_design/presentation/custom_widget/title_order_id_with_stats_widget.dart';

class TitleOrderIdWithStats extends StatelessWidget {
  final int status;
  final String id;
  const TitleOrderIdWithStats({super.key,required this.status,required this.id});

  @override
  Widget build(BuildContext context) {
    return TitleOrderIdWithStatsWidget(
      status: status,
      id:id,
    );
  }
}