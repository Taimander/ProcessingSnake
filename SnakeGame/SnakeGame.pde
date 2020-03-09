void setup() {
  size(800,600);
  frameRate(60);
  game = new Snake(50,50);
  menu = new Menu();
}

Snake game;
Menu menu;

int currentState = 0; // 0 = MENU, 1 = GAME

void draw() {
  
  if(currentState == 0) {
    background(30);
    menu.drawLogo();
    menu.drawOptions();
  }
  
  if(currentState == 1) {
    background(30);
    game.drawParts();
    game.drawFood();
    game.tick();
  }
}

void keyPressed() {
  if(currentState == 0) {
    menukeyhandle();
  }
    
  if(currentState == 1) {
    snakeKeysHandle();
  }
} //<>//
