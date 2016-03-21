%% Plot the rank of a cell's area as a fcn of time

A = embryo_cta(6).area_sm;

tbins = linspace(-1000,600,40);

areaRank = zeros(size(A,2),numel(tbins) - 1);
qtiles = 0:10:100;

for i = 1:numel(tbins)-1
    
    I = embryo_cta(6).dev_time > tbins(i) & embryo_cta(6).dev_time <= tbins(i+1);
    
%     if numel(I(I)) > 0
%         areaRank(i) = nanstd( nanmean(A(I,:)) );
%     end
    
end
