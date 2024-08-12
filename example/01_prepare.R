# This script is based on the "basic example" of HMSC-HPC
library(Hmsc)
library(jsonify)

nSamples = 100
thin = 2
nChains = 4
verbose = 100
transient = nSamples * thin

summary(TD)
m = Hmsc(Y=TD$Y,
         XData=TD$X, XFormula=~.,
         TrData=TD$Tr[,-1], TrFormula=~.,
         phyloTree=TD$phy,
         studyDesign=TD$studyDesign,
         ranLevels=list(plot=TD$rL1, sample=TD$rL2))

# Run HMSC-R
fitR = sampleMcmc(m, samples=nSamples, thin=thin,
                  transient=transient, nChains=nChains,
                  verbose=verbose, engine="R")

plotVariancePartitioning(fitR, computeVariancePartitioning(fitR),
                         args.legend=list(x="bottomright"))

# Prepare input for HMSC-HPC
init_obj = sampleMcmc(m, samples=nSamples, thin=thin,
                      transient=transient, nChains=nChains,
                      verbose=verbose, engine="HPC")

saveRDS(init_obj, file="init_file.rds")
saveRDS(to_json(init_obj), file="init_file_json.rds")

