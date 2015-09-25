
bins = linspace(-400,500,25);

%%

pulse_char = pulse([ 1 2 5 ]);
pulse_cta = pulse( [ 3 4 ] );

%%

charCells = pulse_char.getCells;
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

ctaCells = pulse_cta.getCells;
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

f = pulse_char.get_first_fit;
I = ~cellfun(@isempty,f);
f = [f{I}]; f = [f.center];

% subplot(2,1,1)
scatter(firstCharArea(I),f),hold on
[r,p] = corrcoef(firstCharArea(I)',f')
p = polyfit(firstCharArea(I)',f',1)
x = linspace(0,100,100); plot(x,polyval(p,x),'b');
xlabel('First detected apical area (\mum^2)')
ylabel('Timing of first pulse (sec)')
title('char-RNAi')

f = pulse_cta.get_first_fit;
I = ~cellfun(@isempty,f);
f = [f{I}]; f = [f.center];

% subplot(2,1,2)
scatter(firstCtaArea(I),f,'r','filled'),hold on
[r,p] = corrcoef(firstCtaArea(I)',f')
p = polyfit(firstCtaArea(I)',f',1)
x = linspace(0,100,100); plot(x,polyval(p,x),'r');
xlabel('First detected apical area (\mum^2)')
ylabel('Timing of first pulse (sec)')
title('cta')

