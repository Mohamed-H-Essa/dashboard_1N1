import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/themes/app_theme.dart';
import '../bloc/navigation_bloc.dart';
import '../bloc/navigation_event.dart';
import '../bloc/navigation_state.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDesktop;

  const CustomNavbar({super.key, required this.isDesktop});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: AppTheme.navbarBackground,
      child:
          isDesktop
              ? _buildDesktopNavbar(context)
              : _buildMobileNavbar(context),
    );
  }

  Widget _buildMobileNavbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w),
      child: Row(
        children: [
          // Hamburger menu
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),

          // Logo (now positioned to the left)
          _buildLogo(),

          // Spacer to push the right side icons to the right
          const Spacer(),

          // Right side icons
          Row(
            children: [
              // Settings icon
              IconButton(
                icon: Image.asset(
                  'assets/images/gear_icon.png',
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),

              // Notification bell
              IconButton(
                icon: Image.asset(
                  'assets/images/noti_icon.png',
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),

              // Divider
              const SizedBox(width: 8),
              const VerticalDivider(
                color: Colors.white24,
                thickness: 1,
                indent: 15,
                endIndent: 15,
              ),
              const SizedBox(width: 8),

              // User profile picture
              _buildUserAvatar(small: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavbar(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w),
      child: Row(
        children: [
          // Logo
          _buildLogo(small: true),

          // Spacer
          const Spacer(),

          // Navigation items
          BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(AppConstants.navItems.length, (index) {
                  final item = AppConstants.navItems[index];
                  final isSelected = state.currentPageIndex == index;

                  return _buildNavItem(
                    context: context,
                    item: item,
                    index: index,
                    isSelected: isSelected,
                    navigationBloc: navigationBloc,
                  );
                }),
              );
            },
          ),

          const VerticalDivider(
            color: Colors.white24,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),

          // Settings icon
          IconButton(
            icon: Image.asset(
              'assets/images/gear_icon.png',
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            onPressed: () {},
          ),

          // Notification bell
          IconButton(
            icon: Image.asset(
              'assets/images/noti_icon.png',
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            onPressed: () {},
          ),

          // Divider
          const SizedBox(width: 8),
          const VerticalDivider(
            color: Colors.white24,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          const SizedBox(width: 8),

          // User profile with name
          Row(
            children: [
              _buildUserAvatar(),
              const SizedBox(width: 8),
              Text(
                AppConstants.userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFFFFFFFF),
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required NavItem item,
    required int index,
    required bool isSelected,
    required NavigationBloc navigationBloc,
  }) {
    return InkWell(
      onTap: () {
        navigationBloc.add(NavigateToPageEvent(index));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppTheme.primaryOrange : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          item.title,
          style: TextStyle(
            color:
                isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF999999),
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLogo({bool small = false}) {
    return Image.asset(
      'assets/images/logo.png',
      height: small ? 30 : 40, // Logo height from Figma: 40
      width: small ? 62 : 82, // Logo width from Figma: 82
      fit: BoxFit.contain,
    );
  }

  Widget _buildUserAvatar({bool small = false}) {
    return CircleAvatar(
      radius: small ? 16 : 16,
      // backgroundColor: Colors.grey[300],
      backgroundImage: AssetImage('assets/images/person_random1n1.png'),
      // child: const Icon(Icons.person, color: Colors.grey),
    );
  }
}

// Mobile drawer for navigation
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Drawer(
      child: Container(
        color: AppTheme.navbarBackground,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppTheme.navbarBackground),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppConstants.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppConstants.userRole,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: AppConstants.navItems.length,
                    itemBuilder: (context, index) {
                      final item = AppConstants.navItems[index];
                      final isSelected = state.currentPageIndex == index;

                      return ListTile(
                        leading: Icon(
                          _getIconData(item.icon),
                          color:
                              isSelected
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFF999999),
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            color:
                                isSelected
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFF999999),
                            fontWeight:
                                isSelected
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          navigationBloc.add(NavigateToPageEvent(index));
                          Navigator.pop(context);
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
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'inventory':
        return Icons.inventory;
      case 'attach_money':
        return Icons.attach_money;
      case 'info':
        return Icons.info;
      case 'task':
        return Icons.task;
      case 'analytics':
        return Icons.analytics;
      default:
        return Icons.circle;
    }
  }
}
