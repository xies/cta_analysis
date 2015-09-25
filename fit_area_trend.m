%% Fit area trend

for i = 1:numel(charCells)
    
    A = charCells(i).area;
    I = ~isnan(A);
    x = charCells(i).dev_time';
    pChar(i,:) = polyfit(x(I),A(I),1);
    
end

for i = 1:numel(charCells)
    
    A = ctaCells(i).area;
    I = ~isnan(A);
    x = ctaCells(i).dev_time';
    pCta(i,:) = polyfit(x(I),A(I),1);
    
end

%%

rateChar = nan(size(Achar));
rateCta = nan(size(Acta));

for i = 1:numel(charCells)
    I = ~isnan(charCells(i).area);
    if numel(I(I)) > 10
        rateChar(I,i) = -central_diff_multi( ...
            charCells(i).area(I), charCells(i).dev_time(I) );
    end
end

for i = 1:numel(ctaCells)
    I = ~isnan(ctaCells(i).area);
    if numel(I(I)) > 10
        rateCta(I,i) = -central_diff_multi( ...
            ctaCells(i).area(I), ctaCells(i).dev_time(I) );
    end
end

scatter(nanmean(rateChar),firstCharArea,'b','filled')
[r,p] = corrcoef(nanmean(rateChar)',firstCharArea')
hold on
scatter(nanmean(rateCta),firstCtaArea,'r','filled')
[r,p] = corrcoef(nanmean(rateCta)',firstCtaArea')
xlabel('Constriction rate (\mum^2 sec^{-1})')
ylabel('First detected area (\mum^2)')
xlim([-.1 .2])

