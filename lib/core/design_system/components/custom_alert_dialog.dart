import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  static Future<bool> showConfirmation({
    required BuildContext context,
    required String title,
    required String description,
    required String confirmText,
    String cancelText = 'Cancelar',
  }) async {
    return await showDialog<bool?>(
          context: context,
          builder: (alertDialogContext) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(description),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(alertDialogContext).pop(false),
                  child: Text(cancelText, style: CustomTextStyle.bodyStyleText),
                ),
                TextButton(
                  onPressed: () => Navigator.of(alertDialogContext).pop(true),
                  child: Text(
                    confirmText,
                    style: CustomTextStyle.bodyStyleText,
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  static Future<bool> showInfo({
    required BuildContext context,
    required String title,
    required String description,
    String confirmText = 'Ok',
  }) async {
    return await showDialog<bool?>(
          context: context,
          builder: (alertDialogContext) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(description),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(alertDialogContext).pop(true),
                  child: Text(
                    confirmText,
                    style: CustomTextStyle.bodyStyleText,
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  static Future<void> showImage({
    required BuildContext context,
    required String imageUrl,
  }) async {
    return await showDialog<void>(
      context: context,
      builder: (alertDialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Define o raio da borda
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Não foi possível carregar a imagem.',
                          style: CustomTextStyle.bodyStyleText,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: CustomColorTheme.primaryTextColor,
                      ),
                      onPressed: () =>
                          Navigator.of(alertDialogContext).pop(true),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showContent({
    required BuildContext context,
    required Widget content,
    EdgeInsets? insetPadding,
    Color? backgroundColor,
  }) async {
    return await showDialog<void>(
      context: context,
      builder: (alertDialogContext) {
        return Dialog(
          backgroundColor: backgroundColor,
          insetPadding: insetPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: content,
          ),
        );
      },
    );
  }

  static Future<T?> showOptions<T>({
    required BuildContext context,
    required Widget content,
  }) async {
    return await showDialog<T?>(
      context: context,
      builder: (alertDialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: content,
          ),
        );
      },
    );
  }
}
