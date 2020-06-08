import 'package:flutter/material.dart';

import 'package:extended_image/extended_image.dart';

class CircleAvatarImage extends StatelessWidget
{
	final String url;
	final Map<String, String> headers;
	final bool hasImage;
	final IconData icon;
	final double size;

	CircleAvatarImage({
		@required this.url,
		@required this.headers,
		@required this.hasImage,
		this.icon,
		this.size = 32
	});

	@override
	Widget build(BuildContext context)
	{
		return CircleAvatar(
			radius: size - 8,
			backgroundColor: hasImage ?
			Colors.transparent : null,
			child: hasImage ?
			ExtendedImage.network(
				url,
				headers: headers,
				enableLoadState: true,
				loadStateChanged: (state) {
					switch(state.extendedImageLoadState)
					{
						case LoadState.completed:
							return ExtendedRawImage(
								image: state.extendedImageInfo.image,
							);
						case LoadState.loading:
							return Center(
								child: CircularProgressIndicator(),
							);
						default:
							return Icon(
								Icons.error,
								size: size,
							);
					}
				},
			) :
			Icon(
				icon ??
				Icons.group,
				size: size,
			)
		);
	}
}