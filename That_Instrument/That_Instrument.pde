/*
 * SoundPlace 本体
*/

import midiMixer.*;
import javax.sound.midi.*;
import java.io.*;
import javax.swing.*;
import processing.opengl.*;

//--映像関連
SparcleManager manager = new SparcleManager();

//--midi関連
Sequencer sequencer;
SeqMixer mixer = new SeqMixer(Sequence.PPQ, 480);
Sequence selected[] = new Sequence[4];
Sequence sequences[][] = new Sequence[4][4];
int tempo = 128; //テンポ
int selidx[] = {3, 0, 2, 1}; //各チャンネルで選択されている音源番号
color efColor[] = {
    color(255, 119, 119), 
    color(119, 255, 119), 
    color(119, 119, 255), 
    color(119, 255, 255)
}; //エフェクトカラー
int efcID = 0; //最後に選択された列番号

//楽器番号はちょっと長くなるので別で記述
//番号の特定は instlist[i][selidx[i]] でぶん回せばよい
int instlist[][] = {
    {  1, 86, 36,  1}, //音源パターン1
    {111, 95, 44,  1}, //音源パターン2
    { 11, 98, 32,  1}, //音源パターン3
    { 90, 31, 15,  1} //音源パターン4
};

//--システム
int lcnt = 0;
int seqStat = 0; //シーケンサの状態 ファイル切り替え時1になりエフェクトが無効化される
int mils = 0, mils_ = 0; //コントローラが操作されるインターバル
int efmode = 0; //常時エフェクトのモード

//--
void setup() {

    //--描画準備
    fullScreen(OPENGL);
    noCursor();

    //--ミックスする音源ファイルを取得
    File homeDir[] = new File("/Users/ttsof/Desktop/LunaCF/SourceCode/Processing/App/SoundPlace/That_Instrument/musics").listFiles();
    for(int i = 0; i < 4; i++){
        File childDir[] = homeDir[i].listFiles();
        for(int j = 0; j < 4; j++){
            try {
                sequences[i][j] = MidiSystem.getSequence(childDir[j]);
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }

    //--シーケンサ準備
    try {
        sequencer = MidiSystem.getSequencer(true);
        sequencer.open();
        //--受け取るコントロール番号を指定してリスナ追加
        int ctrls[] = {110, 111, 112, 113};
        sequencer.addControllerEventListener(new CtrlchangeListener(sequencer, manager), ctrls);
    } catch (Exception e) {
        e.printStackTrace();
    }

    //--ミキサー起動
    mix();
    
}

void draw() {
    background(0x00);
    pointLight(255, 255, 255, width, 0, 400);
    camera(
        width, 0, 200, //視点位置
        1154, 394, -500, //注視方向
        0, 1, 0 //カメラの向き
    ); 
    manager.update();
    if(lcnt % 50 == 0){
        switch (efmode) {
            case 0:
                manager.arrowEffect(efColor[efcID]);    
                break;

            case 1:
                manager.arrowEffect(efColor[efcID]);    
                break;
        }
    }

    if(lcnt % 500 == 0){
        efmode = int(random(2));
    }

    lcnt++;
}

//--選択状態によってミックス
void mix(){
    mixer = new SeqMixer(Sequence.PPQ, 480);
    for(int i = 0; i < 4; i++){
        mixer.setSequence(i, sequences[i][selidx[i]]);
    }
    int insts[] = new int[16];
    int volumes[] = {0, 0, 0, 0};
    int chList[] = {1, 2, 3, 4, 5, 6, 10, 11, 12, 7, 8, 9};
    for(int i = 0; i < 4; i++){
        for(int j = i * 3; j < i * 3 + 3; j++){
            insts[chList[j]] = instlist[selidx[i]][i];
        }
    }
    mixer.setInsts(insts);

    long current = 0; //現在位置
    if(sequencer.isRunning()){
        current = sequencer.getTickPosition();
    }
    try {
        seqStat = 1;
        sequencer.stop();
        sequencer.setSequence(mixer.getSequence());
        sequencer.setTickPosition(current);
        sequencer.setLoopStartPoint(0);
        sequencer.setLoopEndPoint(sequencer.getTickLength());
        sequencer.setLoopCount(-1);
        sequencer.start();
        seqStat = 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
}

void mousePressed(){
    manager.hexaWallEffect(#FFFFFF);
}