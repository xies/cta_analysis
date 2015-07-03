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

bins = linspace(-200,200,20);
subplot(2,1,1), title('char-RNAi');
plot_cdf( [firstCharApical.center],bins,'r-'); hold on
plot_cdf( [firstCharBasal.center],bins,'b-');
[h,p] = kstest2([firstCharBasal.center],[firstCharApical.center])

subplot(2,1,2), title('cta');
plot_cdf( [firstCtaApical.center],bins,'r-'); hold on
plot_cdf( [firstCtaBasal.center],bins,'b-');
[h,p] = kstest2([firstCtaBasal.center],[firstCtaApical.center])
