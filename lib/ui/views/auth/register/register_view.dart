import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/auth/register/register_view_model.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class RegisterView extends ViewModelBuilderWidget<RegisterViewModel>
{
	@override
	bool get reactive => false;

	@override
	bool get disposeViewModel => true;

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
											Text(
												"MPM Logo",
												style: Theme.of(context).textTheme.headline4
											),
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
		return RegisterViewModel();
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
			initialValue: model.user.username,
			decoration: InputDecoration(
				labelText: "Username *",
				prefixIcon: Icon(
					Icons.person,
					size: 32,
				),
			),
			validator: model.usernameValidator,
			onChanged: (str) => model.user.username = str,
			onSaved: (str) => model.user.username = str,
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
			initialValue: model.user.email,
			decoration: InputDecoration(
				labelText: "Email *",
				prefixIcon: Icon(
					Icons.email,
					size: 32,
				),
			),
			validator: model.emailValidator,
			onChanged: (str) => model.user.email = str,
			onSaved: (str) => model.user.email = str,
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
			initialValue: model.user.password,
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
			onSaved: (str) => model.user.password = str,
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