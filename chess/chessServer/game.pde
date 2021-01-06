void game() {
}

void receiveMove() {
  Client myClient = myServer.available();
  if (myClient!= null) {
    String incoming = myClient.readString();
    int r1 = int(incoming.substring(0, 1));
    int c1 = int(incoming.substring(2, 3));
    int r2 = int(incoming.substring(4, 5));
    int c2 = int(incoming.substring(6, 7));
    int t = int(incoming.substring(8, 9));
    if (t == 1) {
      lastPieceTaken = grid[r2][c2];
      grid[r2][c2] = grid[r1][c1];
      grid[r1][c1] = ' ';
      itsMyTurn = true;
      mode = GAME;
    } else if (t == 2) {
      grid[r1][c1] = grid[r2][c2];
      grid[r2][c2] = lastPieceTaken;
      itsMyTurn = false;
      mode = WAITING;
    } else if (t == 3) {
      grid[r2][c2] = 'Q';
      itsMyTurn = true;
      mode = GAME;
    } else if (t == 4) {
      lastPieceTaken = grid[r2][c2];
      grid[r2][c2] = grid[r1][c1];
      grid[r1][c1] = ' ';
      itsMyTurn = false;
      mode = WAITING;
    } else if (t == 5) {
      grid[r2][c2] = 'B';
      itsMyTurn = true;
      mode = GAME;
    } else if (t == 6) {
      grid[r2][c2] = 'N';
      itsMyTurn = true;
      mode = GAME;
    } else if (t == 7) {
      grid[r2][c2] = 'R';
      itsMyTurn = true;
      mode = GAME;
    } else if (t == 8) {
      grid[r1][c1] = 'P';
      grid[r2][c2] = lastPieceTaken;
      itsMyTurn = false;
      mode = WAITING;
    }
  }
}

void drawBoard() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if ( (r%2) == (c%2) ) {
        fill(gray);
      } else {
        fill(blue);
      }
      rect(c*100, r*100, 100, 100);
    }
  }
}

void drawPieces() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if (grid[r][c] == 'r') image (wrook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'R') image (brook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'b') image (wbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'B') image (bbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'n') image (wknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'N') image (bknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'q') image (wqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'Q') image (bqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'k') image (wking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'K') image (bking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'p') image (wpawn, c*100, r*100, 100, 100);
      if (grid[r][c] == 'P') image (bpawn, c*100, r*100, 100, 100);
    }
  }
}

void gameClicks() {
  if (itsMyTurn && firstClick) {
    mode = GAME;
    row1 = mouseY/100;
    col1 = mouseX/100;
    firstClick = false;
    if (grid[row1][col1] == 'p') {
      p = true;
      sp = false;
    }
  } else {
    row2 = mouseY/100;
    col2 = mouseX/100;
    lastPieceTaken = grid[row2][col2];
    if (itsMyTurn && !(row2 == row1 && col2 == col1) && p && row2 == 0) {
      grid[row2][col2] = grid[row1][col1];
      grid[row1][col1] = ' ';
      mode = PPROMO;
      myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 4);
      ppro = true;
      firstClick = true;
      itsMyTurn = false;
      sp = false;
    } else if (itsMyTurn && !(row2 == row1 && col2 == col1)) {
      grid[row2][col2] = grid[row1][col1];
      grid[row1][col1] = ' ';
      mode = WAITING;
      myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 1);
      ppro = false;
      firstClick = true;
      itsMyTurn = false;
      sp = false;
    }
  }
}

void keyReleased() {
  if (key == 'z' && !itsMyTurn) {
    if (sp == false) {
      grid[row1][col1] = grid[row2][col2];
      grid[row2][col2] = lastPieceTaken;
      mode = GAME;
      myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 2);
      firstClick = true;
      itsMyTurn = true;
      sp = false;
    } else if (sp == true) {
      grid[row1][col1] = 'p';
      grid[row2][col2] = lastPieceTaken;
      mode = GAME;
      sp = false;
      myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 8);
      firstClick = true;
      itsMyTurn = true;
      sp = false;
    }
  }
  if (key == 'q' || key == 'Q' && ppro && p) {
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        grid[row2][col2] = 'q';
        mode = WAITING;
        myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 3);
        ppro = false;
        p = false;
        sp = true;
      }
    }
  } else if (key == 'b'|| key == 'B' && ppro && p) {
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        grid[row2][col2] = 'b';
        mode = WAITING;
        myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 5);
        ppro = false;
        p = false;
        sp = true;
      }
    }
  } else if (key == 'n' || key == 'N' && ppro && p) {
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        grid[row2][col2] = 'n';
        mode = WAITING;
        myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 6);
        ppro = false;
        p = false;
        sp = true;
      }
    }
  } else if (key == 'r' || key == 'R' && ppro && p) {
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        grid[row2][col2] = 'r';
        mode = WAITING;
        myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 7);
        ppro = false;
        p = false;
        sp = true;
      }
    }
  }
}
