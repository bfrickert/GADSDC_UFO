ufo13 <- subset(ufo, Year == 13)
ufoJuly4.20113 <- subset(ufo, Year == 13 & Month == 7 & Day == 4)
ufo13.count.by.shape <- count(ufo13$Shape)
july4.count.by.shape <- count(ufoJuly4.20113$Shape)

light <- subset(ufo13.count.by.shape,x == 'Light')$freq
fireball <- subset(ufo13.count.by.shape,x == 'Fireball')$freq
changing <- subset(ufo13.count.by.shape,x == 'Changing')$freq
(light + fireball + changing)/sum(ufo13.count.by.shape$freq)


light <- subset(july4.count.by.shape,x == 'Light')$freq
fireball <- subset(july4.count.by.shape,x == 'Fireball')$freq
changing <- subset(july4.count.by.shape,x == 'Changing')$freq
(light + fireball + changing)/sum(july4.count.by.shape$freq)
