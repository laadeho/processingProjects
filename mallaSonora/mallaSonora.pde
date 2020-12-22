//Nodos n;
//ArrayList<Nodos> nodoAL;
import processing.dxf.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;

Malla malla;

boolean graba;
boolean audioCargado;

int numSeg = 32;
int anchoTotal = 4000;
float promedia = 0;

void setup() {
  //fullScreen(P3D, 1);
  size(1920, 1200, P3D);
  surface.setLocation(1920, 0);
  surface.setResizable(false);

  //size(displayWidth, displayHeight, P3D);
  background(0);

  minim = new Minim(this);
  selectInput("Selecciona Audio a procesar:", "fileSelected");

  //n = new Nodos(8, 200);
  //nodoAL = new ArrayList<Nodos>();
  malla = new Malla();


  noCursor();
  noStroke();
}

void fileSelected(File selection) {
  surface.setSize(800, 600);
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Archivo seleccionado: " + selection.getAbsolutePath());
    player = minim.loadFile(selection.getAbsolutePath());
    player.play();
    audioCargado=true;
    surface.setSize(displayWidth, displayHeight);
  }
}

void draw() {
  if (audioCargado) {
    if (graba) {
      beginRaw(DXF, "output####.dxf"); // Start recording to the file
      camera(1500, -6500, -15000, 1500, 0, -15000, -1, -1, 0);
    } else
      camera(-1000, -800, -5500, 100, -550, -5500, 0, 1, 0);
    background(0);
    lights();
    malla.draw();
    malla.update();

    float vals[];
    vals = new float[numSeg];
    for (int i = 0; i < numSeg; i++)
      //  for (int i = 0; i < player.bufferSize() - 1; i++)
    {
      vals[i] = (player.right.get(i*(player.bufferSize()/numSeg)) + player.left.get(i*(player.bufferSize()/numSeg)))*150;
      /*
     float x1 = map( i, 0, player.bufferSize()/numSeg, 0, width ); 
       float x2 = map( i+1, 0, player.bufferSize()/numSeg, 0, width ); 
       */

      /*
    line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
       line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
       */
    }


    for (int i=0; i<player.bufferSize()-1; i++) {
      promedia += (player.left.get(i) + player.right.get(i))*10;
    }
    promedia = promedia / player.bufferSize();



    //println(promedia);
    if (abs(promedia) > 0.05 && frameCount%5 == 0) {
      malla.nodosList.add(new Nodos(numSeg, anchoTotal, vals)); 
      promedia = 0;
    }
    //n.draw();
    //n.update();

    //for (int i=nodoAL.size()-1; i>=0; i--) {
    //  Nodos nd = nodoAL.get(i);
    //  nd.draw();
    //  nd.update();
    //}

    //if(frameCount % 15 == 0){
    //  nodoAL.add(new Nodos(16, 450));
    //}

    if (graba) {
      endRaw(); 
      graba = false; // Stop recording to the file
    }
  }
}
void keyPressed() {
  //nodoAL.add(new Nodos(16, 450));
  if (key == 'R' || key == 'r') { // Press R to save the file
    graba = true;
  } else if (key == 's') {
    saveFrame("####.png");
  }
}
