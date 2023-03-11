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
                 output$parameters$stdyx.standardized$est[1], output$parameters$stdyx.standardized$se[1], 
                 output$parameters$stdyx.standardized$est_se[1], output$parameters$stdyx.standardized$pval[1],
                 output$parameters$stdyx.standardized$est[2], output$parameters$stdyx.standardized$se[2],
                 output$parameters$stdyx.standardized$est_se[2], output$parameters$stdyx.standardized$pval[2],
                 output$parameters$stdyx.standardized$est[3], output$parameters$stdyx.standardized$se[3],
                 output$parameters$stdyx.standardized$est_se[3], output$parameters$stdyx.standardized$pval[3],
                 output$parameters$unstandardized$est[28], output$parameters$unstandardized$se[28],
                 output$parameters$unstandardized$est_se[28], output$parameters$unstandardized$pval[28],
                 output$parameters$unstandardized$est[29], output$parameters$unstandardized$se[29],
                 output$parameters$unstandardized$est_se[29], output$parameters$unstandardized$pval[29],
                 output$parameters$unstandardized$est[30], output$parameters$unstandardized$se[30],
                 output$parameters$unstandardized$est_se[30], output$parameters$unstandardized$pval[30],
                 output$parameters$ci.unstandardized$low.5[1], output$parameters$ci.unstandardized$up.5[1], 
                 output$parameters$ci.unstandardized$low2.5[1], output$parameters$ci.unstandardized$up2.5[1],
                 output$parameters$ci.unstandardized$low5[1], output$parameters$ci.unstandardized$up5[1],
                 output$parameters$ci.unstandardized$low.5[2], output$parameters$ci.unstandardized$up.5[2], 
                 output$parameters$ci.unstandardized$low2.5[2], output$parameters$ci.unstandardized$up2.5[2],
                 output$parameters$ci.unstandardized$low5[2], output$parameters$ci.unstandardized$up5[2],
                 output$parameters$ci.unstandardized$low.5[3], output$parameters$ci.unstandardized$up.5[3], 
                 output$parameters$ci.unstandardized$low2.5[3], output$parameters$ci.unstandardized$up2.5[3],
                 output$parameters$ci.unstandardized$low5[3], output$parameters$ci.unstandardized$up5[3],
                 output$parameters$ci.unstandardized$low.5[28], output$parameters$ci.unstandardized$up.5[28], 
                 output$parameters$ci.unstandardized$low2.5[28], output$parameters$ci.unstandardized$up2.5[28],
                 output$parameters$ci.unstandardized$low5[28], output$parameters$ci.unstandardized$up5[28],
                 output$parameters$ci.unstandardized$low.5[29], output$parameters$ci.unstandardized$up.5[29], 
                 output$parameters$ci.unstandardized$low2.5[29], output$parameters$ci.unstandardized$up2.5[29],
                 output$parameters$ci.unstandardized$low5[29], output$parameters$ci.unstandardized$up5[29],
                 output$parameters$ci.unstandardized$low.5[30], output$parameters$ci.unstandardized$up.5[30], 
                 output$parameters$ci.unstandardized$low2.5[30], output$parameters$ci.unstandardized$up2.5[30],
                 output$parameters$ci.unstandardized$low5[30], output$parameters$ci.unstandardized$up5[30])
  names(retvals) = c('COLEFF.unstd.est','COLEFF.unstd.se','COLEFF.unstd.tval','COLEFF.unstd.pval',
                     'AGE.unstd.est','AGE.unstd.se','AGE.unstd.tval','AGE.unstd.pval',
                     'COLEFFxAGE.unstd.est','COLEFFxAGE.unstd.se','COLEFFxAGE.unstd.tval','COLEFFxAGE.unstd.pval',
                     'COLEFF.std.est','COLEFF.std.se','COLEFF.std.tval','COLEFF.std.pval',
                     'AGE.std.est','AGE.std.se','AGE.std.tval','AGE.std.pval',
                     'COLEFFxAGE.std.est','COLEFFxAGE.std.se','COLEFFxAGE.std.tval','COLEFFxAGE.std.pval',
                     'SIMP_LO_AGE.unstd.est','SIMP_LO_AGE.unstd.se','SIMP_LO_AGE.unstd.tval','SIMP_LO_AGE.unstd.pval',
                     'SIMP_MED_AGE.unstd.est','SIMP_MED_AGE.unstd.se','SIMP_MED_AGE.unstd.tval','SIMP_MED_AGE.unstd.pval',
                     'SIMP_HI_AGE.unstd.est','SIMP_HI_AGE.unstd.se','SIMP_HI_AGE.unstd.tval','SIMP_HI_AGE.unstd.pval',
                     'COLEFF.ci.unstd.low.5','COLEFF.ci.unstd.up.5','COLEFF.ci.unstd.low2.5',
                     'COLEFF.ci.unstd.up2.5','COLEFF.ci.unstd.low5','COLEFF.ci.unstd.up5',
                     'AGE.ci.unstd.low.5','AGE.ci.unstd.up.5','AGE.ci.unstd.low2.5',
                     'AGE.ci.unstd.up2.5','AGE.ci.unstd.low5','AGE.ci.unstd.up5',
                     'COLEFFxAGE.ci.unstd.low.5','COLEFFxAGE.ci.unstd.up.5','COLEFFxAGE.ci.unstd.low2.5',
                     'COLEFFxAGE.ci.unstd.up2.5','COLEFFxAGE.ci.unstd.low5','COLEFFxAGE.ci.unstd.up5',
                     'SIMP_LO_AGE.ci.unstd.low.5','SIMP_LO_AGE.ci.unstd.up.5','SIMP_LO_AGE.ci.unstd.low2.5',
                     'SIMP_LO_AGE.ci.unstd.up2.5','SIMP_LO_AGE.ci.unstd.low5','SIMP_LO_AGE.ci.unstd.up5',
                     'SIMP_MED_AGE.ci.unstd.low.5','SIMP_MED_AGE.ci.unstd.up.5','SIMP_MED_AGE.ci.unstd.low2.5',
                     'SIMP_MED_AGE.ci.unstd.up2.5','SIMP_MED_AGE.ci.unstd.low5','SIMP_MED_AGE.ci.unstd.up5',
                     'SIMP_HI_AGE.ci.unstd.low.5','SIMP_HI_AGE.ci.unstd.up.5','SIMP_HI_AGE.ci.unstd.low2.5',
                     'SIMP_HI_AGE.ci.unstd.up2.5','SIMP_HI_AGE.ci.unstd.low5','SIMP_HI_AGE.ci.unstd.up5')
  retvals
}