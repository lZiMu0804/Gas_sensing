%%
clc;clear all;close all;
%% Initialize the population
d = 11;        %space dimension
N = 20;        %the number of initial populations
ger = 25;      %maximum number of iterations
limit = [2,20;4,32;0.5,13.5;1,9.5;1,7;3,17;0.1,1;10,30;10,100;2,20;1,7;];% set positional parameter range limits 
vlimit = [-1,1;-1,1;-1,1;-1,1;-1,1;-1,1;-1,1;-1,1;-1,1;-1,1;-1,1;];% set speed limit
w = 0.8;                       % inertia weight
c1 = 0.1;                       % self-learning factor
c2 = 0.1;                       % group-learning factor 
%% Invoke HFSS
hfssExePath = '"D:\Program Files\AnsysEM\AnsysEM19.1\Win64\ansysedt.exe"';  %HFSS path
scriptPath = 'D:\Git_project\Gas_sensing\code\ooopso\script\Stript';      %script path
%% Generate initial files
if ~exist('.\result','dir')  
    mkdir('.\result');
end
if ~exist('.\script','dir')
    mkdir('.\script');
end
if ~exist('.\array','dir')
    mkdir('.\array');
end
if ~exist('.\parameter','dir')
    mkdir('.\parameter');
end
if ~exist(['.\array\array' num2str(N) '.hfss'],'file')
    testcopyArray(N);
end

%% The location of the initial population
x = testinitpop(d,N,limit);
x=x';
x(1,1)=11;
x(1,2)=17.9;
x(1,3)=6.9;
x(1,4)=5.75;
x(1,5)=4.2;
x(1,6)=10.5;
x(1,7)=0.2;
x(1,8)=20;
x(1,9)=25.6;
x(1,10)=7.6;
x(1,11)=3.2;

v = roundn(rand(N,d),-1);        % speed initialization
xm = x;                          % the historical best position for each individual
ym = zeros(1, d);                % the historical best position of the population
fxm = 1./zeros(N, 1);            % the historical best fitness of each individual
fym = inf;                       % population history best fitness ----initial positive infinity
iter = 1;                        % number of iterations
%record = zeros(ger, 1);
convergence=[];
while iter <= ger+1
%     scriptPath='F:\data\HFSS_matlab\testpso\'
%     testmakeScript(scriptPath);                                                                                       %打开HFSS  fx即为返回结果值

    fx = testcalfit(x,iter,hfssExePath,scriptPath);                                                                    %打开HFSS  fx即为返回结果值
   % convergence=[convergence min(fx)];
    fx = fx';
    for l = 1:N     
        if fxm(l) > fx(l)
            fxm(l) = fx(l);     % update the best fitness of individual history
            xm(l,:) = x(l,:);   % update individual historical best position
        end
    end
    if fym > min(fxm)
        [fym, nmin] = min(fxm);   % update the historical best fitness of the group
        ym = xm(nmin, :);         % update group historical best position
    end
    convergence=[convergence fym];
    v = roundn(v * w + c1 * rand *(xm - x) + c2 * rand *(repmat(ym, N, 1) - x),-1);
    %roundn 四舍五入函数
    % Boundary Velocity Handling
    for l=1:d                      %速度边界（-1，1）
        for j=1:N
        if  v(j,l)>vlimit(l,2)
            v(j,l)=vlimit(l,2);
        end
        if  v(j,l) < vlimit(l,1)
            v(j,l)=vlimit(l,1);
        end
        end
    end      
   x = roundn(x + v,-1);% location update
   for l=1:d
        for j=1:N
        if  x(j,l)>limit(l,2)
            x(j,l)=limit(l,2);
        end
        if  x(j,l) < limit(l,1)
            x(j,l)=limit(l,1);
        end
        end
   end 
    fprintf('%fiteration\n',iter);
%     record(iter) = fym;% Maximum record
    fname = ['.\result\convergence'  num2str(iter)];
    save([fname '.mat'], 'convergence');
    iter = iter+1;
end
plot(convergence);
disp(['max value',num2str(fym)]);
disp(['variable value',num2str(ym)]);
%fname = '.\result\convergence';
%save([fname '.mat'], 'convergence');


