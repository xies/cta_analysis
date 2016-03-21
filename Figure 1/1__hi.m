%% Figure 1 h-i Colored apical area v. time binned by initial area

% Need: embryo_stack containing cta

%% h:

% find_first = @(t) t < -150;

% tbins = linspace(-800,600,30);

embryoID = [5];

Abins = linspace(15,75,15);
C = pmkmp(numel(Abins));
A = cat(2,embryo_wt(embryoID).area_sm);

find_initial = @(t) (t < -350);
I = find_initial( embryo_wt(embryoID).dev_time );
[N,whichBin_wt] = histc(nanmean(A(I,:)),Abins);

for i = 1:numel(Abins)
    plot(embryo_wt(embryoID).dev_time, ...
        nanmean(A(:,whichBin_wt == i),2),'Color',C(i,:));
    hold on
end

%% alternative h...

tbins = linspace(-1000,600,20);
Abins = linspace(0,100,30);
MSE_wt = nan(1,numel(tbins) - 1);
MSE_cta = nan(1,numel(tbins) - 1);
A_wt= cat(2,embryo_wt(3).area_sm);
A_cta = cat(2,embryo_cta(3).area_sm);


for i = 1:numel(tbins)-1
    
    I = embryo_wt(3).dev_time > tbins(i) & embryo_wt(3).dev_time <= tbins(i+1);
    [~,whichBin_wt] = histc(nanmean(A_wt(I,:)),Abins);
    
    I = embryo_cta(3).dev_time > tbins(i) & embryo_cta(3).dev_time <= tbins(i+1);
    [~,whichBin_cta] = histc(nanmean(A_cta(I,:)),Abins);
    
%     subplot(2,5,i);
    thisMSE_wt = zeros(1,numel(Abins));
    thisMSE_cta = zeros(1,numel(Abins));
    
    for j = 1:numel(Abins)
        
%         plot(embryo_wt(embryoID).dev_time, ...
%             nanmean(A(:,whichBin == j),2),'Color',C(j,:));
%         hold on
%         
%         xlim([-1000 600])
%         title(['T = ' num2str(tbins(i))])
        thisMSE_wt(j) = nanmean(nanvar(A_wt(:,whichBin_wt == j),[],2));
        thisMSE_cta(j) = nanmean(nanvar(A_cta(:,whichBin_cta == j),[],2));
    end
    MSE_wt(i) = nanmean(thisMSE_wt);
    MSE_cta(i) = nanmean(thisMSE_cta);
end

plot(tbins(1:end-1),MSE_wt);
hold on
plot(tbins(1:end-1),MSE_cta,'g-');
xlabel('Bin time')
ylabel('Mean squared error')


