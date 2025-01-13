import 'dart:io';

import 'package:memmatch/core/types/message_view_type.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../package_loader/load_modules.dart';

class UiWidgets {
  static Widget getLogo(
      {required String path, required double width, required double height}) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: SvgPicture.asset(
        path,
        alignment: Alignment.center,
        width: width,
        height: height,
      ),
    );
  }

  static Widget getSvg(String path,
      {required double width,
      required double height,
      double? padding = 0,
      double paddingLeft = 0,
      double paddingTop = 0,
      double paddingRight = 0,
      double paddingBottom = 0,
      ColorFilter? colorFilter,
      BoxFit? fit}) {
    if (padding != 0) {
      return Padding(
        padding: EdgeInsets.all(padding ?? 0),
        child: SvgPicture.asset(
          path,
          alignment: Alignment.center,
          width: width,
          height: height,
          colorFilter: colorFilter,
          fit: fit ?? BoxFit.cover,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: paddingLeft,
            top: paddingTop,
            right: paddingRight,
            bottom: paddingBottom),
        child: SvgPicture.asset(
          path,
          alignment: Alignment.center,
          width: width,
          height: height,
          colorFilter: colorFilter,
          fit: fit ?? BoxFit.cover,
        ),
      );
    }
  }

  static Widget getIndicator(int activeIndex, int indicatorCount,
      Color activeColor, Color inactiveColor) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < indicatorCount; i++)
              if (i == activeIndex) ...[
                circleBar(true, activeColor, inactiveColor)
              ] else
                circleBar(false, activeColor, inactiveColor),
          ],
        ),
      ],
    );
  }

  static Widget circleBar(
      bool isActive, Color activeColor, Color inactiveColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? activeColor : inactiveColor,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }

  static Widget getRoundButton(BuildContext context, String text,
      {double? width,
      double? height,
      double? padding,
      double? radius,
      onPressed}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8.0),
      child: ElevatedButton(
          style: UIWidgetStyle.buttonStyle(Theme.of(context).primaryColor,
              Size(width ?? 50, height ?? 50), radius ?? 10),
          onPressed: onPressed ?? () {},
          child: Text(text)),
    );
  }

  static getSimpleSnakeBar(BuildContext context, String message,
      {Color? color}) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      elevation: 50,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget getPadding({int padding = 8, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }

  static showErrorMessage(
      BuildContext context, AppResponseType responseType, String? message,
      {MessageViewType messageViewType = MessageViewType.toast}) {
    if (responseType == AppResponseType.normal) {
      getMessageCardView(context, message, Colors.blueAccent,
          messageViewType: messageViewType);
    } else {
      getMessageCardView(context, message, Colors.red,
          messageViewType: messageViewType);
    }
  }

  static showAppMessages(
      BuildContext context, AppResponseType responseType, String? message,
      {MessageViewType messageViewType = MessageViewType.toast}) {
    if (responseType == AppResponseType.success) {
      getMessageCardView(context, message, Colors.green,
          messageViewType: messageViewType);
    } else if (responseType == AppResponseType.normal) {
      getMessageCardView(context, message, Colors.blueAccent,
          messageViewType: messageViewType);
    } else if (responseType == AppResponseType.warning) {
      getMessageCardView(context, message, Colors.orange,
          messageViewType: messageViewType);
    } else {
      getMessageCardView(context, message, Colors.red,
          messageViewType: messageViewType);
    }
  }

  static getMessageCardView(BuildContext context, String? message, Color color,
      {MessageViewType messageViewType = MessageViewType.toast}) {
    if (messageViewType == MessageViewType.snackBar) {
      final snackBar = SnackBar(
        content: Text(message ?? ErrorMessages.somethingWentWrong),
        backgroundColor: color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      toastification.dismissAll();
      toastification.show(
        showIcon: false,
        alignment: Alignment.topCenter,
        style: ToastificationStyle.fillColored,
        context: context,
        title: Text(
          (message != "" || message != null)
              ? message ?? ErrorMessages.somethingWentWrong
              : ErrorMessages.somethingWentWrong,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ),
        autoCloseDuration: const Duration(seconds: 3),
        pauseOnHover: true,
        showProgressBar: false,
        primaryColor: color,
        backgroundColor: color,
      );
    }
  }

  static Widget previousButton({
    Color? color,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: iconColor ?? AppColors.black,
          size: 12,
        ),
      ),
    );
  }

  static Widget nextButton({
    Color? color,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: iconColor ?? AppColors.black,
          size: 12,
        ),
      ),
    );
  }

  static void showAlertDialog({
    required BuildContext context,
    required String title,
    String? positiveBtnName,
    String? negativeBtnName,
    required VoidCallback positiveBtnOnTap,
    VoidCallback? negativeBtnOnTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  wordSpacing: -2,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                positiveBtnOnTap();
                context.pop();
              },
              child: Text(
                positiveBtnName ?? AppStrings.yes,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (negativeBtnOnTap != null) {
                  negativeBtnOnTap();
                }
                context.pop();
              },
              child: Text(
                negativeBtnName ?? AppStrings.no,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget getSvgFromNetwork(String url,
      {required double width,
      required double height,
      double? padding = 0,
      double paddingLeft = 0,
      double paddingTop = 0,
      double paddingRight = 0,
      double paddingBottom = 0,
      ColorFilter? colorFilter,
      BoxFit? fit}) {
    if (padding != 0) {
      return Padding(
        padding: EdgeInsets.all(padding ?? 0),
        child: SvgPicture.network(
          url,
          alignment: Alignment.center,
          width: width,
          height: height,
          colorFilter: colorFilter,
          fit: fit ?? BoxFit.cover,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: paddingLeft,
            top: paddingTop,
            right: paddingRight,
            bottom: paddingBottom),
        child: SvgPicture.network(
          url,
          alignment: Alignment.center,
          width: width,
          height: height,
          colorFilter: colorFilter,
          fit: fit ?? BoxFit.cover,
        ),
      );
    }
  }

  static Widget getSvgFromPath(String path,
      {required double width,
      required double height,
      double? padding = 0,
      double paddingLeft = 0,
      double paddingTop = 0,
      double paddingRight = 0,
      double paddingBottom = 0,
      ColorFilter? colorFilter,
      BoxFit? fit,
      Widget? errorWidget}) {
    if (padding != 0) {
      return Padding(
        padding: EdgeInsets.all(padding ?? 0),
        child: SvgPicture.file(
          File(path),
          alignment: Alignment.center,
          width: width,
          height: height,
          colorFilter: colorFilter,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print(stackTrace);
            print(error);
            return IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: paddingLeft,
            top: paddingTop,
            right: paddingRight,
            bottom: paddingBottom),
        child: SvgPicture.file(
          File(path),
          alignment: Alignment.center,
          width: width,
          height: height,
          colorFilter: colorFilter,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // print(stackTrace);
            // print(error);
            return errorWidget?? Container();

          },
        ),
      );
    }
  }
}
