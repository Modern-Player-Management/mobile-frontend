import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, {Function willPop, bool canPop = true}) 
{
	showDialog(
		context: context,
		barrierDismissible: canPop,
		builder: (_) => WillPopScope(
			onWillPop: () async {
				if(willPop != null)
				{
					willPop();
				}
				return canPop;
			},
			child: Material(
				type: MaterialType.transparency,
				child: Center(
					child: CircularProgressIndicator(),
				),
			),
		)
	);
}

Future<bool> showConfirmDialog(BuildContext context, String title, String content) async 
{
	return await showDialog<bool>(
		barrierDismissible: false,
		context: context,
		builder: (BuildContext context) {
			return AlertDialog(
				title: Text(title),
				content: Text(content),
				actions: <Widget>[
					FlatButton(
						child: new Text("Cancel"),
						onPressed: () {
							Navigator.pop(context, false);
						},
					),
					FlatButton(
						child: new Text("Ok"),
						onPressed: () {
							Navigator.pop(context, true);
						},
					),
				],
			);
		},
    );
}