import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/navigation_bloc.dart';
import '../bloc/navigation_state.dart';
import '../widgets/custom_navbar.dart';
import 'items_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomNavbar(isDesktop: isDesktop),
      drawer: isDesktop ? null : const CustomDrawer(),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return _buildPageContent(state.currentPageIndex);
        },
      ),
    );
  }

  Widget _buildPageContent(int index) {
    // Return the appropriate page based on the navigation index
    switch (index) {
      case 0: // Items page
        return const ItemsPage();
      default:
        // For other pages, show a placeholder
        final item = AppConstants.navItems[index];
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_getIconData(item.icon), size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This page is under construction',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        );
    }
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
