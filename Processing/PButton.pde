class PButton {
  int x, y, w, h;
  String label;
  boolean clicked = false;

  PButton(int x, int y, int w, int h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }

  void display() {
    fill(175);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2);
  }

  boolean isClicked() {
    if (mousePressed && mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      clicked = true;
    } else {
      clicked = false;
    }
    return clicked;
  }
}
