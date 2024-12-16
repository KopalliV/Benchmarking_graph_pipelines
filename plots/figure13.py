import matplotlib.pyplot as plt
import numpy as np

# Data
tools = ['Minimap2', 'Minigraph-Cactus', 'Minigraph']
aligned_percentages = [82.47, 73.39, 73.27]
perfectly_aligned_percentages = [68.77, 82.77, 78.13]

# Bar width and positions
bar_width = 0.35
index = np.arange(len(tools))

# Create subplots
fig, ax = plt.subplots(1, 2, figsize=(16, 8))

# Aligned reads plot
ax[0].bar(index, aligned_percentages, bar_width, color='#6baed6')
ax[0].set_ylabel('Percentage (%)', fontsize=14, fontweight='bold')
ax[0].set_title('a) Percentage of Total Aligned Reads', fontsize=17, fontweight='bold')
ax[0].set_xticks(index)
ax[0].set_xticklabels(tools, fontsize=17, fontweight='bold')
ax[0].set_ylim(0, 100)
for i, percentage in enumerate(aligned_percentages):
    ax[0].text(i, percentage + 1, f'{percentage:.2f}%', ha='center', va='bottom', fontsize=12, fontweight='bold')

# Perfectly aligned reads plot
ax[1].bar(index, perfectly_aligned_percentages, bar_width, color='#66c2a4')
ax[1].set_ylabel('Percentage (%)', fontsize=14, fontweight='bold')
ax[1].set_title('b) Percentage of Perfectly Aligned Reads', fontsize=17, fontweight='bold')
ax[1].set_xticks(index)
ax[1].set_xticklabels(tools, fontsize=17, fontweight='bold')
ax[1].set_ylim(0, 100)
for i, percentage in enumerate(perfectly_aligned_percentages):
    ax[1].text(i, percentage + 1, f'{percentage:.2f}%', ha='center', va='bottom', fontsize=12, fontweight='bold')

# Save and show plot
plt.tight_layout()
plt.savefig('alignment_performance.pdf', format='pdf')
plt.show()
