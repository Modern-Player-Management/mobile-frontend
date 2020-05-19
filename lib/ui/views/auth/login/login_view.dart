import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:mpm/ui/views/auth/login/login_view_model.dart';

class LoginView extends ViewModelBuilderWidget<LoginViewModel>
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
											_PasswordTextField(),
											SizedBox(height: 16),
											_LoginButton(),
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
	LoginViewModel viewModelBuilder(context) 
	{
		return LoginViewModel();
	}
}

class _UsernameTextField extends HookViewModelWidget<LoginViewModel>
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

class _PasswordTextField extends HookViewModelWidget<LoginViewModel>
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
			),
			obscureText: true,
			validator: model.passwordValidator,
			onSaved: (str) => model.user.password = str,
		);
	}
}

class _LoginButton extends ViewModelWidget<LoginViewModel>
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
							"Login",
							style: TextStyle(
								color: Colors.white,
								fontSize: 16
							),
						),
						color: Theme.of(context).primaryColor,
						onPressed: model.login
					),
				)
			],
		);
	}
}

class _Error extends ViewModelWidget<LoginViewModel>
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