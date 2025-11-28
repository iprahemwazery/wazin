abstract class RootState {}

class RootInitial extends RootState {}

class RootPageChanged extends RootState {
  final int index;
  RootPageChanged(this.index);
}
