PImage dl;
int size = 15;
//void setup() {
size (1920, 1080);
dl = loadImage ("pict.jpg");
background (0);
ellipseMode(CORNER);
//}

//void draw () {
background(0);
for (int f = 0; f < dl.width; f = f + size) {
  for (int a = 0; a < dl.height; a = a + size) {
    color c = dl.get(int(f), int(a));
    noStroke();
    fill(c);
    ellipse(f+2.5, a+2.5, size-5, size-5);
    fill(c, 240);
    rect (f, a, size, size);
  }
}
saveFrame("data/pict_pixel.png");
delay(500);
exit();
//}
