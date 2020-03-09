class Menu {
  
  ArrayList<Option> options = new ArrayList<Option>();
  int cursor = 0;
  
  public Menu() {
    options.add(new singleplayerOption());
    options.add(new multiplayerOption());
    options.add(new sizeOption());
    options.add(new exitOption());
  }
  
  public void drawOptions() {
    noStroke();
    rectMode(CENTER);
    textSize(30);
    textAlign(CENTER);
    fill(255);
    int k = 0;
    for(Option o : options) {
      if(o instanceof OptionMenu) {
        OptionMenu om = (OptionMenu)o;
        fill(255);
        if(k == cursor)
          fill(0xFFFF0000);
        if(om.hasValue()) {
          text(om.getDisplayName()+":"+om.getValue(),width/2,225 + (k * 50));
        }else {
          text(om.getDisplayName(),width/2,225 + (k * 50));
        }
      }else {
        
      }
      k++;
    }
  }
  
  public void drawLogo() {
    noStroke();
    rectMode(CENTER);
    textSize(75);
    textAlign(CENTER);
    fill(255);
    text("Snake",width/2,100);
  }
  
}

interface Option {}

interface Submenu {
  
}

class multiplayerOption implements OptionMenu, Option {
  public String getDisplayName() {
    return "MULTIPLAYER";
  }
  
  public String getValue() {
    return "";
  }
  
  public boolean hasValue() {
    return false;
  }
  
  public void click() {
    
  }
}

class singleplayerOption implements OptionMenu, Option {
  public String getDisplayName() {
    return "SINGLEPLAYER";
  }
  
  public String getValue() {
    return "";
  }
  
  public boolean hasValue() {
    return false;
  }
  
  public void click() {
    if(gsize == 0) 
      game = new Snake(16,12);
    if(gsize == 1)
      game = new Snake(32,24);
    if(gsize > 1)
      exit();
    currentState = 1;
  }
}

class exitOption implements OptionMenu, Option {
  
  public String getDisplayName() {
    return "EXIT";
  }
  
  public String getValue() {
    return "";
  }
  
  public boolean hasValue() {
    return false;
  }
  
  public void click() {
    exit();
  }
  
}

int gsize = 0;

class sizeOption implements OptionMenu, Option {
  public String getDisplayName() {
    return "Size";
  }
  
  public String getValue() {
    switch(gsize) {
      case 0: return "16x12";
      case 1: return "32x24";
      default: break;
    }
    return "null";
  }
  
  public boolean hasValue() {
    return true;
  }
  
  public void click() {
    gsize = (gsize+1)%2;
  }
}

interface OptionMenu {
  public String getDisplayName();
  public String getValue();
  public boolean hasValue();
  public void click();
}

void menukeyhandle() {
  if(keyCode == DOWN) {
    menu.cursor = (menu.cursor+1)%menu.options.size();
  }
  if(keyCode == UP) {
    menu.cursor = menu.cursor==0?menu.options.size()-1:menu.cursor-1;
  }
  if(keyCode == ENTER) {
    if(menu.options.get(menu.cursor) instanceof OptionMenu)
      ((OptionMenu)menu.options.get(menu.cursor)).click();
  }
}
