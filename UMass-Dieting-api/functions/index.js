const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');
const cors = require('cors');
const cron = require('node-cron');
const fs = require("fs");
const app = express();

var serviceAccount = require("./permissions.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://fir-api-9a206..firebaseio.com"
});
const db = admin.firestore();

app.use(cors({ origin: true }));

app.post('/api/scrape', (req, res) => {
    fs.readFile("./data.json", "utf8", (err, jsonString) => {
      if (err) {
        console.log("Error reading file from disk:", err);
        return;
      }
      try {
        const data = JSON.parse(jsonString);
        (async () => {
            try {
                await db.collection('database').doc('data').set(data);
                return res.status(200).send();
            } catch (error) {
                console.log(error);
                return res.status(500).send(error);
            }
            })();
      } catch (err) {
        console.log("Error parsing JSON string:", err);
      }
    });
});

app.get('/api/foods/get/:dining_hall/:menu', (req, res) => {
    const {
        dining_hall,
        menu
    } = req.params;
    (async () => {
        try {
            const data = await db.collection('database').doc('data').get()
            .then(data => {
                const foods = [];
                for (const food in data.data()[dining_hall][menu]) {
                    foods.push(data.data()[dining_hall][menu][food]);
                }
                return foods;
            })
            return res.status(200).send(data);
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
        })();
});

app.post('/api/users/create', (req, res) => {
    const {
        email,
        password,
        gender,
        age,
        weight,
        height,
        activity_level,
        location_lat,
        location_long,
        tag_preferences,
        reccomended_calories
    } = req.body;
    (async () => {
        try {
            await db.collection('users').add({
                email,
                password,
                gender,
                age,
                weight,
                height,
                activity_level,
                location_lat,
                location_long,
                tag_preferences,
                reccomended_calories
            });                
            return res.status(200).send();
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
        })();
});

app.post('/api/reccomendations/create', (req, res) => {
    const {
        tag_preferences,
        reccomended_calories
    } = req.body;
    (async () => {
        try {
            // TODO: logic

            // calculate reccomended 

            return res.status(200).send();
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
        })();
});

exports.app = functions.https.onRequest(app);
