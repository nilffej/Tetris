class JPiece extends Piece {

  /*
  center is second from the top of the "J"
   orientation = 0 --> on its side - long side on the bottom
   orientation = 1 --> upright - upside down J
   orientation = 2 --> on its side - short side on bottom
   orientation = 3 --> upright - regular J
   */

  JPiece(int r, int c, Board b) {
    super(r, c, b);
    cords = new int[]{r-1, c-1, r, c-1, r, c+1};
    col = 4;
  }

  void rot() {
    if (orientation == 0) {
      if (checkCords(new int[]{r-1,c,r-1,c+1,r+1,c})) {
        undisplay();
        cords = new int[]{r-1,c,r-1,c+1,r+1,c};
        display();
        orientation = 1;
      }
    } else if (orientation == 1) {
      if(!checkLeft() && checkCords(new int[]{r,c+1,r,c+2,r+1,c+2})){
        undisplay();
        c++;
        cords = new int[]{r,c-1,r,c+1,r+1,c+1};
        display();
        orientation = 2;
      }
      else if (checkCords(new int[]{r,c-1,r,c+1,r+1,c+1})) {
        undisplay();
        cords = new int[]{r,c-1,r,c+1,r+1,c+1};
        display();
        orientation = 2;
      }
    } else if (orientation == 2) {
      if (checkCords(new int[]{r+1,c-1,r+1,c,r-1,c})) {
        undisplay();
        cords = new int[]{r+1,c-1,r+1,c,r-1,c};
        display();
        orientation = 3;
      }
    } else { //orientation == 3
      if(!checkRight() && checkCords(new int[]{r,c-1,r,c-2,r-1,c-2})){
        undisplay();
        c--;
        cords = new int[]{r-1,c-1,r,c-1,r,c+1};
        display();
        orientation = 0;
      }
      else if (checkCords(new int[]{r-1,c-1,r,c-1,r,c+1})) {
        undisplay();
        cords = new int[]{r-1,c-1,r,c-1,r,c+1};
        display();
        orientation = 0;
      }
    }
  }

  boolean isColliding() {
    if (orientation == 0) return !checkCords(new int[]{r+1,c-1,r+1,c,r+1,c+1});
    if (orientation == 1) return !checkCords(new int[]{r+2,c,r,c+1});
    if (orientation == 2) return !checkCords(new int[]{r+1,c-1,r+1,c,r+2,c+1});
    //orientation == 3
    return !checkCords(new int[]{r+2,c-1,r+2,c});
  }

  boolean checkLeft() {
    if(orientation == 0) return checkCords(new int[]{r-1,c-2,r,c-2});
    if(orientation == 1) return checkCords(new int[]{r-1,c-1,r,c-1,r+1,c-1});
    if(orientation == 2) return checkCords(new int[]{r,c-2,r+1,c});
    //orientation = 3
    return checkCords(new int[]{r-1,c-1,r,c-1,r+1,c-2});
  }

  boolean checkRight() {
    if(orientation == 0) return checkCords(new int[]{r-1,c,r,c+2});
    if(orientation == 1) return checkCords(new int[]{r-1,c+2,r,c+1,r+1,c+1});
    if(orientation == 2) return checkCords(new int[]{r,c+2,r+1,c+2});
    //orientation = 3
    return checkCords(new int[]{r-1,c+1,r,c+1,r+1,c+1});
  }
  
}
