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
        'https://picsum.photos/240/350',
        'https://picsum.photos/260/510',
        'https://picsum.photos/530/350',
        'https://picsum.photos/370/280',
        'https://picsum.photos/370/280',
        'https://picsum.photos/370/280',
        'https://picsum.photos/370/280',
        'https://picsum.photos/370/280',
        'https://picsum.photos/600/900',
        'https://picsum.photos/600/300',
      ],
      [
        'https://picsum.photos/280/310',
        'https://picsum.photos/200/520',
        'https://picsum.photos/500/330',
        'https://picsum.photos/300/250',
        'https://picsum.photos/600/900',
        'https://picsum.photos/600/300',
      ],
      [
        'https://picsum.photos/200/380',
        'https://picsum.photos/200/540',
        'https://picsum.photos/500/330',
        'https://picsum.photos/300/240',
        'https://picsum.photos/600/930',
        'https://picsum.photos/600/390',
      ],
      [
        'https://picsum.photos/210/300',
        'https://picsum.photos/220/500',
        'https://picsum.photos/530/300',
        'https://picsum.photos/340/200',
        'https://picsum.photos/600/900',
        'https://picsum.photos/600/300',
      ],
      [
        'https://picsum.photos/270/300',
        'https://picsum.photos/230/500',
        'https://picsum.photos/560/300',
        'https://picsum.photos/300/200',
        'https://picsum.photos/600/900',
        'https://picsum.photos/600/300',
      ],
      [
        'https://picsum.photos/200/300',
        'https://picsum.photos/200/500',
        'https://picsum.photos/500/300',
        'https://picsum.photos/300/200',
        'https://picsum.photos/600/900',
        'https://picsum.photos/600/300',
      ],
      ['https://picsum.photos/200/300', 'https://picsum.photos/600/300'],
      [
        'https://picsum.photos/200/300',
        'https://picsum.photos/200/500',
        'https://picsum.photos/600/300',
      ],
      [
        'https://picsum.photos/100/100',
        'https://picsum.photos/200/500',
        'https://picsum.photos/500/300',
        'https://picsum.photos/300/200',
        'https://picsum.photos/600/900',
        'https://picsum.photos/600/300',
        'https://picsum.photos/600/300',
        'https://picsum.photos/600/300',
        'https://picsum.photos/600/300',
        'https://picsum.photos/600/300',
        'https://picsum.photos/600/300',
      ],
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
            // 'Long item title highlighting how long titles are handled with ellipsis',
            'Item title',
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
