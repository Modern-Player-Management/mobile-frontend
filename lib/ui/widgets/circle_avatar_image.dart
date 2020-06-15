import 'package:flutter/material.dart';

import 'package:extended_image/extended_image.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

class CircleAvatarImage extends StatefulWidget
{
	final String image;
	final IconData icon;
	final double size;

	CircleAvatarImage({
		@required this.image,
		this.icon,
		this.size = 32
	});
	
	@override
	_CircleAvatarImageState createState() => _CircleAvatarImageState();
}

class _CircleAvatarImageState extends State<CircleAvatarImage> 
{
	final _storage = locator<SecureStorage>();

	String url;
	Map<String, String> headers;
	bool hasImage = false;

	@override
	void initState()
	{
		super.initState();
		hasImage = widget.image != null;
		url = "$serverUrl/api/files/${widget.image}";
		headers = {
			"Authorization": "Bearer ${_storage.token}"
		};
	}

	@override
	Widget build(BuildContext context)
	{
		return CircleAvatar(
			radius: widget.size - 8,
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
								size: widget.size,
							);
					}
				},
			) :
			Icon(
				widget.icon ??
				Icons.group,
				size: widget.size,
			)
		);
	}
}