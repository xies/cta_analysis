%% Figure 1 f-g KDE of apical area v. time

% Need: embryo_stack containing cta
pulseOI = pulse_cta;

find_first = @(t) t < -150;

%% cta initial area

initialArea = cell(1,numel(pulseOI));
for i = 1:numel(pulseOI)
    
    c = pulseOI.getCells;
    A = cat(2,c.area_sm);
    T = cat(2,c.dev_time)';
    
    A( ~find_first(T) ) = NaN;
    
    initialArea{i} = nanmean(A);
    
end

initialArea = [initialArea{:}];

%% Generate plot

area_bins = linspace(15,75,20);

c = pulseOI.getCells;
plot_pdf(initialArea([c.label] == 1),area_bins,'r-');
hold on
plot_pdf(initialArea([c.label] == 2),area_bins,'c-');
vline(nanmean(initialArea([c.label] == 1)),'r--');
vline(nanmean(initialArea([c.label] == 2)),'c--');
xlim([10 75])

xlabel('Initial apical area (\mum^2)')
ylabel('PDF')
legend('Constricting','Expanding');

display('---')
display('T-test:')
[~,p] = ttest2(initialArea([c.label] == 1),initialArea([c.label] == 2))
display('KS-test:')
[~,p] = kstest2(initialArea([c.label] == 1),initialArea([c.label] == 2))