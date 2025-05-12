import 'package:flutter/material.dart';
import 'dart:math';

class ItemModel {
  final String id;
  final String title;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final int unfinishedTasks;
  final List<String> assignedUserAvatars;
  final String status;

  const ItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.unfinishedTasks,
    required this.assignedUserAvatars,
    required this.status,
  });

  // Sample data for testing
  static List<ItemModel> getSampleItems() {
    // Generate random user avatar URLs from randomuser.me API
    final List<List<String>> userAvatarSets = [
      [
        'https://randomuser.me/api/portraits/men/96.jpg',
        'https://randomuser.me/api/portraits/men/52.jpg',
        'https://randomuser.me/api/portraits/men/77.jpg',
        'https://randomuser.me/api/portraits/men/83.jpg',
        'https://randomuser.me/api/portraits/men/88.jpg',
        'https://randomuser.me/api/portraits/men/86.jpg',
        'https://randomuser.me/api/portraits/men/82.jpg',
        'https://randomuser.me/api/portraits/men/23.jpg',
        'https://randomuser.me/api/portraits/men/33.jpg',
      ],
      _generateRandomUserAvatars(3),
      _generateRandomUserAvatars(2),
      _generateRandomUserAvatars(3),
      _generateRandomUserAvatars(3),
      _generateRandomUserAvatars(3),
      _generateRandomUserAvatars(3),
      _generateRandomUserAvatars(2),
      _generateRandomUserAvatars(3),
    ];

    return [
      ItemModel(
        id: '1',
        title: 'Item title',
        imageUrl: 'assets/images/a2.png',
        startDate: DateTime(2024, 1, 16),
        endDate: DateTime(2024, 1, 20),
        unfinishedTasks: 4,
        assignedUserAvatars: userAvatarSets[0],
        status: 'Pending Approval',
      ),
      ItemModel(
        id: '2',
        imageUrl: 'assets/images/b.png',
        title:
            'Long item title highlighting how long titles are handled with ellipsis',
        startDate: DateTime(2024, 1, 16),
        endDate: DateTime(2024, 1, 20),
        unfinishedTasks: 4,
        assignedUserAvatars: userAvatarSets[1],
        status: 'Pending Approval',
      ),
      ItemModel(
        id: '3',
        title: 'Item title',
        imageUrl: 'assets/images/a2.png',
        startDate: DateTime(2024, 1, 16),
        endDate: DateTime(2024, 1, 20),
        unfinishedTasks: 4,
        assignedUserAvatars: userAvatarSets[2],
        status: 'Pending Approval',
      ),
      ItemModel(
        id: '4',
        title: 'Item title',
        imageUrl: 'assets/images/a1.png',
        startDate: DateTime(2024, 1, 16),
        endDate: DateTime(2024, 1, 20),
        unfinishedTasks: 4,
        assignedUserAvatars: userAvatarSets[3],
        status: 'Pending Approval',
      ),
      ItemModel(
        id: '5',
        title: 'Item title',
        imageUrl: 'assets/images/a2.png',
        startDate: DateTime(2024, 1, 16),
        endDate: DateTime(2024, 1, 20),
        unfinishedTasks: 4,
        assignedUserAvatars: userAvatarSets[4],
        status: 'Pending Approval',
      ),
      ItemModel(
        id: '6',
        title: 'Item title',
        imageUrl: 'assets/images/b.png',
        startDate: DateTime(2024, 1, 16),
        endDate: DateTime(2024, 1, 20),
        unfinishedTasks: 4,
        assignedUserAvatars: userAvatarSets[5],
        status: 'Pending Approval',
      ),
      ItemModel(
        id: '7',
        title: 'Item title',
        imageUrl: 'assets/images/a1.png',
        startDate: DateTime(2024, 1, 16),
        endDate: DateTime(2024, 1, 20),
        unfinishedTasks: 4,
        assignedUserAvatars: userAvatarSets[6],
        status: 'Pending Approval',
      ),
      ItemModel(
        id: '8',
        title: 'Item title',
        imageUrl: 'assets/images/a2.png',
        startDate: DateTime(2024, 1, 16),
        endDate: DateTime(2024, 1, 20),
        unfinishedTasks: 4,
        assignedUserAvatars: userAvatarSets[7],
        status: 'Pending Approval',
      ),
    ];
  }

  // Generate random user avatar URLs from randomuser.me API
  static List<String> _generateRandomUserAvatars(int count) {
    final List<String> avatars = [];
    final Random random = Random();

    for (int i = 0; i < count; i++) {
      // Generate random user IDs between 1 and 99
      final int userId = random.nextInt(99) + 1;

      // Randomly choose between male and female avatars
      final String gender = random.nextBool() ? 'men' : 'women';

      // Create the URL for the thumbnail size avatar
      avatars.add(
        'https://randomuser.me/api/portraits/thumb/$gender/$userId.jpg',
      );
    }

    return avatars;
  }
}
