import processing.pdf.*;

// REQUIERE LIBRERÍA DE OPENCV FOR PROCESSING
import gab.opencv.*;
OpenCV opencv;

PImage img, imgPG, ref;
PGraphics pg;
ArrayList<Contour> contours;

boolean calculaEscala = true;
boolean calculaContornos;
int imgW, imgH;

boolean imagenCargada;
boolean grabaVector;
boolean esHorizontal;
boolean previo;

void setup() {
  //fullScreen();
  size(800, 800);
  selectInput("Selecciona imagen a procesar:", "fileSelected");
}

void fileSelected(File selection) {
  surface.setSize(800, 600);
  if (selection == null) {
    println("Se usa imagen demo.");
    img = loadImage("caras.jpeg");
    imagenCargada = true;
    calculaContornos = true;
  } else {
    println("Archivo seleccionado: " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    imagenCargada=true;
    calculaContornos = true;
  }
}


void draw() {
  if (imagenCargada) {

    if (img.width < img.height)
      esHorizontal = false;
    else
      esHorizontal = true;

    if (esHorizontal) {
      pg = createGraphics(800, 600);
      surface.setSize(800, 600);
    } else {
      pg = createGraphics(600, 800);
      surface.setSize(600, 800);
    }

    if (calculaEscala) {
      if (esHorizontal) {
        float factor = int(pg.width * 100) / int(img.width);
        println("Ancho pg: "+int(pg.width * 100));
        println("Ancho canvas * 100: "+ int(img.width));
        println("Factor escala: "+ factor);
        imgW = int(img.width * (factor/100));
        imgH = int(img.height * (factor/100));

        println("imgW: "+imgW+", imgH: "+imgH);
        println("pg width: "+pg.width+", height: "+pg.height);
        pg.beginDraw();
        pg.image(img, 0, 0, imgW, imgH);
        pg.endDraw();

        imgPG = pg.get();
      } else {
        float factor = int(pg.height * 100) / int(img.height);
        println("Alto pg: "+int(pg.height * 100));
        println("Alto canvas * 100: "+ int(img.height));
        println("Factor escala: "+ factor);
        imgW = int(img.width * (factor/100));
        imgH = int(img.height * (factor/100));

        println("imgW: "+imgW+", imgH: "+imgH);
        println("pg width: "+pg.width+", height: "+pg.height);
        pg.beginDraw();
        pg.image(img, 0, 0, imgW, imgH);
        pg.endDraw();

        imgPG = pg.get();
      }
      calculaEscala = false;
    } else if (calculaContornos) {
      opencv = new OpenCV(this, imgPG);
      opencv.gray();
      opencv.threshold(70);
      ref = opencv.getOutput();
      contours = opencv.findContours();

      calculaContornos = false;
    } else {
      if (mousePressed) {
        //opencv = new OpenCV(this, img);
        opencv.gray();
        if (mouseButton == LEFT) {
          opencv.brightness((int)map(mouseX, 0, width, -255, 255));
          opencv.blur(int(map(mouseY, 0, height, 2, 10)));
          opencv.threshold(int(map(mouseX, 0, width, 0, 100)));
        }
        ref = opencv.getOutput();
        contours = opencv.findContours();
      }

      image(ref, 0, 0);

      if (grabaVector) {
        beginRecord(PDF, day()+"_"+hour()+"_"+minute()+"_"+second()+"_vector.pdf");
        background(0);
      }
      for (Contour contour : contours) {
        stroke(0, 255, 0);

        contour.draw();

        //stroke(255, 0, 0);
        //beginShape();
        //for (PVector point : contour.getPolygonApproximation().getPoints()) {
        //  vertex(point.x, point.y);
        //}
        //endShape();
      }
      if (grabaVector) {
        endRecord();
        grabaVector = false;
        println("captura vector");
      }
      if (previo) {
        image(imgPG, 0, 0);
      }
    }
  }
}

void keyPressed() {
  if (key == 'p')
    previo = true;
}
void keyReleased() {
  if (key == 'r') {
    grabaVector = true;
  }
  if (key == 'p')
    previo = false;
}
