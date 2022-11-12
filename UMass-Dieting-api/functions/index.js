// const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


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
        recommended_calories
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
                recommended_calories
            });                
            return res.status(200).send();
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
        })();
});

app.post('/api/recommendations/create', (req, res) => {
    const {
        user_ID,
        dining_hall,
        menu
    } = req.body;
    (async () => {
        try {
            // TODO: logic
            let food_info;
            const data = await db.collection('database').doc('data').get()
            .then(data => {
                const foods = [];
                for (const food in data.data()[dining_hall][menu]) {
                    foods.push(data.data()[dining_hall][menu][food]);
                }
                food_info = foods;
            })
            

            
            let tag_preferences;
            let recommended_calories;
            let user_info = await db.collection('users').doc(user_ID).get()
            .then(user_info => {
                tag_preferences = user_info.data()["tag_preferences"]
                recommended_calories = user_info.data()["reccomended_calories"]
            })
            
            

            return res.status(200).send({tag_preferences, recommended_calories, food_info});
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
        })();
});

exports.app = functions.https.onRequest(app);
