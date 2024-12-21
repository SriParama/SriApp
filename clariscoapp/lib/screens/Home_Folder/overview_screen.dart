import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/globle_colors.dart';
import '../../widgets/custom_rectangluartile.dart';
import '../../Provider/user_provider.dart';
import '../../widgets/record_not_found_widget.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
    if (value.user!.tasks.isEmpty && value.user!.goals.isEmpty) {
          return const RecordNotFoundWidget();
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            if (value.user?.tasks != null && value.user!.tasks.isNotEmpty) ...[
              Customrectangluartile(
                trailingIcon: Icons.download_done_rounded,
                title: 'Tasks',
                subtitle:
                    "You marked ${value.user?.tasks.length} tasks as complete in this period",
                color: GlobalColors.getRandomBrightColor(),
              ),
              const SizedBox(height: 15),
            ],
            if (value.user?.goals != null && value.user!.goals.isNotEmpty) ...[
              Customrectangluartile(
                 trailingIcon: Icons.center_focus_strong_outlined,
                title: 'Goals', 
                subtitle:
                    "You checked in to ${value.user?.goals.length} goals in this period",
                color: GlobalColors.getRandomBrightColor(),
              ),
            ],
            
          ],
        );
      },
    );
  }
}
