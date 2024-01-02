

#' Title this is a helper function to organize dataframe
#' read by json reader. Different level data is read seperatly
#' @param rowNumber is the row of the dataframe
#' @param df dataframe that contain json data not flatten
#' @param formLevelKey top level key in json
#' @param gridLevelKey if it has multiple key then use the function
#' for each grid level key
#' @param idKey id that is unique so that data can be matches
#' with form level data
#' @return returns a dataframe
#' @export
#'
#' @examples
organizeDataGrid <- function(rowNumber, df, formLevelKey, gridLevelKey, idKey){
  temp <- data.frame(df[rowNumber, gridLevelKey])
  temp[, idKey] <- df[[formLevelKey]][rowNumber, idKey]
  temp
}


organizeJsonObj <- function(df, levelKey = "form"){
  temp <- df[, levelKey]
  atomicColumn <- unlist(lapply(temp[1,], function(x) is.atomic(x)))
  temp[, atomicColumn]
}

organizeList <- function(dfList, keyList, idKey = "confirmationId"){

  for(i in 1:length(keyList)){
    dfList[[i]][, idKey] <- keyList[[i]]
  }
  dplyr::bind_rows(dfList)
}
organizeAtomic <- function(df, idKey = "confirmationId", idkeyLevel = "form"){

  atomicColumn <- unlist(lapply(df[1,], function(x) is.atomic(x)))
  temp <- df[, atomicColumn]
  temp [, idKey] <- df[[idkeyLevel]][, idKey]
  temp
}





#' A function that reads a JSON file and returns dataframe
#' seperated by their level. Form level orgaznied in one dataframe
#' and grid level is organized in another.
#' @param filePath path of the JSON input
#' @param formLevelKey first level key
#' @param gridLevelKey second level key
#' @param idKey unique id to match second level to first level
#' generally unique id is attached to first level
#' @param ignoreFormLevelData if we don't want the first level data
#' provide this param as TRUE and function will only return a dataframe
#'
#' @return a dataframe
#' @export
#'
#' @examples readJson(filePath = "data//reporting.JSON,
#' formLevelKey = "form",
#' gridLevelKey = "DataGrid",
#' idKey = "confirmationId",
#' ignoreFormLevelData = FLASE)
readJson <- function(filePath,
                     formLevelKey = NULL,
                     gridLevelKey = NULL,
                     idKey = "confirmationId",
                     ignoreFormLevelData = FALSE){

  dfJson <- jsonlite::fromJSON(filePath, flatten = FALSE)

  if(is.null(formLevelKey)) formLevelKey = "form"

  if(!is.null(gridLevelKey)){
    temp <- lapply(seq(1:nrow(dfJson)),
                   organizeDataGrid,
                   dfJson,
                   formLevelKey,
                   gridLevelKey,
                   idKey)

    temp <- dplyr::bind_rows(temp)

    if(ignoreFormLevelData) return(temp)

    return(
      merge(dfJson[[formLevelKey]],
            temp,
            by.x = idKey,
            by.y = idKey,
            all.y = TRUE))

    }
  else{
    return(dfJson[[formLevelKey]])
  }
}


tabulize <- function(name, x){

  if(!is.list(x[[name]])){
    out <- data.frame(x[name])

  }
  else{
    out <- data.frame(t(x[[name]]))
  }

  out
}


#' Title
#'
#' @param jsonFile file path for json
#' @param outputFile file path for output excel.
#' @param idKey unique id name
#' @param formLevelKey form level key
#' @param gridLevelKeys data grid level keys a vector
#'
#' @return a list of dataframe and write to excel file.
#' @export
#'
#' @examples readRedipReport(jsonfile = "data//path.json", outputFile = "data//path.xlsx")
readRedipReport <- function(jsonFile,
                            outputFile,
                            idKey = "confirmationId",
                            formLevelKey = "form",
                            gridLevelKeys = c("deliverableTasks",
                                              "expenditureReport")) {
  dfJson <- jsonlite::fromJSON(jsonFile, flatten = FALSE)

  topLevelData <- organizeAtomic(dfJson, idKey = idKey, idkeyLevel = formLevelKey)
  formLevelData <- organizeJsonObj(dfJson, levelKey = formLevelKey)

  keyList <- formLevelData[, idKey, drop = TRUE]

  tempList <- vector("list")
  for (i in gridLevelKeys){
    tempList[[i]] <- organizeList(dfJson[[i]], keyList = keyList)
  }
  tmp <- merge(formLevelData, topLevelData)
  tempList$reportInfo <- tmp

  writexl::write_xlsx(tempList, path = outputFile)
  tempList

}
