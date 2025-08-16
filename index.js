// index.js
const express = require('express');
const app = express();

app.get('/', (_req, res) => res.send('Hello from Node in Docker on WSL2!'));

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening on ${port}`));
