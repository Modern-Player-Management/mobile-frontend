import 'package:flutter/material.dart';

class Button extends StatelessWidget
{	
	final Widget child;
	final Color color;
	final void Function() onPressed; 
	final EdgeInsetsGeometry padding;

	Button({
		@required this.child,
		@required this.color,
		@required this.onPressed,
		this.padding = const EdgeInsets.all(8.0)
	});

	@override
	Widget build(BuildContext context)
	{
		return Padding(
			padding: padding,
			child: Row(
				children: <Widget>[
					Expanded(
						child: RaisedButton(
							child: child,
							color: color,
							onPressed: onPressed,
						),
					)
				],
			),
		);
	}
}