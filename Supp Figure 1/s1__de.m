%% Supp Fig 1 d-e, area dynamics in cta

c = pulse_cta.getCells;
c_const = c([c.label] == 1);
c_exp = c([c.label] == 2);

%% d: individual traces of area v. time

% colors = {'r-','c-'};

for i = 1:numel(c_const)
    hold on
    plot(c_const(i).dev_time,c_const(i).area_sm,'r-');
end
for i = 1:numel(c_exp)
    hold on
    plot(c_exp(i).dev_time,c_exp(i).area_sm,'c-');
end

xlabel('Time (s)')
ylabel('Apical area (\mum^2')

%% e: initial area in WT, cta, char
Abins = linspace(0,100,15 );
find_initial = @(t) (t < -150);

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

plot_pdf(A_cta,Abins,'g-');
hold on
plot_pdf(A_wt,Abins,'b-');
plot_pdf(A_char,Abins,'r-');
