void snakeKeysHandle() {
  if(keyCode == LEFT && (game.lastDirectionInput != 1 || game.snakeParts.size()==1)) {
      game.direction = 3;
    }
    if(keyCode == UP && (game.lastDirectionInput != 2 || game.snakeParts.size()==1)) {
      game.direction = 0;
    }
    if(keyCode == DOWN && (game.lastDirectionInput != 0 || game.snakeParts.size()==1)) {
      game.direction = 2;
    }
    if(keyCode == RIGHT && (game.lastDirectionInput != 3 || game.snakeParts.size()==1)) {
      game.direction = 1;
    }
    if(game.isAlive == false && keyCode == ENTER) {
      currentState = 0;
    }
}

class Snake {
  
  int sizeX, sizeY;
  int blocksizeX, blocksizeY;
  
  int score = 0;
  
  boolean isAlive = true;
  
  java.util.Random rng = new java.util.Random();
  
  int foodX, foodY;
  int headX, headY;
  
  int lastDirectionInput = -1;
  int direction = 1;
  
  ArrayList<PVector> snakeParts = new ArrayList<PVector>();
  
  int timeout = 0;
  
  public Snake() {
    this(16,12);
  }
  
  public Snake(int sizeX, int sizeY) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.blocksizeX = width/sizeX;
    this.blocksizeY = height/sizeY;
    randomizeFood();
    headX = sizeX/2;
    headY = sizeY/2;
    snakeParts.add(new PVector(headX,headY));
  }
  
  public void drawFood() {
    stroke(30);
    fill(0xFFFF0000);
    rectMode(CORNER);
    rect(foodX*blocksizeX,foodY*blocksizeY,blocksizeX,blocksizeY);
  }
  
  public void drawParts() {
    for(PVector part : snakeParts) {
      stroke(30);
      fill(0xFF00FF00);
      rectMode(CORNER);
      rect(part.x*blocksizeX,part.y*blocksizeY,blocksizeX,blocksizeY);
    }
  }
  
  public void lost() {
    rectMode(CENTER);
    fill(255);
    noStroke();
    textSize(50);
    textAlign(CENTER);
    text("U DED",width/2,height/2);
    textSize(25);
    text("Score: "+score,width/2,(height/2)+75);
  }
  
  public void randomizeFood() {
    do {
      foodX = Math.abs(rng.nextInt()) % sizeX;
      foodY = Math.abs(rng.nextInt()) % sizeY;
    }while(isOccupied(foodX,foodY));
  }
  
  public PVector getNextPosition() {
    if(direction == 0) {
      int newY = headY - 1;
      if(newY == -1)
        newY = sizeY-1;
      return new PVector(headX,newY);
    }
    if(direction == 1) {
      int newX = headX + 1;
      if(newX == sizeX)
        newX = 0;
      return new PVector(newX, headY);
    }
    if(direction == 2) {
      int newY = headY + 1;
      if(newY == sizeY)
        newY = 0;
      return new PVector(headX, newY);
    }
    if(direction == 3) {
      int newX = headX - 1;
      if(newX == -1)
        newX = sizeX;
      return new PVector(newX, headY);
    }
    return null;
  }
  
  public void tick() {
    if(isAlive) {
      if(timeout >= 20) {
        timeout = 0;
        
        PVector newPos = getNextPosition();
        
        if(!isOccupied((int)newPos.x,(int)newPos.y)) {
          headX = (int)newPos.x;
          headY = (int)newPos.y;
          lastDirectionInput = direction;
          snakeParts.add(new PVector(headX,headY));
          if(foodX == headX && foodY == headY) {
            score++;
            randomizeFood();
          }else{
            snakeParts.remove(0);
          }
        }else{
            isAlive = false;
            lost();
        }
      }else{
        timeout++;
      }
    }else{
      lost();
    }
  }
  
  public boolean isOccupied(int x, int y) {
    for(PVector part : snakeParts) {
      if(part.x == x && part.y == y) {
        return true;
      }
    }
    return false;
  }
  
}
