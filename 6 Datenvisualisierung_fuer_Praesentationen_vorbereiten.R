################################################################
## Skript:      6 Datenvisualisierung f�r Pr�sentationen
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:
## (1) Die Optik von Grafiken anpassen �ber "Themes"
## (2) Titel und Untertitel setzen
## (3) X und Y-Achsen-Beschriftung
## (4) Legende anpassen
## (5) Anmerkungen in Plots platzieren
## (6) Farbwahl
##
######################################



## Libraries
library(ggplot2)


######
# (1) Themes
#  Themes kontrollieren die nicht datenspezfischen optischen Parameter
## Neben dem Standard theme (theme_grey) existieren einige weitere vordefinierte Themes
## bspw. theme_classic
## Sie k�nnen eine neues Theme aktivieren indem Sie es als Komponente 
## an eine Grafik h�ngen oder sie �ndern das theme f�r die aktuelle Session mit theme_set(theme_xy())

## Verwenden Sie das Histogramm mit den mtcars-Daten zum Benzinverbrauch (mpg).
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)

## Plotten Sie das Histogramm mit theme_classic() und mit theme_bw()
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_classic()

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_bw()


## Themes lassen sich nach blieben modifzieren.
## Jeffrey B.Arnold stellt im Package ggthemes einige weitere themes zur Verf�gung
## https://cran.r-project.org/web/packages/ggthemes/vignettes/ggthemes.html
## Testen Sie das theme des Grossmeisters Edward Tufte (theme_tufte)
## und jenes von Nate Silver ## http://fivethirtyeight.com/ (theme_fivethirtyeight())

library(ggthemes)
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_fivethirtyeight()

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_tufte()

#################
# Modifikation an theme-Parametern
#

# Schauen Sie sich die Struktur von theme_grey() an
theme_grey()
str(theme_grey())
# Jedes einzelne Element der Liste kann  modifiziert werden (wenn man m�chte)

# Daf�r erg�nzen Sie die Grafik mit der Komponente theme()
# Innerhalb von theme starten Sie mit dem zu modifzierenden Element
# Je nach Attribut des Subobjektes nehmen Sie Modifikationen wie folgt vor
# F�r Linien:                 element_line()
# F�r Hintergrund und Rahmen: element_rect()
# F�r Text:                   element_text()
# l�schen eines Elements:     element_blank()
# Bspw. arbeitet theme(plot.title=element_text(color="red")) mit einem 
# element_text() um die Farbe des Titels rot zu setzen

# Im Rahmen des Titel setzens (n�chster Abschnitt) testen wir, wie �ber theme() die Gr�sse des Titels angepasst wird

####
# themes k�nnen selber spezifiert werden
### Aufgabe: versuchen zu verstehen, was theme_blank alles macht

theme_clean<-function(base_size=12) {
  require(grid)
  theme_grey(base_size)
  theme(
    axis.title=element_blank(),
    axis.text=element_blank(),
    panel.background=element_blank(),
    panel.grid=element_blank(),
    axis.ticks.length=unit(0,"cm"),
    axis.ticks.margin=unit(0,"cm"),
    panel.margin=unit(0,"lines"),
    plot.margin=unit(c(0,0,0,0),"lines"),
    complete=TRUE
  )
}  

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_clean()


####
# ggplot2 bietet eine Reihe an M�glichkeiten, Graphiken auf einfache Weise zu modifzieren


#######################
# 2) Verwenden von Titeln
###################

# Erg�nzen sie das Benzin-Histogramm mit dem Titel "Benzinverbrauch von Motorfahrzeugen" 
# verwenden Sie daf�r labs() oder ggtitle()
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  ggtitle("Benzinverbrauch von Motorfahrzeugen")

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(title = "Benzinverbrauch von Motorfahrzeugen")


# Erg�nzen Sie den Titel mit einem Untertitel (n=32)
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  ggtitle("Benzinverbrauch von Motorfahrzeugen", subtitle = "n=32")

# Passen Sie den Schriftgr�sse an �ber theme(plot.title=element_text(size=rel(2)))
# rel() justiert die Gr�sse relativ zur Standardgr�sse (rel(2)=doppelt so gross)
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  ggtitle("Benzinverbrauch von Motorfahrzeugen", subtitle = "n=32")+
  theme(plot.title = element_text(size = rel(2)))


#######################
# 3) x- und y-Achsenbeschriftung
###################

# Manchmal bietet es sich an, die Achsenbeschriftung zu eliminieren
# �bergeben Sie daf�r innerhalb von theme() dem Objekt axis.title 
# das enstprechende Objekt zur L�schung (theme(axis.title=))
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme(axis.title=element_text())

# �berschreiben Sie die bestehenden Labels mit "Meilen pro Gallone" auf der x-Achse 
# und "H�ufigkeiten" auf der y-Achse
# xlab(), ylab()
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(x = "Meilen pro Gallone", y="H�ufigkeiten")

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  xlab("Meilen pro Gallone")+
  ylab("H�ufigkeiten")


#############
# 4) Legende
######

# Es gibt verschiedene M�glichkeiten die Legende anzupassen
# �ber guides() (bisher nicht erw�hnt), �ber scales_
# oder �ber die theme()-System.
# Bleiben wir zun�chst bei theme()

# Ausgangspunkt ist ein Histogramme f�r das Gewicht von Pflanzen nach Behandlungsgruppen
help("PlantGrowth")

ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()

# Die Information in der Legende redundant
# l�schen sie die Legende innerhalb von theme() 
# mit legend.position="none"

ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  theme(legend.position = "none")

# Schieben Sie Legende alternativ �ber die Grafik (top)
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  theme(legend.position = "top")

# Der Titel der Legende l�sst sich ebenfalls anpassen (mit labs(fill=))
# Setzen Sie den neuen Titel "Behandlung"
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  labs(fill="Behandlung")

# Die Labels lassen sich am einfachsten �ber scale_fill_discrete(labels=) anpassen
# �berschreiben Sie die bestehenden Labels
# indem Sie einen Vektor mit den Bezeichnungen "Kontrollgruppe", "Behandlung 1", "Behandlung 2" �bergeben
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  labs(fill="Behandlung")+
  scale_fill_discrete(labels=c("Kontrollgruppe", "Behandlung 1", "Behandlung 2"))

  
# Beachten Sie: Die Beschriftung auf der x-Achse haben sich nicht ver�ndert
# Daf�r m�sste scale_x_discrete verwendet werden. Probierenn Sie es aus
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  labs(fill="Behandlung")+
  scale_fill_discrete(labels=c("Kontrollgruppe", "Behandlung 1", "Behandlung 2"))+
  scale_x_discrete(labels=c("Kontrollgruppe", "Behandlung 1", "Behandlung 2"))


# Alternativ k�nnte man �ber levels() die bestehenden labels im dataframe �berschreiben



#######################
# 5) Anmerkungen in Grafiken
###################

# Anmerkungen k�nnen verwendet werden um 
# Zusatzinformationen in der Grafik zu platzieren

# daf�r wird standardm�ssig annotate() verwendet

## Beispielsweise k�nnen mit annotate()
# Datenwolken in einem Scatterplot beschriftet werden.

# Daten - faithful - Old Faithful Geyser Data
help(faithful)
faithful

# Ausgangspunkt ist ein Scatterplot zur Frage:
# Wie lange dauert es bis der alte, treue Geyser ausbricht? 
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()

# Textschnippsel werden �ber das Koordinatenysystem platziert
# annotate("text",x=,y=,label="Dieser Text wird angezeigt")
# platzieren Sie zwei Textschnippsel in der Grafik die "Fr�hstarter" und "Sp�tz�nder" markieren.
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  annotate("text",x=50,y=2.5,label="Fr�hstarter")+
  annotate("text",x=67,y=4.5,label="Sp�tz�nder")

# geom_text() funktioniert �hnlich, in der Logik von ggplot braucht es aber aes-Spezifikationen
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  geom_text(aes(x=50,y=2.5),label="Fr�hstarter")+
  geom_text(aes(x=67,y=4.5),label="Sp�tz�nder")

# geom_label() verziert die Textschnippsel mit einem Rahmen
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  geom_text(aes(x=50,y=2.5),label="Fr�hstarter")+
  geom_text(aes(x=67,y=4.5),label="Sp�tz�nder")

##
# Die M�glichkeit ausserhalbd der Grafik Fussnoten zu setzen ist n�tzlich um beispielsweise
# einen Hinweis zur Datenquellen zu platzieren
# Mit dem neusten ggplot2 Update ist dies �ber labs(caption=) m�glich
# Setzen Sie die Fussnote: "Quelle: Old Faithful Geyser Data"

ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  labs(caption="Quelle: Old Faithful Geyser Data")

  
  
#######################
# 6) Mit ggplot2 k�nnen Farben auf unterschiedliche Weise zugewiesen werden
# a) Farben direkt definieren (innerhalb geom_)
# b) Farben mit Auspr�gungen von Variablen verkn�pfen (als aesthetics-Parameter)

# a) Farben direkt definieren geschieht innerhalb von geom_
# fill= wird verwendet, um eine Fl�che mit einer bestimmten Farbe zu f�llen
# colour/color= wird f�r Linien verwendet


# F�rben Sie die Fl�chen des Histogrammes mit roter Farbe ein ("red")
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2, fill="red")

# F�rben Sie die Fl�chen des Histogrammes mit roter Farbe ein
# Verwenden Sie nun jedoch (Hexadecimal RGB-Codes) rot=#FF0000
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2, fill="#BB0011")

# F�rben Sie die Fl�chen des Histogrammes mit roter Farbe ein 
# und zeichnen Sie die Rahmen der Balken schwarz
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2, fill="#BB0011", colour = "black")+
  labs(x = "Meilen pro Gallone", y="H�ufigkeiten")
  


#######
# b) Farben mit Auspr�gungen von Variablen verkn�pfen
# Farben werden beim Zeichnen der geoms_ aktiviert
# Die �bergabe der Information erfolgt als Teil der aes()-Definition 

# �bergeben Sie die Werte der Variable Cultivar als F�llfarbe (fill)
ggplot(cabbage_exp, aes(x=Date,y=Weight))+
  geom_bar(position="dodge",stat="identity")






########
# EXTRA
# Die zu verwendende Farbpalette l�sst sich selber bestimmen
# scale_fill_manual() modifiziert Fl�chen
# scale_colour_manual() modifiziert Linien


# Aber welche Farben w�hlt man?
# Auf der Seite http://colorbrewer2.org/ k�nnen verschiedene Farbkombinationen ausgetestet werden, 
# die �ber Hexadecimal-Codes an R �bergeben werden k�nnen


# R ColorBrewer stellt verschiedene Palette zur Verf�gung
library(RColorBrewer)

# Alle Farben anzeigen
display.brewer.all()

# Es existieren drei Klassen von Color-Settings, 
# (1) tief-zu-hoch oder sequentielle
# (2) kategoriale oder qualitative
# (3) polarisierte mit "neutral" in der Mitte (divergierend)


# Eine Farbpalette anzeigen lassen 
# display.brewer.pal(n=Anzahl gew�nschter Farben,name="Name der Palette"
display.brewer.pal(n=3,name="Greens")

# speichern Sie die palette mit brewer.pal() in einem eigenen Objekt.
greens <- brewer.pal(n = 3, name = "Greens")

# Und �bergeben Sie die Palette mit scale_fill_manual(values=) einer Grafik
ggplot(cabbage_exp, aes(x=Date,y=Weight,fill=Cultivar))+
  geom_bar(position="dodge",stat="identity")+
  scale_fill_manual(values=greens)+
  theme_bw()


# Tipp: Stimmen Sie die Farben ihrer Grafiken auf die Farben des CI ihres Unternehmens ab.











