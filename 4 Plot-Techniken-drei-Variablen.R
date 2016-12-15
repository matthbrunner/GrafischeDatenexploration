################################################################
## Skript:      4 Plot-Techniken-drei-Variablen
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   Techniken der Datenexploration mit R - drei Variablen
##
####################################

##
# Benätigte libraries
library(ggplot2)
library(vcd)


###
# Mosaic-Plot für nominale Variablen 


# Daten - UCBAdmissions - Student Admissions at UC Berkeley
# Machen Sie sich mit den Daten vertraut
UCBAdmissions
help("UCBAdmissions")
str(UCBAdmissions)

# UCBAdmissionss ist ein aggregierter Datensatz von Bewerbern der Universität 
# Berkley unterschieden nach Departement und Geschlecht

# Hintergrund: Von 2691 Bewerbern, wurden 1198 (44.5%) zugelassen
# Zum Vergleich: von den 1835  Bewerberinnen, wurden ledilgich 557 (30.4%) zugelassen
# Die Universität Berkley wurde entsprechend verklagt.
# Bei der Diskriminierungsklage gegen die Universität Berkeley handelt es sich 
# um ein berühmtes Beispiel zur Veranschaulichung des Simpson-Paradoxons
# https://de.wikipedia.org/wiki/Simpson-Paradoxon

# Frage: Wurden Frauen wirklich benachteiligt ?


# Das Datenformat ist etwas spezieller
# (3-dimensionale Arrays sind 3-fache Häufigkeitsauszählungen. 
# Sie kännen mit table() erstellt werden)
# mytable <- table(A, B, C) 

# Schauen Sie sich die Daten mit ftable() an
ftable(UCBAdmissions)


## Ein Mosaik-Plot unterteilt die Daten der Reihenfolge der Eingabe nach
# Erstellen Sie einen Mosaik-Plot (mosaic()), der die Daten zuerst nach 
# Zulassung (Admit) und danach nach Geschlecht (Gender) unterteilt
apply(UCBAdmissions, c(1, 2), sum)
mosaicplot(apply(UCBAdmissions, c(1, 2), sum),
           main = "Student admissions at UC Berkeley")
mosaic(UCBAdmissions)
mosaic(~Admit+Gender, data = UCBAdmissions)


# Nun nehmen Sie als dritte Variable die Departemente hinzu +Dept
## Was sagt Ihnen der Mosaik-Plot in Bezug auf die Zulassungspraktiken nach Geschlecht?


## Was wird ersichtlich, wenn wir die Daten anders splitten: Dept+Gender+Admit


## Zusätzliche optische Unterstützung gibt es mit den Optionen highlighting und direction
## Highlighting hebt Ausprägungen einer Variable farblich hervor
## direction gibt an in welche Richtung die Splitt's erfolgen v=vertical, h=horizontal
## Heben Sie die Geschlechter farblich hervor mit folgendem Code-Schnippsel
## highlighting = "Gender",highlighting_fill=c("lightblue","pink"), direction=c("v","v","h")
## Testen Sie die Darstellungsmäglichkeiten indem Sie die Parameter "v" und "h" austauschen.

mosaic(~Dept+Gender+Admit, data = UCBAdmissions,
       highlighting = "Gender", highlighting_fill = c("lightblue", "pink"),
       direction=c("v","v","h"),pop=FALSE)

## Fällt Ihnen etwas auf bezüglich Zulassung nach Geschlecht?





#################### 
# Mehrere Linien in einem Plot
# eignen sich für ordinale Variable auf der x-Achse, kontinuierliche auf der y-Achse + nominale Variable (Gruppe) 

# Benätigte Library (für Datenaufbereitung)
library(plyr)

# Daten: ToothGrowth - The Effect of Vitamin C on Tooth Growth in Guinea Pigs
help(ToothGrowth)

# Die Studie untersucht den Effekt von Vitamin C auf die Zähne. Dafür wurden unterschiedliche
# Verabreichungsmethoden getestet (VC=ascorbic acid, OJ=orange juice)
# Sind die Zähne der Meerschweinchen in Abhängigkeit der Dosis und der Verabreichungsmethode gewachsen?

# Wir berechnen zuerst das mittleres Wachstum der Zähne der Meerschweinchen 
# nach Verabreichungsmethode und Dosis (6 Gruppen) und speichern diese im Objekt tg
tg<-ddply(ToothGrowth, c("supp","dose"), summarise, length=mean(len))
tg


# Erstellen Sie zur Beantwortung der Untersuchungsfrage
# einen Linien-Plot mit der Dosis auf der x-Achse (dose) und der Länge der Zähne auf der y-Achse (length)
# Stellen Sie den Linienverlauf nach Verabreichungsmethode farblich dar (colour=supp)
ggplot(data=tg, aes(x=dose, y=length, colours = supp)) +
  geom_line(aes(group = supp))+
  ylim(0,30)

# Very basic bar graph



# Erstellen Sie  den selben Linien-Plot, der die Verabreichungsmethode über unterschiedliche Linientypen darstellt (linetype) anstatt über Farben
# Zeichnen Sie zusätzlich zu den Linien alle Messpunkte in die Grafik ein


######
# Barplots
# eignen sich für 2 nominale Variablen und eine metrische Variable
# Wenn theoretische begründete Vorstellungen zu Ursache und Wirkungszusammenhängen bestehen, bietet sich folgende Anordnung an: x-Achse (erklärende Variable), Y-Achse (zu erklärende Variable), 
# Farb-Unterschiede für Gruppen (Drittvariablen)

# Daten: cabbage_exp - Data from a cabbage field trial (Summary)
# 
library(gcookbook)
help("cabbage_exp")

# Erstellen Sie einen Barplot, der auf der X-Achse die Information zum Datum enthält, 
# an welchem der Versuchs-Kohl gepflanzt wurde (Date), das mittlere Gewicht auf der y-Achse 
# sowie die unterschiedlichen Kultivierungsmethoden (cultivar) farblich aufzeigt (fill=)
# Hat die Kultivierungsmethode einen Einfluss auf das mittlere Gewicht der untersuchten Kohle?
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar))+
  geom_bar(position="dodge", stat="identity")

# Ohne postion="doge" wird ein gestapelter Barplot gezeigt.
# Für den Vergleich der Kultivierungsmethoden sind die getrennten Balken aber effektiver



#########
# Scatterplots (2 metrische Variablen) mit einer Gruppenvariable 

# Benätigte Library (für Daten)
library(plyr)

# Daten: heightweight - Height and weight of schoolchildren
# Nehmen Sie eine erste Dateninspektion vor
heightweight
help("heightweight")

# Ausgangspunkt ist der im vorangehenden Skript erstellte Scatterplot, 
# der Grässe und Alter der Schulkinder plottet
ggplot(heightweight, aes(x=ageYear,y=heightIn)) +
  geom_point()

# Wie sieht der Plot aus, wenn Geschlechterunterschiede (sex) farblich abgebildet werden (colour=)? 
# Ist der Zusammenhang von Alter und Grässe für Mädchen und Jungs anders?
ggplot(heightweight, aes(x=ageYear,y=heightIn, colour = sex)) +
  geom_point()

# Ergänzen Sie den Plot mit Loess-Linien (), 
# die Linien mit lokaler Anpassung an die Daten vornehmen 
# und den Zusammenhang von Alter und Grässe für Mädchen und Jungs unterschieden aufzeigen.
ggplot(heightweight, aes(x=ageYear,y=heightIn, colour = sex)) +
  geom_point()+
  geom_smooth(method = loess)



####
# Sind Plots mit drei metrischen Variablen mäglich?
# Klar. Hier kommt der Bubble-Chart/Ballon-Chart, eine Erweiterung des Scatterplots


## Daten: countries - Health and economic data about countries around the world from 1960-2010
library(gcookbook)
str(countries)
help(countries)

# Die Daten werden eingegrenzt - nur 2009
countsub<-filter(countries, Year==2009)

# Zeilen mit fehlenden Werten und die Variable laborrate[5] werden geläscht)
countsub<-countsub %>%
  na.omit() %>%
  select(-laborrate)

# Wie ist der Zusammenhang zwischen Kindersterblichkeit(infmortality), 
# Gesundheitsausgaben (healthexp) und dem Bruttosozialprodukt (GDP)?
# Erstellen Sie zur Beantwortung dieser Frage einen Bubble-Chart 
# mit den Gesundheitsausgaben auf der x-Achse, der Kindersterblichkeit 
# auf der y-Achse und dem Bruttosozialprodukt visualisiert über die Grässe der Punkte
# über aes(x=,y=,size=)
ggplot(countsub, aes(x=healthexp, y=infmortality, size=GDP))+
  geom_point()

# Grenzen Sie die Daten zuerst auf das Jahr 2009 ein,
# läschen sie fehlenden Werte na.omit() und die Variable laborrate

# Wenn man die Kreise etwas grässer zeichen will, braucht es scale_size_area(max_size=)
ggplot(countsub, aes(x=healthexp, y=infmortality, size=GDP))+
  geom_point()+
  scale_size_area(max_size = 10)

ggplot(countsub, aes(x=GDP, y=healthexp, size=infmortality))+
  geom_point()+
  scale_size_area(max_size = 15)




