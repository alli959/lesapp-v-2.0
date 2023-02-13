import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/components/QuestionCard.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagebutton/imagebutton.dart';

import '../components/bottom_bar.dart';
import '../components/bottom_settings.dart';
import '../components/colored_tab_bar.dart';
import '../components/sidemenu.dart';
import '../components/update_info.dart';
import '../models/ModelProvider.dart';
import '../shared/loading.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings';

  AudioCache cache = AudioCache();
  bool isInit = false;
  bool isManualCorrection = false;
  AudioPlayer playerDora = AudioPlayer();
  AudioPlayer playerKarl = AudioPlayer();
  PrefVoice prefVoice = PrefVoice.DORA;
  String voiceDora = 'sound/Dora_introduction.mp3';
  String voiceKarl = 'sound/Karl_introduction.mp3';
  bool voiceRecord = true;
  String classname = "bekkur";
  String schoolname = "Utan skóla";
  bool agreement = true;
  String name = "Nafn barns";
  String email = "Netfang foreldris";
  String password = "Lykilorð";
  String age = "Aldur barns";
  bool _specialScreen = true;
  List<String> schoolnamelist = ["Utan skóla"];

  Settings({specialScreen = true}) {
    this._specialScreen = specialScreen;
  }

  @override
  Widget build(BuildContext context) {
    final _databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    if (!isInit) {
      _databaseBloc.add(GetSpecialData());
    }
    return (BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
      if (state is SpecialDataState) {
        prefVoice = state.prefVoice;
        isManualCorrection = state.manualFix;
        voiceRecord = state.saveRecord;
        schoolname = state.schoolname;
        classname = state.classname;
        agreement = state.agreement;
        name = state.name;
        age = state.age;
        schoolnamelist = state.schoolnamelist;
        isInit = true;
      }
      if (state is ActionPerformedState) {
        prefVoice = state.prefVoice;
        isManualCorrection = state.manualFix;
        voiceRecord = state.saveRecord;
        schoolname = state.schoolname;
        classname = state.classname;
        agreement = state.agreement;
        name = state.name;
        age = state.age;
      }

      return DefaultTabController(
          initialIndex: _specialScreen ? 0 : 1,
          length: 2,
          child: Scaffold(
              backgroundColor: settingsBackground,
              appBar: AppBar(
                bottom: ColoredTabBar(
                    Color.fromARGB(255, 203, 229, 136),
                    TabBar(
                      overlayColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 87, 66, 255)),
                      automaticIndicatorColorAdjustment: false,
                      tabs: [
                        Tab(
                          child: Text(
                            'Stillingar',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Notanda Stillingar',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    )),
                backgroundColor: appBar,
                title: Text('Stillingar',
                    style: TextStyle(fontSize: 22, color: Colors.black)),
                iconTheme: IconThemeData(size: 36, color: Colors.black),
              ),
              endDrawer: SideMenu(),
              body: Container(
                  // B L Á A  K O R T I Ð
                  decoration: BoxDecoration(
                    color: settingsBackground, // - - - * * - - -//
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
                  child: TabBarView(children: [
                    !isInit
                        ? Loading()
                        : Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // H L J Ó Ð T A K K I /////////////////////////////////////////////////////////////////////////////////////////
                            children: <Widget>[
                                Expanded(
                                    flex: 8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 10),
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    color:
                                                        settingsBackgroundCards,
                                                    border: Border.all(
                                                      color:
                                                          settingsBorderColor,
                                                      width: 5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Column(children: [
                                                        Center(
                                                          child: ImageButton(
                                                            children: <
                                                                Widget>[],
                                                            unpressedImage:
                                                                Image.asset(
                                                                    'assets/icons/woman_speaking.png'),
                                                            pressedImage:
                                                                Image.asset(
                                                                    'assets/icons/woman_speaking.png'),
                                                            width: 75,
                                                            height: 75,
                                                            onTap: () async => {
                                                              playerDora =
                                                                  await cache.play(
                                                                      voiceDora),
                                                              await Future.delayed(
                                                                  Duration(
                                                                      milliseconds:
                                                                          4000)),
                                                              playerDora.stop()
                                                            },
                                                          ),
                                                        ),
                                                        Center(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 25, 0),
                                                          child:
                                                              RoundIconButton(
                                                            icon: prefVoice ==
                                                                    PrefVoice
                                                                        .DORA
                                                                ? Icons
                                                                    .radio_button_checked
                                                                : Icons
                                                                    .radio_button_off,
                                                            iconSize: 30,
                                                            circleSize: 30,
                                                            onPressed: () => {
                                                              prefVoice == PrefVoice.KARL
                                                                  ? _databaseBloc.add(ActionPerformedEvent(
                                                                      prefVoice:
                                                                          PrefVoice
                                                                              .DORA,
                                                                      saveRecord:
                                                                          voiceRecord,
                                                                      manualFix:
                                                                          isManualCorrection,
                                                                      schoolname:
                                                                          schoolname,
                                                                      classname:
                                                                          classname,
                                                                      agreement:
                                                                          agreement,
                                                                      name:
                                                                          name,
                                                                      age: age))
                                                                  : {}
                                                            },
                                                            size: null,
                                                          ),
                                                        ))
                                                      ]),
                                                      Column(children: [
                                                        Center(
                                                          child: ImageButton(
                                                              children: <
                                                                  Widget>[],
                                                              unpressedImage:
                                                                  Image.asset(
                                                                      'assets/icons/man_speaking.png'),
                                                              pressedImage:
                                                                  Image.asset(
                                                                      'assets/icons/man_speaking.png'),
                                                              width: 75,
                                                              height: 75,
                                                              onTap:
                                                                  () async => {
                                                                        playerKarl =
                                                                            await cache.play(voiceKarl),
                                                                        await Future.delayed(Duration(
                                                                            milliseconds:
                                                                                4000)),
                                                                        playerKarl
                                                                            .stop()
                                                                      }),
                                                        ),
                                                        Center(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 20, 0),
                                                          child:
                                                              RoundIconButton(
                                                            icon: prefVoice ==
                                                                    PrefVoice
                                                                        .DORA
                                                                ? Icons
                                                                    .radio_button_off
                                                                : Icons
                                                                    .radio_button_checked,
                                                            iconSize: 30,
                                                            circleSize: 30,
                                                            onPressed: () => {
                                                              prefVoice == PrefVoice.DORA
                                                                  ? _databaseBloc.add(ActionPerformedEvent(
                                                                      prefVoice:
                                                                          PrefVoice
                                                                              .KARL,
                                                                      saveRecord:
                                                                          voiceRecord,
                                                                      manualFix:
                                                                          isManualCorrection,
                                                                      schoolname:
                                                                          schoolname,
                                                                      classname:
                                                                          classname,
                                                                      agreement:
                                                                          agreement,
                                                                      name:
                                                                          name,
                                                                      age: age))
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
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              // F J Ö L D I   R É T T   G I S K A Ð / Tilraunir

                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 300,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          settingsBackgroundCards,
                                                      border: Border.all(
                                                        color:
                                                            settingsBorderColor,
                                                        width: 5,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: CheckboxListTile(
                                                    title: Text(
                                                      "Handvirk villumeðhöndlun fyrir raddgreiningu",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Metropolis',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    //    <-- label
                                                    value: isManualCorrection,
                                                    onChanged: (newValue) => {
                                                      _databaseBloc.add(
                                                          ActionPerformedEvent(
                                                              prefVoice:
                                                                  prefVoice,
                                                              saveRecord:
                                                                  voiceRecord,
                                                              manualFix:
                                                                  newValue,
                                                              schoolname:
                                                                  schoolname,
                                                              classname:
                                                                  classname,
                                                              agreement:
                                                                  agreement,
                                                              name: name,
                                                              age: age))
                                                    },
                                                  ))),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
                                            // F J Ö L D I   R É T T   G I S K A Ð / Tilraunir

                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 300,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    color:
                                                        settingsBackgroundCards,
                                                    border: Border.all(
                                                      color:
                                                          settingsBorderColor,
                                                      width: 5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: CheckboxListTile(
                                                  title: Text(
                                                    "Leyfa vistun á upptökum til að hægt sé að bæta talgreinirinn. (Vistast ekki undir nafni)",
                                                    style: TextStyle(
                                                      fontFamily: 'Metropolis',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  //    <-- label
                                                  value: voiceRecord,
                                                  // selected: isManualCorrection,

                                                  onChanged: (newValue) => {
                                                    _databaseBloc.add(
                                                        ActionPerformedEvent(
                                                            prefVoice:
                                                                prefVoice,
                                                            saveRecord:
                                                                newValue,
                                                            manualFix:
                                                                isManualCorrection,
                                                            schoolname:
                                                                schoolname,
                                                            classname:
                                                                classname,
                                                            agreement:
                                                                agreement,
                                                            name: name,
                                                            age: age))
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
                                        transformAlignment:
                                            Alignment.bottomCenter,
                                        child: BottomSettings(
                                            onTapApprove: () {
                                              _databaseBloc.add(SaveSpecialData(
                                                prefVoice: prefVoice,
                                                saveRecord: voiceRecord,
                                                manualFix: isManualCorrection,
                                                schoolname: schoolname,
                                                classname: classname,
                                                agreement: agreement,
                                                name: name,
                                                age: age,
                                              ));
                                              Navigator.pop(context);
                                            },
                                            onTapDecline: () {
                                              Navigator.pop(context);
                                            },
                                            image:
                                                'assets/images/bottomBar_bl.png')))
                              ]),
                    Column(children: <Widget>[
                      Expanded(
                          flex: 22,
                          child: Container(
                            transformAlignment: Alignment.topCenter,
                            child: !isInit
                                ? Loading()
                                : Form(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                            initialValue: this.name,
                                            style: TextStyle(
                                                fontFamily: 'Metropolis',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 36, 9, 238)),
                                            decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Metropolis',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black),
                                                labelText: 'Nafn barns'),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Vinsamlegast fyllið út nafn';
                                              }
                                              return null;
                                            },
                                            onChanged: (newValue) => {
                                              _databaseBloc.add(
                                                  ActionPerformedEvent(
                                                      prefVoice: prefVoice,
                                                      saveRecord: voiceRecord,
                                                      manualFix:
                                                          isManualCorrection,
                                                      schoolname: schoolname,
                                                      classname: classname,
                                                      agreement: agreement,
                                                      name: newValue,
                                                      age: age))
                                            },
                                            // onSaved: (value) => name = value,
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            child: DropdownButtonFormField2(
                                                style: TextStyle(
                                                    fontFamily: 'Metropolis',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromARGB(
                                                        255, 36, 9, 238)),
                                                itemPadding:
                                                    EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                value: this.schoolname,
                                                decoration: InputDecoration(
                                                  labelText: 'Skóli',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Metropolis',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black),
                                                ),
                                                // validator: (value) {
                                                //   if (value.isEmpty) {
                                                //     return 'Vinsamlegast fyllið út skóla';
                                                //   }
                                                //   return null;
                                                // },
                                                items: schoolnamelist
                                                    .map((label) =>
                                                        DropdownMenuItem(
                                                          child: Text(label),
                                                          value: label,
                                                        ))
                                                    .toList(),
                                                onChanged: (newValue) => {
                                                      _databaseBloc.add(
                                                          ActionPerformedEvent(
                                                              prefVoice:
                                                                  prefVoice,
                                                              saveRecord:
                                                                  voiceRecord,
                                                              manualFix:
                                                                  isManualCorrection,
                                                              schoolname:
                                                                  newValue,
                                                              classname:
                                                                  classname,
                                                              agreement:
                                                                  agreement,
                                                              name: name,
                                                              age: age))
                                                    })),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontFamily: 'Metropolis',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 36, 9, 238)),
                                            initialValue: this.classname,
                                            decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Metropolis',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black),
                                                labelText: 'Bekkur'),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Vinsamlegast fyllið út bekki';
                                              }
                                              return null;
                                            },
                                            onChanged: (newValue) => {
                                              _databaseBloc.add(
                                                  ActionPerformedEvent(
                                                      prefVoice: prefVoice,
                                                      saveRecord: voiceRecord,
                                                      manualFix:
                                                          isManualCorrection,
                                                      schoolname: schoolname,
                                                      classname: newValue,
                                                      agreement: agreement,
                                                      name: name,
                                                      age: age))
                                            },
                                            // onSaved: (value) => classname = value,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontFamily: 'Metropolis',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 36, 9, 238)),
                                            initialValue: this.age,
                                            decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Metropolis',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black),
                                                labelText: 'Aldur barns'),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Vinsamlegast fyllið út aldur barns';
                                              }
                                              return null;
                                            },
                                            onChanged: (newValue) => {
                                              _databaseBloc.add(
                                                  ActionPerformedEvent(
                                                      prefVoice: prefVoice,
                                                      saveRecord: voiceRecord,
                                                      manualFix:
                                                          isManualCorrection,
                                                      schoolname: schoolname,
                                                      classname: newValue,
                                                      agreement: agreement,
                                                      name: newValue,
                                                      age: newValue))
                                            },
                                            // onSaved: (value) => age = value,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                          )),
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
                                      schoolname: schoolname,
                                      classname: classname,
                                      agreement: agreement,
                                      name: name,
                                      age: age,
                                    ));
                                    Navigator.pop(context);
                                  },
                                  onTapDecline: () {
                                    Navigator.pop(context);
                                  },
                                  image: 'assets/images/bottomBar_bl.png')))
                    ])
                  ]))));
    }));
  }
}
