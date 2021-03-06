3################################################################
## Skript:      5 Spezialisierte-Auswertungstechniken
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziel:    Visuelle Auswertungstechniken kennenlernern 
##              zur Visualisierung mehrerer Variablen
##
####################################

# Ben�tigte Libraries
library(ggplot2)

#################
## Visualisation von Korrelationsmatrizen mit einem Correlogram
## Mittels Correlogram l�sst sich ein schneller �berblick zu Zusammenh�ngen in den Daten erhalten


# Daten - mtcars: Motor Trend Car Road Tests
help(mtcars)

# Eine Korrleationsmatrize gibt alle paarweise m�glichen Korrelation wieder
# Packen Sie den ganzen Datensatz in die Funktion cor(). Erkennen Sie Korrelationsstrukturen?
corrplot(corr = cor(mtcars))



# Es ist schwierig zu erkennen, wo die Musik spielt
# Ein Korrelations-Plot kann Abhilfe schaffen 
# Speichern Sie das Resultat im Objekt mcor
# und plotten Sie dieses Objekt mit corrplot()
library(corrplot)


# corrplot verf�gt �ber verschiedene n�tzliche Optionen. 
# Erg�nzen Sie die corrplot mit der Option addCoef.col = "black"
corrplot(corr = cor(mtcars), method = "pie", addCoef.col = "black")

# Mit "number.cex" justiert die Textgr�sse 
corrplot(corr = cor(mtcars), method = "pie", addCoef.col = "black", number.cex = 0.5)

##################
# Scatterplot-Matrix
# �hnlich wie eine Korrelationsmatrix visualisiert eine Scatterplot-Matrize 
# bivariate Zusammenh�nge in Daten

## Daten: countries - Health and economic data about countries around the world from 1960-2010
library(gcookbook) # F�r Daten
library(GGally)
help(countries)

# Wir untersuchen, wie Wirtschaftswachstum (GDP), Erwerbsquote(laborrate)
# Gesundheitsausgaben (healthexp) und Kindersterblichkeit (infmortality)
# korrelieren

# Erneut wird zuerst ein Subset f�r das Jahr 2009 erstellt
c2009<-countries %>%
  filter(Year==2009) %>%
  select(c(-Code,-Year))

# Die Funktion ggpairs() ist ausgezeichnet f�r Scatterplot-Matrizen
# Erstellen Sie eine Scatterplot/Korrelations-Matrix aller Variablen des reduzierten 
# Datensatzes c2009 (Achtung: schliessen Sie die Variable "Name" aus)
ggpairs(c2009[,2:5])

# Der Plot unterscheidet drei Bereiche: Die Diagonale (diag), den Bereich oberhalb der 
# Diagonale (upper) und den Bereich unterhalb der Diagonale (lower)
# Varieren Sie die Standardeinstellung wie folgt:
# (1) Ersetzen Sie die Dichtfunktion in der Diagonalen mit Bar-Plots
# (2) Erg�nzen Sie die Scatterplots mit einer linearen Kurve 
ggpairs(c2009[,2:5], 
        diag = list(continuous="barDiag"),
        lower = list(continuous="smooth"))


# Zwischen welchen Variablen ist der Zusammenhang am st�rksten?
# ist der Zusammenhang �berall linear?
M1<-lm(data=c2009, infmortality~GDP+laborrate+healthexp)
summary(M1)

c2009$GDP2<-c2009$GDP^2
c2009$healthexp2<-c2009$healthexp^2

M2<-lm(data=c2009, infmortality~GDP+GDP2+laborrate+healthexp+healthexp2)
summary(M2)


###############################################
# Facets oder Trellis-Plots
# 

# Faceting ist eine spezielle ggplot Technik, die es erlaubt Subplots geschichtet 
# nach Gruppen darzustellen
# Deswegen sind Factes besonders f�r Gruppenvergleiche geeignet
# Diese Art von Plots werden auch Trellis Graphen genannt (weil Sie wie Gitter aussehen)

# Daten: mpg - Fuel economy data from 1999 and 2008 for 38 popular models of car
help(mpg)
mpg

# Ausgangsplot ein Scatterplot mit Hubraum (displ) auf der x-Achse und 
# Benzinverbrauch (hwy) auf der y-Achse
ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point()


# Nutzen Sie die Facets-Funktion indem Sie obige Scatterplots unterschieden nach 
# Antriebssystem darstellen (drv) 
# Stellen die Subplots vertikal dar (+facet_grid(var~.))
ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point()+
  facet_grid(drv~.)

# Stellen Sie die Subplots mit horizontaler Anordnung dar (+facet_grid(.~var))
ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point()+
  facet_grid(.~drv)

### Nehmen Sie einen zweifache Facet-Splits vor (Zylinderzahl (cyl), + Antriebssystem (drv))
ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point()+
  facet_grid(drv~cyl)
  


###############################################
# Radar-Charts
# erm�glichen es Profile zu bilden und so erweitere visuelle Vergleiche anzustellen



### Damit wir einen Radarcharts bauen k�nnen, m�ssen die Daten im long-Format sein
###
library(scales)
library(reshape2)
library(tibble)

profil_cars <- mtcars %>%
  rownames_to_column( var = "car" ) %>% # Zeilennamen werden als Variable gespeichert
  mutate_each(funs(rescale), -car) %>%  # Reskalieren der Variablen zwecks Vergleichbarkeit
  melt(id.vars=c("car"), measure.vars=colnames(mtcars)) %>% 
  arrange(car)

# Schauen Sie sich den neuen Datensatz an, damit sie verstehen, wie er umgeformt ist
str(profil_cars)
View(profil_cars)

# Zeichne wir aber zuerst nur ein Profil f�r den "Ferrari Dino"
ferrari<-profil_cars %>%
  filter(car=="Ferrari Dino")

# Zeichnen Sie die Werte f�r den Ferrari als Linienplot
# Achtung: es braucht group=1 bei den aesthetics, damit ggplot weiss, dass die Werte zusammengeh�ren
ggplot(ferrari)+
  aes(x=variable,y=value,group=1)+
  geom_line()


# Jetzt transformieren wir das xy-Koordinatensystem einfach in ein polares Koordinatensystem
# coord_polar()
ggplot(ferrari)+
  aes(x=variable,y=value,group=1)+
  geom_line()+ coord_polar()


# Fast, die L�cke ist unsch�n
# wenn wir stattdessen die Linie als Fl�che zeichnen (geom_polygon()), sieht es besser aus.
# Wenn wir die F�llfl�che leer lassen fill=NA und nur die Linie einf�bren color="black"
# sieht es aus wie eine Linie
ggplot(ferrari)+
  aes(x=variable,y=value,group=1)+
  geom_polygon(color="red", fill=NA)+ coord_polar()




# Probieren Sie nun die Systemmatik auf den Datensatz mit allen Autos (profil_cars) zu �bertragen
# Damit je Auto ein eigenes Profil gezeichnet wird, bietet sich ein facet_wrap an
# Hinweis: mit theme(legend.position = "none") entfernen sie die Legende, die hier �berfl�ssig ist
ggplot(profil_cars)+
  aes(x=variable, y=value,group=car,color=car) +
  geom_polygon(fill=NA) + 
  coord_polar() + facet_wrap(~ car) + 
  theme(axis.text.x = element_text(size = 5))+
  theme(legend.position = "none")



##
# vgl. auch http://www.r-chart.com/2016/10/the-grammar-of-graphics-and-radar-charts.html
# oder als Alternative: https://www.ggplot2-exts.org/ggradar.html







