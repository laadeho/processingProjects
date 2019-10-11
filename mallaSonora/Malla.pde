class Malla {
  ArrayList<Nodos> nodosList;

  Malla() {
    nodosList = new ArrayList<Nodos>();
  }

  void draw() {
    stroke(0, 100);
    strokeWeight(1);
    fill(255);
    if (nodosList.size()>1) {
      for (int i=nodosList.size()-2; i>=0; i--) {
        Nodos nd = nodosList.get(i);
        Nodos nd2 = nodosList.get(i+1);
        //nd.draw();
        beginShape(TRIANGLE_STRIP);
        for (int j=0; j<nd.numChannels-1; j++) {
          vertex(nd.pX[j], nd.pY[j], nd.pZ);
          vertex(nd2.pX[j], nd2.pY[j], nd2.pZ);
        }
        endShape();
      }
    }

    /*
    if (frameCount % 3 == 0) {
     nodosList.add(new Nodos(16, 450));
     }
     */
  }
  void update() {
    for (int i=nodosList.size()-1; i>=0; i--) {
      Nodos nd = nodosList.get(i);
      nd.update();
    }
  }
}
