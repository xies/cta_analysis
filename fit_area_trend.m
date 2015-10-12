%% Fit area trend

find_first = @(t) t < -250;
find_before = @(t) ( t < 50 & t > -50 );
find_after = @(t) ( t > 200 & t < 300 );

%%

c = pulse_cta(1).getCells;

firstArea = nan(1,numel(c));
A_resp = nan(1,numel(c));

for i = 1:numel(c)
    t = c(i).dev_time; I = ~isnan(t);
    Ifirst = find_first(t);
    Ibefore = find_before(t);
    Iafter = find_after(t);
    firstArea(i) = nanmean(c(i).area_sm(Ifirst));
    ar = central_diff( c(i).area_sm(I) ,t(I) );
    A_resp(i) = nanmean( ar(~Ifirst(I)) );
%     A_resp(i) = nanmean(c(i).area_sm(Iafter)) - nanmean(c(i).area_sm(Ibefore));
end

scatter(firstArea,A_resp,'r');

[r,p] = corrcoef( firstArea', A_resp' ,'spearman')
