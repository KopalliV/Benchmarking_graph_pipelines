import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

def read_and_process_data(filename, aligner_name):
    df = pd.read_csv(filename, sep="\t", names=["minQ", "reads_mapped", "reads_mapped_correctly"])
    df["aligner"] = aligner_name
    df["reads_mapped"] = pd.to_numeric(df["reads_mapped"], errors='coerce')
    df["reads_mapped_correctly"] = pd.to_numeric(df["reads_mapped_correctly"], errors='coerce')
    df["percent_mapped"] = df["reads_mapped"] / 2e6 * 100
    df["percent_mapped_correctly"] = df["reads_mapped_correctly"] / df["reads_mapped"] * 100
    df["percent_total_correct"] = df["reads_mapped_correctly"] / 2e6 * 100
    return df

giraffe_rates = read_and_process_data("giraffe_cumulative_rates.tsv", "giraffe")
minimap_rates = read_and_process_data("minimap_cumulative_rates.tsv", "minimap")

df = pd.concat([giraffe_rates, minimap_rates], ignore_index=True)
df.to_csv("percent_mapped.tsv", sep="\t", index=False)

sns.relplot(data=df, kind="line", x="percent_mapped", y="percent_total_correct", hue="aligner", style="aligner", height=3, aspect=1)
plt.savefig("percent_mapped.pdf")
plt.close()

sns.relplot(data=df, kind="line", x="minQ", y="percent_mapped_correctly", hue="aligner", style="aligner", height=3, aspect=1)
plt.gca().set_xticks([0, 20, 40, 60])
plt.gca().set_xticklabels([0, 20, 40, 60])
plt.savefig("minQ3.pdf")
plt.close()

