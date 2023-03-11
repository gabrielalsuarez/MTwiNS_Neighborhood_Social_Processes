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
                 output$parameters$unstandardized$est[31], output$parameters$unstandardized$se[31],
                 output$parameters$unstandardized$est_se[31], output$parameters$unstandardized$pval[31],
                 output$parameters$unstandardized$est[32], output$parameters$unstandardized$se[32],
                 output$parameters$unstandardized$est_se[32], output$parameters$unstandardized$pval[32],
                 output$parameters$unstandardized$est[33], output$parameters$unstandardized$se[33],
                 output$parameters$unstandardized$est_se[33], output$parameters$unstandardized$pval[33],
                 output$parameters$ci.unstandardized$low.5[1], output$parameters$ci.unstandardized$up.5[1], 
                 output$parameters$ci.unstandardized$low2.5[1], output$parameters$ci.unstandardized$up2.5[1],
                 output$parameters$ci.unstandardized$low5[1], output$parameters$ci.unstandardized$up5[1],
                 output$parameters$ci.unstandardized$low.5[2], output$parameters$ci.unstandardized$up.5[2], 
                 output$parameters$ci.unstandardized$low2.5[2], output$parameters$ci.unstandardized$up2.5[2],
                 output$parameters$ci.unstandardized$low5[2], output$parameters$ci.unstandardized$up5[2],
                 output$parameters$ci.unstandardized$low.5[3], output$parameters$ci.unstandardized$up.5[3], 
                 output$parameters$ci.unstandardized$low2.5[3], output$parameters$ci.unstandardized$up2.5[3],
                 output$parameters$ci.unstandardized$low5[3], output$parameters$ci.unstandardized$up5[3],
                 output$parameters$ci.unstandardized$low.5[31], output$parameters$ci.unstandardized$up.5[31], 
                 output$parameters$ci.unstandardized$low2.5[31], output$parameters$ci.unstandardized$up2.5[31],
                 output$parameters$ci.unstandardized$low5[31], output$parameters$ci.unstandardized$up5[31],
                 output$parameters$ci.unstandardized$low.5[32], output$parameters$ci.unstandardized$up.5[32], 
                 output$parameters$ci.unstandardized$low2.5[32], output$parameters$ci.unstandardized$up2.5[32],
                 output$parameters$ci.unstandardized$low5[32], output$parameters$ci.unstandardized$up5[32],
                 output$parameters$ci.unstandardized$low.5[33], output$parameters$ci.unstandardized$up.5[33], 
                 output$parameters$ci.unstandardized$low2.5[33], output$parameters$ci.unstandardized$up2.5[33],
                 output$parameters$ci.unstandardized$low5[33], output$parameters$ci.unstandardized$up5[33])
  names(retvals) = c('ADI.unstd.est','ADI.unstd.se','ADI.unstd.tval','ADI.unstd.pval',
                     'NORMS.unstd.est','NORMS.unstd.se','NORMS.unstd.tval','NORMS.unstd.pval',
                     'ADINORM.unstd.est','ADINORM.unstd.se','ADINORM.unstd.tval','ADINORM.unstd.pval',
                     'SIMP_LO_N.unstd.est','SIMP_LO_N.unstd.se','SIMP_LO_N.unstd.tval','SIMP_LO_N.unstd.pval',
                     'SIMP_MED_N.unstd.est','SIMP_MED_N.unstd.se','SIMP_MED_N.unstd.tval','SIMP_MED_N.unstd.pval',
                     'SIMP_HI_N.unstd.est','SIMP_HI_N.unstd.se','SIMP_HI_N.unstd.tval','SIMP_HI_N.unstd.pval',
                     'ADI.ci.unstd.low.5','ADI.ci.unstd.up.5','ADI.ci.unstd.low2.5',
                     'ADI.ci.unstd.up2.5','ADI.ci.unstd.low5','ADI.ci.unstd.up5',
                     'NORMS.ci.unstd.low.5','NORMS.ci.unstd.up.5','NORMS.ci.unstd.low2.5',
                     'NORMS.ci.unstd.up2.5','NORMS.ci.unstd.low5','NORMS.ci.unstd.up5',
                     'ADINORM.ci.unstd.low.5','ADINORM.ci.unstd.up.5','ADINORM.ci.unstd.low2.5',
                     'ADINORM.ci.unstd.up2.5','ADINORM.ci.unstd.low5','ADINORM.ci.unstd.up5',
                     'SIMP_LO_N.ci.unstd.low.5','SIMP_LO_N.ci.unstd.up.5','SIMP_LO_N.ci.unstd.low2.5',
                     'SIMP_LO_N.ci.unstd.up2.5','SIMP_LO_N.ci.unstd.low5','SIMP_LO_N.ci.unstd.up5',
                     'SIMP_MED_N.ci.unstd.low.5','SIMP_MED_N.ci.unstd.up.5','SIMP_MED_N.ci.unstd.low2.5',
                     'SIMP_MED_N.ci.unstd.up2.5','SIMP_MED_N.ci.unstd.low5','SIMP_MED_N.ci.unstd.up5',
                     'SIMP_HI_N.ci.unstd.low.5','SIMP_HI_N.ci.unstd.up.5','SIMP_HI_N.ci.unstd.low2.5',
                     'SIMP_HI_N.ci.unstd.up2.5','SIMP_HI_N.ci.unstd.low5','SIMP_HI_N.ci.unstd.up5')
  retvals
}