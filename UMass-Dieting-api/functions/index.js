const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');
const cors = require('cors');
const cron = require('node-cron');
const fs = require("fs");
const app = express();

var serviceAccount = require("./permissions.json");
const { initializeApp } = require('firebase-admin');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://fir-api-9a206..firebaseio.com"
});
const db = admin.firestore();

function generateRandomFloatInRange(min, max) {
    return (Math.random() * (max - min + 1)) + min;
}

app.use(cors());

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
    let bestMeal = null;
    const {
        tag_preferences,
        recommended_calories,
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
                    // only > 50 calories
                    if (data.data()[dining_hall][menu][food]['calories'] > 35) {
                        foods.push(data.data()[dining_hall][menu][food]);
                    }
                }
                food_info = foods;
            })
            if (food_info.length === 0) {
                return res.status(200).send({});
            }            
            let initalFilter = []
            food_info.forEach(food => {

                // get all tags related to food
                food_tags = food['tags'].split(" ")
                let has_tags = false;
                
                // loop through user's preferenes
                for(let i = 0; i < tag_preferences.length; i++){
                    // if user preference is not in food, don't add it 
                    if((food_tags.includes(tag_preferences[i]))){
                        has_tags = true;
                        break
                    }
                }

                if (tag_preferences.length === 0) {
                    has_tags = true;
                }                
                
                // if the user preference and carbon rating > C we push 
                if(has_tags && (food['carbon_rating'] == 'A' || food['carbon_rating'] == 'B' || food['carbon_rating'] == 'C')){
                    initalFilter.push(food)
                }

            })

            if (initalFilter.length === 0) {
                return res.status(200).send({});
            }
            
            meals = [];
            for(let j = 0; j < 10; j++){

                let mealObject = {
                    'dishes': [],
                    'calories': 0,
                    'total_fat': 0,
                    'sat_fat': 0,
                    'trans_fat': 0,
                    'cholesterol': 0,
                    'sodium': 0,
                    'total_carbs': 0,
                    'dietary_fiber': 0,
                    'sugar': 0,
                    'protein': 0,
                    'co2': 0
                }
                // console.log(initalFilter[0]['dish_name'])
                while(mealObject['calories'] <= recommended_calories/3){
                    let curr = initalFilter[Math.floor(Math.random() * initalFilter.length)]
                    mealObject['dishes'].push(curr)
                    mealObject['calories'] += curr['calories']
                    mealObject['total_fat'] += curr['total_fat']
                    mealObject['sat_fat'] += curr['sat_fat']
                    mealObject['trans_fat'] += curr['trans_fat']
                    mealObject['cholesterol'] += curr['cholesterol']
                    mealObject['sodium'] += curr['sodium']
                    mealObject['total_carbs'] += curr['total_carbs']
                    mealObject['dietary_fiber'] += curr['dietary_fiber']
                    mealObject['sugar'] += curr['sugar']
                    mealObject['protein'] += curr['protein']
                    // mealObject['co2'] += curr['protein']
                    if (curr['serving_size'].toUpperCase().includes('OZ')) {

                        const getCarbonMap = () => {
                            return {
                                'A': generateRandomFloatInRange(0.4, 1.4),
                                'B': generateRandomFloatInRange(1.8, 2.45),
                                'C': generateRandomFloatInRange(2.5, 3.4),
                            }
                        }

                        const carbonMap = getCarbonMap();

                        // console.log(curr['serving_size']);
                        const tokens = curr['serving_size'].split(' ');

                        if (tokens.length > 0) {
                            const oz = tokens[0];

                            // does not contains digit
                            if (oz.match(/^[0-9]+$/) != null) {
                                const grams = parseInt(oz) * 28.3495;
                                mealObject['co2'] += grams * carbonMap[curr['carbon_rating']];
                            }
                        }
                    } else {
                        mealObject['co2'] += 50;
                    }
                }

                meals.push(mealObject)

                // console.log(meals);
                
                bestMeal = meals[0];
                for (let i=0; i<meals.length; ++i) {
                    if (meals[i]['co2'] != 0 && meals[i]['co2'] < bestMeal['co2']) {
                        bestMeal = meals[i];
                    }
                }
            }
            
            

            return res.status(200).send(bestMeal);
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
        })();
});

exports.app = functions.https.onRequest(app);
