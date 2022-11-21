# Processing 10x Spatial Transcriptomics Samples
## Seurat_Clustering_USCSpatial_LIBD.R
This script performs Seurat Clustering on 8x USC Spatial Transcriptomics samples and 4x SpatialLIBD samples to generate a csv file with barcodes assigned to 10 clusters.  
### Usage
Download the file `Seurat_Clustering_USCSpatial_LIBD.R` and open with RStudio. RStudio version 4.1.3 was used in generating this script.  
Input files: filtered feature matrix h5 files for each sample
Output file: integratedSamples.csv
Path to h5 files (line 11) and desired path for output file (line 30) should be updated prior to use.  
### Additional Processing
In order to use the second script in this directory, `Cluster_Annotated_Tissue_Images.R`, individual csv files for each sample with barcodes and their corresponding clusters need to be generated. The output file from this script, `integratedSamples.csv` contains this information. To do this, the `integratedSamples.csv` can be filtered based on sample ID ('orig.ident' in column 2) and cluster designation ('seurat_clusters' in column 5); this data should be stored in a two-column csv file for each sample, with columns named "Barcode" and "cluster".
### Dependencies
R version 4.1.3
packages:
* ggplot2 version 3.3.5
* Matrix version 1.4-0
* rjson version 0.2.21
* cowplot version 1.1.1
* RColorBrewer version 1.1-3
* grid version 4.1.3
* readbitmap version 0.1.5
* Seurat version 4.1.0
* SeuratObject version 4.0.4
* dplyr version 1.0.8
* hdf5r version 1.3.5
* data.table version 1.14.2

## Cluster_Annotated_Tissue_Images.R
This script, taken from the 10x Genomics website, can be used to annotate tissue images with cluster designations. The original code and further information can be found on the 10x Genomics website (here)[https://support.10xgenomics.com/spatial-gene-expression/software/pipelines/latest/rkit?src=event&lss=tradeshow&cnm=ts-2020-02-08-event-ra_g-keystone-banff-amr&cid=NULL].
### Usage
Download the file `Cluster_Annotated_Tissue_Images.R` and open with RStudio. RStudio version 4.1.3 was used in generating this script. 
**Input Files/Paths to be Updated:**
* image_paths: `tissue_hires_image.png`. These can be found on GEO.
* scalefactor_paths: `scalefactors_json.json`. These can be found on GEO.
* tissue_paths: `tissue_positions_list.txt`. These can be found on GEO.
* cluster_paths: `Sample_clusters.csv`. This was generated by processing the `integratedSamples.csv` file from the previous script (see above).
* matrix_paths: `Sample.h5`. These can be found on GEO.

Note: This script can be run on one sample at a time to generate one image at a time. Running this script on multiple samples at the same time will generate a grid of images. Clusters will be colored automatically using the Spectral color palette; alternatively, manual colors can be assigned by uncommenting line 161.

### Dependencies
* Seurat version 4.1.0
* SeuratObject version 4.0.4
* reshape2 version 1.4.4
* tidyr version 1.2.0
* dplyr version 1.0.8
* hdf5r version 1.3.5