import re,math
import time
from time import sleep
import urllib.request
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.keys import Keys
import requests
import undetected_chromedriver.v2 as uc
sarkiListesi=[]
durum=0

driver = webdriver.Chrome(ChromeDriverManager().install())

url = "https://open.spotify.com/playlist/4DIMr0Ol7eblIBWzscWCcf"
driver.get(url)
body = driver.find_element_by_css_selector('body')
body.click()

sarkiSayisi = body.text.split("\n")[16].split(" ")[0]
playlistAdi=body.text.split("\n")[13]

for i in range(math.ceil(int(sarkiSayisi)/6)):
    for x in body.text.split("\n"):
        try:
            x=int(x)
        except:
            pass
        if type(x)==int:
            durum=1
            continue
        if durum==1:
            if x not in sarkiListesi and type(x) != int:
                sarkiListesi.append(x)
            durum=0
    body.send_keys(Keys.PAGE_DOWN)

print(sarkiListesi,"\n",len(sarkiListesi))

username="buraksamp34@gmail.com"
password="40501645768"



driver = uc.Chrome()
driver.delete_all_cookies()

driver.get("https://accounts.google.com/signin/v2/identifier?ltmpl=music&service=youtube&uilel=3&passive=true&continue=https%3A%2F%2Fwww.youtube.com%2Fsignin%3Faction_handle_signin%3Dtrue%26app%3Ddesktop%26hl%3Dtr%26next%3Dhttps%253A%252F%252Fmusic.youtube.com%252F%26feature%3D__FEATURE__&hl=en&flowName=GlifWebSignIn&flowEntry=ServiceLogin")

sleep(3)

driver.find_element_by_xpath('//input[@type="email"]').send_keys(username)
driver.find_element_by_xpath('//*[@id="identifierNext"]').click()
sleep(5)

driver.find_element_by_xpath('//input[@type="password"]').send_keys(password)
driver.find_element_by_xpath('//*[@id="passwordNext"]').click()

sleep(2)

driver.get('https://music.youtube.com/playlist?list=PLgCI5loG-Chfb50DT4Ki1AS4SzLGe5eNn')
sleep(2)
try:
    driver.find_element_by_xpath("//*[text()='Add to library']").click()
except:
    pass
for i in sarkiListesi:
    search_keyword = i.replace(" ","+")
    #html=urllib.request.urlopen("https://music.youtube.com/search?q=" + search_keyword)
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
        driver.find_element_by_xpath("//*[text()='deneme']").click()
    except:
        pass
sleep(10000)



""" 
search_keyword = "mozart".replace(" ","+")
html=urllib.request.urlopen("https://www.youtube.com/results?search_query=" + search_keyword)
video_ids=re.findall(r"watch\?v=(\S{11})", html.read().decode())
print("https://www.yotube.com/watch?v="+ video_ids[0])
"""
