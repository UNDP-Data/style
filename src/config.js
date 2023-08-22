const path = require("path");

module.exports = {
  sprites: [
    {
      output_dir: path.resolve(__dirname, "../docs/sprite"),
      icons: [path.resolve(__dirname, "../assets//maki-icons")],
      isSDF: true,
    },
    {
      output_dir: path.resolve(__dirname, "../docs/sprite-non-sdf"),
      icons: [path.resolve(__dirname, "../assets/maki-icons")],
      isSDF: false,
    },
  ],
};
