/* General settings */
const SETTINGS = {
  slidingDuration: 1000,      // How long it should take for the notification to slide in
  duration: 2500,             // How long the duration should stay shown. Note: Not in miliseconds - play around with the value
  easingStyle: 'easeOutExpo', // Easing style of the animation. Find more easings here: https://easings.net/
  lightMode: false,           // To enable light mode, set this to true. To enable dark mode, keep this false OR remove this line
  sound: true                 // To disable the sound effect, set this to false OR remove this line
}

/* Presets */
const PRESETS = {
  error: {
    icon: 'x-circle-fill', // You can find icon names here: https://icons.getbootstrap.com/
    primaryColor: '#ff6a6a',
    lightMode: {
      primaryColor: '#f5487f',
      secondaryColor: '#fff0f5e6'
    },
  },
  info: {
    icon: 'info-circle-fill',
    primaryColor: '#63abff',
    lightMode: {
      primaryColor: '#347bef',
      secondaryColor: '#eff6ffe6'
    }
  },
  success: {
    icon: 'check-circle-fill',
    primaryColor: '#6aff9d',
    lightMode: {
      primaryColor: '#279856',
      secondaryColor: '#f2fff8e6'
    }
  },
  warning: {
    icon: 'exclamation-circle-fill',
    primaryColor: '#f3e776',
    secondaryColor: '',
    lightMode: {
      primaryColor: '#d4cd21',
      secondaryColor: '#ffffefe6'
    }
  }
}