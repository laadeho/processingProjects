import processing.pdf.*;

int t = 15;
int dmin = 25;
int dmax = 32;
boolean grabaVector;

boolean imagenCargada;
ArrayList<PVector> coords;
PImage img;

void setup() {
  size (1700, 1100);
  selectInput("Selecciona imagen a procesar:", "fileSelected");
  coords = new ArrayList<PVector>();

  if (imagenCargada) {
    println(img.width);
    println(img.height);
    background(255);
    strokeWeight(1);
    //ellipseMode(CORNER);
    if (grabaVector)
      beginRecord(PDF, "lineas.pdf");
    noLoop();
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Se usa imagen demo.");
    img = loadImage("caras.jpeg");
    imagenCargada = true;
    //calculaContornos = true;
  } else {
    println("Archivo seleccionado: " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    imagenCargada=true;
    //calculaContornos = true;
  }
}

void draw () {
  if (imagenCargada) {
    for (int f = 0; f < img.height; f = f + t) {
      for (int a = 0; a < img.width; a = a + t) {
        color c = img.get(int(a), int(f));
        float b = brightness(c);
        //noStroke();
        //fill(c);
        //ellipse(f+2.5, a+2.5, t*.75, t*.75);
        //fill(c, 240);
        //rect (f, a, t, t);
        int numP = 0;
        //if (b<250)
        numP = int(map(b, 0, 255, 3, 0));

        float ta = map(b, 0, 255, t, 0)-1;
        /*
      if (int(ta)>2)
         circ(a, f, ta);
         */

        if (numP>1)
          modulo(a, f, t, numP);
      }
    }
    println("listo");
    //saveFrame("data/px"+day()+hour()+minute()+".jpg");
    //exit();
    noFill();    
    //beginShape();

    for (int i=coords.size()-1; i>0; i--) {
      PVector inicio = coords.get(i);
      for (int j=coords.size()-1; j>0; j--) {

        PVector dest = coords.get(j);
        float d = dist(inicio.x, inicio.y, dest.x, dest.y);

        if (d>dmin && d<dmax) {
          line(inicio.x, inicio.y, dest.x, dest.y);
          //curveVertex(inicio.x, inicio.y);//, dest.x, dest.y);
          //println("Punto: "+i);
        }
      }
    }
    //endShape();
    println("fin");

    if (grabaVector) {
      endRecord();
      grabaVector = false;
      exit();
    }
  }
}
void modulo(int px, int py, int t, int n) {
  /*int choose = int(random(2));
   if (choose == 0) {
   for (int i=0; i<n; i++) {
   line(px, py+(t/n)*i, px+t, py+(t/n)*i);
   }
   } else {
   for (int i=0; i<n; i++) {
   line(px+(t/n)*i, py, px+(t/n)*i, py+t);
   }
   }*/
  for (int i=0; i<n; i++) {
    float ppx = px+random(t);
    float ppy = py+random(t);
    //point(ppx, ppy);
    coords.add(new PVector(ppx, ppy));
  }
}

void circ(int px, int py, float t) {
  ellipse(px, py, t, t);
}
