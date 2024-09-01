import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/features/profile/presentation/widgets/folder_item.dart';
import 'package:rentit/features/profile/presentation/widgets/section_header.dart';

class FoldersSection extends StatelessWidget {
  const FoldersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(title: 'Relevants'),
        SizedBox(height: 10),
        Row(
          children: [
            FolderItem(icon: FontAwesomeIcons.ccStripe, label: 'Payment Shots'),
            SizedBox(width: 10),
            FolderItem(icon: FontAwesomeIcons.chartLine, label: 'Analytics '),
          ],
        ),
      ],
    );
  }
}