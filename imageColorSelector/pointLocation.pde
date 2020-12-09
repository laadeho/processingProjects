class ColorSel {
  color c;

  ColorSel(int x, int y) {
    c = img.get(x, y);
    println("Se agrega un color");
  }
}

class PointLoc {
  PVector pos; 
  PVector posBack;
  color col;

  ColorSel cs; 

  int _id; 

  PointLoc(int x, int y, int id) {
    cs = new ColorSel(x, y);
    pos = new PVector(x, y);
    posBack = pos;
    col = color(cs.c);
    _id = id;
  }

  void draw() {
    strokeWeight(25);
    stroke(0);
    point(pos.x, pos.y);

    strokeWeight(20);
    stroke(col);
    point(pos.x, pos.y);

    fill(255);
    String st ="";
    if (!format) {
      st = _id + ". Color R: " + red(col) + ", G: " + green(col) +", B: " + blue(col);
    } else {
      st = "(" + red(col) + ", " + green(col) +", " + blue(col) + ")";
    }

    text(st, pos.x+25, pos.y);
  }
}
