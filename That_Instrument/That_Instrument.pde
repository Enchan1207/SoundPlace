/*
 * SoundPlace 本体
*/


import midiMixer.*;
import javax.sound.midi.*;
import java.io.*;

//--映像関連
SparcleManager manager = new SparcleManager();

//--midi関連
Sequencer sequencer;
SeqMixer mixer = new SeqMixer(Sequence.PPQ, 480);
Sequence selected[] = new Sequence[4];
Sequence sequences[][] = new Sequence[4][4];
int selidx[] = {0, 0, 0, 0}; //各チャンネルで選択されている音源番号
int insts[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}; //楽器番号/ch
int tempo = 120; //テンポ

//--システム
int lcnt = 0;

//--
void setup() {
    //--
    // size(400, 300, P3D);
    fullScreen(P3D);
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
        sequencer = MidiSystem.getSequencer();
        sequencer.open();
    } catch (Exception e) {
        e.printStackTrace();
    }

    //--ミキサー起動
    mix();

    // manager.beatEffect(); //この命令をミキサーかどこかでできればいいんだが…ん?こんなところにsequencerとaddeventlistenerが…?
    
    

}

void draw() {
    background(0);

    manager.update();

    if(mousePressed){
        manager.radialEffect();
    }

    lcnt++;
}

//--選択状態によってミックス
void mix(){
    for(int i = 0; i < 4; i++){
        mixer.setSequence(i, sequences[i][selidx[i]]);
    }

    long current = 0;
    if(sequencer.isRunning()){
        current = sequencer.getTickPosition();
    }
    try {
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
