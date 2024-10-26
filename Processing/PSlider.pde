class PSlider {
  int x, y, w, h;
  float minVal, maxVal, currentVal;
  String label;
  boolean dragging = false;

  PSlider(int x, int y, int w, int h, float minVal, float maxVal, float currentVal, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.minVal = minVal;
    this.maxVal = maxVal;
    this.currentVal = currentVal;
    this.label = label;
  }

  void display() {
    // Hintergrund des Sliders
    noStroke();
    fill(220);
    rect(x, y, w, h, h / 2);  // Abgerundete Ecken

    // Position des Schiebereglers
    float sliderPos = map(currentVal, minVal, maxVal, x, x + w);

    // Schieberegler Griff
    fill(100, 100, 250);
    ellipse(sliderPos, y + h / 2, h * 1.2, h * 1.2);  // Kreisförmiger Griff

    // Beschriftung und Wert
    fill(0);
    textAlign(CENTER, CENTER);
    text(label + ": " + nf(currentVal, 1, 2), x + w / 2, y - 15);
  }

  void update() {
    if (dragging) {
      float newSliderPos = constrain(mouseX, x, x + w);
      currentVal = map(newSliderPos, x, x + w, minVal, maxVal);
    }
  }

  float getValue() {
    return currentVal;
  }

  void mousePressed() {
    float sliderPos = map(currentVal, minVal, maxVal, x, x + w);
    if (dist(mouseX, mouseY, sliderPos, y + h / 2) < h * 0.6) {
      dragging = true;
    }
  }

  void mouseReleased() {
    dragging = false;
  }
}
