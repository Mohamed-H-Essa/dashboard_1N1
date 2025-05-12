import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/utils/image_utils.dart';
import '../../domain/models/item_model.dart';
import 'package:intl/intl.dart';

class ItemCardBackup extends StatelessWidget {
  final ItemModel item;
  final bool isDesktop;

  const ItemCardBackup({Key? key, required this.item, this.isDesktop = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0.r),
      color: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0.r),
        child: Container(
          width: 244.w, // Card width from Figma: 244
          height: 322.h, // Card height from Figma: 322
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(51), // 0.2 * 255 = 51
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Image with gradient overlay
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 182.h,
                        child: Stack(
                          children: [
                            // Base image
                            Positioned.fill(
                              child: Image.asset(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Use our utility to generate a colored placeholder
                                  return ImageUtils.generateColoredPlaceholder(
                                    item.imageUrl,
                                  );
                                },
                              ),
                            ),
                            // Gradient overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      const Color(0xFF999999),
                                    ],
                                    stops: const [
                                      0.6,
                                      1.0,
                                    ], // Stop at 40% from bottom (0.6 from top)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: (1.2).h),
                    ],
                  ),

                  // Status badge
                  Positioned(
                    bottom: 0,
                    left: 16.w, // Add left padding
                    child: _buildStatusBadge(),
                  ),

                  // More options button
                  Positioned(
                    top: 16.h,
                    right: 16.w,
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(
                          153,
                        ), // 0.6 * 255 = 153, 60% opacity
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(77), // 0.3 * 255 = 77
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: const Color(0xFFFFFFFF), // Pure white dots
                          size: 20.sp,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // Show options menu
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // Content section
              Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFFFF),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 8.h),

                    // Date range
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16.sp,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatDateRange(item.startDate, item.endDate),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Footer with avatars and task count
                    Row(
                      children: [
                        // Avatars
                        _buildAvatarStack(),

                        const Spacer(),

                        // Task count
                        Text(
                          '${item.unfinishedTasks} unfinished tasks',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      margin: EdgeInsets.only(
        // bottom: 16.h,
      ), // Add margin to lift it from the bottom edge
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(179), // 0.7 * 255 = 179
        borderRadius: BorderRadius.circular(30.r), // More rounded corners
        border: Border.all(
          color:
              AppTheme.primaryOrange, // Solid orange border like in the image
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77), // 0.3 * 255 = 77
            blurRadius: 8.r,
            spreadRadius: 1.r,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.status,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp, // Slightly larger text
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18.sp),
        ],
      ),
    );
  }

  Widget _buildAvatarStack() {
    final double avatarSize = 24.r;
    final double avatarOverlap = 8.r;

    return SizedBox(
      height: avatarSize,
      width:
          (avatarSize - avatarOverlap) * item.assignedUserAvatars.length +
          avatarOverlap,
      child: Stack(
        children: [
          for (int i = 0; i < item.assignedUserAvatars.length && i < 2; i++)
            Positioned(
              left: i * (avatarSize - avatarOverlap),
              child: CircleAvatar(
                radius: avatarSize / 2,
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(item.assignedUserAvatars[i]),
                onBackgroundImageError: (exception, stackTrace) {
                  // Fallback if image fails to load
                  return;
                },
              ),
            ),
          if (item.assignedUserAvatars.length > 2)
            Positioned(
              left: 2 * (avatarSize - avatarOverlap),
              child: CircleAvatar(
                radius: avatarSize / 2,
                backgroundColor: Colors.grey[700],
                child: Text(
                  '+${item.assignedUserAvatars.length - 2}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDateRange(DateTime start, DateTime end) {
    final DateFormat formatter = DateFormat('MMM d, yyyy');
    return '${formatter.format(start)} - ${formatter.format(end)}';
  }
}
