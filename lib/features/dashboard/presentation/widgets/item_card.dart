import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../dashboard/domain/models/item_model.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final bool isDesktop;

  const ItemCard({super.key, required this.item, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    // Card dimensions based on design specifications
    final double cardWidth = 243.25.w; // Exact width as specified
    final double cardHeight = 322.h;
    final double imageHeight = cardHeight * 0.57; // 57% of card height
    final double contentHeight = cardHeight * 0.57; // 57% of card height
    final Color cardColor = Colors.black;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          // Image with gradient overlay
          _buildImageSection(imageHeight),

          // Content section (overlaps with image)
          Positioned(
            bottom: 0,
            child: _buildContentSection(contentHeight, cardWidth),
          ),

          // Options menu (three dots)
          Positioned(top: 12.h, right: 12.w, child: _buildOptionsMenu()),

          // Status badge
          Positioned(
            top: imageHeight - 24.h, // Position it to overlap the image
            left: 16.w,
            child: _buildStatusBadge(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),

        image: DecorationImage(
          image: AssetImage(item.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF999999), // Specific color as per requirements
          ],
          stops: const [0.6, 1.0], // Stop at 40% from bottom
        ),
      ),
    );
  }

  Widget _buildContentSection(double height, double width) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.black, // Content section background
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Space for the status badge
          SizedBox(height: 24.h),

          // Title
          Text(
            item.title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 8.h),

          // Date
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14.sp,
                color: Colors.white70,
              ),
              SizedBox(width: 4.w),
              Text(
                _formatDateRange(item.startDate, item.endDate),
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),

          const Spacer(),

          // User avatars and task count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User avatars
              _buildUserAvatars(),

              // Task count
              Text(
                '${item.unfinishedTasks} unfinished tasks',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsMenu() {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(153), // 0.6 opacity
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.more_horiz, color: Colors.white, size: 16.sp),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(179), // 0.7 opacity
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppTheme.primaryOrange.withAlpha(128), // 0.5 opacity
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.status,
            style: GoogleFonts.inter(
              color: AppTheme.primaryOrange,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.primaryOrange,
            size: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatars() {
    // Limit the number of avatars to display
    final int maxAvatars = 3;
    final int remainingCount =
        item.assignedUserAvatars.length > maxAvatars
            ? item.assignedUserAvatars.length - maxAvatars
            : 0;

    return Row(
      children: [
        // Display avatars
        for (
          int i = 0;
          i < item.assignedUserAvatars.length && i < maxAvatars;
          i++
        )
          Align(
            widthFactor: 0.7,
            child: CircleAvatar(
              radius: 12.r,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(item.assignedUserAvatars[i]),
            ),
          ),

        // Display remaining count if any
        if (remainingCount > 0)
          Align(
            widthFactor: 0.7,
            child: CircleAvatar(
              radius: 12.r,
              backgroundColor: Colors.grey,
              child: Text(
                '+$remainingCount',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatDateRange(DateTime start, DateTime end) {
    final DateFormat formatter = DateFormat('MMM d');
    return '${formatter.format(start)} - ${formatter.format(end)}, ${end.year}';
  }
}
