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
