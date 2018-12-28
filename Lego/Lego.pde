PImage dl;

//void setup() {
size (1024, 1024);
dl = loadImage ("pict.jpg");
background (0);
ellipseMode(CORNER);
//}

//void draw () {
background(0);
for (int f = 0; f < dl.height; f = f + 25) {
  for (int a = 0; a < dl.width; a = a + 25) {
    color c = dl.get(int(f), int(a));
    noStroke();
    fill(c);
    ellipse(f+2.5, a+2.5, 20, 20);
    fill(c, 240);
    rect (f, a, 25, 25);
  }
}
saveFrame("data/pict_pixel.png");
exit();
//}