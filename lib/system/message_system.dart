import 'dart:io';

import 'package:flutter/material.dart';

import '../design/dimensions.dart';

enum MessageIconTypes {
  DONE,
  CLOSE,
  FAILED,
  NULL,
}

class MessageSystem {
  static final Map<MessageIconTypes, Icon?> _messageIcons = {
    MessageIconTypes.DONE: const Icon(
      Icons.check,
      color: Color(0xFF1CBA3E),
    ),
    MessageIconTypes.CLOSE: const Icon(
      Icons.close,
      color: Color(0xFFBA1A1A),
    ),
    MessageIconTypes.FAILED: const Icon(
      Icons.warning_amber_rounded,
      color: Color(0xFFBA1A1A),
    ),
    MessageIconTypes.NULL: null,
  };

  static Future<void> initSnackBarMessage(
    BuildContext context,
    MessageIconTypes iconType, {
    String? message,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 12 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 10 * getScaleFactorFromWidth(context)),
          if (iconType != MessageIconTypes.NULL) _messageIcons[iconType]!,
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  static Future<void> initSnackBarErrorMessage(
    BuildContext context, {
    String? message,
    String? error,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: message ?? "",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontSize: 10 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w500,
                ),
                children: [TextSpan(text: "\n${error ?? ""}")],
              ),
            ),
          ),
          SizedBox(width: 10 * getScaleFactorFromWidth(context)),
          _messageIcons[MessageIconTypes.FAILED]!,
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  static Future<void> initWillPopMessage(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          '앱을 완전히 종료 하시겠습니까?',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              '예',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () => exit(0),
          ),
          TextButton(
            child: Text(
              '아니오',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
