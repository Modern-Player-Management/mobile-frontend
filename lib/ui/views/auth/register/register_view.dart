import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:mpm/ui/views/auth/register/register_view_model.dart';
import 'package:mpm/ui/widgets/logo.dart';

class RegisterView extends ViewModelBuilderWidget<RegisterViewModel>
{
	@override
	bool get reactive => false;

	@override
	Widget builder(context, model, child)
	{
		return Scaffold(
			body: Center(
				child: Stack(
					children: <Widget>[
						SingleChildScrollView(
							physics: BouncingScrollPhysics(),
							child: Padding(
								padding: const EdgeInsets.all(32),
								child: Form(
									key: model.formKey,
									child: Column(
										children: <Widget>[
											Logo(),
											SizedBox(height: 16),
											_UsernameTextField(),
											_EmailTextField(),
											_PasswordTextField(),
											_ConfirmPasswordTextField(),
											SizedBox(height: 16),
											_RegisterButton(),
											SizedBox(height: 16),
											_Error(),
										],
									),
								),
							),
						)
					],
				),
			)
		);
	}
  
	@override
	RegisterViewModel viewModelBuilder(context) 
	{
		return RegisterViewModel(
			context: context
		);
	}
}

class _UsernameTextField extends HookViewModelWidget<RegisterViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.player.username,
			decoration: InputDecoration(
				labelText: "Username *",
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

class _EmailTextField extends HookViewModelWidget<RegisterViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.player.email,
			decoration: InputDecoration(
				labelText: "Email *",
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

class _PasswordTextField extends HookViewModelWidget<RegisterViewModel>
{
	@override
  	bool get reactive => true;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.player.password,
			decoration: InputDecoration(
				labelText: "Password *",
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

class _ConfirmPasswordTextField extends HookViewModelWidget<RegisterViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			decoration: InputDecoration(
				labelText: "Confirm password *",
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

class _RegisterButton extends ViewModelWidget<RegisterViewModel>
{
	@override
	bool get reactive => false;

	@override
	Widget build(context, model)
	{
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				Expanded(
					child: RaisedButton(
						child: Text(
							"Signup",
							style: TextStyle(
								color: Colors.white,
								fontSize: 16
							),
						),
						color: Theme.of(context).primaryColor,
						onPressed: model.register
					),
				)
			],
		);
	}
}

class _Error extends ViewModelWidget<RegisterViewModel>
{
	@override
	bool get reactive => true;

	@override
	Widget build(context, model)
	{
		return model.requestError == null ?
		Container() :
		Card(
			elevation: 0,
			color: Colors.red.shade50,
			child: Padding(
				padding: const EdgeInsets.all(8.0),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Icon(
							Icons.error_outline,
							color: Colors.red.shade400
						),
						SizedBox(width: 8,),
						Expanded(
							child: Text(
								model.requestError,
								style: TextStyle(
									color: Colors.red.shade900,
									fontSize: 20,
								),
								overflow: TextOverflow.ellipsis,
							),
						)
					],
				)
			),
		);
	}
}