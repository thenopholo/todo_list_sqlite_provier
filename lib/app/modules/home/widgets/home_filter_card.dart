import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/ui/app_theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../../../models/total_task_model.dart';
import '../home_controller.dart';

class HomeFilterCard extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilterType;
  final TotalTaskModel? totalTasks;
  final bool isSelected;

  const HomeFilterCard({
    super.key,
    required this.label,
    required this.taskFilterType,
    required this.isSelected,
    this.totalTasks,
  });

  double _getDonePercentage() {
    final total = totalTasks?.totalTasks ?? 0.0;
    final isDone = totalTasks?.totalTasksDone ?? 0.1;

    if (total == 0) {
      return 0.0;
    }

    final percent = (isDone * 100) / total;
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.read<HomeController>().findTasks(filter: taskFilterType),
      borderRadius: BorderRadius.circular(30),
      child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(
            minHeight: 120,
            maxWidth: 150,
          ),
          decoration: BoxDecoration(
            color: isSelected ? context.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color:
                  isSelected ? context.primaryColorLight : context.primaryColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(45),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${totalTasks?.totalTasks ?? 0} Tasks',
                style: context.titleText.copyWith(
                  fontSize: 10,
                  color: isSelected ? Colors.white : context.primaryColor,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : context.primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(
                  begin: 0.0,
                  end: _getDonePercentage(),
                ),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(isSelected
                        ? context.primaryColorLight
                        : context.primaryColor),
                  );
                },
              ),
            ],
          )),
    );
  }
}
