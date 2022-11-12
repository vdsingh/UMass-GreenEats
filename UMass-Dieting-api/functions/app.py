from selenium import webdriver
from selenium.webdriver.common.by import By
from datetime import datetime
import json


def get_food(food_items, food_list):
    for food in food_items:
            data = food.find_element(By.TAG_NAME, 'a')

            ingredients = data.get_attribute('data-ingredient-list')
            try:
                ingredients = str(ingredients)
            except Exception as a:
                pass

            healthfulness = data.get_attribute('data-healthfulness')
            try:
                healthfulness = str(healthfulness)
            except Exception as a:
                pass
        
            carbon_rating = data.get_attribute('data-carbon-list')
            try:
                carbon_rating = str(carbon_rating)
            except Exception as a:
                pass

            allergens = data.get_attribute('data-allergens')
            try:
                allergens = str(allergens)
            except Exception as a:
                pass

            serving_size = data.get_attribute('data-serving-size')
            try:
                serving_size = str(serving_size)
            except Exception as a:
                pass

            calories = int(data.get_attribute('data-calories'))
            total_fat = float(data.get_attribute('data-total-fat')[:-1])
            sat_fat = float(data.get_attribute('data-sat-fat')[:-1])
            trans_fat = data.get_attribute('data-trans-fat')[:-1]
            try:
                trans_fat = float(trans_fat)
            except Exception as a:
                pass

            cholesterol = float(data.get_attribute('data-cholesterol')[:-2])
            sodium = float(data.get_attribute('data-sodium')[:-2])
            total_carbs = float(data.get_attribute('data-total-carb')[:-1])
            dietary_fiber = float(data.get_attribute('data-dietary-fiber')[:-1])
            sugar = data.get_attribute('data-sugars')[:-1]
            try:
                sugar = float(sugar)
            except Exception as a:
                pass

            protein = float(data.get_attribute('data-protein')[:-1])
            dish_name = str(data.get_attribute('data-dish-name'))

            tag_data = food.find_elements(By.TAG_NAME, 'img')
            tags = ""
            for tag in tag_data:
                temp = tag.get_attribute('src')[53:-4]
                tags += temp + " "
            tags = str(tags)

            food_list[dish_name] = {
                'dish_name': dish_name,
                'ingredients': ingredients,
                'healthfulness': healthfulness,
                'carbon_rating': carbon_rating,
                'allergens': allergens,
                'serving_size': serving_size,
                'calories': calories,
                'total_fat': total_fat,
                'sat_fat': sat_fat,
                'trans_fat': trans_fat,
                'cholesterol': cholesterol,
                'sodium': sodium,
                'total_carbs': total_carbs,
                'dietary_fiber': dietary_fiber,
                'sugar': sugar,
                'protein': protein,
                'tags': tags
            }

            


def main():
    options = webdriver.FirefoxOptions()
    options.headless = True
    driver = webdriver.Firefox(executable_path="geckodriver", options=options)
    
    
    # not_found = True
    # while not_found:
    #     try:
    #         food_items = driver.find_element(By.ID, 'dining_menu').find_element(By.ID, 'breakfast_menu').find_element(By.ID, 'content_text').find_elements(By.TAG_NAME, 'li')
    #         not_found = False
    #     except Exception as e:
    #         pass
    
    #print(food_items)

    # food_items = driver.find_element(By.ID, 'dining_menu').find_element(By.ID, 'content_text').find_elements(By.TAG_NAME, 'li')

    
    # for food in food_items:
    #     not_found = True
    #     while not_found:
    #         try:
    #             ingredients = food.find_element(By.TAG_NAME, 'a').get_attribute('data-ingredient-list')
    #             #link = post.find_element(By.TAG_NAME, 'a')
    #             food_info.append({'ingredients': ingredients})
    #             not_found = False
    #         except Exception as e:
    #             pass

    dining_halls_menus = {}

    for dh in ['worcester', 'berkshire', 'hampshire', 'franklin']:
        print(dh)
        driver.get('https://umassdining.com/locations-menus/' + dh + '/menu')

        menu_bfast = {}
        try:
            if dh in ['worcester', 'berkshire']:
                food_items = driver.find_element(By.ID, 'dining_menu').find_element(By.CLASS_NAME, 'breakfast_fp').find_elements(By.TAG_NAME, 'li')
                get_food(food_items, menu_bfast)
        except Exception as e:
            pass

        menu_lunch = {}
        food_items = driver.find_element(By.ID, 'dining_menu').find_element(By.CLASS_NAME, 'lunch_fp').find_elements(By.TAG_NAME, 'li')
        get_food(food_items, menu_lunch)

        menu_dinner = {}
        food_items = driver.find_element(By.ID, 'dining_menu').find_element(By.CLASS_NAME, 'dinner_fp').find_elements(By.TAG_NAME, 'li')
        get_food(food_items, menu_dinner)

        menu_latenight = {}
        if dh in ['worcester', 'berkshire']:
            food_items = driver.find_element(By.ID, 'dining_menu').find_element(By.CLASS_NAME, 'latenight_fp').find_elements(By.TAG_NAME, 'li')
            get_food(food_items, menu_latenight)

        menu = {
            'breakfast_menu': menu_bfast,
            'lunch_menu': menu_lunch,
            'dinner_menu': menu_dinner,
            'latenight_menu': menu_latenight,
        }

        dining_halls_menus[dh] = menu

    print(dining_halls_menus)

    json_object = json.dumps(dining_halls_menus, indent=4)
 
    # Writing to sample.json
    with open("data.json", "w") as outfile:
        outfile.write(json_object)

    driver.close()

    driver.quit()


if __name__ == '__main__':
    
    # curr_time = datetime.strftime(datetime.now(), "%H %M").split(" ")
    # print(curr_time)

    # if int(curr_time[0])<=6:
    #     current_menu = 'none'
    # elif int(curr_time[0])<=10:
    #     current_menu = 'breakfast'
    # elif int(curr_time[0])<=4 or (int(curr_time[0])==4 and int(curr_time[1])<=29):
    #     current_menu = 'lunch'
    # elif int(curr_time[0])<=8:
    #     current_menu = 'dinner'
    # elif int(curr_time[0])<=11:
    #     current_menu = 'latenight'


    # print(current_menu)
    main()

