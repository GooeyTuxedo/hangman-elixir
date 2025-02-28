// assets/js/hangman_hooks.js

// Shared state that persists across LiveView updates
window.hangmanSoundState = {
  enabled: localStorage.getItem('hangmanSoundEnabled') !== 'false'
};

// Sound Control Hook
export const createSoundControlHook = () => {
  return {
    mounted() {
      // Initialize the UI based on stored state
      this.updateIcon();
      
      // Set up click handler
      this.el.addEventListener('click', () => {
        window.hangmanSoundState.enabled = !window.hangmanSoundState.enabled;
        localStorage.setItem('hangmanSoundEnabled', window.hangmanSoundState.enabled);
        this.updateIcon();
      });
    },
    
    updated() {
      // Make sure the icon stays consistent after LiveView updates
      this.updateIcon();
    },
    
    updateIcon() {
      const volumeOn = this.el.querySelector('#volume-on');
      const volumeOff = this.el.querySelector('#volume-off');
      
      if (window.hangmanSoundState.enabled) {
        volumeOn.classList.remove('hidden');
        volumeOff.classList.add('hidden');
      } else {
        volumeOn.classList.add('hidden');
        volumeOff.classList.remove('hidden');
      }
    }
  };
};

// Sounds Hook
export const createSoundsHook = () => {
  return {
    mounted() {
      console.log("HangmanSounds hook mounted");
      
      // Preload audio files
      this.correctSound = new Audio('/sounds/correct.mp3');
      this.wrongSound = new Audio('/sounds/wrong.mp3');
      this.winSound = new Audio('/sounds/win.mp3');
      this.loseSound = new Audio('/sounds/lose.mp3');

      // Load sounds
      [this.correctSound, this.wrongSound, this.winSound, this.loseSound].forEach(sound => {
        sound.load();
      });

      // Set up event listeners
      this.guessResultHandler = (e) => {
        if (!window.hangmanSoundState.enabled) return;
        
        if (e.detail.correct) {
          this.correctSound.play().catch(err => console.error("Error playing sound:", err));
        } else {
          this.wrongSound.play().catch(err => console.error("Error playing sound:", err));
        }
      };
      
      this.gameOverHandler = (e) => {
        if (!window.hangmanSoundState.enabled) return;
        
        if (e.detail.won) {
          this.winSound.play().catch(err => console.error("Error playing sound:", err));
        } else {
          this.loseSound.play().catch(err => console.error("Error playing sound:", err));
        }
      };
      
      window.addEventListener('phx:guess-result', this.guessResultHandler);
      window.addEventListener('phx:game-over', this.gameOverHandler);
    },
    
    destroyed() {
      // Clean up event listeners when the hook is destroyed
      window.removeEventListener('phx:guess-result', this.guessResultHandler);
      window.removeEventListener('phx:game-over', this.gameOverHandler);
    }
  };
};