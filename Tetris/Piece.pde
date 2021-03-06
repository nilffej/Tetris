abstract class Piece {
  int r;
  int c;
  int orientation, col;
  Board b;
  int[] cords;

  Piece(int r, int c, Board b) {  
    this.r = r;
    this.c = c;
    this.b = b;
    orientation = 0;
  }
  
  boolean checkCords(int[] cords){
    for(int i = 0; i < cords.length; i+= 2){
      int tempr = cords[i];
      int tempc = cords[i+1];
      if(tempr < 1 || tempc < 0 || tempc > b.grid[0].length-1 || (b.grid[tempr][tempc] != 0 && b.grid[tempr][tempc] != col*10)) return false;
    }
    return true;
  }

  void moveLeft() {
    undisplay();
    c -= 1;
    for (int i = 1; i<cords.length; i+=2) {
      cords[i]--;
    }
    display();
  }
  void moveRight() {
    undisplay();
    c += 1;
    for (int i = 1; i<cords.length; i+=2) {
      cords[i]++;
    }
    display();
  }
  void moveDown() {
    if (!isColliding()) {
      undisplay();
      r += 1;
      for (int i = 0; i<cords.length; i+=2) {
        cords[i]++;
      }
      display();
    }
  }

  String toString() {
    return "Piece";
  }

  void keyPressed() {
    if (keyCode == LEFT && checkLeft()) moveLeft();
    else if (keyCode == RIGHT && checkRight()) {
      moveRight();
    } else if (keyCode == UP) {
      rot();
    } else if (key == ' ') {
      while (!isColliding()) {
        moveDown();
      }
      b.clearLine();
      b.playPiece();
    } else if (keyCode == DOWN) {
      moveDown();
    }
  }

  abstract boolean checkLeft();
  abstract boolean checkRight();
  abstract boolean isColliding();
  abstract void rot();

  void display() {
    for (int i = 0; i < cords.length; i += 2) {
      //System.out.println("r: "+cords[i] + " c: " + cords[i+1]);
      b.grid[cords[i]][cords[i+1]] = col;
    }
    b.grid[r][c] = col;
  }

  void undisplay() {
    for (int i = 0; i < cords.length; i += 2) {
      b.grid[cords[i]][cords[i+1]] = 0;
    }
    b.grid[r][c] = 0;
  }
}
