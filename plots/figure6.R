library(reshape2)
library(ggplot2)
library(scales)

datasets <- c('Minigraph', 'PGGB', 'Minigraph-Cactus')
segments_real <- c(469192, 33235478, 33158682)
links_real <- c(651489, 45682351, 45257196)

# Create data frame and reorder dataset factor
df_real <- data.frame(datasets, segments_real, links_real)
df_real$datasets <- factor(df_real$datasets, levels = c('Minigraph-Cactus', 'PGGB', 'Minigraph'))

# Melt the data
df_long_real <- melt(df_real, id.vars = 'datasets')

# Create the plot
p <- ggplot(df_long_real, aes(x = datasets, y = value, fill = variable)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  geom_text(aes(label = value), vjust = -0.5, position = position_dodge(width = 0.9), size = 7, fontface = "bold") +
  labs(x = '', y = '', title = '') +
  scale_y_continuous(labels = comma) + theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 0, hjust = 0.5, face = "bold", size = 25), 
    axis.text.y = element_text(angle = 0, hjust = 0.5, face = "bold", size = 25),
    axis.title.y = element_text(size = 25, face = "bold"),                          
    legend.text = element_text(size = 25),
    legend.title = element_text(size = 25, face = "bold"),
    plot.margin = margin(70, 20, 20, 20),
    panel.grid = element_blank(),
    aspect.ratio = 1/1
  ) +
  scale_fill_manual(values = c("#6baed6", "#66c2a4"), name = 'Variables',
                    labels = c('Number of Nodes', 'Number of Edges'))

# Plot and save
plot(p)
ggsave("real_nodes_plot.pdf", width = 15, height = 15, dpi = 600)

