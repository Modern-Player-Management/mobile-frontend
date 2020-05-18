import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:mpm/ui/views/auth/auth_view_model.dart';
import 'package:mpm/utils/colors.dart';

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
			body: Center(
				child: Container(
					width: MediaQuery.of(context).size.width * 0.9,
					child: Padding(
						padding: const EdgeInsets.all(16),
						child: SingleChildScrollView(
							child: Form(
								key: model.formKey,
								child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
									crossAxisAlignment: CrossAxisAlignment.center,
									children: <Widget>[
										SizedBox(height: 32),
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
										_AuthButton(),
										_ToggleAuthMethod(),
										SizedBox(height: 16),
										_Error(),
									],
								),
							),
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
				prefixIcon: Icon(
					Icons.person,
					size: 32,
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
				prefixIcon: Icon(
					Icons.email,
					size: 32,
				),
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
  	bool get reactive => true;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.password,
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

class _AuthButton extends ViewModelWidget<AuthViewModel>
{
	@override
	bool get reactive => true;

	@override
	Widget build(context, model)
	{
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				Expanded(
					child: RaisedButton(
						child: Text(
							model.authText,
							style: TextStyle(
								color: Colors.white,
								fontSize: 16
							),
						),
						color: Theme.of(context).primaryColor,
						onPressed: model.auth
					),
				)
			],
		);
	}
}

class _ToggleAuthMethod extends ViewModelWidget<AuthViewModel>
{
	@override
	bool get reactive => true;

	@override
	Widget build(context, model)
	{
		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				Text(
					model.switchText,
					style: TextStyle(
						fontSize: 16
					),
				),
				InkWell(
					hoverColor: Colors.transparent,
					focusColor: Colors.transparent,
					splashColor: Colors.transparent,
					highlightColor: Colors.transparent,
					child: Padding(
						padding: const EdgeInsets.all(8.0),
						child: Text(
							model.switchTextButton,
							style: TextStyle(
								color: ThemeColors.primary,
								fontSize: 16
							),
						),
					),
					onTap: model.toggleLogin,
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
						Text(
							model.requestError,
							style: TextStyle(
								color: Colors.red.shade900,
								fontSize: 20
							),
						),
					],
				)
			),
		);
	}
}