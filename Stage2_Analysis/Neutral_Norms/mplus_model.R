library(MplusAutomation)

processVoxel <- function(v){
  # save voxeldat for reference via mPlus (if not yet saved)
  if(!file.exists('voxeldata.csv')){
    df = cbind(designmat,voxeldat)
    df = df[, -grep('X',colnames(df))]
    df[is.na(df)] = -99
    write.table(df,file='voxeldata.csv',col.names=FALSE,row.names=FALSE,sep=",")
    
  }
  # create input file from template, replace voxel
  inpTxt = readLines('./mplus_input_template.txt')
  voxTxt = gsub(pattern="__VOXEL__", replace = as.character(v), x = inpTxt)
  inMplus = paste0('./mplus_vox/V',as.character(v),'.inp')
  writeLines(voxTxt, con=inMplus)
  # now, let's go ahead and run the model in mPlus
  runModels(target=inMplus)
  # read the output
  outMplus = paste0('./mplus_vox/V',as.character(v),'.out')
  output = readModels(outMplus,what="parameters")
  # specify return vals
  retvals = list(output$parameters$unstandardized$est[1], output$parameters$unstandardized$se[1], 
                 output$parameters$unstandardized$est_se[1], output$parameters$unstandardized$pval[1],
                 output$parameters$unstandardized$est[2], output$parameters$unstandardized$se[2],
                 output$parameters$unstandardized$est_se[2], output$parameters$unstandardized$pval[2],
                 output$parameters$unstandardized$est[3], output$parameters$unstandardized$se[3],
                 output$parameters$unstandardized$est_se[3], output$parameters$unstandardized$pval[3],
                 output$parameters$unstandardized$est[4], output$parameters$unstandardized$se[4],
                 output$parameters$unstandardized$est_se[4], output$parameters$unstandardized$pval[4],
                 output$parameters$unstandardized$est[5], output$parameters$unstandardized$se[5],
                 output$parameters$unstandardized$est_se[5], output$parameters$unstandardized$pval[5],
                 output$parameters$stdyx.standardized$est[1], output$parameters$stdyx.standardized$se[1], 
                 output$parameters$stdyx.standardized$est_se[1], output$parameters$stdyx.standardized$pval[1],
                 output$parameters$stdyx.standardized$est[2], output$parameters$stdyx.standardized$se[2],
                 output$parameters$stdyx.standardized$est_se[2], output$parameters$stdyx.standardized$pval[2],
                 output$parameters$stdyx.standardized$est[3], output$parameters$stdyx.standardized$se[3],
                 output$parameters$stdyx.standardized$est_se[3], output$parameters$stdyx.standardized$pval[3],
                 output$parameters$stdyx.standardized$est[4], output$parameters$stdyx.standardized$se[4],
                 output$parameters$stdyx.standardized$est_se[4], output$parameters$stdyx.standardized$pval[4],
                 output$parameters$stdyx.standardized$est[5], output$parameters$stdyx.standardized$se[5],
                 output$parameters$stdyx.standardized$est_se[5], output$parameters$stdyx.standardized$pval[5],
                 output$parameters$ci.unstandardized$low.5[1], output$parameters$ci.unstandardized$up.5[1], 
                 output$parameters$ci.unstandardized$low2.5[1], output$parameters$ci.unstandardized$up2.5[1],
                 output$parameters$ci.unstandardized$low5[1], output$parameters$ci.unstandardized$up5[1],
                 output$parameters$ci.unstandardized$low.5[2], output$parameters$ci.unstandardized$up.5[2], 
                 output$parameters$ci.unstandardized$low2.5[2], output$parameters$ci.unstandardized$up2.5[2],
                 output$parameters$ci.unstandardized$low5[2], output$parameters$ci.unstandardized$up5[2],
                 output$parameters$ci.unstandardized$low.5[3], output$parameters$ci.unstandardized$up.5[3], 
                 output$parameters$ci.unstandardized$low2.5[3], output$parameters$ci.unstandardized$up2.5[3],
                 output$parameters$ci.unstandardized$low5[3], output$parameters$ci.unstandardized$up5[3],
                 output$parameters$ci.unstandardized$low.5[4], output$parameters$ci.unstandardized$up.5[4], 
                 output$parameters$ci.unstandardized$low2.5[4], output$parameters$ci.unstandardized$up2.5[4],
                 output$parameters$ci.unstandardized$low5[4], output$parameters$ci.unstandardized$up5[4],
                 output$parameters$ci.unstandardized$low.5[5], output$parameters$ci.unstandardized$up.5[5], 
                 output$parameters$ci.unstandardized$low2.5[5], output$parameters$ci.unstandardized$up2.5[5],
                 output$parameters$ci.unstandardized$low5[5], output$parameters$ci.unstandardized$up5[5],
                 output$parameters$ci.stdyx.standardized$low.5[1], output$parameters$ci.stdyx.standardized$up.5[1], 
                 output$parameters$ci.stdyx.standardized$low2.5[1], output$parameters$ci.stdyx.standardized$up2.5[1],
                 output$parameters$ci.stdyx.standardized$low5[1], output$parameters$ci.stdyx.standardized$up5[1],
                 output$parameters$ci.stdyx.standardized$low.5[2], output$parameters$ci.stdyx.standardized$up.5[2], 
                 output$parameters$ci.stdyx.standardized$low2.5[2], output$parameters$ci.stdyx.standardized$up2.5[2],
                 output$parameters$ci.stdyx.standardized$low5[2], output$parameters$ci.stdyx.standardized$up5[2],
                 output$parameters$ci.stdyx.standardized$low.5[3], output$parameters$ci.stdyx.standardized$up.5[3], 
                 output$parameters$ci.stdyx.standardized$low2.5[3], output$parameters$ci.stdyx.standardized$up2.5[3],
                 output$parameters$ci.stdyx.standardized$low5[3], output$parameters$ci.stdyx.standardized$up5[3],
                 output$parameters$ci.stdyx.standardized$low.5[4], output$parameters$ci.stdyx.standardized$up.5[4], 
                 output$parameters$ci.stdyx.standardized$low2.5[4], output$parameters$ci.stdyx.standardized$up2.5[4],
                 output$parameters$ci.stdyx.standardized$low5[4], output$parameters$ci.stdyx.standardized$up5[4],
                 output$parameters$ci.stdyx.standardized$low.5[5], output$parameters$ci.stdyx.standardized$up.5[5], 
                 output$parameters$ci.stdyx.standardized$low2.5[5], output$parameters$ci.stdyx.standardized$up2.5[5],
                 output$parameters$ci.stdyx.standardized$low5[5], output$parameters$ci.stdyx.standardized$up5[5],
                 output$parameters$r2$est, output$parameters$r2$se, output$parameters$r2$est_se, output$parameters$r2$pval)
  names(retvals) = c('NORMS.unstd.est','NORMS.unstd.se','NORMS.unstd.tval','NORMS.unstd.pval',
                     'AGE.unstd.est','AGE.unstd.se','AGE.unstd.tval','AGE.unstd.pval',
                     'SEX.unstd.est','SEX.unstd.se','SEX.unstd.tval','SEX.unstd.pval',
                     'RACE.unstd.est','RACE.unstd.se','RACE.unstd.tval','RACE.unstd.pval',
                     'SCAN.unstd.est','SCAN.unstd.se','SCAN.unstd.tval','SCAN.unstd.pval',
                     'NORMS.std.est','NORMS.std.se','NORMS.std.tval','NORMS.std.pval',
                     'AGE.std.est','AGE.std.se','AGE.std.tval','AGE.std.pval',
                     'SEX.std.est','SEX.std.se','SEX.std.tval','SEX.std.pval',
                     'RACE.std.est','RACE.std.se','RACE.std.tval','RACE.std.pval',
                     'SCAN.std.est','SCAN.std.se','SCAN.std.tval','SCAN.std.pval',
                     'NORMS.ci.unstd.low.5','NORMS.ci.unstd.up.5','NORMS.ci.unstd.low2.5',
                     'NORMS.ci.unstd.up2.5','NORMS.ci.unstd.low5','NORMS.ci.unstd.up5',
                     'AGE.ci.unstd.low.5','AGE.ci.unstd.up.5','AGE.ci.unstd.low2.5',
                     'AGE.ci.unstd.up2.5','AGE.ci.unstd.low5','AGE.ci.unstd.up5',
                     'SEX.ci.unstd.low.5','SEX.ci.unstd.up.5','SEX.ci.unstd.low2.5',
                     'SEX.ci.unstd.up2.5','SEX.ci.unstd.low5','SEX.ci.unstd.up5',
                     'RACE.ci.unstd.low.5','RACE.ci.unstd.up.5','RACE.ci.unstd.low2.5',
                     'RACE.ci.unstd.up2.5','RACE.ci.unstd.low5','RACE.ci.unstd.up5',
                     'SCAN.ci.unstd.low.5','SCAN.ci.unstd.up.5','SCAN.ci.unstd.low2.5',
                     'SCAN.ci.unstd.up2.5','SCAN.ci.unstd.low5','SCAN.ci.unstd.up5',
                     'NORMS.ci.std.low.5','NORMS.ci.std.up.5','NORMS.ci.std.low2.5',
                     'NORMS.ci.std.up2.5','NORMS.ci.std.low5','NORMS.ci.std.up5',
                     'AGE.ci.std.low.5','AGE.ci.std.up.5','AGE.ci.std.low2.5',
                     'AGE.ci.std.up2.5','AGE.ci.std.low5','AGE.ci.std.up5',
                     'SEX.ci.std.low.5','SEX.ci.std.up.5','SEX.ci.std.low2.5',
                     'SEX.ci.std.up2.5','SEX.ci.std.low5','SEX.ci.std.up5',
                     'RACE.ci.std.low.5','RACE.ci.std.up.5','RACE.ci.std.low2.5',
                     'RACE.ci.std.up2.5','RACE.ci.std.low5','RACE.ci.std.up5',
                     'SCAN.ci.std.low.5','SCAN.ci.std.up.5','SCAN.ci.std.low2.5',
                     'SCAN.ci.std.up2.5','SCAN.ci.std.low5','SCAN.ci.std.up5',
                     'R2.est','R2.se','R2.tval','R2.pval')
  retvals
}