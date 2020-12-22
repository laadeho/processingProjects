import processing.pdf.*;

PrintWriter output;

PImage img;
boolean imageLoaded;
boolean mueve = true;
int np;
//ArrayList <ColorSel> cs;
ArrayList <PointLoc> pl;

boolean showImage = true;
boolean arrange;

boolean captura;

boolean dosPantallas = true;
int estilo = 0;

boolean crearTexto;

void setup() {
  selectInput("Select a file to process:", "fileSelected");
  //cs = new ArrayList<ColorSel>();
  pl = new ArrayList<PointLoc>();
}

void draw() {
  if (captura) {
    beginRecord(PDF, "capturas/"+hour()+"_"+minute()+"_"+second()+"_####.pdf");
  }
  background(0);

  if (imageLoaded) {
    if (showImage)
      image(img, 0, 0);
  }
  for (int i=0; i<pl.size(); i++) {
    PointLoc plTemp = pl.get(i);
    plTemp.draw();
  }
  if (arrange) {
    for (int i=0; i<pl.size(); i++) {
      PointLoc plTemp = pl.get(i);

      int posX = 100;
      int posY = 100 + i*30;
      PVector posArrange = new PVector(posX, posY);
      plTemp.pos = PVector.lerp(plTemp.pos, posArrange, 0.05);
    }
  } else {
    for (int i=0; i<pl.size(); i++) {
      PointLoc plTemp = pl.get(i);
      plTemp.pos = PVector.lerp(plTemp.pos, plTemp.posBack, 0.05);
    }
  }


  if (captura) {
    saveFrame("capturas/"+hour()+"_"+minute()+"_"+second()+"_####.png");
    endRecord();
    crearTexto = true;
    captura = false;
  }
  if (crearTexto) {
    output = createWriter("capturas/color_"+ estilo + ".txt");
    output.print("{");
    for (int i=0; i<pl.size(); i++) {
      PointLoc plTemp = pl.get(i);
      output.print(plTemp.st);
    }
    output.print("},");

    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    //exit(); // Stops the program

    crearTexto = false;
  }
}

void mousePressed() {
  //ColorSel csTemp = new ColorSel(mouseX, mouseY);
  //cs.add(csTemp);
  PointLoc plTemp = new PointLoc(mouseX, mouseY, pl.size());
  pl.add(plTemp);
}

void keyPressed() {
  switch(key) {
  case 's':
    showImage = !showImage;
    break;
  case 'a': 
    arrange = !arrange;
    break;
  case 'f':
    estilo ++;
    estilo = estilo%4;
    break;
  case 'c':
    captura = true;
    break;
  case 't':
    crearTexto = true;
    break;
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    imageLoaded = true;

    surface.setSize(img.width, img.height);
    surface.setLocation(int(displayWidth/2- img.width/2), displayHeight/2 - img.height/2);
    if (dosPantallas) {
      surface.setLocation(int(displayWidth*1.5 - img.width/2), displayHeight/2 - img.height/2);
    }
  }
}
