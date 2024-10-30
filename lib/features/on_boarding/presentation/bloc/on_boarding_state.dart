part of 'on_boarding_bloc.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();  

  @override
  List<Object> get props => [];
}
class OnBoardingInitial extends OnBoardingState {}
