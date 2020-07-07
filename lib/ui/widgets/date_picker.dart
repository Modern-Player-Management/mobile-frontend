import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget 
{
	final bool Function(DateTime date) onSelectDate;
	final DateTime initialDate;
	final String selectText;

	DatePicker({
		@required this.onSelectDate,
		this.initialDate,
		this.selectText
	});

	@override
	_DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> 
{
	DateTime _date;
	final _format = DateFormat.yMd('fr_FR').add_Hm();

	@override
	void initState() 
	{
		_date = widget.initialDate;
		super.initState();
	}

	@override
	Widget build(BuildContext context)
	{
		return Card(
			child: InkWell(
				child: Row(
					children: <Widget>[
						Padding(
							padding: const EdgeInsets.all(16),
							child: Text(
								_formatDate(),
								style: Theme.of(context).textTheme.subtitle1,
							),
						)
					],
				),
				onTap: _onTap,
			),
		);
	}

	String _formatDate()
	{
		if(_date != null)
		{
			return _format.format(_date);
		}

		return widget.selectText ?? "Select a date";
	}

	void _onTap() async
	{
		
		var date = await showDatePicker(
			context: context, 
			initialDate: DateTime.now(), 
			firstDate: DateTime.now(), 
			lastDate: DateTime(2100)
		);

		if(date == null)
		{
			return;
		}

		var time = await showTimePicker(
			context: context, 
			initialTime: TimeOfDay.now()
		);

		if(time != null && widget.onSelectDate != null)
		{
			date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
			var res = widget.onSelectDate(date);
			if(res != null && res)
			{
				setState(() {
					_date = date;
				});
			}
		}
	}
}