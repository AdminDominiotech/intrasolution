import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:safe2biz/app/global/controllers/app_controller.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/errors/exceptions.dart';
import 'package:safe2biz/app/global/core/utils/value_listenable_builder_two.dart';

class ItemPhoto extends StatefulWidget {
  const ItemPhoto({
    Key? key,
    required this.onChange,
    this.imageInitial,
    this.showError = false,
    this.title,
  }) : super(key: key);
  final void Function(File? file) onChange;
  final File? imageInitial;
  final String? title;
  final bool showError;

  @override
  State<ItemPhoto> createState() => _ItemPhotoState();
}

class _ItemPhotoState extends State<ItemPhoto> {
  final ValueNotifier<File?> image = ValueNotifier<File?>(null);

  final ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  Future<void> _loadImg(BuildContext context, AppController app) async {
    FocusScope.of(context).unfocus();
    loading.value = true;
    final typeSource = await showCupertinoModalPopup<TypeSource>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, TypeSource.camera);
            },
            isDestructiveAction: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.camera_on_rectangle_fill,
                  color: S2BColors.black,
                  size: 30,
                ),
                const SizedBox(width: 10),
                TextLabel.h6(
                  'Cámara',
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, TypeSource.gallery);
            },
            isDestructiveAction: true,
            isDefaultAction: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.photo_fill_on_rectangle_fill,
                  color: S2BColors.black,
                  size: 30,
                ),
                const SizedBox(width: 10),
                TextLabel.h6(
                  'Galería',
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    try {
      if (typeSource == null) {
        widget.onChange(null);
      } else {
        final imgResponse = await app.loadImageDevice(typeSource);
        if (imgResponse == null) {
          image.value = null;
          widget.onChange(null);
        } else {
          image.value = imgResponse;

          widget.onChange(imgResponse);
        }
      }
    } catch (e) {
      loading.value = false;
      throw LocalException(message: e.toString());
    }

    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final app = GetIt.I<AppController>();
    if (widget.imageInitial != null) {
      image.value = widget.imageInitial;
    }
    return InkWell(
      onTap: () => _loadImg(context, app),
      child: Padding(
        padding: const EdgeInsets.only(bottom: S2BSpacing.lg),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextLabel.labelText(
                widget.title ?? 'Foto',
              ),
            ),
            const SizedBox(
              height: S2BSpacing.sl,
            ),
            ValueListenableBuilderTwo<File?, bool>(
              valueListenableA: image,
              valueListenableB: loading,
              builder: (context, ximage, loading, _) {
                // log('Rebuild ItemPhoto:::::: img: ${ximage} ::: loading: ${loading}');
                final status = ximage != null ? true : false;
                return DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(
                    S2BSpacing.sl,
                  ),
                  dashPattern: const [7, 5],
                  color: status
                      ? S2BColors.primaryColor
                      : S2BColors.whiteSecundary,
                  child: Container(
                    width: MediaQuery.of(context).size.width.toDouble() * 0.4,
                    height:
                        MediaQuery.of(context).size.height.toDouble() * 0.15,
                    margin: const EdgeInsets.all(
                      S2BSpacing.sm,
                    ),
                    child: loading
                        ? const LoadingContainer()
                        : status
                            ? Image(
                                image: FileImage(
                                  ximage,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.teal,
                                    size: 40.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      S2BSpacing.xs,
                                    ),
                                    child: TextLabel.small(
                                      'Presiona aquÍ para\ncargar o captura una foto',
                                      textAlign: TextAlign.center,
                                      color: S2BColors.silver,
                                    ),
                                  ),
                                ],
                              ),
                  ),
                );
              },
            ),
            if (widget.showError)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: S2BSpacing.xs),
                child: TextLabel.small(
                  'Requerido',
                  color: S2BColors.dangerColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
