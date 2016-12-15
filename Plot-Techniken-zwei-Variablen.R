################################################################
## Skript:      3 Plot-Techniken-zwei-Variablen
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziel:    Bivariate Techniken der Datenexploration mit R
##
####################################




## Libraries
library(ggplot2)
library(dplyr)



#################
# Liniendiagramme
####
# Geeignet für ein ordinales Merkmal (viele Ausprägungen 5+) auf der x-Achse  
# und ein metrisches Merkmal auf der y-Achse (Bsp. eine Zeitreihe)

# Daten- BOD > Biochemical Oxygen Demand
# Schauen Sie sich den Datensatz an. Was wurde mit dem Datensatz untersucht? Was wurde gemessen?
help(BOD)

View(BOD)

# Wir untersuchen, wie sich die Variable "demand" über die Zeit entwickelt
# Wie entwickelt sich die biochemische Sauerstoff-Nachfrage von Wasser über die Zeit?
# Erstellen Sie ein Liniendiagram mit der Zeit (Time) auf der x-Achse und der Sauerstoff-Nachfrage (demand) auf der y-Achse
ggplot(BOD, aes(x=BOD$Time, y=BOD$demand))+
  geom_line()


# Standardmässig verwendet ggplot eine Wertebereich für die Y-Achsen, 
# die gerade ausreichend ist um alle Punkte anzuzeigen. 
# Wie sieht das Bild aus, wenn die Y-Achse bei Null startet? +ylim(0,max(BOD$demand))
ggplot(BOD, aes(x=BOD$Time, y=BOD$demand))+
  geom_line()+
  ylim(0, max(BOD$demand))


# Fügen Sie der Grafik ebenfalls die Messpunkte hinzu (mit +geom_point)
# Nur so wird ersichtlich, für welche Zeitpunkte tatsächlich Messungen vorliegen.
# Sind für alle Zeitpunkte Messdaten vorhanden?
ggplot(BOD, aes(x=BOD$Time, y=BOD$demand))+
  geom_line()+
  geom_point()



############
# Balkendiagramme 
#####

# Geeignet für ein ordinales Merkmal (wenige Ausprägungen) oder ein nominales Merkmal auf der x-Achse
# und ein metrisches Merkmal auf der y-Achse (Bpsw. Gruppenvergleiche für wenig Beobachtungen)

# Wie sieht der BOD-Plot von oben (x=Time, y=demand) mit Balken aus?
ggplot(BOD, aes(x=BOD$Time, y=BOD$demand))+
  geom_bar(stat="count")


# Achtung: Die Standardeinstellung von geom_bar() ist stat="count", d.h. die Höhe der Balken wird entsprechend der Anzahl Ausprägungen je Kategorie gezeichnet. 
help(geom_bar)
# Das passt prima für eine Häufigkeitsauszählung, nicht jedoch für die Anwendung hier.
# Im vorliegenden Fall soll die Länge der Balken entsprechend der beobachtet Werte gezeichnet werden. 
# Überschreiben Sie den Standardparameter mit dem Zusatz stat="identity"


############
# EXTRA zu Balkendiagramme 
# Eine elegante Alternative zum Bar Charts ist der Cleveland Dot Plot
# Er ist übersichtichler, weil weniger "Tinte" verwendet wird (Edward Tufte, Daten-Design-Guru, empfiehlt möglichst auf Grafik-Junk zu verzichten, d.h. überflüssige "Tinte" zu entfernen)
# Der Cleveland-Dot-Plot eignet sich daher für den Vergleich vieler Gruppen/Objekte 
# (nominale Variablen mit vielen Ausprägungen) weil er übersichtlicher ist

# Benötigte Library (für die Daten)
library(gcookbook)

# Daten: tophitters2001: Batting averages of the top hitters in Major League Baseball in 2001
# Baseball-Statistik der besten 144 Hitter 

# Inspizieren Sie die Daten
str(tophitters2001)
help("tophitters2001")

# Wir wollen die mittlere Anzahl getroffener Schläge je Spieler untersuchen (avg)

## Als Bar-Plot (geom_bar)
ggplot(tophitters2001, aes(x=name,y=avg)) +
  geom_bar(stat="identity")

# Als Punkt-Plot (geom_point)
ggplot(tophitters2001, aes(x=avg,y=name)) +
  geom_point()

# Es sind zu viele! Wir wollen wirklich nur die Besten
# Grenzen Sie die Daten auf die jene Hitters ein, die eine Trefferquote >0.31 haben
tophit<-tophitters2001[tophitters2001$avg>0.30,]

# Erstellen Sie nochmals einen Punkte-Plot
ggplot(tophit, aes(x=avg,y=name)) +
  geom_point()

# Jetzt ordnen wir die Namen (mit reorder())
ggplot(tophit, aes(x=avg,y=reorder(name,avg))) +
  geom_point()


# Und noch ein bisschen Zusatzästhetik.
# Voilà ein Cleveland-Dot-Plot 
ggplot(tophit, aes(x=avg,y=reorder(name,avg))) +
  geom_segment(aes(yend=name),xend=0, colour="grey50")+
  geom_point(size=4)+
  xlab("Mittlere Trefferquote je Versuch")+
  ylab("")+
  theme_bw()+
  theme(panel.grid.major.y=element_blank())

# EXTRA 
############

######
# Boxplots 

# Sind besonders für Gruppenvergleiche von metrischen Variablen mit vielen Beobachtungen geeignet
# Nutzen Sie erneut den Auto-Datensatz (mtcars)
# Übergeben Sie die Zahl der Zylinder(cyl) als x-Wert und die PS(hp) als Y-Wert


# Beeinflusst die Zahl der Zylinder die PS?







###################
# Streudiagram / Scatterplot
#####

## 
# Geeignet zur Darstellung beobachteter Wertepaare zweier metrischer Variablen

# Benötigte Libraries (für die Daten)
library(gcookbook)

# Daten (heightweight): Height and weight of schoolchildren
# Machen Sie sich mit den Daten vertraut. Welche Informationen beinhaltet der Datensatz?


# Erstellen Sie einen Scatterplot mit dem Alter der Schulkinder(ageYear) auf der X-Achse 
# und dem Grösse (heightIn) auf der Y-Achse

# Frage: Gibt es einen Zusammenhang zwischen dem Alter und der Grösse der Schulkinder?

# Der Zusammenhang kann  mit einer Regressionslinie veranschauchlicht werden
# Die Regressionslinie zeigt den linearen mittlere Veränderung der Grösse in Abhängigkeit des Alters
# +stat_smooth(method=lm, se=FALSE)








##### 
# EXTRA zu Scatterplot
# Was geschieht, wenn viele Datenpunkte vorliegen (grosse Datensätze).
# Die Datenpunkte überlagern (Overplotting) und 
# es wird schwierig die Verteilung der Daten in diesem Bereich zu erkennen

# Daten: diamonds- diamonds Data - Prices of 50,000 round cut diamonds

# Erste Dateninspektion
diamonds
help(diamonds)
str(diamonds)

# Nun zeichnen wir einen Scatterplot mit über 54'000 Datenpunkten
# Plotten Sie das Gewicht der Diamanten (carat) auf der x-Achse und 
# den Preis in US-Dollars (price) auf der y-Achse
ggplot(diamonds, aes(x=carat,y=price))+
  geom_point()

# Einige Muster werden kenntlich, Grenzen bei 1, 1.5 und 2 carat
# Insbesondere im Bereich von 0 bis 2 carat bleibt die Sache  obskur
# Es besteht die Möglichkeit, die Dichte zusätzlich mit einer Farbe zu visualisieren

# Dichte ist je Bins visualisiert
ggplot(diamonds, aes(x=carat,y=price))+
  stat_bin2d(bins=50)+
  scale_fill_gradient(low="lightblue",high="red",limits=c(0,6000))

# Werden Diamanten immer wertvoller je schwerer sie sind?
ggplot(diamonds, aes(x=carat,y=price))+
  stat_bin2d(bins=50)+
  scale_fill_gradient(low="lightblue",high="red",limits=c(0,6000))+
  stat_smooth(method=lm, se=FALSE,colour="black")

# Lineare Regression ist nicht die einzige Methode zur graphischen Beschreibung des Zusammenhanges
# Default für stat_smooth ist auch nicht lm, sondern loess
# loess sind locally weighted polynomiale Kurven, d.h. es wird nicht ein linearer Zusammenhang über alle Daten abzubilden versucht.
# Vielmehr werden die Daten in kleine Abschnitte zerlegt und eine Linie mit lokaler Anpassung an die Daten erzeugt
# Das ist ein guter Weg, um die Linearität eines Zusammenhanges zu überprüfen
ggplot(diamonds, aes(x=carat,y=price))+
  stat_bin2d(bins=50)+
  scale_fill_gradient(low="lightblue",high="red",limits=c(0,6000))+
  stat_smooth(method=loess, se=FALSE,colour="black")







