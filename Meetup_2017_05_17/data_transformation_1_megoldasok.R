#################################################################################
## Work hard, play hard -- Kik �s mennyit tanulnak otthon
## es sz�m�t-e ez egy�ltal�n a teszt�r�sn�l?
#################################################################################


#################################################################################
## 1. Elok�sz�letek
#################################################################################

## A tidyverse csomagokra val�sz�nuleg sz�ks�getek lesz.
library(tidyverse)

## M�g mindig a legut�bbi alkalmunkon megismert PISA adatsorral dolgozunk.
## Esetleg sz�ks�g lehet egy working directory be�ll�t�sra is (setwd() f�ggv�ny).
adat <- read.csv("pisa_hun_small.csv")
head(adat)

#################################################################################
## 1. feladat: Van-e k�l�nbs�g a l�nyok �s a fi�k otthon tanul�si szok�saiban?
#################################################################################

#################################################################################
## 1.1. feladat: K�sz�ts�nk egy �j oszlopot az eredeti adatsorban, amiben
## elt�roljuk az otthon �sszesen (matematika, nyelv, term�szettudom�nyok) 
## elt�lt�tt idot.
## 1 pont
#################################################################################

adat <- adat %>%
  mutate(OraszamOssz = OraszamOtthonMat + OraszamOtthonTermTud + OraszamOtthonNyelv)

#################################################################################
## 1.2. feladat: Milyen a nemek ar�nya a 20 otthon legt�bbet tanul� di�k k�z�tt?
## Ok mennyit idot t�ltenek otthon tanul�ssal?
## 3 pont
#################################################################################

top20 <- adat %>%
  arrange(desc(OraszamOssz)) %>%
  slice(1:20) 

(top20)

top20 %>%
  group_by(Nem) %>%
  summarise(atlag = mean(OraszamOssz))
#################################################################################
## 1.3. feladat: Rajzoljunk boxplotot arr�l, hogy az egyes nem tagjai h�ny �r�t
## t�ltenek otthoni gyakorl�ssal (�ssesen)!
## 2 pont
#################################################################################

ggplot(adat) +
  geom_boxplot(aes(x = Nem, y = OraszamOssz))

#################################################################################
## 1.4. feladat: Az �bra azt sugallja, hogy medi�nban nincs nagy k�l�nbs�g,
## a 75. percentilisben viszont igen. Sz�moljuk ki mindk�t nemre ezt a k�t �rt�ket,
## p�ld�ul a quantile() f�ggv�ny seg�ts�g�vel!
## 3 pont
#################################################################################

adat %>%
  group_by(Nem) %>%
  summarise(perc75 = quantile(OraszamOssz, 0.75, na.rm = T))

#################################################################################
## 2. feladat: Vajon az egyes t�rgyakb�l m�sk�ppen gyakorolnak otthon?
#################################################################################

#################################################################################
## 2.1. feladat: Transzform�ljuk egyetlen v�ltoz�ba (hossz� szerkezetben) 
## az otthoni gyakorl�st jelzo v�ltoz�kat (OraszamOtthon*)!
## 2 pont
#################################################################################

adat_hosszu <- gather(adat, Tantargy, Oraszam, c(7:9))

#################################################################################
## 2.1. feladat: Rajzoljuk �t a fenti boxplotot �gy, hogy az �sszes t�rgy
## k�l�n-k�l�n megjelenjen! K�l�nb�zik-e p�ld�ul a nyelvi gyakorl�ssal elt�lt�tt
## �r�k sz�ma a matematik��t�l?
## 2 pont
#################################################################################

ggplot(adat_hosszu) +
  geom_boxplot(aes(x = Nem, y = Oraszam)) +
  facet_wrap(~Tantargy)

#################################################################################
## 3. feladat: Vajon mennyit sz�m�t a gyakorl�s?
#################################################################################

#################################################################################
## 3.1. feladat: K�sz�ts�nk egy �j v�ltoz�t OraszamKategoria n�ven,
## ami az otthon nyelvgyakorl�ssal
## t�lt�tt �r�k 2-es alap� logaritmus�nak az als� eg�sz r�sz�t t�rolja majd!
## Esetleg n�zz�k meg a log2() �s a floor() f�ggv�nyeket!
## 3 pont
#################################################################################

adat <- adat %>%
  mutate(OraszamKategoria = floor(log2(OraszamOtthonNyelv)))
head(adat)

#################################################################################
## 3.2. feladat: Rajzoljunk boxplotot a sz�veg�rt�s pontsz�mokb�l a nemekre
## �s a gyakorl�ssal t�lt�tt �r�kra szepar�ltan (p�ld�ul sz�nezz�nk a nemek
## szerint �s facetelj�nk a f�nti v�ltoz� ment�n)!
## 3 pont
#################################################################################

ggplot(adat) +
  geom_boxplot(aes(x = Nem, y = PontSzovegertes)) +
  facet_wrap(~OraszamKategoria)
