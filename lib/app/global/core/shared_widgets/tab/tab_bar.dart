import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.children,
    this.initTab = 0,
  }) : super(key: key);

  final List<String> tabs;
  final List<Widget> children;
  final int initTab;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  final currentPostion = ValueNotifier<int>(0);

  @override
  void initState() {
    controller = TabController(length: widget.tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      initialIndex: widget.initTab,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: S2BColors.primaryColor,
              border: Border(
                bottom: BorderSide(color: S2BColors.orange),
              ),
            ),
            child: TabBar(
              // controller: controller,
              onTap: (i) {
                currentPostion.value = i;
              },
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: S2BSpacing.xs),
              indicatorColor: S2BColors.orange,
              indicatorWeight: 3.0,
              labelColor: S2BColors.white,
              unselectedLabelColor: S2BColors.orange,
              labelStyle: TextStyle(
                fontFamily: S2BTypography.roboto,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.0,
              ),
              tabs: widget.tabs
                  .asMap()
                  .map(
                    (i, title) => MapEntry(
                      i,
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: S2BSpacing.md),
                        child: ValueListenableBuilder<int>(
                          valueListenable: currentPostion,
                          builder: (_, postion, __) {
                            return TextLabel.labelText(
                              title,
                              textAlign: TextAlign.center,
                              fontWeight: postion == i
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: postion == i
                                  ? S2BColors.white
                                  : S2BColors.silver,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              // controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.children,
            ),
          ),
        ],
      ),
    );
  }
}
