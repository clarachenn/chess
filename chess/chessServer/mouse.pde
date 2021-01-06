void mouseReleased() {

  if (mode == GAME) {
    gameClicks();
  } else if (mode == PPROMO) {
    ppromoClicks();
  } else if (mode == WAITING) {
    waitingClicks();
  }
}
