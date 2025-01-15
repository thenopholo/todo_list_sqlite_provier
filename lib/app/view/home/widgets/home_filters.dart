import 'package:flutter/material.dart';

import '../../../core/ui/app_theme_extensions.dart';
import 'home_filter_card.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({super.key});

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'FILTROS',
          style: context.titleText,
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              HomeFilterCard(),
              HomeFilterCard(),
              HomeFilterCard(),
              HomeFilterCard(),
              HomeFilterCard(),
              HomeFilterCard(),
              HomeFilterCard(),
            ],
          ),
        ),
      ],
    );
  }
}
