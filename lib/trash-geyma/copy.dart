

/**
class OneFinish extends StatelessWidget {
  OneFinish({@required this.stig});
  double stig;
  static const String id = 'OneFinish';

  @override
  Widget build(BuildContext context) {
    //sleep(const Duration(milliseconds: 100));
    return LevelFin(
      stig: stig,
      image: 'assets/images/cat_skuggi-05.png',
      undertext: '\n stig fyrir þetta borð!',
      appBarText: 'Lágstafir',
    );
  }
}

class LevelFin extends StatelessWidget {
  LevelFin({
    @required this.stig,
    this.image,
    this.undertext,
    this.appBarText,
  });

  double stig;
  String image;
  String undertext;
  String appBarText;

  String currentScore;
  String currentScoreTwo;
  String currentScoreThree;

  QuizBrain quizBrain = QuizBrain();
  QuizBrainLvlTwo quizBrainTwo = QuizBrainLvlTwo();
  QuizBrainLvlThree quizBrainThree = QuizBrainLvlThree();

  final _formKey = GlobalKey<FormState>();

  String writePoints() {
    quizBrain.reset();
    quizBrainTwo.reset();
    quizBrainThree.reset();
    return stig.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    String highestScore = '\n Jei þú slóst metið þitt!';
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          double stigamet = stig;
          if (double.parse(userData.score) > stigamet) {
            stigamet = double.parse(userData.score);
            highestScore = '';
          }
          return Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: cardColor,
                title: Text(appBarText),
              ),
              endDrawer: SideMenu(),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        highestScore,
                        style: finishSmallText,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topCenter,
                              child: Image.asset(image),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 30, right: 10),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: writePoints(),
                                  style: TextStyle(
                                    height: 1,
                                    letterSpacing: -5,
                                    fontFamily: 'Metropolis-Medium.otf',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 100,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: undertext,
                                      style: finishSmallText,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            child: SetScore(
                              currentScore: stigamet.toStringAsFixed(0),
                              level: LevelOne.id,
                              text: 'Aftur í lágstafi',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              child: SetScore(
                                currentScore: stigamet.toStringAsFixed(0),
                                level: LevelOneCap.id,
                                text: 'Hástafir',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              child: SetScore(
                                currentScore: stigamet.toStringAsFixed(0),
                                level: LvlTwoChoose.id,
                                text: 'Borð 2: Orð',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BottomBar(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        image: 'assets/images/bottomBar_ye.png'),
                  ],
                ),
              ),
            ),
          );
        }
        return Loading();
      },
    );
  }
}
