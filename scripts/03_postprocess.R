library(Hmsc)

nSamples = 100
thin = 2
transient = nSamples * thin

m = Hmsc(Y=TD$Y,
         XData=TD$X, XFormula=~.,
         TrData=TD$Tr[,-1], TrFormula=~.,
         phyloTree=TD$phy,
         studyDesign=TD$studyDesign,
         ranLevels=list(plot=TD$rL1, sample=TD$rL2))

importFromHPC = readRDS(file="post_file.rds")
postList = importFromHPC[["list"]]
cat(sprintf("fitting time %.1f sec\n", importFromHPC["time"]))

fitTF = importPosteriorFromHPC(m, postList, nSamples, thin, transient)

plotVariancePartitioning(fitTF, computeVariancePartitioning(fitTF),
                         args.legend=list(x="bottomright"))

