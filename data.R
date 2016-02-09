datf <- grep("csv$", input_files, value=TRUE)
print(datf)
allobs <- read.csv(datf)[[2]]
print(summary(allobs))

