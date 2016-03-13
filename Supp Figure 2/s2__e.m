%% Supplemental Figure 2 e

% Needs: pulse_cta, clustered

%% e: clustered area response heatmaps

for i = 1:3
    
    h = subplot(1,3,i);
    f = pulse_cta.get_cluster(i)
    [X,Y] = meshgrid(f(1).corrected_time,1:numel(f));
    pcolor(X,Y,cat(1,f.sort('cluster_weight').corrected_area_norm))
%     set(h,'YDir','reverse');
    shading flat
    
    xlabel('Pulse time (s)')
    caxis([-8 8])
    colorbar;
    
end
