import 'package:flutter/cupertino.dart';
import '../../../../../../features/internal_services/internal_services_statistics/Internal_services_page/widgets/new_order_widget.dart';

class ListNewOrderWidget extends StatelessWidget {
  const ListNewOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: 7,
      separatorBuilder: (context, index) =>
      const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return NewOrderWidget(
          spacing: 25,
          onTap: () {

          },
        );
      },
    );
  }
}