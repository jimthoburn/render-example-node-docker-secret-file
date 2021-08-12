'use strict';

const express = require('express');

// Constants
const PORT = process.env.PUBLIC_PORT;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Hello World');
});

// Health Check
app.get('/health-check', (req, res) => {
  res.send('Server is healthy');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);

console.log(`The value of the “SECRET_PORT” environment variable is: ${ process.env.SECRET_PORT }`);
