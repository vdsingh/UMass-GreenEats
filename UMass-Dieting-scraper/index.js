
const express = require('express');
const cron = require('node-cron');
const app = express();
const port = process.env.PORT || 5000;

const admin = require('firebase-admin');

var serviceAccount = require('./permissions.json');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://fir-api-9a206..firebaseio.com"
});
const db = admin.firestore();

cron.schedule('0 */24 * * *', async() => {
    const { spawn } = require('child_process');
    const pyProg = spawn('python3', ['./scrape.py']);
    let json = '';
    pyProg.stdout.on('data', async function(data) {
      json += data.toString();
    });
    console.log(json);

    pyProg.on('exit', async function(data) {
        try {
	    console.log('exiting');
	    console.log(json);
            await db.collection('database').doc('data-2').set(JSON.parse(json));
        } catch (error) {
            console.log(error);
        }
    })
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
})
