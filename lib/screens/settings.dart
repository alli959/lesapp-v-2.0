import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/components/QuestionCard.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagebutton/imagebutton.dart';

import '../components/bottom_bar.dart';
import '../components/bottom_settings.dart';
import '../components/sidemenu.dart';
import '../models/ModelProvider.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings';
  bool isInit = false;
  PrefVoice prefVoice = PrefVoice.DORA;
  bool isManualCorrection = false;
  bool voiceRecord = true;

  String voiceDora = 'sound/Dora_introduction.mp3';
  String voiceKarl = 'sound/Karl_introduction.mp3';

  AudioPlayer playerDora = AudioPlayer();
  AudioPlayer playerKarl = AudioPlayer();
  AudioCache cache = AudioCache();

  @override
  Widget build(BuildContext context) {
    final _databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    if (!isInit) {
      _databaseBloc.add(GetSpecialData());
      isInit = true;
    }
    return (BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
      if (state is SpecialDataState) {
        prefVoice = state.prefVoice;
        isManualCorrection = state.manualFix;
        voiceRecord = state.saveRecord;
      }
      if (state is ActionPerformedState) {
        prefVoice = state.prefVoice;
        isManualCorrection = state.manualFix;
        voiceRecord = state.saveRecord;
      }

      return Scaffold(
          appBar: AppBar(
            backgroundColor: appBar,
            title: Text('Stillingar',
                style: TextStyle(fontSize: 22, color: Colors.black)),
            iconTheme: IconThemeData(size: 36, color: Colors.black),
          ),
          endDrawer: SideMenu(),
          body: Container(
              // B L ?? A  K O R T I ??
              decoration: BoxDecoration(
                color: Color(0xFFF2AA4C), // - - - * * - - -//
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.50),
                    spreadRadius: 6,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // H L J ?? ?? T A K K I /////////////////////////////////////////////////////////////////////////////////////////
                  children: <Widget>[
                    Expanded(
                        flex: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF989394),
                                        border: Border.all(
                                          color: Color(0xFF989394),
                                          width: 5,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Column(children: [
                                            Center(
                                              child: ImageButton(
                                                children: <Widget>[],
                                                unpressedImage: Image.asset(
                                                    'assets/icons/woman_speaking.png'),
                                                pressedImage: Image.asset(
                                                    'assets/icons/woman_speaking.png'),
                                                width: 75,
                                                height: 75,
                                                onTap: () async => {
                                                  playerDora = await cache
                                                      .play(voiceDora),
                                                  await Future.delayed(Duration(
                                                      milliseconds: 4000)),
                                                  playerDora.stop()
                                                },
                                              ),
                                            ),
                                            Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 25, 0),
                                              child: RoundIconButton(
                                                icon: prefVoice ==
                                                        PrefVoice.DORA
                                                    ? Icons.radio_button_checked
                                                    : Icons.radio_button_off,
                                                iconSize: 30,
                                                circleSize: 30,
                                                onPressed: () => {
                                                  prefVoice == PrefVoice.KARL
                                                      ? _databaseBloc.add(
                                                          ActionPerformedEvent(
                                                              prefVoice:
                                                                  PrefVoice
                                                                      .DORA,
                                                              saveRecord:
                                                                  voiceRecord,
                                                              manualFix:
                                                                  isManualCorrection))
                                                      : {}
                                                },
                                                size: null,
                                              ),
                                            ))
                                          ]),
                                          Column(children: [
                                            Center(
                                              child: ImageButton(
                                                  children: <Widget>[],
                                                  unpressedImage: Image.asset(
                                                      'assets/icons/man_speaking.png'),
                                                  pressedImage: Image.asset(
                                                      'assets/icons/man_speaking.png'),
                                                  width: 75,
                                                  height: 75,
                                                  onTap: () async => {
                                                        playerKarl = await cache
                                                            .play(voiceKarl),
                                                        await Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    4000)),
                                                        playerKarl.stop()
                                                      }),
                                            ),
                                            Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 20, 0),
                                              child: RoundIconButton(
                                                icon: prefVoice ==
                                                        PrefVoice.DORA
                                                    ? Icons.radio_button_off
                                                    : Icons
                                                        .radio_button_checked,
                                                iconSize: 30,
                                                circleSize: 30,
                                                onPressed: () => {
                                                  prefVoice == PrefVoice.DORA
                                                      ? _databaseBloc.add(
                                                          ActionPerformedEvent(
                                                              prefVoice:
                                                                  PrefVoice
                                                                      .KARL,
                                                              saveRecord:
                                                                  voiceRecord,
                                                              manualFix:
                                                                  isManualCorrection))
                                                      : {}
                                                },
                                                size: null,
                                              ),
                                            ))
                                          ]),
                                        ])))
                          ],
                        )),
                    Expanded(
                      flex: 14,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  // F J ?? L D I   R ?? T T   G I S K A ?? / Tilraunir

                                  child: Container(
                                      alignment: Alignment.center,
                                      width: 300,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF989394),
                                          border: Border.all(
                                            color: Color(0xFF989394),
                                            width: 5,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: CheckboxListTile(
                                        title: Text(
                                          "Handvirk villume??h??ndlun fyrir raddgreiningu",
                                          style: TextStyle(
                                            fontFamily: 'Metropolis',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        //    <-- label
                                        value: isManualCorrection,
                                        onChanged: (newValue) => {
                                          _databaseBloc.add(
                                              ActionPerformedEvent(
                                                  prefVoice: prefVoice,
                                                  saveRecord: voiceRecord,
                                                  manualFix: newValue))
                                        },
                                      ))),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                // F J ?? L D I   R ?? T T   G I S K A ?? / Tilraunir

                                child: Container(
                                    alignment: Alignment.center,
                                    width: 300,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF989394),
                                        border: Border.all(
                                          color: Color(0xFF989394),
                                          width: 5,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: CheckboxListTile(
                                      title: Text(
                                        "Leyfa vistun ?? uppt??kum til a?? h??gt s?? a?? b??ta talgreinirinn. (Vistast ekki undir nafni)",
                                        style: TextStyle(
                                          fontFamily: 'Metropolis',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      //    <-- label
                                      value: voiceRecord,
                                      // selected: isManualCorrection,

                                      onChanged: (newValue) => {
                                        _databaseBloc.add(ActionPerformedEvent(
                                            prefVoice: prefVoice,
                                            saveRecord: newValue,
                                            manualFix: isManualCorrection))
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Container(
                      //   child: bottomBar,
                      // ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                            transformAlignment: Alignment.bottomCenter,
                            child: BottomSettings(
                                onTapApprove: () {
                                  _databaseBloc.add(SaveSpecialData(
                                    prefVoice: prefVoice,
                                    saveRecord: voiceRecord,
                                    manualFix: isManualCorrection,
                                  ));
                                  Navigator.pop(context);
                                },
                                onTapDecline: () {
                                  Navigator.pop(context);
                                },
                                image: 'assets/images/bottomBar_bl.png')))
                  ])));
    }));
  }
}
