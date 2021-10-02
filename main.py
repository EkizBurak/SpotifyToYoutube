import time,math
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.keys import Keys

sarkiListesi=[]
durum=0

driver = webdriver.Chrome(ChromeDriverManager().install())

url = "https://open.spotify.com/playlist/2Go7FGLwRshojHDNtBFf09"
driver.get(url)
body = driver.find_element_by_css_selector('body')
body.click()

sarkiSayisi = body.text.split("\n")[16].split(" ")[0]
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
driver.quit()
