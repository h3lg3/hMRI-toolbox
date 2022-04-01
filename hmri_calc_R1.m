% Calculate R1 map from PDw and T1w data.
% 
% Input:
%   PDw and T1w are structs with the fields:
%     {PDw,T1w}.data (array of signals)
%     {PDw,T1w}.fa   (nominal flip angle, rad)
%     {PDw,T1w}.TR   (repetition time, s or ms)
%     {PDw,T1w}.B1   (the ratio: actual fa / nominal fa)
%
%   small_angle_approx (bool which determines whether to use the small
%     angle approximation [true] or to use a more exact formula [false])
%
% Output:
%   R1 (in reciprocal of TR units)

function R1=hmri_calc_R1(PDw,T1w,small_angle_approx)

if isempty(PDw.B1), PDw.B1=1; end
if isempty(T1w.B1), T1w.B1=1; end

if ~small_angle_approx
    PDw.t=2*tan(PDw.B1.*PDw.fa/2);
    T1w.t=2*tan(T1w.B1.*T1w.fa/2);
else    
    PDw.t=PDw.B1.*PDw.fa;
    T1w.t=T1w.B1.*T1w.fa;
end

assert(all(size(PDw.data)==size(T1w.data)),'hmri:inputArraySize','PDw.data and T1w.data must be the same size!')
assert(PDw.TR>0,'hmri:TR','PDw.TR must be positive!')
assert(T1w.TR>0,'hmri:TR','T1w.TR must be positive!')

R1=0.5*( PDw.data.*PDw.t/PDw.TR - T1w.data.*T1w.t/T1w.TR )...
    ./( T1w.data./T1w.t - PDw.data./PDw.t );

% Make data points with missing data NaN
nanmask=(T1w.data==0)|(PDw.data==0)|(T1w.t==0)|(PDw.t==0);
R1(nanmask)=NaN;

end