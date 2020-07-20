import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

enum ToastStyle 
{
	error,
	warning,
	success,
	info
}

class ToastFactory 
{
	static void show({
		@required BuildContext context, 
		@required String msg, 
		ToastStyle style = ToastStyle.info,
		Duration duration = const Duration(milliseconds: 1500)
	}) 
	{
		IconData icon;
		Color color;

		switch(style) {
			case ToastStyle.error: 
				icon = Icons.error;
				color = Colors.red.shade400;
				break;
			case ToastStyle.warning: 
				icon = Icons.warning;
				color = Colors.yellow.shade400;
				break;
			case ToastStyle.success: 
				icon = Icons.info;
				color = Colors.green.shade400;
				break;
			default: 
				icon = Icons.info;
				color = Colors.blue.shade400;
				break;
		}

		showCustom(
			context: context,
			icon: Icon(
				icon,
				size: 32,
				color: Colors.white,
			),
			text: Text(
				msg,
				style: TextStyle(
					color: Colors.white,
					fontSize: 18
				),
			),
			duration: duration,
			background: color
		);
	}

	static void showCustom({
		@required BuildContext context,
		@required Widget icon,
		@required Widget text,
		@required Color background,
		Duration duration = const Duration(milliseconds: 1500),
		Duration animationDuration = const Duration(milliseconds: 300),
		bool crossPage = false
	}) 
	{
		BotToast.showCustomNotification(
			toastBuilder: (_){
				return Card(
					color: background,
					child: ListTile(
						leading: icon,
						title: text
					),
				);
			},
			duration: duration,
			animationDuration: animationDuration,
			crossPage: crossPage,
		);
	}
}