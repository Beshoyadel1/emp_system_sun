import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../bloc/notification_cubit/notification_cubit.dart';
import '../../bloc/notification_cubit/notification_state.dart';
import '../../../data/model/get_user_new_notification_model/get_user_new_notification_model.dart';
import '../../module/notification_module/notification_module.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<NotificationCubit>();
    cubit.getUserNotification();
    cubit.makeNotificationViewed();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final cubit = context.read<NotificationCubit>();
      if (cubit.hasMore && !cubit.isLoadingMore) {
        cubit.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final cubit = context.read<NotificationCubit>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkColor),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: TextInAppWidget(
          text: isAr ? 'الإشعارات' : 'Notifications',
          textSize: 18,
          textColor: AppColors.darkColor,
          fontWeightIndex: FontSelectionData.boldFontFamily,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.cardStroke, height: 1),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => cubit.getUserNotification(),
        color: AppColors.mainColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      final total = cubit.totalCount > 0
                          ? cubit.totalCount
                          : cubit.notifications.length;
                      return TextInAppWidget(
                        text:
                            isAr ? 'إجمالي الإشعارات: $total' : 'Total: $total',
                        textSize: 13,
                        textColor: AppColors.textSecondary,
                        fontWeightIndex: FontSelectionData.mediumFontFamily,
                      );
                    },
                  ),
                  TextButton.icon(
                    onPressed: () => cubit.getUserNotification(),
                    icon: const Icon(Icons.refresh,
                        size: 16, color: AppColors.mainColor),
                    label: TextInAppWidget(
                      text: isAr ? 'تحديث' : 'Refresh',
                      textSize: 13,
                      textColor: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    if (state is NotificationLoading &&
                        cubit.notifications.isEmpty) {
                      return const _ShimmerNotificationList();
                    }

                    if (state is NotificationError &&
                        cubit.notifications.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 48, color: AppColors.errorRedColor),
                            const SizedBox(height: 8),
                            TextInAppWidget(
                              text: state.message,
                              textSize: 15,
                              textColor: AppColors.darkColor,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                foregroundColor: AppColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () => cubit.getUserNotification(),
                              child: Text(isAr ? 'إعادة المحاولة' : 'Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (cubit.notifications.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.notifications_none_outlined,
                              size: 64,
                              color: AppColors.greyColor,
                            ),
                            const SizedBox(height: 12),
                            TextInAppWidget(
                              text: isAr
                                  ? 'لا توجد إشعارات مسجلة'
                                  : 'No notifications found',
                              textSize: 16,
                              textColor: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount:
                          cubit.notifications.length + (cubit.hasMore ? 1 : 0),
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        if (index == cubit.notifications.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: cubit.isLoadingMore
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.mainColor,
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () => cubit.loadMore(),
                                      child: Text(
                                        isAr
                                            ? 'تحميل المزيد من الإشعارات'
                                            : 'Load more notifications',
                                        style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        }

                        final item = cubit.notifications[index];
                        return _NotificationCard(
                          item: item,
                          onTap: () {
                            if (item.isChatRelated) {
                              NotificationModule.instance.navigationService
                                  .openChat();
                            } else {
                              NotificationModule.instance.navigationService
                                  .openDashboardOrders();
                            }
                          },
                        );
                      },
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

class _NotificationCard extends StatelessWidget {
  final NotificationModel item;
  final VoidCallback? onTap;

  const _NotificationCard({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final title = item.getTitle(context);
    final description = item.getDescription(context);
    final dateStr = item.getFormattedDate(context);
    final isUnread = item.isViewed == false;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isUnread
                ? AppColors.mainColor.withValues(alpha: 0.5)
                : AppColors.cardStroke,
            width: isUnread ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkColor.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isUnread
                    ? AppColors.mainColor.withValues(alpha: 0.12)
                    : AppColors.scaffoldBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_active_outlined,
                color: isUnread ? AppColors.mainColor : AppColors.greyColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
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
                          textSize: 15,
                          textColor: AppColors.darkColor,
                          fontWeightIndex: isUnread
                              ? FontSelectionData.boldFontFamily
                              : FontSelectionData.semiBoldFontFamily,
                          maxLines: 1,
                          isEllipsisTextOverflow: true,
                        ),
                      ),
                      if (dateStr.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        TextInAppWidget(
                          text: dateStr,
                          textSize: 11,
                          textColor: AppColors.greyColor,
                        ),
                      ],
                    ],
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    TextInAppWidget(
                      text: description,
                      textSize: 13,
                      textColor: AppColors.textSecondary,
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

class _ShimmerNotificationList extends StatelessWidget {
  const _ShimmerNotificationList();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGreyColor.withValues(alpha: 0.4),
      highlightColor: AppColors.whiteColor,
      child: ListView.separated(
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, __) => Container(
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
