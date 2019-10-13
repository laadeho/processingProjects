ArrayList<Punto> puntos;

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 0);
  puntos = new ArrayList<Punto>();
  println(puntos.size());
}

void draw() {
  background(210, 40, 100);
  for (int i=0; i<puntos.size(); i++) {
    Punto p = puntos.get(i);
    p.update();
    p.draw();
    if (p.muere) { /// if(p.muere == true)
      puntos.remove(i);
    }
  }
}

void mouseReleased() {
  puntos.add(new Punto(mouseX, mouseY));
}
void mouseDragged() {
  puntos.add(new Punto(mouseX, mouseY));
}

void keyPressed() {
  if (key=='s') {
    saveFrame("####.png");
  }
}
