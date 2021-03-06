################################################################
## Skript:      2 Plot-Techniken-eine-Variable
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Univarite Techniken der Datenexploration mit R
##              (2) Unterschiede konventionelle Plot-Methode und ggplot erkennen 
##
####################################



## Libraries
library(ggplot2)

###
# Daten - Motor Trend Car Road Tests - mtcars
# F�hren Sie eine erste Datenbegutachtung durch, damit Sie eine grundlegende Vorstellung
# der verwendeten Daten haben
help(mtcars)

###############
# Stabdiagramme
# Frage: Welche Zylinderzahl kommt am h�ufigsten vor?
plot(table(mtcars$cyl))

###############
# Balken-Diagramme
# Erstellen Sie ein Balken-Diagramm f�r die Zylinderzahl mit der konventionellen Plot Funktion
barplot(table(mtcars$cyl))
 
# Erstellen Sie ein Balken-Diagramm mit ggplot 
# �bergeben Sie die Varialbe cyl einmal als kategoriales Merkmal (factor) 
# und einmal als metrisches Merkmal (numeric)
data.cyl <- df(mtcars$cyl)
max.cyl <- max(data.cyl)
min.cyl <- min(data.cyl)

factor(data.cyl)

# Umsetzung mit R
# factor > nominale Merkmale factor(data$var)
# ordered > ordinales Merkmal ordered(data$var)
# numeric > metrische Merkmale as.numeric(data$var)

ggplot(mtcars, aes(x=factor(data.cyl)))+
  geom_bar()

ggplot(mtcars, aes(x=as.numeric(data.cyl)))+
  geom_bar()

###############
# Kuchendiagramme

# Zeichnen Sie ein Kuchendiagram mit der konventionellen Plot Funktion
pie(table(mtcars$cyl))


## In ggplot gibt es keine direkte Umsetzung eines Kuchendiagrammes, weil Hadley Wickham, wie viele andere Statistiker
## glaubt, dass Kuchendiagramme ungenau sind
## Mit ein bisschen Arbeit l�sst sich jedoch ein Kuchendiagramm �ber einen Barchart und der Funktion coord_polar()
## erstellen
## vgl. http://www.r-chart.com/2010/07/pie-charts-in-ggplot2.html





###############
# Histogramme

# Untersuchen Sie die Verteilung der Variable mpg (miles per gallon)
# Die Variable gibt Auskunft zum Benzinverbrauch
# (eine Meile ~1.6 KM, eine Gallone ~ 3.8 liter)


# Erstellen Sie ein Histogramm mit der konventionellen Plot Funktion
# In welche Kategorie fallen am meisten Fahrzeuge?
hist(mtcars$mpg)

# Ver�ndern Sie die Zahl der Klassen �ber die Option breaks 
# Wie sieht das Histogram aus mit 5,7,10 Unterteilungen aus?
# �ndert sich etwas in Bezug auf die Aussage, welch Kategorie von Benzinverbrauch am h�ufigsten vorkommt?
hist(mtcars$mpg, breaks = 10)

# Erstellen Sie ein Histogramm mit ggplot
# Wie geht ggplot bei der Bestimmung der Breite der Intervalle vor?

ggplot(mtcars, aes(x=mpg))+
  geom_histogram()



# Mit ggplot l�sst sich die Breite der Klassen �ber "binwidth" steuern 
# Justieren Sie die Intervallbreite so, dass sie ungef�hr der Einteilung von breaks=10 mit der konvetionellen Plot-Funktion entspricht.
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth = 3)



#####
# EXTRA
# Alternativ l�sst sich f�r metrische Variablen eine WahrschenlichkeitsDichte-Funktion sch�tzen.
# Sie zeigt an, in welchen Bereiche viele und und in welchen
# Bereichen wenige Wahrscheinlichkeits"Masse" vorliegt
ggplot(mtcars, aes(x=mpg))+
  geom_density()

# Die Linien am Rand sind etwas unsch�n, vergr�ssern wir doch einfach die x-Achse
ggplot(mtcars, aes(x=mpg))+
  geom_density() +
  xlim(1,45)

# Mit adjust, l�sst sich die Gl�ttung kontrollieren
# Standard ist adjust=1, gr�ssere Werte=st�rkere Gl�ttung und umgekehrt
# Testen Sie verschiedene Parameter f�r adjust und beobachten Sie, wie sich die 
# Dichtefunktion ver�ndert
ggplot(mtcars, aes(x=mpg))+
  geom_density(adjust = 0.1) +
  xlim(1,45)
# EXTRA
#####




###############
# Boxplot
# 

# Erstellen Sie ein Boxplot f�r die Pferdest�rke (hp=horsepower) mit der konventionellen Plotfunktion
boxplot(mtcars$hp)

# Erstellen Sie ein Boxplot f�r die Pferdest�rke (hp=horsepower) mit ggplot
ggplot(data = mtcars, aes(x = factor(""),y = hp))+
  geom_boxplot()

# Gibt es ein Auto, dass Aufgrund der Daten als Ausreiser bezeichnet werden kann? Um welches Auto handelt es sich?
ggplot(data = mtcars, aes(x = factor(""),y = hp))+
  geom_boxplot()+
  geom_text(data = mtcars[mtcars$hp>300,], label = rownames(mtcars[mtcars$hp>300,]))














