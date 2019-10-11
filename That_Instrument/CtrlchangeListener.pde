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
        int part = event.getData1() - 110;
        println(event.getTick());
        if(seqStat == 0){
            switch (part) {
                case 0:
                    
                    break;

                case 1:

                    break;

                case 2:

                    break;

                case 3:
                    manager.beatEffect(#FFCC00);
                    break;
            }
        }

    }
}