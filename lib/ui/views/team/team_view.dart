import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

import 'package:mpm/services/database/models/event.dart';
import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';
import 'package:mpm/utils/colors.dart';

class TeamView extends ViewModelBuilderWidget<TeamViewModel>
{
	final Team team;

	TeamView({
		this.team
	});

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"${model.team.name}"
				),
			),
			body: Column(
				children: <Widget>[
					_Header(),
					Expanded(
						child: _Tabs(),
					)
				],
			),
			bottomNavigationBar: _NavigationBar(),
			floatingActionButton: model.isManager ?
			FloatingActionButton(
				child: Icon(
					Icons.add
				),
				onPressed: model.add,
			) : null
		);
	}
	@override
	TeamViewModel viewModelBuilder(context)
	{
		return TeamViewModel(
			context: context,
			team: team
		);
	}
  
}

class _Header extends ViewModelWidget<TeamViewModel>
{
	@override
	Widget build(context, model)
	{
		return Card(
			child: ListTile(
				leading: CircleAvatarImage(
					image: model.team.image,
				),
				title: Text(
					"${model.team.description}"
				),
				subtitle: Text(
					"Players: ${model.team.players.length}"
				),
				trailing: model.isManager ?
				Row(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						IconButton(
							icon: Icon(
								Icons.edit,
								color: Colors.green,
							),
							onPressed: model.edit,
						),
						IconButton(
							icon: Icon(
								Icons.delete,
								color: Colors.red,
							),
							onPressed: model.delete,
						),
					],
				) : null,
			)
		);
	}
}

class _Tabs extends ViewModelWidget<TeamViewModel>
{
	@override
	Widget build(context, model)
	{
		return PageView(
			controller: model.controller,
			onPageChanged: model.onPageChanged,
			children: <Widget>[
				_Events(),
				_TeamPlayersView()
			],
		);
	}
}

class _NavigationBar extends ViewModelWidget<TeamViewModel>
{
	@override
	Widget build(context, model)
	{
		return FFNavigationBar(
			theme: FFNavigationBarTheme(),
			selectedIndex: model.selectedTab,
			onSelectTab: model.onSelectTab,
			items: [
				FFNavigationBarItem(
					iconData: Icons.calendar_today,
					label: 'Events',
				),
				FFNavigationBarItem(
					iconData: Icons.group,
					label: 'Players',
				)
			],
		);
	}
}

class _Events extends ViewModelBuilderWidget<TeamCalendarViewModel>
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
						padding: const EdgeInsets.symmetric(horizontal: 8),
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
								title: Text(
									event.name
								),
							);
						},
						childCount: model.selectedEvents.length
					),
				)
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

class _TeamPlayersView extends ViewModelBuilderWidget<TeamPlayersViewModel>
{
	@override
	Widget builder(context, model, child)
	{
		return model.dataReady ?
		ListView.builder(
			physics: BouncingScrollPhysics(),
			itemCount: model.data.length,
			itemBuilder: (context, index) {
				var player = model.data[index];
				return Card(
					child: ListTile(
						leading: CircleAvatarImage(
							image: player.image,
							icon: Icons.person,
						),
						title: Text(
							player.username
						),
						trailing: model.isManager ?
						IconButton(
							icon: Icon(
								Icons.delete,
								color: Colors.red,
							),
							onPressed: () => model.onPressed(player),
						) : null,
						onTap: () => model.onTap(player),
					)
				);
			}
		) :
		Center(
			child: CircularProgressIndicator(),
		);
	}

	@override
	TeamPlayersViewModel viewModelBuilder(context)
	{
		return TeamPlayersViewModel(
			context: context
		);
	}
}