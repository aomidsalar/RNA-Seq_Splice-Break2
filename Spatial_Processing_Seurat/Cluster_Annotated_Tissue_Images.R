library(ggplot2)
library(Matrix)
library(rjson)
library(cowplot)
library(RColorBrewer)
library(grid)
library(readbitmap)
library(Seurat)
library(dplyr)
library(hdf5r)
library(data.table)

geom_spatial <-  function(mapping = NULL,
                          data = NULL,
                          stat = "identity",
                          position = "identity",
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = FALSE,
                          ...) {
  
  GeomCustom <- ggproto(
    "GeomCustom",
    Geom,
    setup_data = function(self, data, params) {
      data <- ggproto_parent(Geom, self)$setup_data(data, params)
      data
    },
    
    draw_group = function(data, panel_scales, coord) {
      vp <- grid::viewport(x=data$x, y=data$y)
      g <- grid::editGrob(data$grob[[1]], vp=vp)
      ggplot2:::ggname("geom_spatial", g)
    },
    
    required_aes = c("grob","x","y")
    
  )
  
  layer(
    geom = GeomCustom,
    mapping = mapping,
    data = data,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
sample_names <- c("151673") #Sample Name
sample_names
image_paths <- c("~/path/to/151673_tissue_hires_image.png")

scalefactor_paths <- c( "~/path/to/151673_scalefactors_json.json")

tissue_paths <- c("~/path/to/151673_tissue_positions_list.txt")

cluster_paths <- c("~/path/to/151673_10clusters.csv") #File with two columns "Barcode" and "cluster"

matrix_paths <- c("~/path/to/151673.h5")

images_cl <- list()

for (i in 1:length(sample_names)) {
  images_cl[[i]] <- read.bitmap(image_paths[i])
}

height <- list()

for (i in 1:length(sample_names)) {
  height[[i]] <-  data.frame(height = nrow(images_cl[[i]]))
}

height <- bind_rows(height)

width <- list()

for (i in 1:length(sample_names)) {
  width[[i]] <- data.frame(width = ncol(images_cl[[i]]))
}

width <- bind_rows(width)
grobs <- list()
for (i in 1:length(sample_names)) {
  grobs[[i]] <- rasterGrob(images_cl[[i]], width=unit(1,"npc"), height=unit(1,"npc"))
}

images_tibble <- tibble(sample=factor(sample_names), grob=grobs)
images_tibble$height <- height$height
images_tibble$width <- width$width

scales <- list()

for (i in 1:length(sample_names)) {
  scales[[i]] <- rjson::fromJSON(file = scalefactor_paths[i])
}
clusters <- list()
for (i in 1:length(sample_names)) {
  clusters[[i]] <- read.csv(cluster_paths[i])
}
bcs <- list()

for (i in 1:length(sample_names)) {
  bcs[[i]] <- read.csv(tissue_paths[i],col.names=c("barcode","tissue","row","col","imagerow","imagecol"), header = FALSE)
  bcs[[i]]$imagerow <- bcs[[i]]$imagerow * scales[[i]]$tissue_hires_scalef    # scale tissue coordinates for lowres image
  bcs[[i]]$imagecol <- bcs[[i]]$imagecol * scales[[i]]$tissue_hires_scalef
  bcs[[i]]$tissue <- as.factor(bcs[[i]]$tissue)
  bcs[[i]] <- merge(bcs[[i]], clusters[[i]], by.x = "barcode", by.y = "Barcode", all = TRUE)
  bcs[[i]]$height <- height$height[i]
  bcs[[i]]$width <- width$width[i]
}

names(bcs) <- sample_names
matrix <- list()

for (i in 1:length(sample_names)) {
  matrix[[i]] <- as.data.frame(t(Read10X_h5(matrix_paths[i])))
}
umi_sum <- list() 

for (i in 1:length(sample_names)) {
  umi_sum[[i]] <- data.frame(barcode =  row.names(matrix[[i]]),
                             sum_umi = Matrix::rowSums(matrix[[i]]))
  
}
names(umi_sum) <- sample_names

umi_sum <- bind_rows(umi_sum, .id = "sample")
gene_sum <- list() 

for (i in 1:length(sample_names)) {
  gene_sum[[i]] <- data.frame(barcode =  row.names(matrix[[i]]),
                              sum_gene = Matrix::rowSums(matrix[[i]] != 0))
  
}
names(gene_sum) <- sample_names

gene_sum <- bind_rows(gene_sum, .id = "sample")

bcs_merge <- bind_rows(bcs, .id = "sample")
bcs_merge <- merge(bcs_merge,umi_sum, by = c("barcode", "sample"))
bcs_merge <- merge(bcs_merge,gene_sum, by = c("barcode", "sample"))

xlim(0,max(bcs_merge %>% 
             filter(sample ==sample_names[i]) %>% 
             select(width)))
myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")))

plots <- list()

for (i in 1:length(sample_names)) {
  
  plots[[i]] <- bcs_merge %>% 
    filter(sample ==sample_names[i]) %>%
    filter(tissue == "1") %>% 
    ggplot(aes(x=imagecol,y=imagerow,fill=factor(cluster))) +
    geom_spatial(data=images_tibble[i,], aes(grob=grob), x=0.5, y=0.5)+
    geom_point(shape = 21, colour = "black", size = 1.75, stroke = 0.5)+
    coord_cartesian(expand=FALSE)+
    #scale_fill_manual(values = c("#b2df8a","#e41a1c","#377eb8","#4daf4a","#ff7f00","gold", "#a65628", "#999999", "black", "grey", "white", "purple"))+ #This line can be uncommented and modified if you wish to use your own color scheme.
    xlim(0,max(bcs_merge %>% 
                 filter(sample ==sample_names[i]) %>% 
                 select(width)))+
    ylim(max(bcs_merge %>% 
               filter(sample ==sample_names[i]) %>% 
               select(height)),0)+
    xlab("") +
    ylab("") +
    ggtitle(sample_names[i])+
    labs(fill = "cluster")+
    guides(fill = guide_legend(override.aes = list(size=3)))+
    theme_set(theme_bw(base_size = 10))+
    theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.background = element_blank(), 
          axis.line = element_line(colour = "black"),
          axis.text = element_blank(),
          axis.ticks = element_blank())
}

plot_grid(plotlist = plots)

