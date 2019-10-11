class Nodos {
  int numChannels = 4;
  int anchoTotal = 400;
  int anchoCanal;
  int vel = 50;

  ArrayList<PVector> nodo; 

  float pX[], pY[], pZ;

  Nodos() {
    pX = new float[numChannels];
    pY = new float[numChannels];

    for (int i=0; i<numChannels; i++) {
      pY[i] = random(-100, 100);
    }
    anchoCanal = anchoTotal / numChannels;
  }

  Nodos(int nN, int aT) {
    anchoTotal = aT;
    numChannels = nN;
    pX = new float[numChannels];
    pY = new float[numChannels];

    for (int i=0; i<numChannels; i++) {
      pY[i] = random(-10, 10);
    }
    anchoCanal = anchoTotal / numChannels;
  }
  
  Nodos(int nN, int aT, float[] amps) {
    //amps = new float[nN];

    anchoTotal = aT;
    numChannels = nN;
    pX = new float[numChannels];
    pY = new float[numChannels];

    for (int i=0; i<numChannels; i++) {
      pY[i] = amps[i];
    }
    anchoCanal = anchoTotal / numChannels;
  }

  void draw() {
    strokeWeight(10);
    stroke(255);    
    for (int i=0; i<numChannels; i++) {
      //pX[i] = anchoCanal*i;
      point(pX[i], pY[i], pZ);
    }
    //strokeWeight(1);
    //for (int i=0; i<numChannels-1; i++) {
    //  line(anchoCanal*i, pY[i], pZ, anchoCanal*(i+1), pY[i+1], pZ);
    //}
  }

  void update() {
    for (int i=0; i<numChannels; i++) {
      pX[i] = anchoCanal*i;
      //point(pX[i], pY[i], pZ);
    }
    pZ -= vel;
  }
}
