import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../bloc/notification_cubit/notification_cubit.dart';
import '../../bloc/notification_cubit/notification_state.dart';
import '../../../data/model/get_user_new_notification_model/get_user_new_notification_model.dart';
import '../../module/notification_module/notification_module.dart';
import '../notifications_page/notifications_page.dart';

/// Notification icon with badge and dropdown overlay.
class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<NotificationCubit>().getUserNotification();
      }
    });
  }

  @override
  void dispose() {
    _closeOverlay();
    super.dispose();
  }

  void _closeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      if (mounted) {
        context.read<NotificationCubit>().makeNotificationViewed();
      }
    }
  }

  void _toggleOverlay() {
    if (_overlayEntry != null) {
      _closeOverlay();
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      context.read<NotificationCubit>().getUserNotification();
    }
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final Offset globalPos = renderBox != null && renderBox.hasSize
        ? renderBox.localToGlobal(Offset.zero)
        : Offset.zero;
    final Size bellSize = renderBox != null && renderBox.hasSize
        ? renderBox.size
        : const Size(46, 46);

    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final bool isRtl = Localizations.localeOf(context).languageCode == 'ar';

    final bool isOnLeftHalf = renderBox != null && renderBox.hasSize
        ? (globalPos.dx + bellSize.width / 2) < (screenWidth / 2)
        : isRtl;

    final double dropdownWidth = (screenWidth - 32).clamp(280.0, 360.0);

    return OverlayEntry(
      builder: (overlayContext) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeOverlay,
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor:
                isOnLeftHalf ? Alignment.bottomLeft : Alignment.bottomRight,
            followerAnchor:
                isOnLeftHalf ? Alignment.topLeft : Alignment.topRight,
            offset: Offset(isOnLeftHalf ? -6 : 6, 8),
            child: Align(
              alignment: isOnLeftHalf ? Alignment.topLeft : Alignment.topRight,
              child: SizedBox(
                width: dropdownWidth,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteColor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.greyColor.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: _NotificationDropdownContent(
                      onClose: _closeOverlay,
                      notificationCubit: context.read<NotificationCubit>(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleOverlay,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_outlined,
                size: 28,
                color: AppColors.darkColor,
              ),
              PositionedDirectional(
                top: -2,
                end: -2,
                child: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    final cubit = context.read<NotificationCubit>();
                    final int unreadCount = cubit.unreadCount;

                    if (unreadCount == 0) return const SizedBox.shrink();

                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.errorRedColor,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Center(
                        child: Text(
                          unreadCount > 9 ? '9+' : '$unreadCount',
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationDropdownContent extends StatelessWidget {
  final VoidCallback onClose;
  final NotificationCubit notificationCubit;

  const _NotificationDropdownContent({
    required this.onClose,
    required this.notificationCubit,
  });

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextInAppWidget(
                  text: isAr ? 'الإشعارات الأخيرة' : 'Recent Notifications',
                  textSize: 15,
                  textColor: AppColors.darkColor,
                  fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                  isEllipsisTextOverflow: true,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close,
                    size: 18, color: AppColors.greyColor),
                onPressed: onClose,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: BlocBuilder<NotificationCubit, NotificationState>(
              bloc: notificationCubit,
              builder: (context, state) {
                if (state is NotificationLoading &&
                    notificationCubit.notifications.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                        strokeWidth: 2.5,
                      ),
                    ),
                  );
                }

                if (state is NotificationError &&
                    notificationCubit.notifications.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 32, color: AppColors.errorRedColor),
                        const SizedBox(height: 8),
                        TextInAppWidget(
                          text: isAr
                              ? 'حدث خطأ أثناء تحميل الإشعارات'
                              : 'Failed to load notifications',
                          textSize: 13,
                          textColor: AppColors.errorRedColor,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () =>
                              notificationCubit.getUserNotification(),
                          child: TextInAppWidget(
                            text: isAr ? 'إعادة المحاولة' : 'Retry',
                            textSize: 12,
                            textColor: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final displayList =
                    notificationCubit.notifications.take(5).toList();

                if (displayList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.notifications_none,
                            size: 40, color: AppColors.greyColor),
                        const SizedBox(height: 8),
                        TextInAppWidget(
                          text: isAr
                              ? 'لا توجد إشعارات حالياً'
                              : 'No notifications',
                          textSize: 13,
                          textColor: AppColors.greyColor,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: displayList.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = displayList[index];
                    return _DropdownItem(
                      item: item,
                      onTap: () {
                        onClose();
                        if (item.isChatRelated) {
                          NotificationModule.instance.navigationService.openChat();
                        } else {
                          NotificationModule.instance.navigationService.openDashboardOrders();
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
        InkWell(
          onTap: () {
            onClose();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsPage(),
              ),
            );
          },
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child: TextInAppWidget(
                text: isAr ? 'عرض الكل' : 'Display All',
                textSize: 14,
                textColor: AppColors.mainColor,
                fontWeightIndex: FontSelectionData.semiBoldFontFamily,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownItem extends StatelessWidget {
  final NotificationModel item;
  final VoidCallback? onTap;

  const _DropdownItem({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final title = item.getTitle(context);
    final description = item.getDescription(context);

    String timeStr = '';
    if (item.date != null) {
      try {
        timeStr = DateFormat('MM-dd HH:mm').format(item.date!);
      } catch (_) {
        timeStr = '';
      }
    }

    final isUnread = item.isViewed == false;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: isUnread
            ? AppColors.mainColor.withValues(alpha: 0.04)
            : AppColors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: CircleAvatar(
                radius: 4,
                backgroundColor:
                    isUnread ? AppColors.mainColor : AppColors.transparent,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextInAppWidget(
                          text: title,
                          textSize: 13,
                          textColor: AppColors.darkColor,
                          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                          isEllipsisTextOverflow: true,
                          maxLines: 1,
                        ),
                      ),
                      if (timeStr.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        TextInAppWidget(
                          text: timeStr,
                          textSize: 10,
                          textColor: AppColors.greyColor,
                        ),
                      ],
                    ],
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    TextInAppWidget(
                      text: description,
                      textSize: 11,
                      textColor: AppColors.darkColor.withValues(alpha: 0.7),
                      isEllipsisTextOverflow: true,
                      maxLines: 2,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
