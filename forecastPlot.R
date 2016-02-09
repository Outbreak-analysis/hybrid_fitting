forecastPlot <- function(est, obs, finTime, quantiles, topOmit=0){
	midQuant <- (1+length(quantiles))/2
	topQuant <- length(quantiles)-topOmit
	t <- 1:finTime
	est <- est[1:finTime, ]
	obs <- obs[1:finTime]
	ymax <- max(est[, topQuant])
	print(ymax)

	plot(t, est[, midQuant]
		, main=scenario
		, type="l"
		, xlab="Week", ylab="Cases"
		, ylim = c(0, ymax)
	)

	points(t, obs)
	for(i in 1:length(quantiles)){
		print(est[, i])
		lines(t, est[, i]
			, lty = 1 + abs(i-midQuant)
		)
	}
}
