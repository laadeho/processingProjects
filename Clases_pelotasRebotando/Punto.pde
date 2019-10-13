class Punto {
  float px, py;
  float vx, vy;
  float pz, vz;
  float tam = 10;
  color c;
  int cuenta = 0;
  boolean muere = false;

  Punto() { // constructor
    vx = random(-5, 5);
    vy = random(-5, 5);
    c = color(random(255), random(255), random(255));
  }
  Punto(int PX, int PY) { // constructor
    px = PX;
    py = PY;
    vx = random(-5, 5);
    vy = random(-5, 5);
    c = color(random(255), random(255), random(255));
  }

  void draw() {
    stroke(c);
    strokeWeight(tam);
    point(px, py);
  }

  void update() { // calculos
    px += vx;
    py += vy;

    if (px > width || px < 0) {
      vx *= -1;
      tam = 30;
      cuenta++;
    }
    if (py > height || py < 0) {
      vy *= -1;
      tam = 30;
      cuenta++;
    }
    if (tam > 10) {
      tam *= 0.95;
    }
    if (cuenta>=3) {
      muere = true;
    }
  }
}
