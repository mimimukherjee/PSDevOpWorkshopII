const express = require('express');
const app = express();

let port = process.env.PORT || 9500;

app.use(express.static(__dirname));
app.listen(port);

console.log(`listening on ${port}`);
