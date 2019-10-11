String[] lineas;
String[] etiquetas;
String[] coordenadas;
//String

PVector posCadera, posHead;
PVector rotCadera, rotHead;

int lineaLectura = 7;
int ultimaLinea;

int t1 = 15;
PVector[] cubo; // posiciones de cubo

boolean anima = true;
int[] pt = {
  //FERMIN
/*5,*//*23,*/  29, /*47,*/ 53, 68, 80, 92, 98, 
/*113,*/  125, 137, 143, 158, 170, 182, 194, 206, 218, 
  // IRASEMA
  266, 290, 305, 317, 329, 335, 362, 
  374, 380, 395, 407, 419, 431, 443, 455
};

boolean archivoCargado;

void setup() {
  //size(800, 800, P3D);
  //surface.setLocation(0, 0);
  fullScreen(P3D);
  selectInput("Cargar archivo *.CSV:", "fileSelected");

  frameRate(30);
}



void fileSelected(File selection) {
  if (selection == null) {
    lineas = loadStrings("dance01.csv");
    archivoCargado = true;
  } else {
    println("Archivo seleccionado: " + selection.getAbsolutePath());
    lineas = loadStrings(selection.getAbsolutePath());
    archivoCargado = true;
  }
  if (archivoCargado) {
    println(lineas.length); // 4872 numero de lineas

    ultimaLinea = lineas.length-1;

    etiquetas = split(lineas[2], ",");
    println(etiquetas.length);

    coordenadas = split(lineas[lineaLectura], ",");

    rotCadera = new PVector(float(coordenadas[2]), float(coordenadas[3]), float(coordenadas[4]));
    posCadera = new PVector(float(coordenadas[5]), float(coordenadas[6]), float(coordenadas[7]));  
    rotHead = new PVector(float(coordenadas[50]), float(coordenadas[51]), float(coordenadas[52]));
    posHead = new PVector(float(coordenadas[53]), float(coordenadas[54]), float(coordenadas[55]));

    cubo = new PVector[pt.length];
    for (int i=0; i<pt.length; i++) {
      cubo[i] = new PVector(0, 0, 0);
    }
  }
}


void escribePos(int indice, int inicio) {
  if (coordenadas[inicio] != null)
    cubo[indice] = new PVector(float(coordenadas[inicio]), float(coordenadas[inicio+1]), float(coordenadas[inicio+2]));
  pushMatrix();
  translate(cubo[indice].x, cubo[indice].y, cubo[indice].z);
  rotateX(radians(float(coordenadas[inicio-3])));
  rotateY(radians(float(coordenadas[inicio-2])));
  rotateZ(radians(float(coordenadas[inicio-1])));
  box(t1);
  popMatrix();
}
void escribePos(int indice, int inicio, int tam) {
  if (coordenadas[inicio] != null)
    cubo[indice] = new PVector(float(coordenadas[inicio]), float(coordenadas[inicio+1]), float(coordenadas[inicio+2]));
  pushMatrix();
  translate(cubo[indice].x, cubo[indice].y, cubo[indice].z);
  rotateX(radians(float(coordenadas[inicio-3])));
  rotateY(radians(float(coordenadas[inicio-2])));
  rotateZ(radians(float(coordenadas[inicio-1])));
  box(tam);
  popMatrix();
}
void escribePos(int indice, int inicio, int tamX, int tamY, int tamZ) {
  if (coordenadas[inicio] != null)
    cubo[indice] = new PVector(float(coordenadas[inicio]), float(coordenadas[inicio+1]), float(coordenadas[inicio+2]));
  pushMatrix();
  rotateX(radians(float(coordenadas[inicio-3])));
  rotateY(radians(float(coordenadas[inicio-2])));
  rotateZ(radians(float(coordenadas[inicio-1])));
  translate(cubo[indice].x, cubo[indice].y, cubo[indice].z);
  box(tamX, tamY, tamZ);
  popMatrix();
}
int npz = 580;

void draw() {
  background(100);
  camera(150, 100, 650, 0, 0, 0, 0, -1, 0);

  if (archivoCargado) {

    for (int i=0; i<pt.length; i++) {
      escribePos(i, pt[i]); //
    }
    //print(coordenadas[28]+", ");
    /*
  escribePos(0, 104); //
     escribePos(1, 155); // 
     escribePos(2, 53); // cintura
     escribePos(3, 248); // pie izq
     escribePos(4, 257); //  pie der
     escribePos(5, 5, 10); //
     escribePos(6, 29); //
     escribePos(7, 23); //
     escribePos(8, 47); //
     escribePos(9, 92); //
     escribePos(10, 143); //
     escribePos(11, 194); //
     escribePos(12, 224); //
     escribePos(13, 80); //
     escribePos(14, 131); // 
     escribePos(15, 170); // 
     escribePos(16, 182); // 
     escribePos(17, 209); // 
     escribePos(18, 221); // 
     */

    //escribePos(28, 464, 5, 5, 50); // RB
    //escribePos(29, npz); //

    ////// UPDATE 
    coordenadas = split(lineas[lineaLectura], ",");

    if (anima) {
      lineaLectura++;
      lineaLectura = lineaLectura%ultimaLinea;
      if (lineaLectura==0)
        lineaLectura=7;
    }
  }
}

void keyPressed() {
  if (key=='q')
    npz--;
  if (key=='w')
    npz++;


  if (key=='a')
    anima=!anima;
}
