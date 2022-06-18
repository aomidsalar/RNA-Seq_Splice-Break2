input <- read.csv("path/to/sample_LargeMTDeletions_LR-PCR_STRINGENT_pos357-15925.txt", sep="\t")
#input <- input[, colSums(is.na(input)) != nrow(input)]
Sample <- input$Sample_ID[1]
BC <- input$Benchmark_Coverage[1]
no_deletions <- as.numeric(nrow(input))
del_per_10k <- (no_deletions/BC)*10000
cumulative_dels <- sum(input$Deletion_Read_.)
burden_per_del <- cumulative_dels/no_deletions
col1 <- c("Benchmark Coverage","Number of Unique Deletions", "Deletions per 10k Coverage", "Cumulative Deletion Read %", "Burden Per Deletion")
col2 <- c(BC, no_deletions, del_per_10k, cumulative_dels, burden_per_del)
output <- data.frame(col1, col2)
colnames(output) <- c("Metric", Sample)
write.table(output, paste0("~/Desktop/", Sample, "_CumulativeMetrics.txt"),sep="\t", quote=FALSE, row.names=FALSE)
