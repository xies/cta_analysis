%% Fit area trend

find_first = @(t) t < -100;
find_before = @(t) ( t < 50 & t > -50 );
find_after = @(t) ( t > 200 & t < 300 );

%%

c = pulse_char(1).getCells;
f = pulse_char(1).get_first_fit;
[f{cellfun(@isempty,f)}] = deal(NaN);

firstArea = nan(1,numel(c));
A_resp = nan(1,numel(c));

for i = 1:numel(c)
    
    t = c(i).dev_time;
    Ifirst = find_first(t);
    Ibefore = find_before(t);
    Iafter = find_after(t);
    
    firstArea(i) = nanmean(c(i).area_sm(Ifirst));
    c(i).measurement = firstArea(i);
    
    I = ~isnan(c(i).area_sm);
    if numel(I(I)) > 25
        I = ~isnan(c(i).dev_time);
        ar = -central_diff( c(i).area_sm(I) ,t(I) );
%         A_resp(i) = nanmean(ar);
        A_resp(i) = nanmean( ar(t(I) > 0 ) );
    end
%     A_resp(i) = nanmean(c(i).area_sm(Ibefore)) - nanmean(c(i).area_sm(Iafter));
end

% scatter(firstArea,A_resp,'f');
% scatter(firstArea,[f{:}],'f');
% [r,p] = corrcoef( firstArea', [f{:}]','spearman')
