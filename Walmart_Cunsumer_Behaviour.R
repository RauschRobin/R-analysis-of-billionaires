#This project is all about analysing the consumer behaviour of walmart customers.
install.packages(c("dplyr", "ggplot2"))
library(dplyr)
library(ggplot2)

# I decided to analyze a dataset from kaggle about walmart sales, products and store inventories. 
# I try to analyse the consumer behavious based on this data.

# Load data from local files. Files are downloaded from: https://www.kaggle.com/datasets/willianoliveiragibin/sales-in-period-walmart/
df_inventory <- read.csv("Inventory.csv")
df_sales <- read.csv("Sales.csv")
df_products <- read.csv("Products.csv")

# Merge data frames
merged_inventory_and_products <- merge(df_inventory, df_products, by = "ProductId")
data_consumer_behaviour <- merge(merged_inventory_and_products, df_sales, by = c("StoreId", "ProductId"))

# Check if data loaded successfully
if (any(sapply(list(df_inventory, df_sales, df_products), function(df) is.null(df)))) {
  stop("Error loading data.")
}

# OPTIONAL: Save data_consumer_behaviour to a CSV file
write.csv(data_consumer_behaviour, file = "data_consumer_behaviour.csv", row.names = FALSE)

# Look at the merged data from all 3 data sources
print(data_consumer_behaviour)

# Scatter plot of sales quantity vs. product cost
ggplot(data_consumer_behaviour, aes(x = ProductCost, y = Quantity)) +
  geom_point() +
  labs(title = "Scatter Plot of Sales Quantity vs. Product Cost",
       x = "Product Cost",
       y = "Sales Quantity")

# Bar plot of total sales quantity by store
ggplot(data_consumer_behaviour, aes(x = factor(StoreId), y = Quantity)) +
  geom_bar(stat = "sum", fill = "blue") +
  labs(title = "Total Sales Quantity by Store",
       x = "Store ID",
       y = "Total Sales Quantity")

# Now lets compare the Amount of Sales of a seasonal product (e.g. Ice Cream) to the months of a year:
# Filter the merged data for products with "ice cream" in their name
ice_cream_data <- data_consumer_behaviour[grep("ice cream", data_consumer_behaviour$ProductName, ignore.case = TRUE), ]

# Convert the Date column to a Date type (if not already)
ice_cream_data$Date <- as.Date(ice_cream_data$Date)

# Extract month and year from the Date column
ice_cream_data$Month <- format(ice_cream_data$Date, "%m")

# Plot the sales distribution across different months
ggplot(ice_cream_data, aes(x = Month, y = Quantity, fill = ProductName)) +
  geom_bar(stat = "sum", position = "stack") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Ice Cream Sales Across Different Months",
       x = "Month",
       y = "Total Sales Quantity",
       fill = "Product Name") +
  scale_fill_viridis_d()

# Plot the sales distribution across different months for all suppliers of ice cream
ggplot(ice_cream_data, aes(x = Month, y = Quantity, fill = Supplier)) +
  geom_bar(stat = "sum", position = "stack") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Total Ice Cream Sales Across Different Months by Supplier",
       x = "Month",
       y = "Total Ice Cream Sales Quantity",
       fill = "Supplier") +
  scale_fill_viridis_d()

# Plot the sales distribution across different months for all suppliers
ggplot(data_consumer_behaviour, aes(x = Month, y = Quantity, fill = Supplier)) +
  geom_bar(stat = "sum", position = "stack") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Total Sales Across Different Months by Supplier",
       x = "Month",
       y = "Total Sales Quantity",
       fill = "Supplier") +
  scale_fill_viridis_d()

