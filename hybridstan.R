require(rstan)
set.seed(seed)
forecast=100
if(forecast>0) forecastobs <- c(rep(1, forecast))

obs <- allobs[!is.na(allobs)]

numobs <- length(obs)
forecastnum <- length(forecastobs)

lag <- 5
lagvec <- 1:lag

effRepHa <- effRepHShape/(1-effRepHmean)
effRepHb <- effRepHShape/effRepHmean

preExp <- preMean/(lag+preMean)

numobs <- length(obs)

#creating the data/inits/constants -----
data <- list (obs=obs
              ,lag=lag
              ,foieps=foieps
              ,pop=pop
              ,kappa=kappa
              ,numobs=numobs
              ,forecastnum=forecastnum
              ,effRepHa=effRepHa
              ,effRepHb=effRepHb 
              ,hetShape=hetShape
              ,hetMean=hetMean
              ,Rshape=Rshape 
              ,Rmean=Rmean
              ,gpShape=gpShape
              ,gpMean=gpMean
              ,gsShape=gsShape 
              ,gsMean=gsMean
              ,preExp=preExp
              ,shapeH=shapeH
              ,lagvec=lagvec)

pre <- 1+obs[[1]]
inits <- list(list(genPos = gpMean
                   , effRep = maxRep
                   , forecastobs = forecastobs
                   , preInc = c(rep(pre, lag), 1+obs,2+forecastobs)
                   , repShape=1
                   , incShape=1
                   , alpha=1
                   , RRprop=0.5
                   , R0=1
                   , genShape=1
                   , obsMean=c(obs,forecastobs)
))
# hybrid stan----
sim <- stan(file="hybrid.stan",data=data,init=inits,
            pars=c("forecastobs", "R0"
                   , "effRep", "RRprop", "alpha"
                   , "preInc"),
            iter=500,
            chains=1)

print(sim)
