library(DESeq2)
library(ggplot2)
library(magrittr)
library(cluster)
library(factoextra)
library(ggalluvial)
countData <- Data[-c(1)]
dds <- DESeqDataSetFromMatrix(countData = countData, colData = colnames, design=~type)

deseq_object <- DESeq(dds)

deseq_results = results(deseq_object)
deseq_results <- lfcShrink(
  deseq_object,
  coef = 2,
  res = deseq_results
)

deseq_results

deseq_df <- deseq_results %>%
  as.data.frame() %>%
  tibble::rownames_to_column("Gene") %>%
  dplyr::mutate(threshold = padj < 0.05) %>%
  dplyr::arrange(dplyr::desc(log2FoldChange))

deseq_df

subset = deseq_df[1:5000,]

dist_subset = dist(subset)
hclust_subset = hclust(dist_subset)
plot(hclust_subset)

subset10 = deseq_df[1:10,]
subset100 = deseq_df[1:100,]
subset1000 = deseq_df[1:1000,]
subset10000 = deseq_df[1:10000,]

dist_subset10 = dist(subset10)
dist_subset100 = dist(subset100)
dist_subset1000 = dist(subset1000)
dist_subset10000 = dist(subset10000)

hclust_subset10 = hclust(dist_subset10)
hclust_subset100 = hclust(dist_subset100)
hclust_subset1000 = hclust(dist_subset1000)
hclust_subset10000 = hclust(dist_subset10000)

pam_subset = pam(subset, k=5)

fvizpam_subset10 = pam(subset10, k=5)
pam_subset100 = pam(subset100, k=5)
pam_subset1000 = pam(subset1000, k=5)
pam_subset10000 = pam(subset10000, k=5)

fviz_cluster(pam_subset10)
