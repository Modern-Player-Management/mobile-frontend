import 'package:flutter/material.dart';

enum MessageStyle {
	error,
	warning,
	success,
	info
}

// easy snackbar
// show snackbar with different theme
class SnackbarFactory {
	static void show(BuildContext context, String msg, MessageStyle style, 
		{int duration = 2, ScaffoldState scaffoldState}) {
		IconData icon;
		Color backgroundColor;

		switch(style) {
			case MessageStyle.error:
				icon = Icons.info_outline;
				backgroundColor = Colors.red.shade800;
				break;
			case MessageStyle.warning:
				icon = Icons.info_outline;
				backgroundColor = Colors.yellow.shade800;
				break;
			case MessageStyle.success:
				icon = Icons.info_outline;
				backgroundColor = Colors.green.shade800;
				break;
			case MessageStyle.info:
			default:
				icon = Icons.info_outline;
				backgroundColor = Colors.blue.shade800;
		}

		if(scaffoldState == null) {
			scaffoldState = Scaffold.of(context);
		}

		scaffoldState.showSnackBar(
			SnackBar(
				backgroundColor: backgroundColor,
				content: Row(
					children: <Widget>[
						Padding(
							padding: const EdgeInsets.only(right: 8.0),
							child: Icon(icon, size: 30),
						),
						Expanded(child: Text(msg))
					],
				),
				duration: Duration(seconds: duration),
			)
		);
	}
}