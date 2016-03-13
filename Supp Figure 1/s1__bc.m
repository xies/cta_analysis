%% Supp Figure 1 b-e Cta apical area

% Need: pulse_wt, pulse_cta, embryo_cta, pulse_char

%% b: std in WT and area

for i = 1:numel(pulse_wt)
    
    c = pulse_wt(i).getCells;
    hold on
    A = cat(2,c.area_sm);
    plot(c(1).dev_time,nanstd(A,[],2)./nanmean(A,2),'g-')
    
end

for i = 1:numel(pulse_cta)
    
    c = pulse_cta(i).getCells;
    hold on
    A = cat(2,c.area_sm);
    plot(c(1).dev_time,nanstd(A,[],2)./nanmean(A,2),'b-')
    
end
xlabel('Time (s)')
ylabel('C.V. in apical area (\mu m^2)')

%% c: Hartigan's test for unimodality

tbins = [-Inf linspace(-800,800,20) Inf];

data_cta = cell(numel(tbins)-1,numel(pulse_cta));
data_wt = cell(numel(tbins)-1,numel(pulse_wt));

% cta
for i = 1:numel(pulse_cta)
    
    c = pulse_cta(i).getCells;
    t = c.dev_time;
    [~,which] = histc(t,tbins);
    A = cat(2,c.area_sm);
    
    for j = 1:numel(tbins)
        a = A(which == j,:);
        a = a(:);
        data_cta{j,i} = a';
    end
end

% WT
for i = 1:numel(pulse_wt)
    
    c = pulse_wt(i).getCells;
    t = c.dev_time;
    [~,which] = histc(t,tbins);
    A = cat(2,c.area_sm);
    
    for j = 1:numel(tbins)
        a = A(which == j,:);
        a = a(:);
        data_wt{j,i} = a';
    end
end

%%

P_wt = nan(1,numel(tbins)); P_cta = nan(1,numel(tbins));

for j = 1:numel(tbins)
    
    if ~isempty(nonans([data_cta{j,:}]))
        [DIP_cta(j),P_cta(j)] = HartigansDipSignifTest(nonans([data_cta{j,:}]),1e3);
    end
    if ~isempty(nonans([data_wt{j,:}]))
        [DIP_wt(j),P_wt(j)] = HartigansDipSignifTest(nonans([data_wt{j,:}]),1e3);
    end
    
end

%%

plot(tbins(1:end),-log10(P_wt),'b-')
hold on;
plot(tbins(1:end),-log10(P_cta),'g-')
hline(-log10(0.05),'r--');

xlabel('Time (s)');
ylabel('Hartigan''s test log(P)');
legend('cta','WT');


