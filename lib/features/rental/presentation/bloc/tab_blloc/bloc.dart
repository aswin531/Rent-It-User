import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/tab_blloc/event.dart';
import 'package:rentit/features/rental/presentation/bloc/tab_blloc/state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState(0)) {
    on<BookingTabChanged>((event, emit) {
      emit(TabState(event.index));
    });
  }
}