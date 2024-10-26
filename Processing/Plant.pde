class Plant {
  PImage img;
  float time;
  color bgColor;
  float pedalSize;
  float pedalLen;
  float pedalSizeMultiplicator;
  float amplitude;
  PVector position;
  float initialRotation;
  boolean moving;

  Plant(PImage img, color bgColor, float pedalSize, float pedalLen, float pedalSizeMultiplicator, float amplitude, PVector position, float initialRotation) {
    this.img = img;
    this.bgColor = bgColor;
    this.pedalSize = pedalSize;
    this.pedalLen = pedalLen;
    this.pedalSizeMultiplicator = pedalSizeMultiplicator;
    this.amplitude = amplitude;
    this.position = position;
    this.initialRotation = initialRotation;
    time = 0;
    moving = true;
  }

  void drawPlant() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(initialRotation);
    rotateZ(PI / 6);

    float scalingFactor = map(time, 0, TWO_PI, 0, 1);
    scale(scalingFactor);

    for (float i = 0; i < PI * 2; i += PI * 2 / 6) {
      pushMatrix();
      translate(0, 0, -PI * 2 / 6);
      rotate(i);
      drawLeaf(time);
      popMatrix();
    }
    popMatrix();
    if (moving) {
      time += 0.05;
      if (time >= TWO_PI) {
        stop();
      }
    }
  }

  void drawLeaf(float time) {
    float step = 150;
    float size = this.pedalSize;
    float len = PI * this.pedalSizeMultiplicator;
    float len2 = this.pedalLen;

    beginShape(TRIANGLE_STRIP);
    texture(img);

    vertex(0, 0, 0, 0, 0);

    for (float i = 0; i <= len; i += len / step) {
      vertex(i * len2, sin(i) * size, (this.amplitude * sin((i * 1.5 + time))) * 75, i / len + cos(time / 2), 1);
      vertex(i * len2, -sin(i) * size, (this.amplitude * sin((i * 1.5 + time))) * 75, i / len + sin(time / 2), 0);
    }
    endShape(CLOSE);
  }

  void stop() {
    moving = false;
    time = TWO_PI;
  }
}
