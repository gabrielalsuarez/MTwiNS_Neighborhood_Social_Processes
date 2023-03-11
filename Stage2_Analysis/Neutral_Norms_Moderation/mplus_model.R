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
  names(retvals) = c('NORMS.unstd.est','NORMS.unstd.se','NORMS.unstd.tval','NORMS.unstd.pval',
                     'AGE.unstd.est','AGE.unstd.se','AGE.unstd.tval','AGE.unstd.pval',
                     'NORMSxAGE.unstd.est','NORMSxAGE.unstd.se','NORMSxAGE.unstd.tval','NORMSxAGE.unstd.pval',
                     'NORMS.std.est','NORMS.std.se','NORMS.std.tval','NORMS.std.pval',
                     'AGE.std.est','AGE.std.se','AGE.std.tval','AGE.std.pval',
                     'NORMSxAGE.std.est','NORMSxAGE.std.se','NORMSxAGE.std.tval','NORMSxAGE.std.pval',
                     'SIMP_LO_AGE.unstd.est','SIMP_LO_AGE.unstd.se','SIMP_LO_AGE.unstd.tval','SIMP_LO_AGE.unstd.pval',
                     'SIMP_MED_AGE.unstd.est','SIMP_MED_AGE.unstd.se','SIMP_MED_AGE.unstd.tval','SIMP_MED_AGE.unstd.pval',
                     'SIMP_HI_AGE.unstd.est','SIMP_HI_AGE.unstd.se','SIMP_HI_AGE.unstd.tval','SIMP_HI_AGE.unstd.pval',
                     'NORMS.ci.unstd.low.5','NORMS.ci.unstd.up.5','NORMS.ci.unstd.low2.5',
                     'NORMS.ci.unstd.up2.5','NORMS.ci.unstd.low5','NORMS.ci.unstd.up5',
                     'AGE.ci.unstd.low.5','AGE.ci.unstd.up.5','AGE.ci.unstd.low2.5',
                     'AGE.ci.unstd.up2.5','AGE.ci.unstd.low5','AGE.ci.unstd.up5',
                     'NORMSxAGE.ci.unstd.low.5','NORMSxAGE.ci.unstd.up.5','NORMSxAGE.ci.unstd.low2.5',
                     'NORMSxAGE.ci.unstd.up2.5','NORMSxAGE.ci.unstd.low5','NORMSxAGE.ci.unstd.up5',
                     'SIMP_LO_AGE.ci.unstd.low.5','SIMP_LO_AGE.ci.unstd.up.5','SIMP_LO_AGE.ci.unstd.low2.5',
                     'SIMP_LO_AGE.ci.unstd.up2.5','SIMP_LO_AGE.ci.unstd.low5','SIMP_LO_AGE.ci.unstd.up5',
                     'SIMP_MED_AGE.ci.unstd.low.5','SIMP_MED_AGE.ci.unstd.up.5','SIMP_MED_AGE.ci.unstd.low2.5',
                     'SIMP_MED_AGE.ci.unstd.up2.5','SIMP_MED_AGE.ci.unstd.low5','SIMP_MED_AGE.ci.unstd.up5',
                     'SIMP_HI_AGE.ci.unstd.low.5','SIMP_HI_AGE.ci.unstd.up.5','SIMP_HI_AGE.ci.unstd.low2.5',
                     'SIMP_HI_AGE.ci.unstd.up2.5','SIMP_HI_AGE.ci.unstd.low5','SIMP_HI_AGE.ci.unstd.up5')
  retvals
}