import peasy.*;

PeasyCam cam;
Tree mainTree;
PlantVariables plant;
UI ui;
boolean isGrowing = false;
PImage plantImage;

void setup() {
  size(1000, 1000, P3D);
  noStroke();

  textureMode(NORMAL);
  textureWrap(REPEAT);

  ui = new UI();
  ui.setupUI();

  plantImage = loadImage("text2.png"); 

  // Erstelle den Unterordner 'archiv', falls er nicht existiert
  File archiveDir = new File(dataPath("archiv"));
  if (!archiveDir.exists()) {
    archiveDir.mkdirs();
  }
}

void draw() {
  if (!isGrowing) {
    ui.drawUI(); 
  } else {
    if (cam == null) {
      cam = new PeasyCam(this, 600); 
    }
    background(0);
    mainTree.drawTree();
  }
}

void mousePressed() {
  ui.mousePressed();
}

void mouseReleased() {
  ui.mouseReleased();
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveTreeImage();
  }
}

void saveTreeImage() {
  // Erzeuge einen Dateinamen basierend auf dem aktuellen Zeitpunkt
  String timestamp = nf(year(), 4) + nf(month(), 2) + nf(day(), 2) + "_" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  String filename = "archiv/tree_image_" + timestamp + ".png";
  
  // Speichere das aktuelle Frame als Bilddatei
  saveFrame(filename);
}
