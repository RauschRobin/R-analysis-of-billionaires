# Dataset from https://www.kaggle.com/datasets/nelgiriyewithana/billionaires-statistics-dataset
# Libraries
library(ggplot2)

# Read the CSV file into a data frame
df <- read.csv("BillionairesStatisticsDataset.csv")

df

# Create a data frame with the top 10 billionaires
top_10_billionaires <- df[1:10, ]

# Convert the 'finalWorth' column to numeric
top_10_billionaires$finalWorth <- as.numeric(gsub(",", "", top_10_billionaires$finalWorth))

# Create a bar plot
plot <- ggplot(top_10_billionaires, aes(x = reorder(personName, -finalWorth), y = finalWorth, fill = personName)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 10 Billionaires and their Net Worth",
       x = "Billionaires",
       y = "Net Worth (in billions USD)",
       fill = "Billionaire") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Show the plot
print(plot)
