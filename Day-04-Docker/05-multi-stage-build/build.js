const fs = require("fs");

if (!fs.existsSync("dist")) {
    fs.mkdirSync("dist");
}

fs.copyFileSync("src/server.js", "dist/server.js");

console.log("Build completed successfully.");