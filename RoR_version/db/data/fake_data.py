from faker import Factory
from random import randint 
from random import expovariate
from bs4 import BeautifulSoup
from urllib.request import urlopen

import numpy
import os
import pprint

def promID(name):
  if name.lower().find("ufc") !=-1:
    return(1)
  elif name.lower().find("ultimate fighter") != -1:
    return(1)
  elif name.lower().find("strikeforce") !=-1:
    return(2)
  elif name.lower().find("wec") !=-1:
    return(2)
  else:
    return(0)

#return true if redlink
def check_redlink(url):
  if url.find("redlink") == -1:
    return(0)
  else:
    return(1)


######################################
fake = Factory.create()

############ fighters ################
f = open('fighters.txt', 'w')

for _ in range(0,200):
    f.writelines(["::",fake.name(), "::", str(randint(10,40)), "::", str(randint(5,20)), "::", str(randint(0,10)), "::", str(randint(0,5)), "\n"])

f.close
####################################

########### judges ##################

f = open('judges.txt', 'w')

for _ in range(0,50):
    f.writelines(["::",fake.name(), "\n"])

f.close

#####################################

########## fightcards ###############

f1 = open('fightcards.txt', 'w')
f2 = open('locations.txt', 'w')
wiki = "http://en.wikipedia.org"
events = wiki + "/wiki/List_of_UFC_events"
locations = {}
locID = 0;
if not(check_redlink(events)):
  with urlopen(events) as page:
    soup = BeautifulSoup(page)

tables = soup.find_all("table", class_="sortable wikitable succession-box")

fc_count=0
#List of UFC Events
for row in tables[1].findAll("tr"): #past events from wiki page
  cells = row.findAll("td") #parse each row in html table that is td 
  urls = row.find("a") #get all urls from html table
  if len(cells) >= 3:
    fc_count = fc_count+1
    #need to remove sort key from wiki
    fc_entry = cells[1].contents
    if len(fc_entry)>1: #has sort key
      fightcardName = fc_entry[1].text
    else:               #no sort key
      fightcardName = fc_entry[0].text

    location = cells[4].text
    city = location.split(",")[0]
    if location.count(",") >1:
        state = location.split(",")[1]
        country = location.split(",")[2]
    else:
        state = "NULL"
        country = location.split(",")[1]
    fightDate = cells[2].text[8:18]
    if ((city+state+country) in locations.keys()) is False:
        locID = locID +1
        locations[city+state+country] = [locID, city, state, country]
        f2.writelines(["::", city,"::",state, "::", country,"\n"])
    f1.writelines(["::", str(1),"::",fightcardName, "::", str(locations[city+state+country][0]), "::",fightDate, "\n"])


f1.close
f2.close
####################################

######### fights ###################
f = open('fights.txt', 'w')

for _ in range(0,2000):
    #fightcardID (1-338), fightcardNum(1-15), fighter1ID(1-200), fighter2ID(1-200), weightclass (1-8), cardlevel (1-3), championship(0-1), fighttime(60 - 1500), method
    fcID = str(randint(1,fc_count))
    fcnum = str(randint(1,15))
    wc = str(randint(1,8))
    cardlevel = str(randint(1,3))
    champ = str(numpy.floor(expovariate(5)))
    ftime = str(randint(60,1500))
    method = fake.text(max_nb_chars=50)
    f.writelines(["::",fcID, "::", fcnum, "::", wc, "::", cardlevel, "::", champ, "::", ftime, "::", method, "\n"])

f.close
####################################

######### fightstats ###################
######### Judgescore ###################
f1 = open('fightstats.txt', 'w')
f2 = open('judgescores.txt', 'w')

jid = [0]*3

prev=0
for fid in range(1,2000+1):
    rounds = randint(1,5) # choose between 1 and 5 round fights
    # get three judges that are different
    jid[0] = randint(1,50)
    jid[1] = randint(1,50)
    while jid[0] == jid[1]:
        jid[1] = randint(1,50)
    jid[2] = randint(1,50)
    while jid[2] == jid[1] or jid[2]==jid[0]:
        jid[2] = randint(1,50)
    
    for _ in  range(0,2):
        fighterid = randint(1,200)
        while fighterid == prev:
            fighterid = randint(1,200)
        prev=fighterid
        for r in range(1,rounds+1):
            #fightID (1-2000), fighterNum(1-2), round, kd(0-3), str_landed(5-20), str_thrown(10-50), td_thrown(0-8), td_com(0-5), sub_att(0-3)
            kd = str(randint(0,3))
            str_landed =randint(5,20)
            str_thrown=randint(10,50)
            while str_landed >= str_thrown:
                str_landed =randint(5,10)
            td_com = randint(0,5)
            td_thrown = randint(0,8)
            while td_com > td_thrown:
                td_com = td_thrown
            sub_att = str(randint(0,3))
            f1.writelines(["::",str(fid), "::", str(fighterid), "::", str(r), "::", kd, "::", str(str_landed), "::", str(str_thrown), "::", str(td_thrown), "::", str(td_com), "::", sub_att, "\n"])
            
            score = str(randint(8,10))
            f2.writelines(["::", str(jid[0]), "::",str(fid), "::", str(fighterid), "::", str(r), "::", score, "\n"])
            score = str(randint(8,10))
            f2.writelines(["::", str(jid[1]), "::",str(fid), "::", str(fighterid), "::", str(r), "::", score, "\n"])
            score = str(randint(8,10))
            f2.writelines(["::", str(jid[2]), "::",str(fid), "::", str(fighterid), "::", str(r), "::", score, "\n"])

f.close
