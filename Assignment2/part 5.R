library(gprofiler2)
gostres <- gost(Data$gene_id, organism = 'hsapiens')
head(gostres$result,20)
