function hmri_local_defaults
% PURPOSE
% To set user-defined (site- or protocol-specific) defaults parameters
% which are used by the hMRI toolbox. Customized processing parameters can
% be defined, overwriting defaults from hmri_defaults. Acquisition
% protocols can be specified here as a fallback solution when no metadata
% are available. Note that the use of metadata is strongly recommended. 
%
% RECOMMENDATIONS
% Parameters defined in this file are identical, initially, to the ones
% defined in hmri_defaults.m. It is recommended, when modifying this file,
% to remove all unchanged entries and save the file with a meaningful name.
% This will help you identifying the appropriate defaults to be used for
% each protocol, and will improve the readability of the file by pointing
% to the modified parameters only.
%
% WARNING
% Modification of the defaults parameters may impair the integrity of the
% toolbox, leading to unexpected behaviour. ONLY RECOMMENDED FOR ADVANCED
% USERS - i.e. who have a good knowledge of the underlying algorithms and
% implementation. The SAME SET OF DEFAULT PARAMETERS must be used to
% process uniformly all the data from a given study. 
%
% HOW DOES IT WORK?
% The modified defaults file can be selected using the "Configure toolbox"
% branch of the hMRI-Toolbox. For customization of B1 processing
% parameters, type "help hmri_b1_standard_defaults.m". 
%
% DOCUMENTATION
% A brief description of each parameter is provided together with
% guidelines and recommendations to modify these parameters. With few
% exceptions, parameters should ONLY be MODIFIED and customized BY ADVANCED
% USERS, having a good knowledge of the underlying algorithms and
% implementation. 
% Please refer to the documentation in the github WIKI for more details. 
%__________________________________________________________________________
% Written by E. Balteau, 2017.
% Cyclotron Research Centre, University of Liege, Belgium

% Global hmri_def variable used across the whole toolbox
global hmri_def

hmri_def.precoreg = 1; % for tMPPCA denoised maps: precoreg = 1: skip coreg for PD, MT and T1 maps because maps are already coregistered

%==========================================================================
% R1/PD/R2s/MT map creation parameters
%==========================================================================

% Choose method of R2* fitting; this is a trade-off between speed and
% accuracy.
% - 'OLS' (classic ESTATICS ordinary least squares model; fast but not as 
%         accurate as WLS1)
% - 'WLS1' (weighted least squares with one iteration; slower than OLS but 
%          significantly more accurate. Uses parallelization over voxels to 
%          speed up calculation)
% - 'WLS2', 'WLS3' (weighted least squares with 2 or 3 iterations; did not
%                   show great improvement over WLS1 in test data)
% - 'NLLS_OLS', 'NLLS_WLS1' (nonlinear least squares using either OLS or
%                            WLS1 to provide the initial parameter
%                            estimates; very slow, even with
%                            parallelization over voxels. Recommend WLS1
%                            instead)
hmri_def.R2s_fit_method = 'WLS1';

%--------------------------------------------------------------------------
% quantitative maps: quality evaluation and realignment to MNI
%--------------------------------------------------------------------------
% creates a matlab structure containing markers of data quality
hmri_def.qMRI_maps.QA          = 0; 
end