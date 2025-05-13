import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_management_dashboard/core/utils/debug_utils.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../dashboard/domain/models/item_model.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final bool isDesktop;

  const ItemCard({
    super.key,
    required this.item,
    required this.isDesktop,
    required this.aspectRatio,
  });

  // The standard aspect ratio for the card (width / height)
  final double aspectRatio;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate dimensions based on the constraints provided by the parent
        final double cardWidth = constraints.maxWidth;
        final double cardHeight = cardWidth / aspectRatio;

        // Calculate component heights based on percentages
        final double imageHeight = cardHeight * 0.57; // 57% of card height
        final double contentHeight = cardHeight * 0.57; // 57% of card height

        return Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            // color: Colors.black, // Pure black background
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Image with gradient overlay
              _buildImageSection(imageHeight),

              // Content section (overlaps with image)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: contentHeight,
                child: _buildContentSection(contentHeight),
              ),

              // Options menu (three dots)
              Positioned(top: 12.r, right: 12.r, child: _buildOptionsMenu()),

              // Status badge
              // Positioned(
              //   top: imageHeight - 24.r, // Position it to overlap the image
              //   left: 16.r,
              //   child: _buildStatusBadge(),
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSection(double height) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: height,
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
            // Linear gradient overlay that fades from fully visible at the top
            // to #999999 at the bottom with a stop point at 40% from the bottom
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppTheme.cardColor],
              stops: [0.1, 1.0], // 0.6 represents 40% from the bottom
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection(double height) {
    return Container(
      padding: EdgeInsets.all(16),

      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Space for the status badge
          _buildStatusBadge(),

          SizedBox(height: 8),
          // Title
          Text(
            item.title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 8),

          // Date
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Colors.white70,
              ),
              SizedBox(width: 4),
              Builder(
                builder: (context) {
                  return Text(
                    _formatDateRange(item.startDate, item.endDate),
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: clampDouble(
                        MediaQuery.of(context).size.width * 0.04,
                        10,
                        12,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          // const Spacer(),
          Divider(),

          // User avatars and task count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User avatars
              _buildUserAvatars(),

              // Task count
              Text(
                '${item.unfinishedTasks} unfinished tasks',
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsMenu() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(153), // 0.6 opacity
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.more_horiz, color: Colors.white, size: 16),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color:
            AppTheme.statusBackground, // Using the new statusBackground color
        borderRadius: BorderRadius.circular(900.r),
        border: Border.all(
          color: AppTheme.statusBorder, // Using the new statusBorder color
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.status,
            style: GoogleFonts.inter(
              fontSize: 14, // Updated to match the preferred font size
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 3),
          Icon(Icons.keyboard_arrow_down, size: 16),
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
            widthFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.usersAvatarBorder, width: 1),
                // image: DecorationImage(
                //   // image: NetworkImage(item.assignedUserAvatars[i]),
                //   // image: NetworkImage('https://picsum.photos/200/300'),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: CircleAvatar(
                radius: 12,
                // backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  item.assignedUserAvatars[i]..tk421('Room111'),
                ),
                // backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              ),
            ),
          ),

        // Display remaining count if any
        if (remainingCount > 0)
          Align(
            widthFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.usersAvatarBorder, width: 2),
              ),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppTheme.usersAvatarBorder,
                child: Text(
                  '+$remainingCount',
                  style: GoogleFonts.inter(
                    color: AppTheme.orangeYellow,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatDateRange(DateTime start, DateTime end) {
    final DateFormat formatter = DateFormat('MMM d');
    return ' 4 Nights (${formatter.format(start)} - ${formatter.format(end)}, ${end.year})';
  }
}
