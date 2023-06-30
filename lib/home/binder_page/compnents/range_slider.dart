import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderContainer extends StatefulWidget {
  bool? isAgePreference;
  String? title;

  SliderContainer({
    Key? key,
    this.isAgePreference,
    this.title,
  }) : super(key: key);

  @override
  State<SliderContainer> createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer> {
  static const double _minValue = 2.0;
  static const double _maxValue = 160.0;
  double selectedValue = _minValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<BinderWatch>(
      builder: (context, myProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.isAgePreference!
                        ? '${myProvider.currentAgeValue.first.toStringAsFixed(0)}-${myProvider.currentAgeValue.last.toStringAsFixed(0)}'
                        : '${myProvider.distancePreference.toStringAsFixed(0)} km',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.red[400],
                  inactiveTrackColor: Colors.grey,
                  thumbColor: Colors.white,
                  overlayColor: Colors.red[400],
                  trackHeight: 1,
                  thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 12),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
                ),
                child: widget.isAgePreference!
                // RangeValues _currentValue = const RangeValues(18, 22);
                    ? RangeSlider(
                  values: RangeValues(myProvider.currentAgeValue.first, myProvider.currentAgeValue.last),
                  divisions: ((100 - 18) ~/ 4),
                  min: 18,
                  max: 100.0,
                  onChanged: (RangeValues values) {
                    double start = values.start;
                    double end = values.end;
                    if (end - start <= 4) {
                      if (start == 18) {
                        end = start + 4;
                      }
                      start = end - 4;
                    }
                    myProvider.setCurrentAgeValue([start, end]);
                  },
                )
                    : Slider(
                  min: _minValue,
                  max: _maxValue,
                  value: myProvider.distancePreference,
                  onChanged: (val) {
                   myProvider.setDistancePreference(val);
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Only show people in this range",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: Colors.red[400],
                    value: widget.isAgePreference!
                        ? myProvider.showPeopleInRangeAge
                        : myProvider.showPeopleInRangeDistance,
                    onChanged: (newValue) {
                      if (widget.isAgePreference!) {
                        myProvider.setSwitchPeopleInRangeAge(newValue);
                      } else {
                        myProvider.setSwitchPeopleInRangeDistance(newValue);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
