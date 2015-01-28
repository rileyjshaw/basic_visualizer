
import ddf.minim.analysis.*;
import ddf.minim.*;
 
Minim minim;

AudioPlayer song;
FFT fft;

float hue = 0;
 
void setup () {
  size(1920 / 2, 1080 / 2, P3D);
  minim = new Minim(this);
    
  song = minim.loadFile("Watermelon Beef Man.mp3", 512);
  song.loop();
   
  fft = new FFT(song.bufferSize(), song.sampleRate());
  fft.window(FFT.HAMMING);
  
  colorMode(HSB, 360, 100, 100);
  smooth();
}
 
void draw () {
  float band;
  color barColor = color(hue, 100, 100);
  
  fft.forward(song.mix);
  
  background(12);
  for (int i = 0; i <= 150; i += 2) {
    // get magnitude at frequency i
    band = fft.getBand(i / 2);

    stroke(barColor);
    strokeWeight(width / 150);
    line(width * i / 150, height / 2 - 10 - 4 * band, width * i / 150, height / 2 + 10 + 4 * band);
    
    hue = (hue + 0.0005) % 360;
  }
}
 
void stop() {
  song.close();
  minim.stop();
   
  super.stop();
}

