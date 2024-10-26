class UI {
  PSlider lightSlider, tempSlider, waterSlider;
  PButton startButton;
  boolean destroyed = false;
  Plant[] plants = new Plant[10];
  PImage bgImage;

  // Setup the UI elements and background
  void setupUI() {
    // Initialize sliders with position, size, range, initial value, and label
    lightSlider = new PSlider(50, 50, 300, 20, 1, 10, 5, "Light");
    tempSlider = new PSlider(50, 100, 300, 20, 1, 10, 5, "Temperature");
    waterSlider = new PSlider(50, 150, 300, 20, 1, 10, 5, "Water");

    startButton = new PButton(150, 200, 100, 30, "Start");

  

    // Initialize plants with random positions and sizes
    for (int i = 0; i < plants.length; i++) {
      PVector position = new PVector(random(-300, 300), random(-300, 300), random(-300, 300));
      float pedalSize = random(1, 100);
      float pedalLen = random(1, 100);
      float initialRotation = 0;
      plants[i] = new Plant(loadImage("text" + (i % 2 == 0 ? "2" : "") + ".png"), 
                            #CDDC39, 
                            pedalSize, 
                            pedalLen, 
                            1, 
                            0.2, 
                            position, 
                            initialRotation);
    }
  }

  // Draw the UI elements and background
  void drawUI() {
    if (!destroyed) {
      background(23 ,100, 80);
      
     

      // Draw plants in the background
      for (int i = 0; i < plants.length; i++) {
        pushMatrix();
        translate(width / 2, height / 2); // Center the plants on the screen
        plants[i].drawPlant();
        popMatrix();
      }

      // Update and display sliders
      lightSlider.update();
      lightSlider.display();
      tempSlider.update();
      tempSlider.display();
      waterSlider.update();
      waterSlider.display();

      // Display start button
      startButton.display();

      if (startButton.isClicked()) {
        float light = lightSlider.getValue();
        float temp = tempSlider.getValue();
        float water = waterSlider.getValue();

        plant = new PlantVariables(light, temp, water);

        fill(0);
        text("Bloom Factor: " + nf(plant.bloomFactor, 1, 2), 50, 250);
        text("Grow Factor: " + nf(plant.growFactor, 1, 2), 50, 270);
        text("Branch Factor: " + nf(plant.branchFactor, 1, 2), 50, 290);

        destroyed = true;

        mainTree = new Tree(new PVector(0, 0, 0), int(plant.branchFactor), 0, int(plant.growFactor), 20, plant.growFactor * 100);
        isGrowing = true; 
      }
    } else {
      background(0);
    }
  }

  void destroy() {
    lightSlider = null;
    tempSlider = null;
    waterSlider = null;
    startButton = null;
    destroyed = true;
  }

  void mousePressed() {
    if (!destroyed) {
      lightSlider.mousePressed();
      tempSlider.mousePressed();
      waterSlider.mousePressed();
    }
  }

  void mouseReleased() {
    if (!destroyed) {
      lightSlider.mouseReleased();
      tempSlider.mouseReleased();
      waterSlider.mouseReleased();
    }
  }
}
