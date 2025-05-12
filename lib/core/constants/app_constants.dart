class AppConstants {
  // App name
  static const String appName = 'Dashboard';

  // Navigation items based on the provided images
  static const List<NavItem> navItems = [
    NavItem(title: 'Items', icon: 'inventory'),
    NavItem(title: 'Pricing', icon: 'attach_money'),
    NavItem(title: 'Info', icon: 'info'),
    NavItem(title: 'Tasks', icon: 'task'),
    NavItem(title: 'Analytics', icon: 'analytics'),
  ];

  // User info
  static const String userName = 'John Doe';
  static const String userRole = 'Admin';
}

class NavItem {
  final String title;
  final String icon;

  const NavItem({required this.title, required this.icon});
}
