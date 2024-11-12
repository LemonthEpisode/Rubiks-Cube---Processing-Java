

// MODULO 16 ::    x &= 15
// DIVDED 16 ::    x >> 4

// HANDLE XYZ IN ROLL

class Rubik {
  
  byte c [];
  
  int [] mvStack = new int[25];
  int ptr = 0;
  int frm = 0;
  
  Rubik() {
    
    c = new byte [54];
    
    for (byte i=0; i<6; i++)
      for (byte j=0; j<9; j++)
        c[j+9*i] = i;
    
    for (int i=0; i<mvStack.length; i++)
      mvStack[i] = -1;
      
    shuffle();
    
  }
  
  boolean isSolved() {
  
    for (byte i=0; i<6; i++)
      for (byte j=0; j<9; j++)
        if (c[j+9*i] != i)
          return false;
    return true;
  
  }
  
  void disp() {
    displayFace(0);
    displayAdjacentCenters();
  }
  
  void displayFace(int face) {
    
    fill(0);
    rect(144,144,312,312,5);
    
    for (byte i=0; i<3; i++) {
      for (byte j=0; j<3; j++) {
        fill(colors[c[i+j*3+9*face]]);
        rect(150+102*i,150+102*j,96,96,10);
      }
    }
  
  }
  
  void displayAdjacentCenters() {
    
    fill(0);
    rect(286,18,28,28);
    rect(554,286,28,28);
    rect(286,554,28,28);
    rect(18,286,28,28);

    fill(colors[c[13]]);
    rect(288,20,24,24);
    
    fill(colors[c[22]]);
    rect(556,288,24,24);
    
    fill(colors[c[31]]);
    rect(288,556,24,24);
    
    fill(colors[c[40]]);
    rect(20,288,24,24);
  
  }
  
  void shuffle() {
    int moves = 3;
    for (int i=0; i<moves; i++) {
      int mv = (int) random(6);
      int rt = (int) random(1,4);
      roll(mv,rt);
    }
  }
   
  /**
   * Rotates the specified faces by a given offset
   *
   * @param s  The indicies to be rotated
   * @param n  The number of position by which faces are rotated.
   */
  void rot(byte [] s, int n) {
    byte [] temp = new byte[s.length];
    for (int i=0; i<s.length; i++)
      temp[(i+n) % s.length] = c[s[i]];
    for (int i=0; i<s.length; i++)
      c[s[i]] = temp[i];
  }
  
  /**
   * Main movement function
   *
   * @param m  Face or Layer ID
   * @param n  Direction of movement: 1 for CW, 3 for CCW.
   */
  void roll(int m, int n) {
    
    // handle XYZ
    
    pushMovement(m+16*(n-1));
    
    rot(mv[m], 3*n);
    
    if (m>5) return;
    
    byte [] s = new byte[8];
    for (int i=0; i<s.length; i++)
      s[i] = (byte) (roll[i] + 9*m);
    rot(s, 2*n);
  
  }
  
  /**
   * Pushes a given movement into stack.
   *
   * @param s movement ID.
   */
  void pushMovement(int s) {

    // pushes non-reducile movements
    //if ((s ^ mvStack[ptr]) & 15 != 0) {
    if (s%16 != mvStack[ptr]%16) {
      ptr = (ptr + 1) % mvStack.length;
      mvStack[ptr] = s;
      frm = ptr;
      println(new String(mvNotation(mvStack[ptr])));
    }
    
    // pops opposed movements
    //if (s+mvStack[ptr]-(s&15)<<1=32)
    if (s+mvStack[ptr]-2*(s%16)==32) {
      ptr = (ptr - 1) % mvStack.length;
      println("POPPED");
      return;
    }
      
    // adjust repeated movements
    mvStack[ptr] += s+16-s%16;
    println(new String(mvNotation(mvStack[ptr])));
    return;
    
  }
  
  /**
   * Undoes the last movement in stack.
   */
  void undo() {
    
    if (ptr == (frm + 1) % mvStack.length)
      return;
  
    roll(
      mvStack[ptr]%16,         // mvStack[ptr] & 15
      (int) 3-mvStack[ptr]/16  // 3 - mvStack >> 4
    );
    
    ptr = (ptr + 1) % mvStack.length;
  
  }
  
  /**
   * Redoes undone movements until it hits frame limit.
   */
  void redo() {
  
    if (ptr == frm) return;
    
  }
  
  /**
   * Converts a movement ID into a char array.
   */
  char [] mvNotation(int s) {
    
    char [] n = new char[s<16?2:3];
    n[0] = ' ';
    n[1] = notation[s%16];
    if (s>=16) n[2] = s<32?'2':'\'';
    return n;
  
  }
  
  void move(char s) {
    switch (s) {
      case 'x':
        roll(R,1);
        roll(L,3);
        roll(M,3);
        return;
      case 'X':
        roll(M,1);
        roll(L,1);
        roll(R,3);
        return;
      case 'y':
        roll(U,1);
        roll(D,3);
        roll(E,3);
        return;
      case 'Y':
        roll(E,1);
        roll(D,1);
        roll(U,3);
        return;
      case 'z':
        roll(F,1);
        roll(S,1);
        roll(B,3);
        return;
      case 'Z':
        roll(B,1);
        roll(S,3);
        roll(F,3);
        return;
      case 'r':
        roll(R,1);
        return;
      case 'R':
        roll(R,3);
        return;
      case 'l':
        roll(L,1);
        return;
      case 'L':
        roll(L,3);
        return;
      case 'm':
        roll(M,1);
        return;
      case 'M':
        roll(M,3);
        return;
      case 'u':
        roll(U,1);
        return;
      case 'U':
        roll(U,3);
        return;
      case 'd':
        roll(D,1);
        return;
      case 'D':
        roll(D,3);
        return;
      case 'e':
        roll(E,1);
        return;
      case 'E':
        roll(E,3);
        return;
      case 'f':
        roll(F,1);
        return;
      case 'F':
        roll(F,3);
        return;
      case 'b':
        roll(B,1);
        return;
      case 'B':
        roll(B,3);
        return;
      case 's':
        roll(S,1);
        return;
      case 'S':
        roll(S,3);
        return;
      default:
        return;
    }
  }
  
}
