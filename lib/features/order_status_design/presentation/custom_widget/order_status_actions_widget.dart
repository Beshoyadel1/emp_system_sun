import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/core/theming/fonts.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';

import '../../../../../../../features/order_status_design/presentation/cubit/order_status_cubit/order_status_cubit.dart';
import '../../../../../../../features/order_status_design/presentation/custom_widget/show_order_status_confirmation_dialog.dart';

class OrderStatusActionsWidget extends StatefulWidget {
  final int? status;
  final int orderId;
  final double? textSize;

  const OrderStatusActionsWidget({
    super.key,
    required this.status,
    required this.orderId,
    this.textSize,
  });

  @override
  State<OrderStatusActionsWidget> createState() =>
      _OrderStatusActionsWidgetState();
}

class _OrderStatusActionsWidgetState
    extends State<OrderStatusActionsWidget> {
  bool _acceptAllOrders = false;
  bool _changeOrderStatus = false;
  bool _isLoadingPermissions = true;

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    final user = await AuthLocalStorage.getUser();
    final permissions = user?.employeeDetails?.permissions;

    if (!mounted) return;

    setState(() {
      _acceptAllOrders = permissions?.acceptAllOrders == true;
      _changeOrderStatus = permissions?.changeOrderStatus == true;
      _isLoadingPermissions = false;
    });
  }

  bool get _isNewOrder =>
      widget.status == OrderStatus.newOrderForProvider ||
          widget.status == OrderStatus.newOrderForCompany;

  bool get _isWaitingAppointment =>
      widget.status == OrderStatus.waitingAppointment;

  bool get _isEmployeeInRoad =>
      widget.status == OrderStatus.employeeInRoad;

  bool get _isWorkInProgress =>
      widget.status == OrderStatus.workInProgress;

  @override
  Widget build(BuildContext context) {
    if (_isLoadingPermissions || widget.status == null) {
      return const SizedBox.shrink();
    }

    if (_changeOrderStatus) {
      if (_isNewOrder) {
        return _buildActions(
          context,
          actions: const [
            _ActionData(
              text: AppLanguageKeys.acceptOrder,
              icon: Icons.check_circle_outline,
              backgroundColor: AppColors.partGreenMixColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.greenColor,
              nextStatus: OrderStatus.waitingAppointment,
            ),
            _ActionData(
              text: AppLanguageKeys.rejectedByProvider,
              icon: Icons.close,
              backgroundColor: AppColors.partPinkMixColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.redColor,
              nextStatus: OrderStatus.rejectedByProvider,
            ),
            _ActionData(
              text: AppLanguageKeys.cancelledByUser,
              icon: Icons.cancel_outlined,
              backgroundColor: AppColors.blackColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.darkColor,
              nextStatus: OrderStatus.cancelledByUser,
            ),
          ],
        );
      }

      if (_isWaitingAppointment) {
        return _buildActions(
          context,
          actions: const [
            _ActionData(
              text: AppLanguageKeys.employeeInRound,
              icon: Icons.airport_shuttle_outlined,
              backgroundColor: AppColors.blueColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.blueColor,
              nextStatus: OrderStatus.employeeInRoad,
            ),
            _ActionData(
              text: AppLanguageKeys.cancelledByUser,
              icon: Icons.cancel_outlined,
              backgroundColor: AppColors.blackColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.darkColor,
              nextStatus: OrderStatus.cancelledByUser,
            ),
          ],
        );
      }

      if (_isEmployeeInRoad) {
        return _buildActions(
          context,
          actions: const [
            _ActionData(
              text: AppLanguageKeys.workInProgress,
              icon: Icons.settings_outlined,
              backgroundColor: AppColors.orangeColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.orangeColor,
              nextStatus: OrderStatus.workInProgress,
            ),
            _ActionData(
              text: AppLanguageKeys.cancelledByUser,
              icon: Icons.cancel_outlined,
              backgroundColor: AppColors.blackColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.darkColor,
              nextStatus: OrderStatus.cancelledByUser,
            ),
          ],
        );
      }

      if (_isWorkInProgress) {
        return _buildActions(
          context,
          actions: const [
            _ActionData(
              text: AppLanguageKeys.orderCompleted,
              icon: Icons.done_all,
              backgroundColor: AppColors.greenColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.greenColor,
              nextStatus: OrderStatus.orderCompleted,
            ),
            _ActionData(
              text: AppLanguageKeys.cancelledByUser,
              icon: Icons.cancel_outlined,
              backgroundColor: AppColors.blackColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.darkColor,
              nextStatus: OrderStatus.cancelledByUser,
            ),
          ],
        );
      }

      return const SizedBox.shrink();
    }

    if (_acceptAllOrders && _isNewOrder) {
      return _buildActions(
        context,
        actions: const [
          _ActionData(
            text: AppLanguageKeys.acceptOrder,
            icon: Icons.check_circle_outline,
            backgroundColor: AppColors.partGreenMixColor,
            color: AppColors.whiteColor,
            dialogColor: AppColors.greenColor,
            nextStatus: OrderStatus.waitingAppointment,
          ),
          _ActionData(
            text: AppLanguageKeys.rejectedByProvider,
            icon: Icons.close,
            backgroundColor: AppColors.partPinkMixColor,
            color: AppColors.whiteColor,
            dialogColor: AppColors.redColor,
            nextStatus: OrderStatus.rejectedByProvider,
          ),
          _ActionData(
            text: AppLanguageKeys.cancelledByUser,
            icon: Icons.cancel_outlined,
            backgroundColor: AppColors.blackColor,
            color: AppColors.whiteColor,
            dialogColor: AppColors.darkColor,
            nextStatus: OrderStatus.cancelledByUser,
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildActions(
      BuildContext context, {
        required List<_ActionData> actions,
      }) {
    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 20,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: actions.map(
            (action) {
          return _buildActionButton(
            context,
            action: action,
          );
        },
      ).toList(),
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
        required _ActionData action,
      }) {
    return InkWell(
      onTap: () async {
        final bool? confirmed =
        await showOrderStatusConfirmationDialog(
          context,
          actionText: action.text,
          actionColor: action.dialogColor,
        );

        if (confirmed != true) {
          return;
        }

        if (!context.mounted) {
          return;
        }

        context.read<OrderStatusCubit>().updateOrderStatus(
          orderId: widget.orderId,
          status: action.nextStatus,
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: action.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: action.color,
          ),
        ),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Icon(
              action.icon,
              size: 12,
              color: action.color,
            ),
            TextInAppWidget(
              text: action.text,
              textSize: widget.textSize ?? 15,
              fontWeightIndex:
              FontSelectionData.regularFontFamily,
              textColor: action.color,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionData {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color color;
  final Color dialogColor;
  final int nextStatus;

  const _ActionData({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.color,
    required this.dialogColor,
    required this.nextStatus,
  });
}