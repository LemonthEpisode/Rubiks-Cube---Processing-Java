Rubik r;

void keyPressed() {
  r.move(key);
  if (key != CODED)
    return;
  if (keyCode == BACKSPACE)
    r.undo();
  if (keyCode == ENTER)
    r.redo();
}

void setup() {
  size(600, 600);
  r = new Rubik();
}

void draw() {
  background(127);
  r.disp();
}
