module.exports = {
  presets: [
      ['@babel/preset-env', {
          targets: {
            esmodules: true,
            node: 14
          }
      }]
  ]
}