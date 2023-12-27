function hfssExecute(hfssExePath, ScriptFile, iconMode, runAndExit)
%iconMode If set to false, HFSS will run in normal mode, otherwise it will run in "iconified" mode
%runAndExitIf set to true, HFSS will run the given script, if set to false, HFSS will run and write the script

%iconMode如果设置为false，HFSS将以正常模式运行，否则将以“图标化”模式运行
%runAndExit如果设置为true，HFSS将运行给定的脚本，如果设置为false，HFSS会运行并写入脚本
if (nargin < 2)     %nargin,Determine the number of input variables
    error('Insufficient number of arguments !');
elseif (nargin < 3)
    iconMode = [];
    runAndExit = [];
end
if isempty(iconMode)
    iconMode = true;
end
if isempty(runAndExit)
    runAndExit = true;
end
if (iconMode == true)
    iconStr = '/Iconic';
else
    iconStr = '';
end
% Setup Run and Exit Mode.
if (runAndExit)
     runStr = '/RunScriptAndExit';
%     runStr = '/RunScript';

else
    runStr = '/RunScript';
end
% Create the Command Path.
cmdHFSS = [hfssExePath, ' ', iconStr, ' ', runStr, ' ' ,  ScriptFile];
% cmdHFSS=ScriptFile;
% Execute the Command.
fprintf('    Running HFSS using %s ...\n\n', cmdHFSS);
[Status, ~] = system(cmdHFSS);     %%运行HFSS
if (Status ~= 0)
    warning('HFSS Execution returned an error status !');
end
