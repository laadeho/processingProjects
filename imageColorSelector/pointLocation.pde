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
  String st;

  ColorSel cs; 

  int _id; 

  PointLoc(int x, int y, int id) {
    cs = new ColorSel(x, y);
    pos = new PVector(x, y);
    posBack = pos;
    col = color(cs.c);
    _id = id;
    st = "";
  }

  void draw() {
    strokeWeight(25);
    stroke(0);
    point(pos.x, pos.y);

    strokeWeight(20);
    stroke(col);
    point(pos.x, pos.y);

    fill(255);
    switch(estilo) {
    case 0:
      st = _id + ". Color R: " + red(col) + ", G: " + green(col) +", B: " + blue(col);
      break;
    case 1:
      st = "(" + red(col) + ", " + green(col) +", " + blue(col) + ")";
      break;    
    case 2: 
      float fr = map(red(col), 0, 255, 0, 1);
      float fg = map(green(col), 0, 255, 0, 1);
      float fb = map(blue(col), 0, 255, 0, 1);

      st = "(" + nf(fr, 0, 2) + ", " + nf(fg, 0, 2) +", " + nf(fb, 0, 2) + ")";

      break;
    case 3: 
      fr = map(red(col), 0, 255, 0, 1);
      fg = map(green(col), 0, 255, 0, 1);
      fb = map(blue(col), 0, 255, 0, 1);
      if (!crearTexto) {
        //st = _id + "_{" + nf(fr, 0, 2) + ", " + nf(fg, 0, 2) +", " + nf(fb, 0, 2) + "},";
        st = "{" + nf(fr, 0, 2) + ", " + nf(fg, 0, 2) +", " + nf(fb, 0, 2) + "},";
      } else {
        st = "{" + nf(fr, 0, 2) + ", " + nf(fg, 0, 2) +", " + nf(fb, 0, 2) + "},";
      }
      break;
    }
    text(st, pos.x+25, pos.y);
  }
}
