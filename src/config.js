const path = require("path");

module.exports = {
  sprites: [
    {
      output_dir: path.resolve(__dirname, "../docs/sprite"),
      icons: [path.resolve(__dirname, "../maki-icons")],
    },
  ],
};
