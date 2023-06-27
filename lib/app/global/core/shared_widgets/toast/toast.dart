// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:safe2biz/app/global/core/core.dart';

enum ToastType {
  success,
  info,
  warning,
  error,
}

class Toast {
  Toast.show({
    required String description,
    String? messageUser,
    String? title,
    ToastType toastType = ToastType.success,
  }) {
    late String newTitle;
    late Color borderColor;
    late Color backgroundColor;
    late Color textColor;
    late IconData icon;

    switch (toastType) {
      case ToastType.success:
        newTitle = title ?? 'Éxito';
        icon = Icons.check_circle_sharp;
        borderColor = S2BColors.msgSuccessBR;
        backgroundColor = S2BColors.msgSuccessBG;
        textColor = S2BColors.msgSuccessTX;
        break;
      case ToastType.info:
        newTitle = title ?? 'Información';
        icon = Icons.info_sharp;
        borderColor = S2BColors.msgInfoBR;
        backgroundColor = S2BColors.msgInfoBG;
        textColor = S2BColors.msgInfoTX;
        break;
      case ToastType.warning:
        newTitle = title ?? 'Advertencia';
        icon = Icons.warning_sharp;
        borderColor = S2BColors.msgWarningBR;
        backgroundColor = S2BColors.msgWarningBG;
        textColor = S2BColors.msgWarningTX;

        break;
      case ToastType.error:
        newTitle = title ?? 'Error';
        icon = Icons.error_sharp;
        borderColor = S2BColors.msgErrorBR;
        backgroundColor = S2BColors.msgErrorBG;
        textColor = S2BColors.msgErrorTX;
        break;
    }
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 5),
      align: Alignment.topCenter,
      toastBuilder: (void Function() cancelFunc) {
        return Padding(
          padding: const EdgeInsets.all(S2BSpacing.md),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(S2BRadius.md),
            child: Container(
              width: double.infinity,
              color: backgroundColor,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(S2BRadius.md),
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        icon,
                        color: toastType == ToastType.warning
                            ? const Color(0xFFF57F17)
                            : borderColor,
                        size: 28,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            newTitle,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              color: textColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                ),
                                if (messageUser != null)
                                  TextSpan(
                                    text: ' ── ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if (messageUser != null)
                                  TextSpan(
                                    text: messageUser,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static NavigatorObserver get toastObserver => BotToastNavigatorObserver();

  static TransitionBuilder get toastInit => BotToastInit();
}
