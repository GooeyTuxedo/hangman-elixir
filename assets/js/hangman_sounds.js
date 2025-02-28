const setupHangmanSounds = () => {
  // Preload audio files
  const correctSound = new Audio('/sounds/correct.mp3');
  const wrongSound = new Audio('/sounds/wrong.mp3');
  const winSound = new Audio('/sounds/win.mp3');
  const loseSound = new Audio('/sounds/lose.mp3');

  // Ensure sounds are loaded
  [correctSound, wrongSound, winSound, loseSound].forEach(sound => {
    sound.load();
  });

  // Set up event listeners
  window.addEventListener('phx:guess-result', (e) => {
    if (e.detail.correct) {
      correctSound.play();
    } else {
      wrongSound.play();
    }
  });

  window.addEventListener('phx:game-over', (e) => {
    if (e.detail.won) {
      winSound.play();
    } else {
      loseSound.play();
    }
  });
};

export default setupHangmanSounds;