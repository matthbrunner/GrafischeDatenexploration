################################################################
## Skript:      1 WarmUpmitR
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Verstehen, wie bereits installierte Datensätze geladen werden
##              (2) Erste (nichtvisuelle) Datenexploration 
##
####################################



#############################
## Übungsdatensätze in R
##### 

# Lassen Sie sich die Datensätze anzeigen, die in R für Übungszwecke implementiert sind
data()


## Suchen Sie den Datensatz zu "Motor Trend Car Road Tests" und führen Sie eine 
## erste Begutachtung durch, die Ihnen Aufschluss zu folgenden Fragen geben.
# Wieviele Variablen sind vorhanden?
View(mtcars)
ncol(mtcars)
# Wie heissen die Variablen?
names(mtcars)
rownames(mtcars)
# Wieviele Objekte sind im Datensatz?
nrow(mtcars)
# Was sind die Beobachtungseinheiten?
str(mtcars)
# Wie sind die Variablen kodiert? Welche Datenypen liegen vor?

# Lassen Sie sich die ersten und die letzten sechs Objekte anzeigen
head(mtcars, 6)
tail(mtcars, 6)
# Mit help erhalten Sie zusätzliche Informationen zu den Daten
?mtcars



###########################
# Was ist der Wertebereich für die Anzahl Zylinder (cyl)?
# Wie hoch ist die durchschnittliche Pferdestärke (hp)? Wie hoch ist der Median?
summary(mtcars)



#######################
# Installieren Sie mit untenstehender ipak-Funktion die Pakete, die später benötigt werden
# Quelle: https://gist.github.com/stevenworthington/3178163
# "ggplot2", "gcookbook", "vcd", "corrplot","ggthemes","ReporteRs","dplyr","GGally","scales","reshape2","tibble"

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("ggplot2", "gcookbook", "vcd", "corrplot","ggthemes","ReporteRs","dplyr","GGally","scales","reshape2","tibble")
ipak(packages)




