function newdata = plg_highpass(data,samprate,cutoff,order)

% newdata = plg_highpass(data,samprate,cutoff,order)
%
% performs a highpass filtering of the input data
% using an nth order zero phase lag butterworth filter
%
% given -> data (data)
%	-> samprate (Hz)
%	-> cutoff freq (Hz)
%	-> order of filter
%
% returns -> filtered data

if nargin==3 order=2; end;

[B,A] = butter(order,cutoff/(samprate/2),'high');

newdata = filtfilt(B,A,data);
