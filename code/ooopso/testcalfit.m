function [ value ] = testcalfit(pop ,index,hfssExePath,scriptPath)  %Define the function calfit, the parameters are pop, index, hfssexepath, scriptpath, the return value is value
%CALFIT Calculate fitness
[py,~] = size(pop);
path = [pwd '/result/'];      %Find the result folder
if index<10
    path = [path '0' num2str(index) ];  %Add folder 0 to the current directory
else
    path = [path num2str(index)];
end
if ~exist(path,'dir')
    mkdir(path)
end
value(1:py) = inf;
for i = 1:py 
    pop(i,7)=0.2;pop(i,8)=20;
    pop1 = pop(i,:)
        if ((pop1(1)+2*pop1(11)+pop1(3)+pop1(4)+2*pop1(10)<50)&&(pop1(5)<pop1(6))&&(pop1(1)+pop1(11)>pop1(6)))
            testmakeScript(pop1(1,:),i,index,scriptPath);  %Calculate the corresponding function value计算响应函数值
            ScriptFile = [scriptPath num2str(i) '.vbs'];  %stored in the corresponding file
            hfssExecute(hfssExePath,ScriptFile,true,true);
            pause(3);
            value(i)= testgetData(i,index,pop1(1,:));
        else
            continue;
        end
end
if index<10
    fname = ['.\result\United0'  num2str(index)];
else
    fname = ['.\result\United'  num2str(index)];
end
[~,a] = size(pop);
pop(:,a+2) = value;
save([fname '.mat'], 'pop');
end

