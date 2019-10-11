import processing.video.*;
import processing.pdf.*;

String rutaCaptura;
int numCapTotal = 50;
boolean grabaFrames = true;

boolean grabaTimeLineVector = false;

Movie vid;

int vidW, vidH;
boolean calculaEscala = true;
boolean inicio, play;

PGraphics pg;
int cuadros;
float cuadroAct;
float saltoTime;
float timeCap;
float lapso;


void setup() {
  size(1920, 1080, P3D);
  selectInput("Selecciona Video a procesar:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Archivo seleccionado: " + selection.getAbsolutePath());
    vid = new Movie(this, selection.getAbsolutePath());
    vid.read();
    selectFolder("Selecciona la ubicación de captura de cuadros:", "folderSelected");
  }
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Ruta seleccionada " + selection.getAbsolutePath());
    rutaCaptura = selection.getAbsolutePath();

    vid.play();
    vid.volume(0);
    inicio = true;
  }
}

void movieEvent(Movie m) {
  m.read();
}


void draw() {
  if (inicio) {
    background(0);
    if (calculaEscala && vid.available()) {
      println("Width: " + vid.width + ", Height: " + vid.height);
      if (vid.width > width) {
        float factor = int(width * 100) / int(vid.width);
        println("Factor escala: "+ factor);
        vidW = int(vid.width * factor/100);
        vidH = int(vid.height * factor/100);
        println("Video resize: " + vidW + ", " + vidH);
      } else if ( vid.width == width) {
        vidW = vid.width;
        vidH = vid.height;
      }
      pg = createGraphics(vidW, vidH, P2D);

      calculaEscala = false;
    } else if (vid.available()) {
      if (!play) {

        play=true;
        saltoTime = vid.duration() / numCapTotal; //seconds
        println("saltoTime: "+saltoTime);
      }
    }
    if (play) {
      if (cuadros < numCapTotal-1) {
        //timeCap = vid.time() + saltoTime;
        //vid.jump(timeCap);

        pg.beginDraw();
        pg.image(vid, 0, 0, vidW, vidH);
        pg.endDraw();

        if (lapso > saltoTime) {
          cuadroAct = vid.time();

          if (grabaFrames)
            pg.save(rutaCaptura + "/cap/frames_"+cuadros+"_"+cuadroAct+".png");

          cuadros++;
          lapso = 0;
          println("Captura en tiempo: "+ timeCap+ ", de un total de: "+vid.duration());
        }

        lapso = abs(cuadroAct-vid.time());
        //delay(1000);
      } else {
        exit();
      }
      image(pg, 0, 0);
    }
    if (grabaTimeLineVector) {
      beginRecord(PDF, rutaCaptura+"/TimeLine_Vector.pdf");
    }
    pushStyle();
    strokeWeight(10);
    stroke(255);
    line(0, height-5, map(vid.time(), 0, vid.duration(), 0, width), height-5);
    strokeWeight(1);
    stroke(255, 0, 0);
    for (int i=0; i<numCapTotal; i++) {
      line(width/numCapTotal * i, height, width/numCapTotal * i, height-20);
    }  
    popStyle();
    if (grabaTimeLineVector) {
      endRecord();
      grabaTimeLineVector = false;
    }
  }
}
