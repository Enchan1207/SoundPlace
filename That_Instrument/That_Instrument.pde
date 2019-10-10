/*
 * SoundPlace 本体
*/

import midiMixer.*;
import MidiDevices.*;
import javax.sound.midi.*;
import java.io.*;
import javax.swing.*;
import processing.opengl.*;

//--映像関連
SparcleManager manager = new SparcleManager();

//--midi関連
MidiDevices  devices = new MidiDevices();
Sequencer sequencer;
SeqMixer mixer = new SeqMixer(Sequence.PPQ, 480);
Sequence selected[] = new Sequence[4];
Sequence sequences[][] = new Sequence[4][4];
int tempo = 128; //テンポ
long current = 0; //現在位置
int selidx[] = {0, 3, 1, 3}; //各チャンネルで選択されている音源番号
color efColor[] = {#CC0000, #00CC00, #0000CC, #CCCC00}; //エフェクトカラー

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

//--
void setup() {
    //--
    // size(400, 300, P3D);
    fullScreen(OPENGL);
    noCursor();

    //--
    devices.scan();
    devices.open(0);

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
        sequencer = MidiSystem.getSequencer(false);
        sequencer.open();
        sequencer.getTransmitter().setReceiver(devices.getReceiver());
    } catch (Exception e) {
        e.printStackTrace();
    }

    //--ミキサー起動
    mix();
    
}

void draw() {
    background(0);

    manager.update();

    /*
     * 状態にかかわらず表示されるエフェクト
    */
    if(lcnt%10 == 0){
        manager.straightEffect(#444444);
    }

    /*
     * miditickデータのカーソル位置のイベントを取得
    */

    if (current >= midiTickdata[3][selidx[3]][tickCursor[3]]){
        manager.beatEffect(#FFCC00);
        tickCursor[3]++;
        if(midiTickdata[3][selidx[3]].length <= tickCursor[3]){
            tickCursor[3] = 0;
        }
    }

    current = sequencer.getTickPosition();
    lcnt++;
}

//--選択状態によってミックス
void mix(){
    for(int i = 0; i < 4; i++){
        mixer.setSequence(i, sequences[i][selidx[i]]);
    }
    int insts[] = new int[16];
    int chList[] = {1, 2, 3, 4, 5, 6, 10, 11, 12, 7, 8, 9};
    for(int i = 0; i < 4; i++){
        for(int j = i * 3; j < i * 3 + 3; j++){
            insts[chList[j]] = instlist[selidx[i]][i];
        }
    }
    mixer.setInsts(insts);

    if(sequencer.isRunning()){
        current = sequencer.getTickPosition();
    }
    try {
        tickCursor[3] = 0;
        sequencer.stop();
        sequencer.setSequence(mixer.getSequence());
        sequencer.setTickPosition(current);
        sequencer.setLoopStartPoint(0);
        sequencer.setLoopEndPoint(sequencer.getTickLength());
        sequencer.setLoopCount(-1);
        sequencer.start();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
