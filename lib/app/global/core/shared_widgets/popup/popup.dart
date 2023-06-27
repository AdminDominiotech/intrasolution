import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class PopupMessage {
  PopupMessage({
    required BuildContext context,
    String? title,
    String? bodyText,
    String? successText,
    String? cancelText,
    bool isDismissible = true,
    bool? showCancel,
    VoidCallback? onSucess,
    VoidCallback? onCancel,
    VoidCallback? onDismiss,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: S2BColors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: S2BSpacing.lg,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: S2BSpacing.zero,
          ),
          children: [
            Container(
              margin: const EdgeInsets.only(top: S2BSpacing.sm),
              padding: const EdgeInsets.symmetric(
                horizontal: S2BSpacing.sl,
              ),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(S2BRadius.md),
                  topRight: Radius.circular(S2BRadius.md),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextLabel.h6(
                    title ?? '',
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding: const EdgeInsets.all(S2BSpacing.md),
                    child: Column(
                      children: [
                        TextLabel.labelText(bodyText ?? ''),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: S2BSpacing.sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BtnDefault(
                          successText ?? 'Aceptar',
                          minWidth: 100,
                          onTap: onSucess ??
                              () {
                                Nav.back(context);
                              },
                        ),
                        const SizedBox(
                          width: S2BSpacing.sl,
                        ),
                        BtnDefault(
                          cancelText ?? 'Cancelar',
                          minWidth: 100,
                          onTap: onCancel ??
                              () {
                                Nav.back(context);
                              },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).then((value) {
      if (onDismiss != null) {
        onDismiss();
      }
    });
  }
}
