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
        manager.beatEffect(#CCFF00);
    }
}