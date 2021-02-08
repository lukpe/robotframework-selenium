from robot.api.deco import keyword
from webdrivermanager.webdrivermanager import ChromeDriverManager, GeckoDriverManager

@keyword
def download_driver(browser='chrome'):
    
    browser = browser.lower()
    if browser =='chrome' or browser == 'gc':
        ChromeDriverManager().download_and_install()
    elif browser == 'firefox' or browser == 'ff':
        GeckoDriverManager().download_and_install()
