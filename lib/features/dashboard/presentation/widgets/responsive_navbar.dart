import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/navigation_bloc.dart';
import '../bloc/navigation_event.dart';

class ResponsiveNavbar extends StatelessWidget {
  final bool isDrawer;
  
  const ResponsiveNavbar({
    Key? key,
    this.isDrawer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDrawer ? _buildDrawer(context) : _buildSidebar(context);
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: _buildNavItems(context),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).drawerTheme.backgroundColor,
      child: _buildNavItems(context),
    );
  }

  Widget _buildNavItems(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    
    return Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: const Center(
            child: Text(
              AppConstants.appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: AppConstants.navItems.length,
            itemBuilder: (context, index) {
              final item = AppConstants.navItems[index];
              return ListTile(
                leading: Icon(_getIconData(item.icon)),
                title: Text(item.title),
                onTap: () {
                  navigationBloc.add(NavigateToPageEvent(index));
                  if (isDrawer) {
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'dashboard':
        return Icons.dashboard;
      case 'folder':
        return Icons.folder;
      case 'task':
        return Icons.task;
      case 'calendar_today':
        return Icons.calendar_today;
      case 'bar_chart':
        return Icons.bar_chart;
      case 'settings':
        return Icons.settings;
      default:
        return Icons.circle;
    }
  }
}
