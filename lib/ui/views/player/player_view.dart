import 'package:flutter/material.dart';
import 'package:mpm/ui/widgets/button.dart';
import 'package:mpm/utils/colors.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/player.dart';
import 'package:mpm/ui/views/player/player_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class PlayerView extends ViewModelBuilderWidget<PlayerViewModel>
{
	@override
	bool get reactive => false;

	final Player player;

	PlayerView({
		this.player
	});

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"MPM"
				),
				actions: <Widget>[
					model.isProfil ?
					IconButton(
						icon: Icon(
							Icons.exit_to_app
						),
						onPressed: model.disconnect,
					) : Container()
				],
			),
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: SingleChildScrollView(
					child: Column(
						children: <Widget>[
							_Header(),
							_UpdateInfo(),
							_UpdatePassword(),
							SizedBox(height: 3),
							_ChangeImage()
						],
					),
				),
			)
		);
	}
  
	@override
	PlayerViewModel viewModelBuilder(context)
	{
		return PlayerViewModel(
			player: player
		);
	}
}

class _Header extends ViewModelWidget<PlayerViewModel>
{
	@override
	Widget build(context, model)
	{
		return Card(
			child: ListTile(
				leading: CircleAvatarImage(
					image: model.player.image,
					icon: Icons.person,
				),
				title: Text(
					model.player.username
				),
			),
		);
	}
}

class _UpdateInfo extends ViewModelWidget<PlayerViewModel>
{
	@override
	Widget build(context, model)
	{
		return model.isProfil ? Card(
			child: Padding(
				padding: const EdgeInsets.all(8.0),
				child: Column(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						Text(
							"Update information",
							style: Theme.of(context).textTheme.headline6,
						),
						_UsernameTextField(),
						_EmailTextField(),
						Button(
							child: Text(
								"Update information",
								style: TextStyle(
									color: ThemeColors.text,
								),
							),
							color: ThemeColors.primary,
							onPressed: model.updateInformation,
						)
					],
				),
			)
		) : Container();
	}
}

class _UsernameTextField extends HookViewModelWidget<PlayerViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.player.username,
			decoration: InputDecoration(
				labelText: "Username",
				prefixIcon: Icon(
					Icons.person,
					size: 32,
				),
			),
			validator: model.usernameValidator,
			onChanged: (str) => model.player.username = str,
			onSaved: (str) => model.player.username = str,
		);
	}
}

class _EmailTextField extends HookViewModelWidget<PlayerViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.player.email,
			decoration: InputDecoration(
				labelText: "Email",
				prefixIcon: Icon(
					Icons.email,
					size: 32,
				),
			),
			validator: model.emailValidator,
			onChanged: (str) => model.player.email = str,
			onSaved: (str) => model.player.email = str,
		);
	}
}

class _UpdatePassword extends ViewModelWidget<PlayerViewModel>
{
	@override
	Widget build(context, model)
	{
		return model.isProfil ? Card(
			child: Padding(
				padding: const EdgeInsets.all(8.0),
				child: Column(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						Text(
							"Change password",
							style: Theme.of(context).textTheme.headline6,
						),
						_PasswordTextField(),
						_ConfirmPasswordTextField(),
						Button(
							child: Text(
								"Update password",
								style: TextStyle(
									color: ThemeColors.text,
								),
							),
							color: ThemeColors.primary,
							onPressed: model.updatePassword,
						)
					],
				),
			)
		) : Container();
	}
}

class _PasswordTextField extends HookViewModelWidget<PlayerViewModel>
{
	@override
  	bool get reactive => true;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.player.password,
			decoration: InputDecoration(
				labelText: "Password",
				prefixIcon: Icon(
					Icons.lock,
					size: 32,
				),
				errorText: model.passwordError
			),
			obscureText: true,
			validator: model.passwordValidator,
			onChanged: model.passwordChanged,
			onSaved: (str) => model.player.password = str,
		);
	}
}

class _ConfirmPasswordTextField extends HookViewModelWidget<PlayerViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			decoration: InputDecoration(
				labelText: "Confirm password",
				prefixIcon: Icon(
					Icons.lock,
					size: 32,
				),
			),
			obscureText: true,
			validator: model.passwordConfirmValidator,
		);
	}
}

class _ChangeImage extends ViewModelWidget<PlayerViewModel>
{
	@override
	Widget build(context, model)
	{
		return model.isProfil ? 
		Button(
			child: Text(
				"Change image",
				style: TextStyle(
					color: ThemeColors.text,
				),
			),
			color: ThemeColors.accent,
			onPressed: model.changeImage,
		) : Container();
	}
}