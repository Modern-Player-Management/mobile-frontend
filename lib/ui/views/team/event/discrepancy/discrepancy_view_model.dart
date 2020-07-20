import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/toast_factory.dart';

class DiscrepancyViewModel extends BaseViewModel
{
	final BuildContext context;
	final Event event;

	final formKey = GlobalKey<FormState>();
	final _discrepancyManager = locator<DiscrepancyManager>();
	final _navigation = locator<NavigationService>();

	final discrepancy = Discrepancy(
		type: 1
	);

	final _format = DateFormat.Hm();

	String get delay {
		if(discrepancy.delayLength == null)
		{
			return "Select a delay length";
		}

		return _format.format(DateTime.fromMillisecondsSinceEpoch((discrepancy.delayLength  - 60) * 1000 * 60));
	}

	DiscrepancyViewModel({
		@required this.context,
		@required this.event
	});

	String reasonValidator(String str)
	{
		if(str.isEmpty)
		{
			return "You must enter a reason";
		}

		return null;
	}

	void saveReason(String str)
	{
		discrepancy.reason = str;
	}

	void pickDelay() async
	{
		Picker(
			itemExtent: 48,
			adapter: NumberPickerAdapter(
				data: [
					NumberPickerColumn(postfix: Text("Hour : "), begin: 0, end: 24),
					NumberPickerColumn(postfix: Text("Minute : "), begin: 1, end: 60),
				]
			),
			onConfirm: (Picker picker, List value) {
				var values = picker.getSelectedValues();
				// 0 : hours & 1 : minutes
				discrepancy.delayLength = values[0] * 60 + values[1];
				notifyListeners();
			}
		).showModal(context);
	}

	void save() async
	{
		if(formKey.currentState.validate())
		{
			formKey.currentState.save();

			if(discrepancy.delayLength == null)
			{
				ToastFactory.show(
					context: context, 
					msg: "You must select a delay length",
					style: ToastStyle.error
				);

				return;
			}

			var res = await _discrepancyManager.add(event, discrepancy);

			if(res == null)
			{
				_navigation.back();
				ToastFactory.show(
					context: context, 
					msg: "Discrepancy added !",
					style: ToastStyle.success
				);
			}
			else
			{
				ToastFactory.show(
					context: context, 
					msg: res,
					style: ToastStyle.error,
					duration: Duration(seconds: 3)
				);
			}
		}
	}
}