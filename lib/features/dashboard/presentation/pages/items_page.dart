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
  const ItemsPage({Key? key}) : super(key: key);

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
            horizontal: 80.w,
            vertical: 16.h,
          ), // Horizontal padding from Figma: 80
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
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Actions
        Row(
          children: [
            // Filter button
            IconButton(
              icon: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.filter_list,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              onPressed: () {
                context.read<ItemsBloc>().add(const FilterItemsEvent());
              },
            ),

            SizedBox(width: 16.w),

            // Add new item button
            ElevatedButton.icon(
              icon: Icon(Icons.add, size: 16.sp),
              label: Text('Add a New Item', style: TextStyle(fontSize: 14.sp)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
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
    if (ResponsiveBreakpoints.of(context).largerThan(DESKTOP)) {
      crossAxisCount = 4; // XL screens
    } else if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
      crossAxisCount = 3; // Desktop
    } else if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      crossAxisCount = 2; // Tablet
    } else {
      crossAxisCount = 1; // Mobile
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 244 / 322, // Card dimensions from Figma: 244 x 322
        crossAxisSpacing: 24.w,
        mainAxisSpacing: 24.h,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemCard(item: items[index], isDesktop: isDesktop);
      },
    );
  }
}
