library(DESeq2)
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

volcano_plot <- EnhancedVolcano::EnhancedVolcano(
       deseq_df,
       lab = deseq_df$Gene,
       x = "log2FoldChange",
       y = "padj",
       pCutoff = 0.01
   )