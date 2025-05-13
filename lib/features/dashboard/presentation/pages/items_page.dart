import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../core/themes/app_theme.dart';
import '../bloc/items/items_bloc.dart';
import '../bloc/items/items_event.dart';
import '../bloc/items/items_state.dart';
import '../widgets/item_card.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if we're on mobile or desktop
    final bool isDesktop = ResponsiveBreakpoints.of(context).largerThan(MOBILE);

    return BlocProvider(
      create: (context) => ItemsBloc()..add(const LoadItemsEvent()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 80.w, // 80px margin on each side as specified
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and actions
              _buildHeader(context, isDesktop),

              SizedBox(height: 16.h),

              // Items grid
              Expanded(
                child: BlocBuilder<ItemsBloc, ItemsState>(
                  builder: (context, state) {
                    if (state is ItemsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryOrange,
                        ),
                      );
                    } else if (state is ItemsLoaded) {
                      return _buildItemsGrid(context, state.items, isDesktop);
                    } else if (state is ItemsError) {
                      return Center(
                        child: Text(
                          'Error: ${state.message}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title
        Text(
          'Items',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Actions
        Row(
          children: [
            // Filter button
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: AppTheme.cardColor,
              ),
              // Using tune.png from assets
              child: Image.asset(
                'assets/images/tune.png',
                width: 30,
                height: 30,
                color: Colors.white,
              ),
            ),

            if (isDesktop) SizedBox(width: 16.w),
            if (isDesktop)
              VerticalDivider(
                color: Colors.white,
                thickness: 9,
                indent: 15,
                endIndent: 15,
              ),
            if (isDesktop) SizedBox(width: 16.w),

            // Add new item button - only visible on desktop
            if (isDesktop)
              ElevatedButton.icon(
                icon: Icon(Icons.add, size: 16),
                label: Text('Add a New Item', style: TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.orangeYellow,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(300),
                  ),
                ),
                onPressed: () {
                  context.read<ItemsBloc>().add(const AddItemEvent());
                },
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemsGrid(BuildContext context, List items, bool isDesktop) {
    // Determine number of columns based on screen size
    int crossAxisCount;
    double horizontalSpacing = 16.w; // 16px horizontal spacing between cards
    double verticalSpacing = 20.h; // 20px vertical spacing between cards

    double webAspectRatio = 243.25 / 322;
    double mobileAspectRatio = 343 / 314;

    // Calculate crossAxisCount based on screen width
    // At 1440px design width, we want 5 cards
    // if (ResponsiveBreakpoints.of(context).screenWidth >= 1440.w) {
    double aspectRatio = 1;
    if (ResponsiveBreakpoints.of(context).largerThan(DESKTOP)) {
      crossAxisCount = 5; // XL screens
      aspectRatio = webAspectRatio;
    } else if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
      aspectRatio = (mobileAspectRatio + 2 * webAspectRatio) / 3;
      crossAxisCount = 4; // Desktop
    } else if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      aspectRatio = (mobileAspectRatio + 2 * webAspectRatio) / 3;
      crossAxisCount = 3; // Tablet
    } else {
      crossAxisCount = 1; // Mobile
      aspectRatio = mobileAspectRatio;
    }

    // Use the aspect ratio defined in the ItemCard class
    // This ensures consistency between the grid and the card

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: horizontalSpacing,
        mainAxisSpacing: verticalSpacing,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemCard(
          item: items[index],
          isDesktop: isDesktop,
          aspectRatio: aspectRatio,
        );
      },
    );
  }
}
