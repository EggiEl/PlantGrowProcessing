class Tree {
  PVector position;
  Plant[] plants;
  Tree[] branches;
  float trunkHeight;
  float trunkBaseRadius;
  float trunkTopRadius;
  float growthProgress;
  float rotation;

  Tree(PVector position, int plantCount, float rotation, int levels, float trunkBaseRadius, float trunkHeight) {
    this.position = position;
    this.trunkHeight = trunkHeight;
    this.trunkBaseRadius = trunkBaseRadius;
    this.trunkTopRadius = trunkBaseRadius / 2;
    this.growthProgress = 0;
    this.rotation = rotation;
    plants = new Plant[plantCount];
    
    for (int i = 0; i < plants.length; i++) {
      float angle = random(TWO_PI);
      float height = random(trunkHeight);
      float xOffset = cos(angle) * map(height, 0, trunkHeight, trunkBaseRadius, trunkTopRadius);
      float yOffset = height;
      float zOffset = sin(angle) * map(height, 0, trunkHeight, trunkBaseRadius, trunkTopRadius);
      PVector plantPosition = new PVector(xOffset, -yOffset, zOffset);

      float pedalSize = random(1, 100);
      float pedalLen = random(1, 100);
      float initialRotation = radians(30);
      plants[i] = new Plant(plantImage, color(#CDDC39), pedalSize, pedalLen, 1, 0.2, plantPosition, initialRotation);
    }

    if (levels > 1) {
      int numBranches = min(8, round(map(plant.branchFactor, 1, 10, 1, 8))); 
      numBranches = min(numBranches, round(map(plant.growFactor, 1, 10, 1, 10 - levels))); 
      branches = new Tree[numBranches];
      for (int i = 0; i < branches.length; i++) {
        PVector branchPosition = new PVector(0, -trunkHeight, 0);
        float branchRotation = radians(random(-80, 80));
        branches[i] = new Tree(branchPosition, plantCount, branchRotation, levels - 1, trunkTopRadius, random(200, 500));
      }
    } else {
      branches = null;
    }
  }

  void drawTree() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(rotation);
    rotateZ(rotation);
    drawTrunk();
    if (growthProgress >= 1) {
      if (branches == null) {
        for (Plant plant : plants) {
          plant.drawPlant();
        }
      } else {
        for (Tree branch : branches) {
          branch.drawTree();
        }
      }
    }
    popMatrix();
    if (growthProgress < 1) {
      growthProgress += 0.01;
    }
  }

  void drawTrunk() {
    fill(#FFFFFF);
    beginShape(QUAD_STRIP);
    for (float angle = 0; angle <= TWO_PI; angle += PI / 6) {
      float xBase = cos(angle) * trunkBaseRadius;
      float zBase = sin(angle) * trunkBaseRadius;
      float xTop = cos(angle) * trunkTopRadius;
      float zTop = sin(angle) * trunkTopRadius;
      vertex(xBase, 0, zBase);
      vertex(xTop, -trunkHeight * growthProgress, zTop);
    }
    endShape(CLOSE);
  }
}
