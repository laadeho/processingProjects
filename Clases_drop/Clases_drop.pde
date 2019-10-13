ArrayList<Pelota> pList;

void setup() {
  fullScreen();
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 50, 100);

  pList = new ArrayList<Pelota>();
}

void draw() {

  for (int i=0; i<pList.size(); i++) {
    Pelota pl = pList.get(i);
    pl.draw();
    pl.update();

    if (pl.muerete) {
      pList.remove(i);
    }
  }
  println(pList.size());
}

void mouseDragged() {
  pList.add(new Pelota(mouseX, mouseY));
}

void mousePressed() {
  pList.add(new Pelota(mouseX, mouseY));
}
void keyPressed() {
  if (key=='s') 
    saveFrame("####.png");

  if (key=='b')
    background(0, 50, 100);
}
