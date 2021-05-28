import os
import platform
from robot.api.deco import keyword


@keyword
def download_driver(browser="chrome"):
    browser = browser.lower()
    if browser == "gc":
        browser = "chrome"
    elif browser == "ff":
        browser = "firefox"

    command = f"webdrivermanager {browser}"
    if platform.system() == "Linux":
        link_path = "$HOME/.local/bin"
        command = f"{command} --linkpath {link_path}"
    os.system(command)
