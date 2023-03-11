# **MTwiNS_Neighborhood_Social_Processes**

## *The Impact of Neighborhood Disadvantage on Amygdala Reactivity: Pathways Through Neighborhood Social Processes*

The content here is for a manuscript by Suarez et al. (2022), which can be found at <https://doi.org/10.1016/j.dcn.2022.101061>. The project examined associations between neighborhood disadvantage (measured using the Area Deprivation Index; ADI), neighborhood social processes (i.e., collective efficacy and neighborhood norms) and amygdala reactivity to socioemotional faces of threat and ambiguity. To address the study aims multiple regression models were estimated using `Neuropointillist` (Madhyastha et al., 2018; <http://ibic.github.io/neuropointillist/>) in conjunction with the `Mplus Automation` package in R (Hallquist & Wiley, 2018). 

This project is in collaboration with Professors, Dr. Luke Hyde, from the University of Michigan, Drs. S. Alexandra Burt and Kelly Klump, from Michigan State University, and Dr. Arianna Gard, from the University of Maryland along with Dr. David A. Clark from Michigan State University and Jared Burton from the University of Michigan.

This project is comprised of two stages: Stage 1 (Registered Report) and Stage 2 (Analysis). Stage 1 is preregistered on the Open Science Framework at: <https://osf.io/kxpft>

# **Stage 1 Registered Report**

The Stage 1 folder contains two files: 

- Manuscript: (*DCN-D-20-00147-Stage-1-IPA.pdf*) This is the initial version of the manuscript that covers the Abstract, Introduction, Methods, and Experimental Design and Statistical Approach, which received an in-principle acceptance at Developmental Cognitive Neuroscience in 2021.
- Code: This is the R Markdown code (and .html output) used to compute descriptive statistics and figures for the Methods section of the manuscript

# **Stage 2 Analysis**

The Stage 2 folder includes a shell script to run Neuropointillist and an R script to write the output files.

 - `run_neuropoint.sh`: This shell script to run an instance of Neuropointillist. User must point the script to the specific data directory that contains the files needed to run Neuropointillist.
 - `write_neuropoint_mplus_output.R`: This code writes the output from Neuropointillist into a ‘.nii.gz’ file.

The Stage 2 folder also includes 10 folders that contain the required code and files for each individual analysis.

 1. *Neutral_ADI*: Neighborhood disadvantage predicting amygdala reactivity to ambiguity (neutral > shapes)
 2. *Neutral_CollectiveEfficacy*: Collective efficacy predicting amygdala reactivity to ambiguity (neutral > shapes)
 3. *Neutral_CollectiveEfficacy_Moderation*: The interaction between neighborhood disadvantage and collective efficacy predicting amygdala reactivity to ambiguity (neutral > shapes)
 4. *Neutral_Norms*: Neighborhood norms predicting amygdala reactivity to ambiguity (neutral > shapes)
 5. *Neutral_Norms_Moderation*: The interaction between neighborhood disadvantage & norms predicting amygdala reactivity to ambiguity (neutral > shapes)
 6. *Threat_ADI*: Neighborhood disadvantage predicting amygdala reactivity to threat (fearful + angry faces > shapes)
 7. *Threat_CollectiveEfficacy*: Collective efficacy predicting amygdala reactivity to threat (fearful + angry faces > shapes)
 8. *Threat_CollectiveEfficacy_Moderation*: The interaction between neighborhood disadvantage and collective efficacy predicting amygdala reactivity to threat (fearful + angry faces > shapes)
 9. *Threat_Norms*: Neighborhood norms predicting amygdala reactivity to threat (fearful + angry faces > shapes)
 10. *Threat_Norms_moderation*: The interaction between neighborhood disadvantage and norms predicting amygdala reactivity to threat (fearful + angry faces > shapes)

Each folder contains the 5 following files:

 - *A contrast TXT file*: **con_0015.txt** or **con_0009.txt** 
    - This text file contains the file path pointing to the contrast image for each subject included in the analysis; con_0009.txt is for the contrast fearful + angry faces > shapes (threat) and con_0015.txt is for the contrast neutral > shapes.
 - `mplus_input_template.txt`*: **Mplus Input Template File** 
    - This text file contain the Mplus code to run the statistical model. Mplus Automation takes this template file and creates an input file for each voxel in the amygdala (468 voxels/input files).
 - `mplus_model.R`: 
    - This script defines the `processVoxel(v)` function that takes as an argument a voxel number, `v`. The code also returns a `list` structure that contains the values that you want to write out as files.
 - `rAAL_BiAAmy_PickAtlas.nii`: 
    - A bilateral amygdala region of interest (ROI) mask defined structurally using the AAL Atlas definition in the WFU PickAtlas Tool, version 1.04 (Maldjian et al., 2003) 
 - `readargs.R`: 
    - This code sets a vector called `cmdargs`, which will be read to obtain the required arguments for the `npoint` function. 
