import 'package:flutter/material.dart';

class IconText extends StatelessWidget
{
	final IconData icon;
	final String text;

	IconText({
		@required this.icon,
		@required this.text
	});

	@override
	Widget build(BuildContext context)
	{
		return Row(
			children: <Widget>[
				Icon(
					icon,
					color: Colors.grey.shade800,
				),
				SizedBox(
					width: 4,
				),
				Text(
					":"
				),
				SizedBox(
					width: 8,
				),
				Text(
					text,
					style: Theme.of(context).textTheme.subtitle1,
				)
			],
		);
	}
}