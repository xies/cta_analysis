%% Supp Figure 3e-f

% Parse model output

RELOAD = 0;

folder_name = '~/Desktop/Model/final_ratio_10_delay_';

d = [250 500:100:2000 2500 3000 3500 7500];
delay_times = cell(1,numel(d));
for i = 1:numel(d)
    delay_times{i} = num2str(d(i));
end

%% e: Get area, time, and IDs

if RELOAD
    
    A = cell(1,numel(d));
    T = cell(1,numel(d));
    ID = cell(1,numel(d));
    for i = 1:numel(d)
        A{i} = csvread([folder_name delay_times{i} '.csv.out/area.csv']);
    end
    
    for i = 1:numel(d)
        T{i} = csvread([folder_name delay_times{i} '.csv.out/assembled_time.csv']);
    end
    
    for i = 1:numel(d)
        ID{i} = csvread([folder_name delay_times{i} '.csv.out/active_cells.csv']);
    end
end

C = pmkmp(255);
valueLookUp = linspace(250,7500,255);
for i = 1:numel(d)-1
    
    plot(T{i} - d(i), nanstd(A{i}(:,ID{i}),[],2),...
        'color',C(findnearest(d(i),valueLookUp),:));
    hold on
    
end

xlabel('Simulation time (s)')
ylabel('S.d. in area');
colorbar;
caxis([d(1) d(end)]); colormap pmkmp

%% f: max s.d. v. delay time

maxSDs = cellfun(@(x,y) max( nanstd(x(:,y),[],2) ), A,ID);

plot(d(1:end-1),maxSDs(1:end-1),'bo-')
xlabel('Delay time, d (s)');
ylabel('Max s.d. in area')

