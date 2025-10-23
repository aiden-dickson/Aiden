# ================================================================
# R DATA CLEANING CHEATSHEET
# A comprehensive guide to cleaning and preparing data in R
# ================================================================


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   LOAD REQUIRED LIBRARIES
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

library(tidyverse)    # Data manipulation (includes dplyr, tidyr, stringr)
library(lubridate)    # Date and time manipulation
library(janitor)      # Data cleaning utilities


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   1. LOADING DATA
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# CSV files
df <- read_csv("data.csv")
df <- read.csv("data.csv")

# Excel files
library(readxl)
df <- read_excel("data.xlsx")
df <- read_excel("data.xlsx", sheet = "Sheet1")

# Stata/SPSS files
library(haven)
df <- read_dta("data.dta")
df <- read_sav("data.sav")

# Tab-delimited files
df <- read_tsv("data.tsv")
df <- read_delim("data.txt", delim = "\t")


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   2. INSPECTING DATA
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# View data structure
str(df)                    # Structure of data
glimpse(df)                # Tidyverse version of str()
head(df)                   # First 6 rows
tail(df)                   # Last 6 rows
View(df)                   # Open data viewer

# Dimensions
dim(df)                    # Rows and columns
nrow(df)                   # Number of rows
ncol(df)                   # Number of columns
names(df)                  # Column names
colnames(df)               # Column names (alternative)

# Summary statistics
summary(df)                # Summary of all columns
summary(df$column_name)    # Summary of specific column


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   3. HANDLING MISSING VALUES
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Check for missing values
is.na(df)                  # Returns TRUE/FALSE for each value
sum(is.na(df))             # Count total missing values
colSums(is.na(df))         # Count missing values per column
mean(is.na(df$column))     # Proportion of missing values

# Visualize missing data
library(naniar)
vis_miss(df)               # Visualize missing data patterns

# Remove missing values
df_clean <- na.omit(df)                    # Remove rows with ANY missing values
df_clean <- df %>% drop_na()               # Tidyverse version
df_clean <- df %>% drop_na(column_name)    # Remove rows with NA in specific column

# Filter out missing values
df_clean <- df %>% filter(!is.na(column_name))
df_clean <- df %>% filter(complete.cases(.))

# Replace missing values
df$column[is.na(df$column)] <- 0                    # Replace with 0
df <- df %>% mutate(column = replace_na(column, 0)) # Tidyverse version
df <- df %>% mutate(column = coalesce(column, 0))   # Replace NA with 0

# Impute with mean/median
df <- df %>%
  mutate(column = ifelse(is.na(column), mean(column, na.rm = TRUE), column))

df <- df %>%
  mutate(column = ifelse(is.na(column), median(column, na.rm = TRUE), column))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   4. SELECTING COLUMNS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Select specific columns
df_subset <- df %>% select(column1, column2, column3)
df_subset <- df %>% select(1:5)                      # Select first 5 columns
df_subset <- df %>% select(starts_with("prefix"))    # Columns starting with prefix
df_subset <- df %>% select(ends_with("suffix"))      # Columns ending with suffix
df_subset <- df %>% select(contains("text"))         # Columns containing text
df_subset <- df %>% select(matches("regex"))         # Columns matching regex

# Remove columns
df <- df %>% select(-column_to_remove)
df <- df %>% select(-c(col1, col2, col3))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   5. FILTERING ROWS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Filter by condition
df_filtered <- df %>% filter(age > 18)
df_filtered <- df %>% filter(age >= 18 & age <= 65)
df_filtered <- df %>% filter(age > 18 | income > 50000)
df_filtered <- df %>% filter(status == "active")
df_filtered <- df %>% filter(status != "inactive")

# Filter with multiple conditions
df_filtered <- df %>% filter(age > 18, status == "active")

# Filter using %in%
df_filtered <- df %>% filter(status %in% c("active", "pending"))
df_filtered <- df %>% filter(!status %in% c("inactive", "deleted"))

# Filter by row number
df_filtered <- df %>% slice(1:10)              # First 10 rows
df_filtered <- df %>% slice_head(n = 10)       # First 10 rows
df_filtered <- df %>% slice_tail(n = 10)       # Last 10 rows
df_filtered <- df %>% slice_sample(n = 100)    # Random 100 rows


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   6. RENAMING COLUMNS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Rename specific columns
df <- df %>% rename(new_name = old_name)
df <- df %>% rename(age = AGE, name = NAME)

# Rename all columns to lowercase
df <- df %>% rename_with(tolower)

# Rename all columns to uppercase
df <- df %>% rename_with(toupper)

# Clean column names (removes spaces, special characters)
df <- df %>% clean_names()


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   7. CREATING/MODIFYING COLUMNS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Create new column
df <- df %>% mutate(new_column = value)
df <- df %>% mutate(total = price * quantity)
df <- df %>% mutate(age_group = ifelse(age >= 18, "Adult", "Minor"))

# Multiple new columns
df <- df %>% mutate(
  total = price * quantity,
  discount = total * 0.1,
  final_price = total - discount
)

# Conditional column creation
df <- df %>% mutate(
  category = case_when(
    score >= 90 ~ "A",
    score >= 80 ~ "B",
    score >= 70 ~ "C",
    score >= 60 ~ "D",
    TRUE ~ "F"
  )
)

# Apply function to multiple columns
df <- df %>% mutate(across(c(col1, col2), ~.x * 2))
df <- df %>% mutate(across(where(is.numeric), ~round(.x, 2)))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   8. DATA TYPE CONVERSION
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Convert to numeric
df <- df %>% mutate(column = as.numeric(column))
df <- df %>% mutate(column = as.integer(column))

# Convert to character/string
df <- df %>% mutate(column = as.character(column))

# Convert to factor
df <- df %>% mutate(column = as.factor(column))
df <- df %>% mutate(column = factor(column, levels = c("Low", "Medium", "High")))

# Convert to logical
df <- df %>% mutate(column = as.logical(column))

# Convert multiple columns
df <- df %>% mutate(across(c(col1, col2), as.numeric))
df <- df %>% mutate(across(where(is.character), as.factor))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   9. HANDLING DUPLICATES
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Check for duplicates
sum(duplicated(df))                        # Count duplicate rows
df %>% filter(duplicated(.) | duplicated(., fromLast = TRUE))  # View duplicates

# Remove duplicates
df <- df %>% distinct()                    # Remove all duplicate rows
df <- df %>% distinct(column, .keep_all = TRUE)  # Remove duplicates based on column

# Find duplicates in specific column
df %>% group_by(id) %>% filter(n() > 1)


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   10. STRING MANIPULATION
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Clean whitespace
df <- df %>% mutate(column = str_trim(column))           # Remove leading/trailing spaces
df <- df %>% mutate(column = str_squish(column))         # Remove extra spaces

# Change case
df <- df %>% mutate(column = str_to_lower(column))
df <- df %>% mutate(column = str_to_upper(column))
df <- df %>% mutate(column = str_to_title(column))

# Substring
df <- df %>% mutate(first_3 = str_sub(column, 1, 3))

# Replace text
df <- df %>% mutate(column = str_replace(column, "old", "new"))
df <- df %>% mutate(column = str_replace_all(column, "old", "new"))

# Remove characters
df <- df %>% mutate(column = str_remove(column, "pattern"))
df <- df %>% mutate(column = str_remove_all(column, "[^0-9]"))  # Keep only numbers

# Split strings
df <- df %>% separate(full_name, c("first_name", "last_name"), sep = " ")

# Combine strings
df <- df %>% mutate(full_name = paste(first_name, last_name, sep = " "))
df <- df %>% unite("full_name", first_name, last_name, sep = " ")

# Check if string contains pattern
df <- df %>% mutate(has_pattern = str_detect(column, "pattern"))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   11. DATE AND TIME HANDLING
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Parse dates
df <- df %>% mutate(date = ymd(date_string))           # Year-month-day
df <- df %>% mutate(date = mdy(date_string))           # Month-day-year
df <- df %>% mutate(date = dmy(date_string))           # Day-month-year
df <- df %>% mutate(datetime = ymd_hms(datetime_string))

# Extract date components
df <- df %>% mutate(
  year = year(date),
  month = month(date),
  day = day(date),
  weekday = wday(date, label = TRUE),
  quarter = quarter(date)
)

# Date calculations
df <- df %>% mutate(
  days_since = today() - date,
  future_date = date + days(30),
  past_date = date - weeks(2)
)

# Format dates
df <- df %>% mutate(date_formatted = format(date, "%Y-%m-%d"))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   12. SORTING DATA
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Sort by column
df <- df %>% arrange(column)                # Ascending order
df <- df %>% arrange(desc(column))          # Descending order

# Sort by multiple columns
df <- df %>% arrange(column1, desc(column2))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   13. GROUPING AND SUMMARIZING
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Group by and summarize
df_summary <- df %>%
  group_by(category) %>%
  summarize(
    count = n(),
    mean_value = mean(value, na.rm = TRUE),
    median_value = median(value, na.rm = TRUE),
    sd_value = sd(value, na.rm = TRUE),
    min_value = min(value, na.rm = TRUE),
    max_value = max(value, na.rm = TRUE)
  )

# Count occurrences
df %>% count(category)
df %>% count(category, sort = TRUE)
df %>% group_by(category) %>% tally()

# Multiple grouping variables
df_summary <- df %>%
  group_by(category, subcategory) %>%
  summarize(total = sum(value, na.rm = TRUE))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   14. RESHAPING DATA
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Wide to long format
df_long <- df %>%
  pivot_longer(
    cols = c(col1, col2, col3),
    names_to = "variable",
    values_to = "value"
  )

# Long to wide format
df_wide <- df %>%
  pivot_wider(
    names_from = variable,
    values_from = value
  )

# Separate columns
df <- df %>% separate(column, c("col1", "col2"), sep = "-")

# Unite columns
df <- df %>% unite("new_col", col1, col2, sep = "-")


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   15. JOINING/MERGING DATA
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Inner join (keep only matching rows)
merged <- df1 %>% inner_join(df2, by = "id")

# Left join (keep all rows from left table)
merged <- df1 %>% left_join(df2, by = "id")

# Right join (keep all rows from right table)
merged <- df1 %>% right_join(df2, by = "id")

# Full join (keep all rows from both tables)
merged <- df1 %>% full_join(df2, by = "id")

# Join by multiple columns
merged <- df1 %>% left_join(df2, by = c("id", "date"))

# Join with different column names
merged <- df1 %>% left_join(df2, by = c("id" = "customer_id"))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   16. HANDLING OUTLIERS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Identify outliers using IQR
Q1 <- quantile(df$value, 0.25, na.rm = TRUE)
Q3 <- quantile(df$value, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR

# Remove outliers
df_clean <- df %>% filter(value >= lower_bound & value <= upper_bound)

# Cap outliers (winsorize)
df <- df %>% mutate(
  value_capped = case_when(
    value < lower_bound ~ lower_bound,
    value > upper_bound ~ upper_bound,
    TRUE ~ value
  )
)


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   17. STANDARDIZING AND NORMALIZING
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Z-score standardization
df <- df %>% mutate(value_std = (value - mean(value, na.rm = TRUE)) / sd(value, na.rm = TRUE))

# Min-max normalization (0 to 1)
df <- df %>% mutate(
  value_norm = (value - min(value, na.rm = TRUE)) /
               (max(value, na.rm = TRUE) - min(value, na.rm = TRUE))
)


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   18. WORKING WITH FACTORS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Convert to factor
df <- df %>% mutate(category = as.factor(category))

# Set factor levels
df <- df %>% mutate(category = factor(category, levels = c("Low", "Medium", "High")))

# Reorder factor levels
df <- df %>% mutate(category = fct_reorder(category, value))

# Combine factor levels
df <- df %>% mutate(category = fct_collapse(category,
  "Group1" = c("A", "B"),
  "Group2" = c("C", "D")
))

# Rename factor levels
df <- df %>% mutate(category = fct_recode(category,
  "New1" = "Old1",
  "New2" = "Old2"
))


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   19. PIPING MULTIPLE OPERATIONS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Chain multiple cleaning operations
df_clean <- df %>%
  clean_names() %>%                           # Clean column names
  filter(!is.na(important_column)) %>%        # Remove NAs
  mutate(across(where(is.character), str_trim)) %>%  # Trim strings
  mutate(date = mdy(date)) %>%                # Convert dates
  filter(date >= ymd("2020-01-01")) %>%       # Filter by date
  distinct() %>%                              # Remove duplicates
  arrange(date)                               # Sort


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   20. EXPORTING CLEANED DATA
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Export to CSV
write_csv(df_clean, "cleaned_data.csv")
write.csv(df_clean, "cleaned_data.csv", row.names = FALSE)

# Export to Excel
library(writexl)
write_xlsx(df_clean, "cleaned_data.xlsx")

# Export to RDS (R data format)
saveRDS(df_clean, "cleaned_data.rds")
df <- readRDS("cleaned_data.rds")


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#   ADDITIONAL USEFUL FUNCTIONS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Remove columns with all NA values
df <- df %>% select(where(~!all(is.na(.))))

# Remove rows with all NA values
df <- df %>% filter(if_any(everything(), ~!is.na(.)))

# Count unique values
df %>% summarize(unique_count = n_distinct(column))

# Get frequency table
table(df$column)
prop.table(table(df$column))  # Proportions

# Replace specific values
df <- df %>% mutate(column = na_if(column, -999))  # Convert -999 to NA
df <- df %>% mutate(column = recode(column, "old" = "new", "old2" = "new2"))

# ================================================================
# END OF CHEATSHEET
# ================================================================
