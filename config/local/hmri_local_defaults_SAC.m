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


%==========================================================================
% R1/PD/R2s/MT map creation parameters
%==========================================================================

%--------------------------------------------------------------------------
% Coregistration of all input images to the average (or TE=0 fit) PDw image
%--------------------------------------------------------------------------
% The coregistration step can be disabled using the following flag (not
% recommended). ADVANCED USER ONLY. 
hmri_def.coreg2PDw = 1*0; 


%--------------------------------------------------------------------------
% Ordinary Least Squares & fit at TE=0
%--------------------------------------------------------------------------
% Create a Least Squares R2* map. The ESTATICS model is applied
% to calculate a common R2* map from all available contrasts. 
% ADVANCED USER ONLY.
hmri_def.R2sOLS = true; 

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
hmri_def.R2s_fit_method = 'OLS';

%--------------------------------------------------------------------------
% Threshold values for qMRI maps
% The thresholds are meant to discard outliers generally due to low SNR in
% some brain areas, leading to physical non-sense values. Thresholding is
% required to process further the maps generated, when e.g. used
% segmentation algorithms make assumptions incompatible with existing
% outliers.
% NOTE that thresholding modifies the signal distribution and may alter
% the statistical results.
% ADVANCED USER ONLY.
%--------------------------------------------------------------------------
hmri_def.qMRI_maps_thresh.R1       = 2000*10; % 1000*[s-1]
hmri_def.qMRI_maps_thresh.A        = 10^10; % [a.u.] based on input images with intensities ranging approx. [0 4096].
hmri_def.qMRI_maps_thresh.R2s      = 10;   % 1000*[s-1]
hmri_def.qMRI_maps_thresh.MTR      = 50*10;
hmri_def.qMRI_maps_thresh.MTR_synt = 50*10;
hmri_def.qMRI_maps_thresh.MT       = 5*10;    % [p.u.]

end
