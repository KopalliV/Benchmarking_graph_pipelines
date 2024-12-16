library(ggplot2)

# Creating the data frame
data_f1 <- data.frame(
  Variant = c("PGGB", "MC", "SVIM_asm", "SyRI"),
  Count = c(0.83, 0.89, 0.93, 0.91)
)

# Plotting the bar chart
p <- ggplot(data_f1, aes(x = Variant, y = Count)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.6) +
  geom_text(aes(label = Count), vjust = -0.5, size = 8, fontface = "bold") +
  labs(x = "", y = "F1 Scores", title = '') +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 0, hjust = 0.5, face = "bold", size = 25),
    axis.text.y = element_text(face = "bold", size = 20),
    axis.title.y = element_text(size = 25, face = "bold"),
    plot.title = element_text(size = 30, face = "bold", hjust = 0.5),
    plot.margin = margin(30, 20, 20, 20),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_line(color = "black"),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# Display the plot
plot(p)

# Save the plot to a file
ggsave("f1_score_plot.pdf", plot = p, width = 10, height = 10, dpi = 600)

