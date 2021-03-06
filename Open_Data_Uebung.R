

library()


# 1. Laden des Datensatzes und erste Begutachtung

# 1.1. Laden Sie den Datensatz gemeindedaten.csv
file <- "C:/Workspace/Weiterbildung/Grafische Datenexploration und Datenvisualisierung/Materialien Open Data �bung Gemeinden der Schweiz-20161208/Daten/gemeindedaten.csv"
gemeinde.daten <- read.csv(file)
str(gemeinde.daten)
View(gemeinde.daten)
# 1.2. Verschaffen Sie sich einen ersten �berblick zu den Daten? 
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

# 1.3. Falls n�tig, definieren Sie im dataframe fehlende Werte so, dass R diese tats�chlich als
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
bev.sum <- sum(gemeinde.daten$bev_total)
mittlere.einwohnerzahl <- bev.sum/length(table(gmdename))
mittlere.einwohnerzahl
mean(gemeinde.daten$bev_total)
# A: Die mittlere Einwohnerzahl liegt bei 3545 (3544.60671256454)
# Wie viele Einwohner leben in der gr�ssten Gemeinde?
# Wie viele in der kleinsten?
max(gemeinde.daten$bev_total)
library(dplyr)
max.gemeinde <- gemeinde.daten %>%
  select(gemeinde = gmdename,
         einwohner = bev_total) %>% 
  filter(einwohner==max(gemeinde.daten$bev_total))
min.gemeinde <- gemeinde.daten %>%
  select(gemeinde = gmdename,
         einwohner = bev_total) %>% 
  filter(einwohner==min(gemeinde.daten$bev_total))

library(data.table)
class(gemeinde.daten)
gemeinde.table <- as.data.table(gemeinde.daten)
max.gem.dt <- gemeinde.daten[gemeinde.daten$bev_total == max(gemeinde.daten$bev_total),]
min.gem.dt <- gemeinde.daten[gemeinde.daten$bev_total == min(gemeinde.daten$bev_total),]

# A: Die gr�sste Gemeinde ist Z�rich mit 391359
# A: Die kleinste Gemeinde ist Corippo mit 13


# 2. Graphische Datenexploration
# F�hren Sie visuelle Auswertungen durch, mit welchen Sie folgende Fragen beantworten lassen:
# 2.1 In welchem Kanton gibt es am meisten Gemeinden? In welchem am wenigsten?
library(ggplot2)
library(data.table)
gemeinde.kantone <- gemeinde.table[, sum(bev_total),by=.(kantone)][order(V1,decreasing=TRUE)]

ggplot(gemeinde.kantone, aes(x=reorder(gemeinde.kantone$kanton, gemeinde.kantone$V1), y=gemeinde.kantone$V1))+
  geom_bar(stat="identity")+
  coord_flip()+
  labs(x ="Kantone", y = "Einwohner")

# 2.2 Betrachten Sie die Einwohnerzahlen der Gemeinden gruppiert nach Sprachregionen. Wie
# heissen die jeweils gr�ssten Gemeinden?

# erstellen einer kolone Max gefilter nach 'Sprachregion'
gemeinde.table[, max := max(bev_total), by = .(sprachregionen)]
gemeinde.table[bev_total == max, .(gmdename, kantone, sprachregionen, bev_total)]

max <- gemeinde.table[bev_total == max, .(gmdename, kantone, sprachregionen, bev_total)]
max

fancy_scientific <- function(l) {
  # turn in to character string in scientific notation
  l <- format(l, scientific = TRUE)
  # quote the part before the exponent to keep all the digits
  l <- gsub("^(.*)e", "'\\1'e", l)
  # turn the 'e+' into plotmath format
  l <- gsub("e", "%*%10^", l)
  # return this as an expression
  parse(text=l)
}

ggplot(max, aes(y=max$bev_total, x=max$gmdename))+
  geom_bar(stat="identity")+
  ylab(label = max$bev_total)+
  theme(text = element_text(size=8))+
  # scale_y_continuous(labels=fancy_scientific) +
  scale_y_continuous(labels = comma)+
  coord_flip()+
  labs(x ="Geminde", y = "Einwohner")

# 2.3. Betrachten Sie die Ver�nderung der Einwohnerzahl von 2010 bis 2014 nach Sprachregionen. In
# welcher Sprachregionen sind die Gemeinden am st�rksten gewachsen? In welcher am
# wenigsten oder gibt es Sprachregionen, in welcher die Einwohnerentwicklung in der Tendenz
# sogar eher r�ckl�ufig ist? Analysieren sie zus�tzlich graphisch, ob die Unterscheidung von
# st�dtischen und l�ndlichen Gemeinden dabei eine Rolle spielt?

# 2.4 Untersuchen Sie die Zusammenhangsstruktur folgender Variablen:
#   bev_dichte, bev_ausl, alter_0_19, alter_20_64, alter_65.,bevbew_geburt, sozsich_sh,
# strafen_stgb
# Gibt es Korrelationen? Falls ja, lassen Sie sich erkl�ren oder sind sie eher unerwartet? Suchen
# Sie sich einen Ihnen interessant erscheinenden Zusammenhang und schauen Sie sich diesen in
# einem eigenen Scatterplot an

# 2.5 Visualisieren Sie eine Kontingenztabelle mit den Variablen Stadt_Land und Sprachregionen.
# Welcher Gemeindetyp �berwiegt bei deutschsprachigen Gemeinden, welcher bei
# italienischsprachigen Gemeinden. Gibt es in jeder Sprachregion isolierte St�dte?

# 2.6. Erstellen Sie ein politisches Profil nach Sprachregionen mit der Hilfe der Variablen zu den
# W�hleranteilen.