from selenium import webdriver
from selenium.webdriver.common.by import By


def main(dining_hall):
    user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36"

    options = webdriver.FirefoxOptions()
    options.headless = True
    options.add_argument(f'user-agent={user_agent}')
    driver = webdriver.Firefox(executable_path="geckodriver", options=options)

    driver.get('https://umassdining.com/locations-menus/' + dining_hall + '/menu')

    not_found = True
    while not_found:
        try:
            food_items = driver.find_element(By.ID, "breakfast_menu").find_element(By.ID, 'content_text').find_elements(By.TAG_NAME, 'li')
            not_found = False
        except Exception as e:
            pass

    print()


if __name__ == '__main__':
    main()

