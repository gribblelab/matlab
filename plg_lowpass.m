function newdata = plg_lowpass(data,samprate,cutoff,order)

% newdata = plg_lowpass(data,samprate,cutoff,order)
%
% performs a lowpass filtering of the input data
% using an nth order zero phase lag butterworth filter
%
% given -> data (data)
%	-> samprate (Hz)
%	-> cutoff freq (Hz)
%	-> order of filter
%
% returns -> filtered data

if nargin==3 order=2; end;

[B,A] = butter(order,cutoff/(samprate/2),'low');

newdata = filtfilt(B,A,data);
