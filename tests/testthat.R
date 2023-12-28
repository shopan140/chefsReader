# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(chefsReader)

test_check("chefsReader")

# Example usage:
# Replace 'your_file_path.json' with the actual path to your JSON file
# Replace c("key1", "key2") with the keys you want to flatten based on
result <- flatten_json("data//fep_reporting.json", c("dataGrid"))

library(jsonlite)

df <- read_json("data//redip_interim_progress_report_submissions.json")

names(df)

data.frame(t(df[[1]][["form"]]))

tabulize("form", df[[1]])
