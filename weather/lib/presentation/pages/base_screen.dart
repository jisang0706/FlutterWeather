import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/utils/background_pick_helper.dart';
import 'package:weather/presentation/blocs/base_state.dart';
import 'package:weather/presentation/blocs/base_bloc.dart';
import 'package:weather/presentation/blocs/sun_times_state.dart';
import 'package:weather/presentation/widgets/base_body.dart';
import 'package:weather/presentation/widgets/base_header.dart';

// 메인 페이지 실질적인 화면
class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<BaseScreen> {
  Color _backgroundColor = Colors.black;
  late final SafeArea _workingArea;

  @override
  void initState() {
    super.initState();
    _workingArea = SafeArea(
        child: Column(children: [
      BaseHeader(),
      Expanded(child: Center(child: BaseBody()))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BaseBloc, BaseState>(
      listenWhen: (previous, current) => current is SunTimesLoaded,
      listener: (context, state) {
        if (state is SunTimesLoaded) {
          setState(() {
            _backgroundColor = BackgroundPickHelper.determineBackgroundColor(
                now: state.now, sunrise: state.sunrise, sunset: state.sunset);
          });
        }
      },
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: _backgroundColor,
          child: _workingArea,
        ),
      ),
    );
  }
}
