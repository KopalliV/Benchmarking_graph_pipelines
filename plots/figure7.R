# Load ggplot2 and tidyr
library(ggplot2) library(tidyr) library(dplyr)
# Example data
data1 <- data.frame( Sample = c("AusTRCF317961", "IS19953", "IS8525", "PI532566", "Rio", "S369-1"), Proportion1 = c(95, 99, 99, 98, 95, 99), Proportion2 = c(5, 1, 1, 2, 5, 1) ) data2 <- data.frame( Sample = c("AusTRCF317961", 
  "IS19953", "IS8525", "PI532566", "Rio", "S369-1"), Proportion1 = c(94, 99, 99, 97, 94, 99), Proportion2 = c(6, 1, 1, 3, 6, 1)
) data3 <- data.frame( Sample = c("AusTRCF317961", "IS19953", "IS8525", "PI532566", "Rio", "S369-1"), Proportion1 = c(77, 89, 92, 79, 78, 85), Proportion2 = c(23, 11, 8, 21, 22, 15) )
# Transform data to long format
data_long1 <- tidyr::pivot_longer( data1, cols = c(Proportion1, Proportion2), names_to = "Category", values_to = "Percentage" ) data_long2 <- tidyr::pivot_longer( data2, cols = c(Proportion1, Proportion2), names_to = "Category", 
  values_to = "Percentage"
) data_long3 <- tidyr::pivot_longer( data3, cols = c(Proportion1, Proportion2), names_to = "Category", values_to = "Percentage" )
# Reverse the stacking order by reordering the "Category" factor levels
data_long1$Category <- factor(data_long1$Category, levels = c("Proportion2", "Proportion1")) data_long2$Category <- factor(data_long2$Category, levels = c("Proportion2", "Proportion1")) data_long3$Category <- 
factor(data_long3$Category, levels = c("Proportion2", "Proportion1"))
# Calculate the cumulative sum for positioning the text inside Proportion1 Manually set custom y_position for each Sample Corrected dataset update for y_position
data_long1 <- data_long1 %>% mutate( y_position = case_when( Sample == "AusTRCF317961" ~ 92, # Set y_position for this bar Sample == "IS19953" ~ 97, # Set y_position for this bar Sample == "IS8525" ~ 97, # Set y_position for this 
      bar Sample == "PI532566" ~ 95, # Set y_position for this bar Sample == "Rio" ~ 92, # Set y_position for this bar Sample == "S369-1" ~ 97 # Set y_position for this bar
    ) ) data_long2 <- data_long2 %>% mutate( y_position = case_when( Sample == "AusTRCF317961" ~ 92, # Set y_position for this bar Sample == "IS19953" ~ 97, # Set y_position for this bar Sample == "IS8525" ~ 97, # Set y_position 
      for this bar Sample == "PI532566" ~ 95, # Set y_position for this bar Sample == "Rio" ~ 92, # Set y_position for this bar Sample == "S369-1" ~ 97 # Set y_position for this bar
    ) ) data_long3 <- data_long3 %>% mutate( y_position = case_when( Sample == "AusTRCF317961" ~ 75, # Set y_position for this bar Sample == "IS19953" ~ 87, # Set y_position for this bar Sample == "IS8525" ~ 90, # Set y_position 
      for this bar Sample == "PI532566" ~ 77, # Set y_position for this bar Sample == "Rio" ~ 76, # Set y_position for this bar Sample == "S369-1" ~ 83 # Set y_position for this bar
    ) )
library(scales)
# Plot 1: Minigraph-Cactus
perc1 <- ggplot(data_long1, aes(x = Sample, y = Percentage, fill = Category)) + geom_bar(stat = "identity", width = 0.3) + geom_text( data = subset(data_long1, Category == "Proportion1"), aes(label = paste0(Percentage, "%"), y = 
    y_position), size = 4.5, fontface = "bold"
  ) + scale_fill_manual(values = c("#66c2a4", "#6baed6"), labels = c("Proportion2", "Proportion1")) + scale_y_continuous( expand = c(0, 0), limits = c(0, 100), labels = label_percent(scale = 1) ) + geom_hline(yintercept = 0, 
  linetype = "solid", color = "gray80", size = 1) + labs(title = "a) Minigraph-Cactus") + theme_minimal() + theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 14, family = "Arial", face = "bold"), axis.text.y = element_text(size = 16, family = "Arial", face = "bold"), panel.grid = element_blank(), legend.position = "none", 
    axis.title.y = element_blank(), axis.title.x = element_blank(), text = element_text(family = "Arial"), plot.margin = margin(t = 80, r = 20, b = 20, l = 20), plot.title.position = "plot", plot.title = element_text(hjust = 0.5, 
    vjust = 4, size = 18, face = "bold", family = "Arial")
  )
# Plot 2: PGGB
perc2 <- ggplot(data_long2, aes(x = Sample, y = Percentage, fill = Category)) + geom_bar(stat = "identity", width = 0.3) + geom_text( data = subset(data_long2, Category == "Proportion1"), aes(label = paste0(Percentage, "%"), y = 
    y_position), size = 4.5, fontface = "bold"
  ) + scale_fill_manual(values = c("#66c2a4", "#6baed6"), labels = c("Proportion2", "Proportion1")) + scale_y_continuous( expand = c(0, 0), limits = c(0, 100), labels = label_percent(scale = 1) ) + geom_hline(yintercept = 0, 
  linetype = "solid", color = "gray80", size = 1) + labs(title = "b) PGGB") + theme_minimal() + theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 14, family = "Arial", face = "bold"), axis.text.y = element_text(size = 16, family = "Arial", face = "bold"), panel.grid = element_blank(), legend.position = "none", 
    axis.title.y = element_blank(), axis.title.x = element_blank(), text = element_text(family = "Arial"), plot.margin = margin(t = 80, r = 20, b = 20, l = 20), plot.title.position = "plot", plot.title = element_text(hjust = 0.5, 
    vjust = 4, size = 18, face = "bold", family = "Arial")
  )
# Plot 3: Minigraph
perc3 <- ggplot(data_long3, aes(x = Sample, y = Percentage, fill = Category)) + geom_bar(stat = "identity", width = 0.3) + geom_text( data = subset(data_long3, Category == "Proportion1"), aes(label = paste0(Percentage, "%"), y = 
    y_position), size = 4.5, fontface = "bold"
  ) + scale_fill_manual(values = c("#66c2a4", "#6baed6"), labels = c("Proportion2", "Proportion1")) + scale_y_continuous( expand = c(0, 0), limits = c(0, 100), labels = label_percent(scale = 1) ) + geom_hline(yintercept = 0, 
  linetype = "solid", color = "gray80", size = 1) + labs(title = "c) Minigraph") + theme_minimal() + theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 14, family = "Arial", face = "bold"), axis.text.y = element_text(size = 16, family = "Arial", face = "bold"), panel.grid = element_blank(), legend.position = "none", 
    axis.title.y = element_blank(), axis.title.x = element_blank(), text = element_text(family = "Arial"), plot.margin = margin(t = 80, r = 20, b = 20, l = 20), plot.title.position = "plot", plot.title = element_text(hjust = 0.5, 
    vjust = 4, size = 18, face = "bold", family = "Arial")
  )
  
# Save the plot as a PDF using the cairo_pdf device
cairo_pdf("combined_pl2ots.pdf", width = 25, height = 10)
# Arrange the plots side by side
grid.arrange(perc1, perc2, perc3, ncol = 3)
# Close the PDF device
dev.off()
