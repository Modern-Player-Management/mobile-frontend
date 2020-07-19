import 'package:flutter/material.dart';

class Logo extends StatelessWidget
{
	@override
	Widget build(context)
	{
		return Image.asset(
			"assets/logo.png",
			width: MediaQuery.of(context).size.width * 0.4,
		);
	}
}