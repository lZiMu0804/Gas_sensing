function [] = testmakeScript(d,num,index,scriptPath)  
% scriptPath='F:\data\HFSS_matlab\testpso\'
% ScriptFile = [scriptPath  'test2.vbs'];  %create script ScriptFile
stind = num2str(index);
stnum = num2str(num);  
ScriptFile = [scriptPath stnum '.vbs'];  %create script ScriptFile
fid = fopen(ScriptFile,'wt'); %open ScriptFile and write as text document
% fid = fopen('Size.txt', 'wt');%会在当前文件夹下生成ax-model3.txt文件

%% HFSS脚本头文件
fprintf(fid, 'Dim oAnsoftApp\n');
fprintf(fid, 'Dim oDesktop\n');
fprintf(fid, 'Dim oProject\n');
fprintf(fid, 'Dim oDesign\n');
fprintf(fid, 'Dim oEditor\n');
fprintf(fid, 'Dim oModule\n');
fprintf(fid, '\n');
fprintf(fid, 'Set oAnsoftApp = CreateObject("AnsoftHfss.HfssScriptInterface")\n');
fprintf(fid, 'Set oDesktop = oAnsoftApp.GetAppDesktop()\n');
fprintf(fid, 'oDesktop.RestoreWindow\n');
fprintf(fid, 'oDesktop.OpenProject "%s"\n', [ 'D:\delete\raderpso\ooopso\array\array' stnum '.aedt']);%program name list
fprintf(fid, ['Set oProject = oDesktop.SetActiveProject("array' stnum '")\n']);
fprintf(fid, 'Set oDesign = oProject.SetActiveDesign("ultra")\n');
fprintf(fid, '  \n');
%% ChangeProperty
% [px,~] = size(d);
% d(1:px) = roundn(d(1:px)*7.8+0.1,-1)+0.1;
fprintf(fid, 'Set oModule = oDesign.GetModule("ReportSetup")\n');
fprintf(fid, 'oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _\n');
fprintf(fid, '  "LocalVariables"), Array("NAME:ChangedProps"');
 for i=1:4
     fprintf(fid, [', Array("NAME:l' num2str(i) '", "Value:=", "' num2str(d(i)) 'mm")']);
 end
fprintf(fid, [', Array("NAME:P", "Value:=", "' num2str(d(5)) 'mm")']);
fprintf(fid, [', Array("NAME:R1", "Value:=", "' num2str(d(6)) 'mm")']);
fprintf(fid, [', Array("NAME:v", "Value:=", "' num2str(d(7)) 'mm")']);
fprintf(fid, [', Array("NAME:ph", "Value:=", "' num2str(d(8)) 'deg")']);
fprintf(fid, [', Array("NAME:tH", "Value:=", "' num2str(d(9)) 'deg")']);
fprintf(fid, [', Array("NAME:R2", "Value:=", "' num2str(d(10)) 'mm")']);
fprintf(fid, [', Array("NAME:Q", "Value:=", "' num2str(d(11)) 'mm")']);
fprintf(fid, ')))\n');
fprintf(fid, '  \n');
%% 运行仿真
fprintf(fid, 'oDesign.AnalyzeAllNominal\n');           %run the program
% 

%% Z11输出
fprintf(fid, 'Set oModule = oDesign.GetModule("ReportSetup")\n');
fprintf(fid, 'oModule.CreateReport "Z Parameter Plot 1", "Modal Solution Data",  _\n');
fprintf(fid, '  "Rectangular Plot", "Setup1 : Sweep", Array("Domain:=", "Sweep"), Array("Freq:=", Array( _\n');
fprintf(fid, '  "All"), "W:=", Array("Nominal"), "h1:=", Array("Nominal"), "l1:=", Array( _\n');
fprintf(fid, '  "Nominal"), "l2:=", Array("Nominal"), "l3:=", Array("Nominal"), "l4:=", Array( _\n');
fprintf(fid, '  "Nominal"), "l7:=", Array("Nominal"), "H:=", Array("Nominal"), "P:=", Array( _\n');
fprintf(fid, '  "Nominal"), "RRR:=", Array("Nominal"), "th:=", Array("Nominal"), "v:=", Array( _\n');
fprintf(fid, '  "Nominal"), "ph:=", Array("Nominal"), "Q:=", Array("Nominal"), "yuan:=", Array( _\n');
fprintf(fid, '  "Nominal"), "l8:=", Array("Nominal"), "h2:=", Array("Nominal"), "$E:=", Array( _\n');
fprintf(fid, '  "Nominal"), "$Z:=", Array("Nominal")), Array("X Component:=", "Freq", "Y Component:=", Array( _\n');
fprintf(fid, '  "re(Z(1,1))", "im(Z(1,1))")), Array()\n');
dir = strrep(pwd,'\','/');
fprintf(fid,['oModule.ExportToFile "Z Parameter Plot 1",  _\n"' dir '/result/']);
if index<10       %the result is output as .csv
    fprintf(fid, ['0' stind '/Z110' stind stnum '.csv"\n']);
else
    fprintf(fid, [stind '/Z11' stind stnum '.csv"\n']);
end
fclose(fid);
% end
end
