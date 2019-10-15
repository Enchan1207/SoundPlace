/*
 * コントロールチェンジを受け取る
*/

import javax.sound.midi.*;

public class CtrlchangeListener extends Thread implements ControllerEventListener {

    private final Sequencer sequencer;

    public CtrlchangeListener(Sequencer sequencer) {
        this.sequencer = sequencer;
    }

    @Override
    public void controlChange(ShortMessage event) {
        int part = event.getData1() - 110, cell = selidx[part];
        color col = efColor[selidx[part]];

        if(seqStat == 0){
            switch (part) {
                case 0: //メインチャンネル
                    
                    break;

                case 1: //サブチャンネル

                    break;

                case 2: //ベースチャンネル
                    
                    break;

                case 3: //ドラムチャンネル
                    switch (cell) {
                        case 0: //mキー
                            
                            break;

                        case 1: //nキー
                            
                            break;

                        case 2: //oキー
                            
                            break;

                        case 3: //pキー
                            
                            break;
                    }
                    break;
            }
        }

    }
}