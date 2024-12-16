library(ggplot2)
library(reshape2)
library(RColorBrewer)

# Data
data <- data.frame(
  Dataset = c("AusTRCF317961", "IS19953", "IS8525", "PI532566", "Rio", "S369-1"),
  Minigraph_Cactus = c(0.882, 0.853, 0.885, 0.979, 0.902, 0.876),
  PGGB = c(0.872, 0.8580, 0.8581, 0.940, 0.909, 0.883),
  SVIM_asm = c(0.942, 0.933, 0.910, 0.985, 0.924, 0.966),
  Syri = c(0.919, 0.909, 0.893, 0.983, 0.900, 0.918)
)

data_melt <- melt(data, id.vars = "Dataset")

# Save plot to PDF
pdf("truvari_plot_improved_darker_colors.pdf", width = 10, height = 8, dpi = 600)

# Plot
p <- ggplot(data_melt, aes(x = Dataset, y = value, color = variable, shape = variable)) +
  geom_line(aes(group = variable), size = 2) +
  geom_point(size = 4) +
  scale_color_manual(values = c("#6baed6", "#66c2a4", "#8cb3d8", "#8dcf8d")) +
  labs(
    x = "Assemblies", 
    y = "F1 Scores"
  ) +
  ylim(0.7, 1.0) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(size = 14, face = "bold"),
    axis.text.y = element_text(size = 14, face = "bold"),
    axis.title.x = element_text(size = 16, face = "bold"),
    axis.title.y = element_text(size = 16, face = "bold"),
    legend.position = "top",
    legend.title = element_blank(),
    legend.text = element_text(size = 12, face = "bold"),
    legend.background = element_blank(),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(10, 10, 10, 10)
  )

# Print the plot to the PDF
print(p)

ggsave("f1_score_assembly_plot.pdf", plot = p, width = 10, height = 8, dpi = 600)

# Close the PDF device
dev.off()

