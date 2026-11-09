import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/core/theming/fonts.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';

import '../../../../../../../features/order_status_design/presentation/cubit/order_status_cubit/order_status_cubit.dart';
import '../../../../../../../features/order_status_design/presentation/custom_widget/show_order_status_confirmation_dialog.dart';
import 'assign_order_dialog.dart';

class OrderStatusActionsWidget extends StatefulWidget {
  final int? status;
  final int orderId;
  final double? textSize;
  final int? providerId;
  final int? branchId;
  final List<int> serviceIds;
  final List<int> serviceScopeIds;

  const OrderStatusActionsWidget({
    super.key,
    required this.status,
    required this.orderId,
    this.textSize,
    this.providerId,
    this.branchId,
    this.serviceIds = const [],
    this.serviceScopeIds = const [],
  });

  @override
  State<OrderStatusActionsWidget> createState() =>
      _OrderStatusActionsWidgetState();
}

class _OrderStatusActionsWidgetState extends State<OrderStatusActionsWidget> {
  bool _canManageOrders = false;
  bool _canProgressOrder = false;
  bool _isLoadingPermissions = true;

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  @override
  void didUpdateWidget(covariant OrderStatusActionsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.serviceIds, widget.serviceIds) ||
        !listEquals(oldWidget.serviceScopeIds, widget.serviceScopeIds)) {
      _loadPermissions();
    }
  }

  Future<void> _loadPermissions() async {
    final user = await AuthLocalStorage.getUser();
    final permissions = user?.employeeDetails?.permissions;
    final ownsOrder = user?.type == UserType.providerUser &&
        widget.providerId != null &&
        (widget.providerId == user?.providerDetails?.id ||
            widget.providerId == user?.providerDetails?.provid);
    final employeeServices = user?.employeeDetails?.serviceIds ?? const <int>[];
    final scopedServices = widget.serviceScopeIds.isEmpty
        ? widget.serviceIds
        : widget.serviceScopeIds;
    final worksOnOrder = scopedServices.any(employeeServices.contains);
    final canAccessOrder = ownsOrder ||
        permissions?.acceptAllOrders == true ||
        worksOnOrder;

    if (!mounted) return;

    setState(() {
      _canManageOrders = ownsOrder ||
          (canAccessOrder &&
              permissions?.acceptAndRefuseAndAssignOrders == true);
      _canProgressOrder = canAccessOrder;
      _isLoadingPermissions = false;
    });
  }

  bool get _isNewOrder =>
      widget.status == OrderStatus.newOrderForProvider ||
      widget.status == OrderStatus.newOrderForCompany;

  bool get _isWaitingAppointment =>
      widget.status == OrderStatus.waitingAppointment;

  bool get _isEmployeeInRoad => widget.status == OrderStatus.employeeInRoad;

  bool get _isWorkInProgress => widget.status == OrderStatus.workInProgress;

  @override
  Widget build(BuildContext context) {
    if (_isLoadingPermissions || widget.status == null || !_canProgressOrder) {
      return const SizedBox.shrink();
    }

    if (_isNewOrder) {
      return _buildActions(
        context,
        actions: [
          if (_canManageOrders)
            const _ActionData(
              text: AppLanguageKeys.acceptOrder,
              icon: Icons.check_circle_outline,
              backgroundColor: AppColors.partGreenMixColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.greenColor,
              nextStatus: OrderStatus.waitingAppointment,
            ),
          if (_canManageOrders)
            const _ActionData(
              text: AppLanguageKeys.rejectedByProvider,
              icon: Icons.close,
              backgroundColor: AppColors.partPinkMixColor,
              color: AppColors.whiteColor,
              dialogColor: AppColors.redColor,
              nextStatus: OrderStatus.rejectedByProvider,
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

    final visibleActions = [
      ...actions,
      if (_canManageOrders &&
          (widget.providerId ?? 0) > 0 &&
          (widget.branchId ?? 0) > 0 &&
          widget.serviceIds.isNotEmpty)
        _ActionData(
          text: AppLanguageKeys.assignOrder,
          icon: Icons.person_add_alt_1,
          backgroundColor: AppColors.blueColor,
          color: AppColors.whiteColor,
          dialogColor: AppColors.blueColor,
          nextStatus: widget.status!,
          assign: true,
        ),
    ];
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: visibleActions.map(
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
        List<int>? employeeIds;
        if (action.assign) {
          employeeIds = await showDialog<List<int>>(
            context: context,
            builder: (_) => AssignOrderDialog(
              providerId: widget.providerId!,
              branchId: widget.branchId!,
              serviceIds: widget.serviceIds,
            ),
          );
          if (employeeIds == null || employeeIds.isEmpty || !context.mounted) {
            return;
          }
        }
        final bool? confirmed = await showOrderStatusConfirmationDialog(
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
              employeeIds: employeeIds,
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
              fontWeightIndex: FontSelectionData.regularFontFamily,
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
  final bool assign;

  const _ActionData({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.color,
    required this.dialogColor,
    required this.nextStatus,
    this.assign = false,
  });
}
