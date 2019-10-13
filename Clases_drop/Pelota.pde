class Pelota {

  color c[];

  int colNum;
  float ac = 0.99;
  PVector pos;
  PVector vel;
  float tam;
  boolean muerete;
  float h, s, b;

  Pelota() {
    colNum = floor(random(5));
    pos = new PVector(width/2, 100);
    vel = new PVector(0, 1);
    tam = random(15, 25);
    c = new color[5];
    b = random(50, 100);
    s = random(50, 100);
    h = random(30);
    for (int i=0; i<5; i++) {
      c[i] = color(0, s, b);
    }
  }

  Pelota(float x, float y) {
    colNum = floor(random(5));
    pos = new PVector(x, y);
    vel = new PVector(random(-.5, .5), 3);
    tam = random(15, 25);
    c = new color[5];
    b = random(50, 100);
    s = random(50, 100);
    h = random(30);
    for (int i=0; i<5; i++) {
      c[i] = color(h, s, b, 80);
    }
  }

  void draw() {
    stroke(c[colNum]);
    strokeWeight(tam);
    point(pos.x, pos.y);
  }

  void update() {
    pos.add(vel);
    vel.y *= ac;
    if (tam > 0) {
      tam *= 0.99;
    }

    if (tam < 2) {
      muerete = true;
    }
    for (int i=0; i<5; i++) {
      c[i] = color(h, s, b, s);
    }
    if (b<100) b++;
    if (s>0) s--;
  }
}
