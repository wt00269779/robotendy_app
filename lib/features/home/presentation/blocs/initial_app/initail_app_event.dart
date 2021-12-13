import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BottomNavigationEvent extends Equatable {
  BottomNavigationEvent([List props = const<dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends BottomNavigationEvent {
  @override
  String toString() => 'Initial BottomNavigation';
}

class PageSelected extends BottomNavigationEvent {
  final int index;

  PageSelected({@required this.index});
  String toString() => 'PageSelected : { $index }';

}