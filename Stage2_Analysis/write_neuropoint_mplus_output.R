library(RNifti)

args = commandArgs(trailingOnly=TRUE)

if (length(args)!=3){
  stop('Did not provide arguments properly (csv) (mask) (out-prefix).n',call.=FALSE)
}

#load some neuropointillist background functions into current namespace
source('/usr/local/neuropointillist/neuropointillist/R/code.R')

csvPath = args[1]
maskPath = args[2]
outPrefix = args[3]

df = read.csv(csvPath,header=FALSE)
mask = readNifti(maskPath)

for(i in 1:nrow(df)) {
  sub = strsplit(as.character(df[i,2]),".",fixed=TRUE)[[1]]
  outFile = paste(outPrefix,'sub-',sub[1],'t',sub[2],'.nii.gz',sep="")
  npointWriteFile(mask,array(df[i,-c(1:7)]),outFile)
}

warnings()