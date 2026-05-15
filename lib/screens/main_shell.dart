import 'package:flutter/material.dart';

import 'categories_screen.dart';
import 'home_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF131313);
    const surfaceContainer = Color(0xFF201F1F);
    const accentColor = Color(0xFFFF6B35);
    const textSecondary = Color(0xFF8E8E93);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          const CategoriesScreen(),
          OrdersScreen(onStartShopping: () => _setIndex(0)),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: surfaceContainer,
        selectedItemColor: accentColor,
        unselectedItemColor: textSecondary,
        onTap: _setIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.tune),
            )
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    const primaryColor = Color(0xFFFFB59D);
    const textPrimary = Color(0xFFFFFFFF);

    if (_currentIndex == 0) {
      return AppBar(
        title: Text(
          'Discover',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.w700,
              ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      );
    }

    if (_currentIndex == 1) {
      return AppBar(
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
      );
    }

    if (_currentIndex == 2) {
      return AppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
      );
    }

    return AppBar(
      title: Text(
        'Profile',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: textPrimary,
              fontWeight: FontWeight.w600,
            ),
      ),
      centerTitle: true,
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    const surfaceColor = Color(0xFF131313);
    const surfaceContainer = Color(0xFF201F1F);
    const dividerColor = Color(0xFF3A3A3C);
    const textPrimary = Color(0xFFFFFFFF);
    const textSecondary = Color(0xFF8E8E93);

    return Drawer(
      backgroundColor: surfaceColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: surfaceContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: textSecondary),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guest User',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'guest@shopscape.com',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: textSecondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: dividerColor),
            _drawerTile(
              context,
              icon: Icons.grid_view,
              label: 'Home',
              onTap: () => _navigateFromDrawer(0),
            ),
            _drawerTile(
              context,
              icon: Icons.category,
              label: 'Categories',
              onTap: () => _navigateFromDrawer(1),
            ),
            _drawerTile(
              context,
              icon: Icons.receipt_long,
              label: 'Orders',
              onTap: () => _navigateFromDrawer(2),
            ),
            _drawerTile(
              context,
              icon: Icons.person,
              label: 'Profile',
              onTap: () => _navigateFromDrawer(3),
            ),
            const Divider(color: dividerColor),
            _drawerTile(
              context,
              icon: Icons.settings,
              label: 'Settings',
              onTap: () => _showSnackBar(context, 'Coming soon'),
            ),
            _drawerTile(
              context,
              icon: Icons.logout,
              label: 'Logout',
              onTap: () => _showSnackBar(context, 'Logged out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    const textPrimary = Color(0xFFFFFFFF);

    return ListTile(
      leading: Icon(icon, color: textPrimary),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textPrimary,
              fontWeight: FontWeight.w600,
            ),
      ),
      onTap: onTap,
    );
  }

  void _navigateFromDrawer(int index) {
    Navigator.of(context).pop();
    _setIndex(index);
  }

  void _showSnackBar(BuildContext context, String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
