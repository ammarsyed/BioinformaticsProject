library(DESeq2)
countData <- Data[-c(1)]
dds <- DESeqDataSetFromMatrix(countData = bruh, colData = colnames, design=~type)
vsd <- vst(dds, blind = FALSE)
plotPCA(vsd, intgroup = c("type"))