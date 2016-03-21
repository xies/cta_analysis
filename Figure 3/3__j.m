%% Figure 3j

Abins = linspace(0,100,15 );
find_initial = @(t) (t < -150 & t > -500);

A = cell(1,3);
for i = 1:3
    c = pulse_cta(i).getCells;
    t = c(1).dev_time;
    I = find_initial(t);
    A{i} = cat(2,c.area_sm);
    A{i} = nanmean(A{i}(I,:));
end
A_cta = [A{:}];

A = cell(1,5);
for i = 1:5
    c = pulse_wt(i).getCells;
    t = c(1).dev_time;
    I = find_initial(t);
    A{i} = cat(2,c.area_sm);
    A{i} = nanmean(A{i}(I,:));
end
A_wt = [A{:}];

A = cell(1,3);
for i = 1:3
    c = pulse_char(i).getCells;
    t = c(1).dev_time;
    I = find_initial(t);
    A{i} = cat(2,c.area_sm);
    A{i} = nanmean(A{i}(I,:));
end
A_char = [A{:}];

f_cta = pulse_cta.get_first_fit;
f_char = pulse_char(2:end).get_first_fit;
f_wt = pulse_wt(2:end).get_first_fit;

I = ~isnan([f_cta{:}]') & ~isnan([A_cta]');
p_cta = polyfit(A_cta(I)',[f_cta{I}]',1)

I = ~isnan([f_char{:}]') & ~isnan([A_char]');
p_char = polyfit(A_char(I)',[f_char{I}]',1)

I = ~isnan([f_wt{:}]') & ~isnan([A_wt]');
p_wt = polyfit(A_wt(I)',[f_wt{I}]',1);

x = [0 60];

%% j

scatter(A_cta,[f_cta{:}],'g');
hold on
plot(x,polyval(p_cta,x),'g-');
xlabel('Timing of first pulse (s)')
ylabel('Initial apical area (\mum^2)')
title('cta')
xlim([15 70])

figure
scatter(A_wt,[f_wt{:}],'b');
hold on
plot(x,polyval(p_wt,x),'b-');

scatter(A_char,[f_char{:}],'r');
hold on
plot(x,polyval(p_char,x),'r-');
xlim([15 70])


