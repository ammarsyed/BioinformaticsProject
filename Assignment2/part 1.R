library(matrixStats)
Data
range <- rowRanges(as.matrix(Data[2:99]))
range <- range[,2] - range[,1]
range
plot(density(log10(range)))
