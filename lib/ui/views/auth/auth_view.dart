import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/auth/auth_view_model.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class AuthView extends ViewModelBuilderWidget<AuthViewModel>
{
	@override
	bool get reactive => false;

	@override
	bool get disposeViewModel => true;

	@override
	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: _Title()
			),
			body: SingleChildScrollView(
				child: Padding(
					padding: const EdgeInsets.all(16),
					child: Form(
						key: model.formKey,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: <Widget>[
								SizedBox(height: 16),
								Text(
									"Modern Player Management",
									style: TextStyle(
										fontSize: 24
									),
								),
								SizedBox(height: 16),
								_UsernameTextField(),
								_EmailTextField(),
								_PasswordTextField(),
								_ConfirmPasswordTextField(),
								SizedBox(height: 16),
								_Buttons(),
								SizedBox(height: 32),
								_Error()
							],
						),
					),
				),
			)
		);
	}
  
	@override
	AuthViewModel viewModelBuilder(context) 
	{
		return AuthViewModel(
			context: context
		);
	}
}

class _Title extends ViewModelWidget<AuthViewModel>
{
	@override
	bool get reactive => true;

	@override
	Widget build(context, model)
	{
		return Text(
			model.isLogin ? 
			"Authentification" :
			"Registration",
		);
	}
}

class _UsernameTextField extends HookViewModelWidget<AuthViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.username,
			decoration: InputDecoration(
				labelText: "Username *",
				icon: Icon(
					Icons.person
				),
			),
			validator: model.usernameValidator,
			onChanged: (str) => model.username = str,
			onSaved: (str) => model.username = str,
		);
	}
}

class _EmailTextField extends HookViewModelWidget<AuthViewModel>
{
	@override
  	bool get reactive => true;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return model.isLogin ?
		Container() :
		TextFormField(
			initialValue: model.email,
			decoration: InputDecoration(
				labelText: "Email *",
				icon: Icon(
					Icons.email
				)
			),
			validator: model.emailValidator,
			onChanged: (str) => model.email = str,
			onSaved: (str) => model.email = str,
		);
	}
}

class _PasswordTextField extends HookViewModelWidget<AuthViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.password,
			decoration: InputDecoration(
				labelText: "Password *",
				icon: Icon(
					Icons.lock
				),
				errorText: model.passwordError
			),
			obscureText: true,
			validator: model.passwordValidator,
			onChanged: model.passwordChanged,
			onSaved: (str) => model.password = str,
		);
	}
}

class _ConfirmPasswordTextField extends HookViewModelWidget<AuthViewModel>
{
	@override
  	bool get reactive => true;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return model.isLogin ?
		Container() :
		TextFormField(
			decoration: InputDecoration(
				labelText: "Confirm password *",
				icon: Icon(
					Icons.lock
				),
			),
			obscureText: true,
			validator: model.passwordConfirmValidator,
		);
	}
}

class _Buttons extends ViewModelWidget<AuthViewModel>
{
	@override
	bool get reactive => true;

	@override
	Widget build(context, model)
	{
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				FlatButton(
					child: Text(
						model.switchText
					),
					onPressed: model.toggleLogin,
				),
				RaisedButton(
					child: Text(
						model.authText,
						style: TextStyle(
							color: Colors.white
						),
					),
					color: Theme.of(context).primaryColor,
					onPressed: model.auth
				)
			],
		);
	}
}

class _Error extends ViewModelWidget<AuthViewModel>
{
	@override
	bool get reactive => true;

	@override
	Widget build(context, model)
	{
		return model.requestError == null ?
		Container() :
		Card(
			color: Colors.red.shade200,
			child: Center(
				child: Padding(
					padding: const EdgeInsets.all(8.0),
					child: Text(
						model.requestError,
						style: TextStyle(
							fontSize: 20
						),
					),
				),
			)
		);
	}
}