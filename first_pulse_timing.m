
bins = linspace(-400,500,25);

%%

pulse_char = pulse([ 1 2 5]);
pulse_cta = pulse( [ 3  4] );
charCells = pulse_char.getCells;
ctaCells = pulse_cta.getCells;

%%

f = pulse_char.get_first_fit;

firstChar = [f{:}];
firstCharApical = [f{[charCells.label]}];
firstCharBasal = [f{~[charCells.label]}];

subplot(2,1,1)
plot_pdf([firstCharApical.center],bins,'r-');
hold on
vline(mean([firstCharApical.center]),'r--')
plot_pdf([firstCharBasal.center],bins,'c-');
vline(mean([firstCharBasal.center]),'c--')
xlabel('Timing of first pulse (sec)')
ylabel('PDF')
title('char-RNAi')
xlim([-250 350])

[h,p] = kstest2([firstCharApical.center],[firstCharBasal.center])

f = pulse_cta.get_first_fit;

firstCta = [f{:}];
firstCtaApical = [f{[ctaCells.label]}];
firstCtaBasal = [f{~[ctaCells.label]}];

subplot(2,1,2)
plot_pdf([firstCtaApical.center],bins,'r-');
hold on
vline(mean([firstCtaApical.center]),'r--')
plot_pdf([firstCtaBasal.center],bins,'c-');
vline(mean([firstCtaBasal.center]),'c--')
xlabel('Timing of first pulse (sec)')
ylabel('PDF')
title('cta')
xlim([-250 350])

[h,p] = kstest2([firstCtaApical.center],[firstCtaBasal.center])

%% Scatter plot first pulse v. first area

Achar = cat(2,pulse_char.getCells.area);
Acta = cat(2,pulse_cta.getCells.area);

firstCharArea = find_first_non_nan(Achar');
firstCtaArea = find_first_non_nan(Acta');

% nan(1,num_cells(1)),...
firstCharArea = cat(2, ...
    nanmean( Achar(1,[charCells.embryoID] == 1),1), ...
    nanmean( Achar(1:14,[charCells.embryoID] == 2)), ...
    nanmean( Achar(1:3,[charCells.embryoID] == 5)) );

firstCtaArea = cat(2,...
    nanmean( Acta(1:30,[ctaCells.embryoID] == 3) ), ...
    nanmean( Acta(1:24,[ctaCells.embryoID] == 4) ) );

f = pulse_char.get_first_fit;
I = ~cellfun(@isempty,f) & ~isnan(firstCharArea);
f = [f{I}]; f = [f.center];

subplot(2,1,1)
[r,p] = corrcoef(firstCharArea(I)',f','spearman')
[p,errorS] = polyfit(firstCharArea(I)',f',1)
x = linspace(0,100,100);
[yhat,delta] = polyval(p,x,errorS);
% shadedErrorBar(x,yhat,delta,'b',1); hold on
scatter(firstCharArea(I),f,'b');hold on
plot(x,yhat,'b');
xlabel('First detected apical area (\mum^2)')
ylabel('Timing of first pulse (sec)')
title('char-RNAi')

f = pulse_cta.get_first_fit;
I = ~cellfun(@isempty,f) & ~isnan(firstCtaArea);
f = [f{I}]; f = [f.center];

subplot(2,1,2)
[r,p] = corrcoef(firstCtaArea(I)',f','spearman')
[p,errorS] = polyfit(firstCtaArea(I)',f',1)
x = linspace(0,100,100);
[yhat,delta] = polyval(p,x,errorS); hold on
% shadedErrorBar(x,yhat,delta,'r',1);hold on
scatter(firstCtaArea(I),f,'r','filled');
plot(x,yhat,'r');
xlabel('First detected apical area (\mum^2)')
ylabel('Timing of first pulse (sec)')
title('cta')


