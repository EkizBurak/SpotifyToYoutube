# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Signal, Slot

from math import ceil
from time import sleep
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.keys import Keys
import undetected_chromedriver.v2 as uc

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
    getError= Signal(str)
    @Slot(str, str, str)
    def convert(self, checkbox, spotifyURL, youtubeURL):
        if checkbox == "false":
            self.getError.emit("You need to accept playlist access")
        elif spotifyURL == "":
            self.getError.emit("Spotify URL cannot be empty")
        elif youtubeURL == "":
            self.getError.emit("Youtube URL cannot be empty")
        elif checkbox == "true":
            playlist = []
            status=0

            driver = webdriver.Chrome(ChromeDriverManager().install())

            driver.get(spotifyURL)
            body = driver.find_element_by_css_selector('body')
            body.click()
            numberofSongs = body.text.split(",")[0].split("\n")[-1].split(" ")[0]
            for i in range(ceil(int(numberofSongs)/6)):
                for x in body.text.split("\n"):
                    try:
                        x=int(x)
                    except:
                        pass
                    if type(x) == int:
                        status = 1
                        continue
                    if status == 1:
                        if x not in playlist and type(x) != int:
                            playlist.append(x)
                        status = 0
                body.send_keys(Keys.PAGE_DOWN)

            username = "E-mail"
            password = "E-mail Password"



            driver = uc.Chrome()
            driver.delete_all_cookies()

            driver.get("https://accounts.google.com/signin/v2/identifier?ltmpl=music&service=youtube&uilel=3&passive=true&continue=https%3A%2F%2Fwww.youtube.com%2Fsignin%3Faction_handle_signin%3Dtrue%26app%3Ddesktop%26hl%3Dtr%26next%3Dhttps%253A%252F%252Fmusic.youtube.com%252F%26feature%3D__FEATURE__&hl=en&flowName=GlifWebSignIn&flowEntry=ServiceLogin")
            sleep(2)

            driver.find_element_by_xpath('//input[@type="email"]').send_keys(username)
            driver.find_element_by_xpath('//*[@id="identifierNext"]').click()
            sleep(2)

            driver.find_element_by_xpath('//input[@type="password"]').send_keys(password)
            driver.find_element_by_xpath('//*[@id="passwordNext"]').click()
            sleep(2)

            driver.get(youtubeURL)
            sleep(4)
            youtubePlaylistName = driver.find_element_by_css_selector('body').text.split("\n")[4]
            sleep(2)
            try:
                driver.find_element_by_xpath("//*[text()='Add to library']").click()
                sleep(2)
            except:
                pass

            try:
                driver.find_element_by_xpath("//*[text()='Continue']").click()
                sleep(2)
            except:
                pass
            for i in playlist:
                search_keyword = i.replace(" ","+")
                driver.get("https://music.youtube.com/search?q=" + search_keyword)
                sleep(2)
                try:
                    driver.find_element_by_xpath("//*[text()='Songs']").click()
                    sleep(2)
                except:
                    pass
                try:
                    driver.find_elements_by_class_name("ytmusic-menu-renderer")[1].click()
                    sleep(2)
                except:
                    pass
                try:
                    driver.find_element_by_xpath("//*[text()='Add to playlist']").click()
                    sleep(2)
                except:
                    pass
                try:
                    driver.find_element_by_xpath(f"//*[text()='{youtubePlaylistName}']").click()
                    sleep(2)
                except:
                    pass

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    main=MainWindow()
    engine.rootContext().setContextProperty("backend", main)
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
