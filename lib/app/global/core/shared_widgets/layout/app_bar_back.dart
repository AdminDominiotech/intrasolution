// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/ui/module_ui.dart';

class AppBarBack extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBack(
    this.title, {
    Key? key,
    this.btnBack,
    this.withTitle = true,
    this.titleListenable,
    this.showLogo = false,
    this.onPressed,
    this.actions,
    this.centerTitle,
  })  : preferredSize = const Size.fromHeight(55.0),
        super(key: key);

  final String title;
  final bool? btnBack;
  final bool withTitle;
  final bool showLogo;
  final ValueListenable<String>? titleListenable;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final bool? centerTitle;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: S2BColors.primaryColor,
      // backwardsCompatibility: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.orange,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      elevation: 0,
      automaticallyImplyLeading: true,
      centerTitle: centerTitle,
      title: Column(
        children: [
          if (showLogo)
            Container(

              child: Image.asset(
                UiValues.intraLogoPng,
                fit: BoxFit.cover,
                height: 20,
                width: MediaQuery.of(context).size.width*0.8,
              ),
            ),
          if (withTitle) const SizedBox(height: 5),
          if (withTitle)
            titleListenable == null
                ? TextLabel.body(
                    title,
                    color: S2BColors.white,
                    fontWeight: FontWeight.w700,
                  )
                : ValueListenableBuilder<String>(
                    valueListenable: titleListenable!,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (
                          Widget child,
                          Animation<double> animation,
                        ) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          value,
                          key: Key(value),
                          style: const TextStyle(
                            color: S2BColors.black,
                            fontSize: 17,
                          ),
                        ),
                      );
                    },
                  ),
          const SizedBox(height: 5),
        ],
      ),
      actions: actions,
      leading: btnBack == null
          ? null
          : btnBack == true
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: onPressed ?? () => Navigator.pop(context),
                )
              : const SizedBox.shrink(),
    );
  }
}
