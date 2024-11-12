/**
 * ================ Movement IDs ===============
 *
 * For repeat twice add 16, and for CCW movement add 32.
 * The first 6 are also the face IDs.
 * Binary form: 00XXYYYY, X and Y defines direction and movement respectively.
 */

byte F =  0;     // Front
byte U =  1;     // Up
byte R =  2;     // Right
byte D =  3;     // Down
byte L =  4;     // Left
byte B =  5;     // Back
byte S =  6;     // Slice
byte E =  7;     // Equator
byte M =  8;     // Middle
byte X =  9;     // Rotate X
byte Y = 10;     // Rotate Y
byte Z = 11;     // Rotate Z

// movement arrays
// This specify the order in which cubies faces are rotated in each move
// 8 arrays for the 8 previously mentioned moves.

byte mv [][] = {
  {15,16,17,18,21,24,29,28,27,44,41,38},
  { 2, 1, 0,38,37,36,47,46,45,20,19,18},
  { 8, 5, 2,17,14,11,45,48,51,35,32,29},
  { 6, 7, 8,24,25,26,51,52,53,42,43,44},
  { 0, 3, 6,27,30,33,53,50,47, 9,12,15},
  {11,10, 9,36,39,42,33,34,35,26,23,20},
  {14,13,12,37,40,43,30,31,32,25,22,19},
  { 3, 4, 5,21,22,23,48,49,50,39,40,41},
  { 1, 4, 7,28,31,34,52,49,46,10,13,16},
};

// the roll array defines the rotation of the face itself
// used alongside the first six movements in same direction

byte [] roll = {0, 1, 2, 5, 8, 7, 6, 3};

// Display Variables

char [] notation = {
  'F', 'U', 'R',
  'D', 'L', 'B',
  'S', 'E', 'M',
};

color [] colors = {
  color(255, 255, 255), color(183,  18,  52),
  color(  0, 155,  72), color(255,  88,   0),
  color(  0,  70, 173), color(255, 213,   0)
};
