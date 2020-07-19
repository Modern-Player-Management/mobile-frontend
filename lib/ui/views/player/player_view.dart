import 'package:flutter/material.dart';
import 'package:mpm/ui/widgets/button.dart';
import 'package:mpm/utils/colors.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/player/player_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class PlayerView extends ViewModelBuilderWidget<PlayerViewModel>
{
	final String playerId;

	PlayerView({
		this.playerId
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
			body: model.dataReady ?
			Padding(
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
			) :
			Center(
				child: CircularProgressIndicator(),
			)
		);
	}
  
	@override
	PlayerViewModel viewModelBuilder(context)
	{
		return PlayerViewModel(
			playerId: playerId
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
					image: model.data.image,
					icon: Icons.person,
				),
				title: Text(
					model.data.username
				),
			),
		);
	}
}

class _UpdateInfo extends ViewModelWidget<PlayerViewModel>
{
	@override
	bool get reactive => false;

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
			initialValue: model.data.username,
			decoration: InputDecoration(
				labelText: "Username",
				prefixIcon: Icon(
					Icons.person,
					size: 32,
				),
			),
			validator: model.usernameValidator,
			onChanged: (str) => model.data.username = str,
			onSaved: (str) => model.data.username = str,
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
			initialValue: model.data.email,
			decoration: InputDecoration(
				labelText: "Email",
				prefixIcon: Icon(
					Icons.email,
					size: 32,
				),
			),
			validator: model.emailValidator,
			onChanged: (str) => model.data.email = str,
			onSaved: (str) => model.data.email = str,
		);
	}
}

class _UpdatePassword extends ViewModelWidget<PlayerViewModel>
{
	@override
	bool get reactive => false;

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
			initialValue: model.data.password,
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
			onSaved: (str) => model.data.password = str,
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
	bool get reactive => false;

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