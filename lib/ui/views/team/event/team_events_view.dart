import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:mpm/services/database/models/event.dart';
import 'package:mpm/ui/views/team/event/team_events_view_model.dart';
import 'package:mpm/utils/colors.dart';

class TeamEventsView extends ViewModelBuilderWidget<TeamCalendarViewModel>
{
	@override
	Widget builder(context, model, child)
	{
		return CustomScrollView(
			physics: BouncingScrollPhysics(),
			slivers: <Widget>[
				SliverToBoxAdapter(
					child: _Calendar(),
				),
				SliverToBoxAdapter(
					child: Padding(
						padding: const EdgeInsets.only(
							left: 8,
							right: 8,
							bottom: 8
						),
						child: Text(
							"Events",
							style: Theme.of(context).textTheme.headline6,
						),
					),
				),
				SliverList(
					delegate: SliverChildBuilderDelegate(
						(context, index) {
							Event event = model.selectedEvents[index];
							return ListTile(
								leading: Icon(
									event.currentHasConfirmed ? Icons.event_available : Icons.event,
									color: event.currentHasConfirmed ? Colors.green : null,
								),
								title: Text(
									"${event.typeName} : \n${event.name}",
									overflow: TextOverflow.ellipsis,
								),
								subtitle: Text(
									event.description,
									overflow: TextOverflow.ellipsis,
									maxLines: 2,
								),
								trailing: Row(
									mainAxisSize: MainAxisSize.min,
									children: <Widget>[
										IconButton(
											icon: Icon(
												event.currentHasConfirmed ? Icons.clear : Icons.check,
												color: event.currentHasConfirmed ? Colors.red : Colors.green,
											),
											onPressed: () => model.presence(event),
										),
										IconButton(
											icon: Icon(
												Icons.timer,
											),
											onPressed: () => model.delay(event),
										),
										model.isManager ?
										IconButton(
											icon: Icon(
												Icons.delete,
												color: Colors.red,
											),
											onPressed: () => model.delete(event, index),
										) : Container()
									],
								),
								onTap: model.isManager ? () => model.updateEvent(event) : null,
							);
						},
						childCount: model.selectedEvents.length
					),
				),
				SliverToBoxAdapter(
					child: Container(
						height: 72,
					)
				),
			],	
		);
	}

	@override
	TeamCalendarViewModel viewModelBuilder(context)
	{
		return TeamCalendarViewModel(
			context: context
		);
	}
}

class _Calendar extends ViewModelWidget<TeamCalendarViewModel>
{
	@override
	Widget build(context, model)
	{
		return TableCalendar(
			locale: 'fr_FR',
			headerStyle: HeaderStyle(
				formatButtonVisible: false
			),
			calendarController: model.calendarController,
			onDaySelected: model.onDaySelected,
			events: model.data,
			calendarStyle: CalendarStyle(
				outsideDaysVisible: false,
				todayColor: ThemeColors.accent,
				selectedColor: ThemeColors.primary
			),
			availableGestures: AvailableGestures.horizontalSwipe,
			builders: CalendarBuilders(
				markersBuilder: (context, date, events, holidays) {
					if(events.isNotEmpty)
					{
						return [AnimatedContainer(
							duration: const Duration(milliseconds: 300),
							decoration: BoxDecoration(
								shape: BoxShape.rectangle,
								color: model.calendarController.isToday(date) ? 
									ThemeColors.primary :
									ThemeColors.accent
							),
							width: 16.0,
							height: 16.0,
							child: Center(
								child: Text(
									'${events.length}',
									style: TextStyle().copyWith(
										color: Colors.white,
										fontSize: 12,
									),
								),
							),
						)];
					}

					return [];
				}
			),
		);
	}
}