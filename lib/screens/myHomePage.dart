import 'dart:math';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:rive/rive.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConfettiController? _confettiController;

  @override
  void dispose() {
    _confettiController!.dispose();

    super.dispose();
  }

  AssetsAudioPlayer player1 = AssetsAudioPlayer();
  AssetsAudioPlayer player2 = AssetsAudioPlayer();

  List<bool> isImageVisibleList1 = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];

  final List<int> numberlist1 = [
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30)
  ];

  final numberDiv = nextNumber(min: 2, max: 6);

  List<RiveAnimation> iconList1 = const [
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv'),
    RiveAnimation.asset('assets/rive/balloonright.riv')
  ].toList();
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  Image balloonImage = const Image(
      fit: BoxFit.contain, image: AssetImage('assets/images/balloonblue.png'));

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 500));

    super.initState();

    player1.open(Audio('assets/audio/Win.mp3'),
        autoStart: false, showNotification: true);

    player2.open(Audio('assets/audio/Lose.wav'),
        autoStart: false, showNotification: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/bg.jpg'),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Find The Numbers Which Are Divisible By $numberDiv',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 8,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children: List.generate(
                        numberlist1.length,
                        (index) => Column(
                              children: [
                                // ConfettiWidget(
                                //   confettiController: _confettiController!,
                                //   //shouldLoop: true,
                                //   blastDirection: pi / 2,
                                //   colors: const [
                                //     Colors.red,
                                //     Colors.green,
                                //     Colors.yellow,
                                //     Colors.purpleAccent,
                                //     Colors.orange
                                //   ],
                                //   numberOfParticles: 2,
                                //   gravity: .25,
                                //   blastDirectionality:
                                //       BlastDirectionality.explosive,

                                //   emissionFrequency: 0.025,
                                // ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (numberlist1[index] % numberDiv ==
                                            0) {
                                          player1.play();
                                          isImageVisibleList1[index] = false;
                                          // _confettiController!.play();

                                          iconList1[index] =const RiveAnimation.asset(
                                              'assets/rive/balloonrightnew.riv');
                                          score++;
                                          correctAnswers++;
                                        } else {
                                          player2.play();
                                          isImageVisibleList1[index] = false;
                                          iconList1[index] =const RiveAnimation.asset(
                                              'assets/rive/balloonwrongnew.riv');
                                          //score--;
                                          wrongAnswers++;
                                        }
                                      });
                                    },
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Stack(
                                        children: [
                                          isImageVisibleList1[index]
                                              ? balloonImage
                                              : const Text(''),
                                          isImageVisibleList1[index]
                                              ? Center(
                                                  child: Text(
                                                    '${numberlist1[index]}',
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : iconList1[index]
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Total Correct Answers $correctAnswers ',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Total Wrong Answers $wrongAnswers ',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
                const Spacer(),
                Text(
                  'Your Final Score is $score',
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// create a method to show randow numbers between 2 numbers
int nextNumber({required int min, required int max}) =>

    //max 50 , min 5
    //1.50-5 = 45
    //2.Random.nextInt(45+1)=>0...45
    //3.5 + 0 ... 45 => 5...50

    min + Random().nextInt(max - min + 1);
