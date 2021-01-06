import processing.net.*;

Client myClient;

color gray = #EDEDED;
color blue  = #7396CB;
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
boolean firstClick, itsMyTurn = false, ppro = false, p, sp = false;
int row1, col1, row2, col2, mode;
char lastPieceTaken;

final int GAME = 0;
final int PPROMO = 1;
final int WAITING = 2;

char grid[][] = {
  {'R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'},
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'},
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'},
  {'r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'}
};

void setup() {
  size(800, 800);
  myClient = new Client(this, "127.0.0.1", 12345);
  firstClick = true;
  mode = WAITING;
  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bknight = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");

  wrook = loadImage("whiteRook.png");
  wbishop = loadImage("whiteBishop.png");
  wknight = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");
}

void draw() {
  drawBoard();
  drawPieces();
  receiveMove();
  
  if (mode == GAME) {
    game();
  } else if (mode == PPROMO) {
    ppromo();
  } else if (mode == WAITING) {
    waiting();
  } else {
    println("Error: Mode = " + mode);
  }
}
