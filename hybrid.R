require("R2jags")

# Parse the lag out of the model file name (clunky)
bugf <- grep("bug$", input_files, value=TRUE)
lag <- as.numeric(gsub("[A-Za-z_.]*", "", bugf))

set.seed(seed)

fitlength <- ifelse(exists("fitlength"), fitlength, length(allobs))
projlength <- ifelse(exists("extend"), length(allobs)+extend, length(allobs))
obs <- rep(NA, projlength)
obs[1:fitlength] <- allobs[1:fitlength]

data <- list (
	obs = obs
	, max = length(obs)
	, lag = lag
	, lagvec = 1:lag
	, pop = pop
	, foieps = foieps
	, kappa = kappa
	, effRepHa = effRepHShape/(1-effRepHmean)
	, effRepHb = effRepHShape/effRepHmean
	, preExp = preMean/(lag+preMean)
	, hetShape = hetShape
	, hetMean = hetMean
	, shapeH = shapeH
	, Rshape = Rshape
	, Rmean = Rmean
	, gpShape = gpShape
	, gpMean = gpMean
	, gsShape = gsShape
	, gsMean = gsMean
   # , Burial = Burial
   # , ETU = ETU
	# , Tracing = Tracing
)

inits <- lapply (mult, function(m){
	pre <- 1+obs[[1]]
	return(list(
		genPos = gpMean
		, effRep = maxRep/m
		, preInc = c(
			rep(pre, lag)
			, 1+obs
		)
	))
})

print(inits)

sim <- jags(model.file=bugf,
	data=data, inits=inits, 
	parameters = c("ker", "R0", "gen"
		, "repMean"
		, "effRep", "RRprop", "alpha"
		, "obs"
		, "inc", "preInc", "foi"
	),
	n.chains = length(mult), n.iter = iterations
)

print(sim)
plot(sim)
traceplot(sim)

proc.time()
