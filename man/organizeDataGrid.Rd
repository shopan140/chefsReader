% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reader.R
\name{organizeDataGrid}
\alias{organizeDataGrid}
\title{Title this is a helper function to organize dataframe
read by json reader. Different level data is read seperatly}
\usage{
organizeDataGrid(rowNumber, df, formLevelKey, gridLevelKey, idKey)
}
\arguments{
\item{rowNumber}{is the row of the dataframe}

\item{df}{dataframe that contain json data not flatten}

\item{formLevelKey}{top level key in json}

\item{gridLevelKey}{if it has multiple key then use the function
for each grid level key}

\item{idKey}{id that is unique so that data can be matches
with form level data}
}
\value{
returns a dataframe
}
\description{
Title this is a helper function to organize dataframe
read by json reader. Different level data is read seperatly
}
