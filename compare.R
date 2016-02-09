par(cex=1.4)
topOmit <- 1
short <- 5

forecastPlot(est, allobs, fitlength, quantiles, topOmit)
forecastPlot(est, allobs, fitlength+short, quantiles, topOmit)
forecastPlot(est, allobs, nrow(est), quantiles, topOmit) 
forecastPlot(est, allobs, nrow(est), quantiles, topOmit=2) 
forecastPlot(est, allobs, nrow(est), quantiles, topOmit=3) 
