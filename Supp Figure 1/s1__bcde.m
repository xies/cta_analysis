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

sbins = [-Inf linspace(-800,400,30) Inf];

for i = 1:numel(pulse_cta)
    
    
    [DIP,P] = HartigansDipSignifTest([])
    
end