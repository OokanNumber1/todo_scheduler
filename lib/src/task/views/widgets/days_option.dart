/*
import 'package:flutter/material.dart';

class DaysOption extends StatelessWidget {
  const DaysOption({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            repeatType.value = RepeatType.daysRepeat;
                          },
                          child: Text(
                            'Days',
                            style: TextStyle(
                                color: repeatType.value == RepeatType.daysRepeat
                                    ? Colors.white
                                    : Colors.lightBlue[300]),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: repeatType.value == RepeatType.daysRepeat
                                ? Colors.lightBlue[300]
                                : Colors.grey[300],
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.4, 48),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            repeatType.value = RepeatType.minutesRepeat;
                          },
                          child: Text(
                            'Minutes',
                            style: TextStyle(
                                color:
                                    repeatType.value == RepeatType.minutesRepeat
                                        ? Colors.white
                                        : Colors.lightBlue[300]),
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.4, 48),
                              primary:
                                  repeatType.value == RepeatType.minutesRepeat
                                      ? Colors.lightBlue[300]
                                      : Colors.grey[300]),
                        )
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              isRepeat.value && repeatType.value == RepeatType.daysRepeat
                  ? Wrap(
                      children: List.generate(
                          days.length,
                          (index) => Choice(
                              isSelected: days[index].value,
                              label: days[index].day)),
                    )
                  : isRepeat.value &&
                          repeatType.value == RepeatType.minutesRepeat
                      ? Column(
                          children: [
                            const Text(
                                'Enter minutes interval between reminders'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: TextField(
                                controller: minuteInterval,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: Colors.blueGrey[200],
                                  filled: true,
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ],
                        );
   }
 }
*/