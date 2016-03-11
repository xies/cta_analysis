%% Figure 2 e-g Pulsing characteristics of cta pulses

% Need: pulse_cta
pulseOI = pulse([3 4 6]);
c = pulseOI.getCells;

%% e: pulse frequency
bins = linspace(0,250,30);


[freq_const,~] = pulseOI.get_frequency(c([c.label] == 1));
[freq_exp,~] = pulseOI.get_frequency(c([c.label] == 2));

plot_pdf([freq_const{:}],bins,'r-');
hold on
plot_pdf([freq_exp{:}],bins,'c-');
vline(nanmean([freq_const{:}]),'r--')
vline(nanmean([freq_exp{:}]),'c--')

xlabel('Interval between pulses (s)')
ylabel('PDF')
legend('Constricting','Expanding')

[~,p] = ttest2([freq_const{:}],[freq_exp{:}])
[~,p] = kstest2([freq_const{:}],[freq_exp{:}])

%% f: pulse amplitude
bins = linspace(0,5e3,30);

f_const = pulseOI.find_fits_from_cell(c([c.label] == 1));
f_exp = pulseOI.find_fits_from_cell(c([c.label] == 2));

plot_pdf([f_const.amplitude],bins,'r-');
hold on
plot_pdf([f_exp.amplitude],bins,'c-');
vline(nanmean([f_const.amplitude]),'r--');
vline(nanmean([f_exp.amplitude]),'c--');

xlabel('Pulse amplitude (a.u.)')
ylabel('PDF')
legend('Constricting','Expanding')

[~,p] = ttest2([f_const.amplitude],[f_exp.amplitude],'>')
[~,p] = kstest2([f_const.amplitude],[f_exp.amplitude],'tail','larger')

%% g: pulse initiation
bins = linspace(-100, 500, 25);

f_init_const = pulseOI.get_first_fit(c([c.label] == 1));
f_init_const = [f_init_const{:}];
f_init_exp = pulseOI.get_first_fit(c([c.label] == 2));
f_init_exp = [f_init_exp{:}];

plot_pdf([f_init_const.center],bins,'r-');
hold on
plot_pdf([f_init_exp.center],bins,'c-');
vline(nanmean([f_init_const.center]),'r--');
vline(nanmean([f_init_exp.center]),'c--');
xlim([-100 500])

xlabel('Timing of first pulse (s)');
ylabel('PDF')
legend('Constricting','Expanding')

[~,p] = ttest2([f_init_const.center],[f_init_exp.center])
[~,p] = kstest2([f_init_const.center],[f_init_exp.center])


