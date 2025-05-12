import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/utils/image_utils.dart';
import '../../domain/models/item_model.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final bool isDesktop;

  const ItemCard({Key? key, required this.item, this.isDesktop = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo
    return Container();
  }
}
