import processing.pdf.*;

int t = 10;
int dmin = 20;
int dmax = 30;
boolean grabaVector;

boolean imagenCargada;
ArrayList<PVector> coords;
PImage img;

void setup() {
  selectInput("Selecciona imagen a procesar:", "fileSelected");
  size (1920, 1080);

  background(255);
  strokeWeight(0.5);
  stroke(0, 100);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Se usa imagen demo.");
    img = loadImage("pict.jpg");
    imagenCargada = true;
  } else {
    println("Archivo seleccionado: " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    imagenCargada=true;

    if (grabaVector)
      beginRecord(PDF, "lineas.pdf");
  }

  coords = new ArrayList<PVector>();

  if (imagenCargada) {
    println(img.width);
    println(img.height);
  }
  //noLoop();
}

void draw () {
  if (imagenCargada) {
    println("Inicia Draw");
    for (int j = 0; j < img.height; j += t) {
      for (int i = 0; i < img.width; i += t) {
        color c = img.get(int(i), int(j));
        float b = brightness(c);
        int numP = 0;
        //if (b<250)
        numP = int(map(b, 0, 255, 5, 0));
        if (numP>0)
          modulo(i, j, t, numP);
      }
    }
    println("Calculando...");

    noFill();    

    for (int i=coords.size()-1; i>0; i--) {
      PVector inicio = coords.get(i);
      for (int j=coords.size()-1; j>0; j--) {

        PVector dest = coords.get(j);
        float d = dist(inicio.x, inicio.y, dest.x, dest.y);

        if (d>dmin && d<dmax) {
          line(inicio.x, inicio.y, dest.x, dest.y);
        }
      }
    }

    println("Grabando imagen.");
    saveFrame("data/imgToVector.png");

    if (grabaVector) {
      endRecord();
      grabaVector = false;
      exit();
    }
    println("Todo Listo... cerrando aplicación");
    delay(1000);

    exit();
  }
  if (frameCount%60==0)
    println("En espera de carga imagen");
}

void modulo(int px, int py, int t, int n) {
  for (int i=0; i<n; i++) {
    float ppx = px+random(t);
    float ppy = py+random(t);
    //point(ppx, ppy);
    coords.add(new PVector(ppx, ppy));
  }
}
