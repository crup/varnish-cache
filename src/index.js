const express = require('express');
const app = express();

app.get('/test', (req, res) => {
  const delayTime = req.query.delay || 0; // default to 0 if no delay is provided
  const startTime = Date.now();
  setTimeout(() => {
    const endTime = Date.now();
    const responseTime = endTime - startTime;
    res.set('Content-Type', 'text/html');
    res.send(Buffer.from(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Sample Site</title>
      <style>
        body { padding-top: 50px; }
      </style>
    </head>
    <body>
    
      <div class="container">
        <div class="jumbotron">
          <h1>Response time: ${responseTime} ms</h1>
        </div>
      </div>
        
    </body>
    </html>
    `));
  }, delayTime);
});

app.listen(3000, () => {
  console.log('Server listening on port 3000');
});