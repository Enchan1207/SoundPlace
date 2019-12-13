/*
 * コントロールチェンジを受け取る
*/

import javax.sound.midi.*;

public class CtrlchangeListener extends Thread implements ControllerEventListener {

    private final Sequencer sequencer;
    private SparcleManager manager;

    public CtrlchangeListener(Sequencer sequencer, SparcleManager manager) {
        this.sequencer = sequencer;
        this.manager = manager;
    }

    @Override
    public void controlChange(ShortMessage event) {
        //--イベントが発火したパートとパートの選択状態を取得
        int part = event.getData1() - 110, cell = selidx[part];
        color col = efColor[part];

        //--エフェクト表示
        manager.note3DEffect(col, part);

    }
}