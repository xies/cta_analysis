%%

fitsCharApical = fits.get_stackID([charApical.stackID]);
fitsCharBasal = fits.get_stackID([charBasal.stackID]);
fitsCtaApical = fits.get_stackID([ctaApical.stackID]);
fitsCtaBasal = fits.get_stackID([ctaBasal.stackID]);

%% Pulse behavior

NcharApical = hist([fitsCharApical.cluster_label],1:4);
NcharBasal = hist([fitsCharBasal.cluster_label],1:4);
NctaApical = hist([fitsCtaApical.cluster_label],1:4);
NctaBasal = hist([fitsCtaBasal.cluster_label],1:4);

N = cat(1,NcharApical,NcharBasal,NctaApical,NctaBasal);
bar(1:4,bsxfun(@rdivide,N,sum(N,2)),'stacked')
set(gca,'XTickLabel', ...
    {'char - Apical','char - Basal','cta - Apical','cta - Basal'});

%% Myosin persistence

MPcharApical = fitsCharApical.get_myosin_persistence;
MPcharBasal = fitsCharBasal.get_myosin_persistence;
MPctaApical = fitsCtaApical.get_myosin_persistence;
MPctaBasal = fitsCtaBasal.get_myosin_persistence;

[X,G] = make_boxplot_args( ...
    MPcharApical, MPcharBasal, MPctaApical, MPctaBasal, ...
    {'char - Apical','char - Basal','cta - Apical','cta - Basal'} );
boxplot(X,G);

[h,p] = ttest2(MPctaApical,MPctaBasal)

%% First pulse timing

f = charApical.get_first_fit(fits);
firstCharApical = [f{:}];
f = charBasal.get_first_fit(fits);
firstCharBasal = [f{:}];
f = ctaApical.get_first_fit(fits);
firstCtaApical = [f{:}];
f = ctaBasal.get_first_fit(fits);
firstCtaBasal = [f{:}];

bins = linspace(-200,600,20);
subplot(2,1,1), 
plot_pdf( [firstCharApical.center],bins,'r-'); hold on
plot_pdf( [firstCharBasal.center],bins,'b-'); title('char-RNAi');
[h,p] = kstest2([firstCharBasal.center],[firstCharApical.center])

subplot(2,1,2), 
plot_pdf( [firstCtaApical.center],bins,'r-'); hold on
plot_pdf( [firstCtaBasal.center],bins,'b-');title('cta');
xlabel('Dev. time (sec)'); ylabel('PDF')
legend('Apical nuclei','Basal nuclei')
[h,p] = kstest2([firstCtaBasal.center],[firstCtaApical.center])

%% Pulse frequency

[freqCharApical, centerCharApical] = charApical.get_frequency(fits);
[freqCharBasal, centerCharBasal] = charBasal.get_frequency(fits);
[freqCtaApical, centerCtaApical] = ctaApical.get_frequency(fits);
[freqCtaBasal, centerCtaBasal] = ctaBasal.get_frequency(fits);

bins = linspace(0,200,20);
subplot(2,1,1), title('char-RNAi');
plot_pdf( [freqCharApical{:}],bins,'r-'); hold on
plot_pdf( [freqCharBasal{:}],bins,'b-');
[h,p] = kstest2([freqCharApical{:}],[freqCharBasal{:}])

subplot(2,1,2), title('cta');
plot_pdf( [freqCtaApical{:}],bins,'r-'); hold on
plot_pdf( [freqCtaBasal{:}],bins,'b-');
xlabel('Pulse interval (sec)'); ylabel('PDF')
legend('Apical nuclei','Basal nuclei')
[h,p] = kstest2([freqCtaApical{:}],[freqCtaBasal{:}])
