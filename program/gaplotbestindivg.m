function state = gaplotbestindivg(options,state,flag)
%GAPLOTBESTF Plots the best score and the mean score.
%   STATE = GAPLOTBESTF(OPTIONS,STATE,FLAG) plots the best score as well
%   as the mean of the scores.
%
%   Example:
%    Create an options structure that will use GAPLOTBESTF
%    as the plot function
%     options = optimoptions('ga','PlotFcn',@gaplotbestf);

%   Copyright 2003-2016 The MathWorks, Inc.

if size(state.Score,2) > 1
    msg = getString(message('globaloptim:gaplotcommon:PlotFcnUnavailable','gaplotbestf'));
    title(msg,'interp','none');
    return;
end

switch flag
    case 'init'
        hold on;
        set(gca,'xlim',[0,options.MaxGenerations]);
        xlabel('Generation','interp','none');
        ylabel('Parameter value','interp','none');
        [bestScore,indexBestScore] = min(state.Score);
        bestIndiv = state.Population(indexBestScore,:);
        plotKp = plot(state.Generation,bestIndiv(1),'--^g');
        set(plotKp,'Tag','gaplotbestindivkp');
        plotKi = plot(state.Generation,bestIndiv(2),'--xr');
        set(plotKi,'Tag','gaplotbestindivki');
        plotKd = plot(state.Generation,bestIndiv(3),'--ob');
        set(plotKd,'Tag','gaplotbestindivkd');
        title(['Best: ',' Mean: '],'interp','none')
    case 'iter'
        best = min(state.Score);
        [bestScore,indexBestScore] = min(state.Score);
        bestIndiv = state.Population(indexBestScore,:);
        %m    = meanf(state.Score);
        plotKp = findobj(get(gca,'Children'),'Tag','gaplotbestindivkp');
        plotKi = findobj(get(gca,'Children'),'Tag','gaplotbestindivki');
        plotKd = findobj(get(gca,'Children'),'Tag','gaplotbestindivkd');
        newX = [get(plotKp,'Xdata') state.Generation];
        newKp = [get(plotKp,'Ydata') bestIndiv(1)];
        set(plotKp,'Xdata',newX, 'Ydata',newKp);
        newKi = [get(plotKi,'Ydata') bestIndiv(2)];
        set(plotKi,'Xdata',newX, 'Ydata',newKi);
        newKd = [get(plotKd,'Ydata') bestIndiv(3)];
        set(plotKd,'Xdata',newX, 'Ydata',newKd);
        %newY = [get(plotMean,'Ydata') m];
        %set(plotMean,'Xdata',newX, 'Ydata',newY);
        %set(get(gca,'Title'),'String',sprintf('Best: %g Mean: %g',bestIndiv,m));
        title('PID Controller Parameter');
    case 'done'
        LegnD = legend('K_p','K_i','K_d');
        set(LegnD,'FontSize',8);
        hold off;
end

%------------------------------------------------
function m = meanf(x)
nans = isnan(x);
x(nans) = 0;
n = sum(~nans);
n(n==0) = NaN; % prevent divideByZero warnings
% Sum up non-NaNs, and divide by the number of non-NaNs.
m = sum(x) ./ n;

