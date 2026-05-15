import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const surfaceContainer = Color(0xFF201F1F);
    const dividerColor = Color(0xFF3A3A3C);
    const textPrimary = Color(0xFFFFFFFF);
    const textSecondary = Color(0xFF8E8E93);
    const errorColor = Color(0xFFFF453A);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, kBottomNavigationBarHeight + 16),
      children: [
        Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: surfaceContainer,
              child: Icon(Icons.person, color: textSecondary, size: 36),
            ),
            const SizedBox(height: 12),
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _profileTile(context, Icons.edit, 'Edit Profile'),
        _profileTile(context, Icons.bookmark_border, 'Saved Items'),
        _profileTile(context, Icons.notifications_none, 'Notifications'),
        _profileTile(context, Icons.support_agent, 'Help & Support'),
        const Divider(color: dividerColor),
        ListTile(
          leading: const Icon(Icons.logout, color: errorColor),
          title: Text(
            'Logout',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: errorColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          onTap: () => _showSnackBar(context, 'Logged out'),
        ),
      ],
    );
  }

  Widget _profileTile(BuildContext context, IconData icon, String label) {
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
      onTap: () => _showSnackBar(context, 'Coming soon'),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
