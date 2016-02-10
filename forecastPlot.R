forecastPlot <- function(est, obs, finTime, quantiles, topOmit=0, scaleTime=finTime, ptime=finTime){
	midQuant <- (1+length(quantiles))/2
	topQuant <- length(quantiles)-topOmit

	
	ymax <- max(est[1:scaleTime, topQuant])
	xmax <- scaleTime


	t <- 1:finTime
	est <- est[t, ]
	obs <- obs[t]

	plot(t, est[, midQuant]
		, main=scenario
		, type="l"
		, xlab="Week", ylab="Cases"
		, ylim = c(0, ymax)
		, xlim = c(0, xmax)
	)

	points(t[1:ptime], obs[1:ptime])
	for(i in 1:length(quantiles)){
		print(est[, i])
		lines(1:finTime, est[1:finTime, i]
			, lty = 1 + abs(i-midQuant)
		)
	}
}
