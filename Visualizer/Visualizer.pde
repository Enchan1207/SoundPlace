import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioPlayer jingle;
FFT fftLin;
FFT fftLog;

float spectrumScale = 10;

void setup(){
  size(512, 512);
  colorMode(HSB, 360, 100, 100);

  minim = new Minim(this);
  jingle = minim.loadFile("music.mp3", 1024);
  jingle.setGain(-30);
  jingle.play();
  
  fftLin = new FFT(jingle.bufferSize(), jingle.sampleRate());
  fftLin.linAverages(100);
  fftLog = new FFT(jingle.bufferSize(), jingle.sampleRate());
  fftLog.logAverages(22, 3);
  
  rectMode(CORNERS);
  noStroke();
}

void draw(){
  background(0);

  fftLin.forward(jingle.mix);
  fftLog.forward(jingle.mix);

  int w = int(width / fftLin.avgSize());
  for(int i = 0; i < fftLin.avgSize(); i++){
    fill(i * w, 40, 100);
    float size = fftLin.getAvg(i) * spectrumScale;
    //arc(256, 256, size, size, radians(i*12),radians(i*12+12));
    rect(i * w, height, i * w + w, height - fftLin.getAvg(i) * spectrumScale);
  }
}
