# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(chefsReader)

output <- readRedipReport(jsonFile = "data//redip_reporting.json",
                          outputFile = "data//output.xlsx")

# test_check("chefsReader")
#
# library(jsonlite)
#
#
# dfJson <- jsonlite::fromJSON("data//redip_reporting.json", flatten = FALSE)
#
# df <- dfJson[1, ]
# dataGridCol = c()
# for(i in names(dfJson)){
#   dataGridCol[i] <- !is.atomic(dfJson[1, i])
# }
#
#
# temp <- dfJson[, dataGridCol]
#
# df1 <- temp$form
# df2 <- temp$deliverableTasks
#
# atomicColumn <- unlist(lapply(dfJson[1,], function(x) is.atomic(x)))
#
# df <- dfJson[, atomicColumn]
#
#
# df <- readJson("data//redip_reporting.json", gridLevelKey = "deliverableTasks")
#
# temp <- organizeAtomic(dfJson)
#
#
# temp1 <- organizeList(dfJson, "form")
#
# df <- dfJson$deliverableTasks
#
# data.frame(df[[1]])
#
# tt <- merge(temp,temp1)
#
#
#
# keyList <- temp1$confirmationId
#
# deliverable <- organizeList(dfJson$deliverableTasks, keyList = keyList)
#
# expenditureTable <- organizeList(dfJson$expenditureReport, keyList = keyList)
#
#
# tt1 <- merge(tt, deliverable)
#
# tt3 <- merge(tt1, expenditureTable)
#
# debug(readRedipReport)



