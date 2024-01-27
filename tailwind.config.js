module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["business", "corporate"],
  },
  theme: {
    fontSize: {
      sm: '0.600rem',
      base: '0.8rem',
      xl: '1.066rem',
      '2xl': '1.421rem',
      '3xl': '1.894rem',
      '4xl': '2.525rem',
      '5xl': '3.366rem',
    },
    fontFamily: {
      heading: 'DM Mono',
      body: 'Noto Sans Ol Chiki',
    },
    fontWeight: {
      normal: '400',
      bold: '700',
    },
  }
}
