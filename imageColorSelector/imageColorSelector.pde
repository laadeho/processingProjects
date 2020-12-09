PImage img;
boolean imageLoaded;
boolean mueve = true;
int np;
//ArrayList <ColorSel> cs;
ArrayList <PointLoc> pl;

boolean showImage = true;
boolean arrange;

boolean format;
boolean captura;

boolean dosPantallas = false;

void setup() {
  selectInput("Select a file to process:", "fileSelected");
  //cs = new ArrayList<ColorSel>();
  pl = new ArrayList<PointLoc>();
}

void draw() {
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
    captura = false;
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
    format = !format;
    break;
  case 'c':
    captura = true;
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
