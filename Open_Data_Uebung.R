

library()


# 1. Laden des Datensatzes und erste Begutachtung

# 1.1. Laden Sie den Datensatz gemeindedaten.csv
file <- "C:/Workspace/Weiterbildung/Grafische Datenexploration und Datenvisualisierung/Materialien Open Data Übung Gemeinden der Schweiz-20161208/Daten/gemeindedaten.csv"
gemeinde.daten <- read.csv(file)
str(gemeinde.daten)
View(gemeinde.daten)
# 1.2. Verschaffen Sie sich einen ersten Überblick zu den Daten? 
# Hat mit dem Einlesen alles geklappt wie erwartet? 
# A: Ja, sieht nicht schlecht aus
# Sind die Daten so kodiert, wie Sie es erwarten?
# A: Da ich nichts erwartet habe, ja :-)!
# Stimmen die Datenformate der Variablen? 
# A: Ja
# Gibt es fehlende Werte und wie sind diese kodiert?
# A: Ja, es hat fehlende Werte, diese sind mit 0.00000 kodiert.
gemeinde.daten <- read.csv(file, encoding = "UTF-8")
str(gemeinde.daten)
View(gemeinde.daten)
class(gemeinde.daten)

# 1.3. Falls nötig, definieren Sie im dataframe fehlende Werte so, dass R diese tatsächlich als
# fehlende Werte auffasst.
is.na(gemeinde.daten) <- !gemeinde.daten
gemeinde.daten
# 1.4. Beantworten Sie folgende Fragen: 
# Wie viele Gemeinden gab es in der Schweiz im Jahr 2014?
length(gemeinde.daten$gmdename)
gmdename <- gemeinde.daten$gmdename
length(table(gmdename))
# A: Es gibt 2324 Gemeinden in der Schweiz
# Was ist die mittlere Einwohnerzahl einer Schweizer Gemeinde?

# Wie viele Einwohner leben in der grössten Gemeinde? Wie viele in der kleinsten?