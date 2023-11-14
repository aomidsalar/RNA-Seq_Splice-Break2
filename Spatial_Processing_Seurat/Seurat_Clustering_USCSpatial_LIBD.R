library(Seurat)
library(ggplot2)
library(reshape2)
library(tidyr)
library(dplyr)
library(hdf5r)
visiumBetaPhase2Samples <- c("144105","144106","144107","144108","144111","144112","144113","144114", "151673", "151674", "151675", "151676") 
sample_objs <- list()
for(i in visiumBetaPhase2Samples) {
  print(i)
  spatialObj <- Read10X_h5(filename = paste0("path/to/h5",i, ".h5")) 
  spatialObj <- CreateSeuratObject(counts = spatialObj, project = i) 
  spatialObj <- NormalizeData(spatialObj) #normalization https://satijalab.org/seurat/reference/normalizedata
  spatialObj <- FindVariableFeatures(spatialObj, selection.method = "vst")
  row.names(spatialObj@meta.data) <- gsub("-1",paste0("-",i),row.names(spatialObj@meta.data))
  sample_objs[[i]]<-spatialObj
}

vBsample.anchors <- FindIntegrationAnchors(object.list = sample_objs) 
vBsamples.integrated <- IntegrateData(anchorset = vBsample.anchors) 
vBsamples.integrated <- ScaleData(vBsamples.integrated, features = VariableFeatures(vBsamples.integrated)) # https://satijalab.org/seurat/reference/scaledata
vBsamples.integrated <- RunPCA(vBsamples.integrated, npcs = 10) #https://satijalab.org/seurat/reference/runpca
vBsamples.integrated <- RunTSNE(vBsamples.integrated, npcs = 10) 
DimPlot(object = vBsamples.integrated, reduction = "tsne")
DimPlot(object = vBsamples.integrated, reduction = "tsne", split.by = "orig.ident")
DimPlot(object = vBsamples.integrated, reduction = "tsne", split.by = "orig.ident", group.by="seurat_clusters")
vBsamples.integrated <- RunUMAP(vBsamples.integrated, dims = 1:10)
vBsamples.integrated <- FindNeighbors(vBsamples.integrated)
vBsamples.integrated <- FindClusters(vBsamples.integrated, resolution = 0.35) # add ,res=some number if you want to adjust resolution. https://satijalab.org/seurat/reference/findclusters 
write.csv(vBsamples.integrated@meta.data,file = "~/Desktop/integratedSamples",row.names=TRUE) # this file will contain barcodes, and will have a column for seurat_clusters
#vBsamples.integrated_subcluster3 <- FindSubCluster(vBsamples.integrated, cluster = "3",graph.name = "integrated_nn",subcluster.name = "sub.cluster",resolution = 0.15,algorithm = 1) #Uncomment to perform sub-clustering of cluster 3
#write.csv(vBsamples.integrated_subcluster3@meta.data,file = "~/Desktop/integratedSamples_withSubcluster3.txt",row.names=TRUE) #Uncomment this line to save Seurat object metadata after sub-clustering of cluster 3
