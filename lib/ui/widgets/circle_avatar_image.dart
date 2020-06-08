import 'package:flutter/material.dart';

import 'package:extended_image/extended_image.dart';

class CircleAvatarImage extends StatelessWidget
{
	final String url;
	final Map<String, String> headers;
	final bool hasImage;
	final IconData icon;

	CircleAvatarImage({
		@required this.url,
		@required this.headers,
		@required this.hasImage,
		this.icon
	});

	@override
	Widget build(BuildContext context)
	{
		return CircleAvatar(
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
								size: 32,
							);
					}
				},
			) :
			Icon(
				icon ??
				Icons.group,
				size: 32,
			)
		);
	}
}