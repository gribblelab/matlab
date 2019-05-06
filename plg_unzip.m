% ------------------------------------------------------------------------
% plg_unzip:    - issues a system call to unix's built-in
%                 /usr/bin/unzip to unzip a KINARM .zip archive
%                 to a given directory unzipToName
%               - used by plg_zip_load.m
%               - by Paul Gribble, April 15 2019
% ------------------------------------------------------------------------

function [status, cmdput] = plg_unzip(zipfile, unzipToName)

% escape the space character and the round brackets
% so that we can handle my crazy-named dropbox directory
zipfile2 = strrep(zipfile,' ','\ ');
zipfile2 = strrep(zipfile2,'(','\(');
zipfile2 = strrep(zipfile2,')','\)');

cmd = char(strcat({'/usr/bin/unzip -q '},zipfile2,{' -d '},unzipToName));
[status, cmdout] = system(cmd);

end