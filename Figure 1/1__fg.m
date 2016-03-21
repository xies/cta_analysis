%% Figure 1 f-g KDE of apical area v. time

% Need: embryo_stack containing cta

%% f: WT KDEs

embryoID = [1:5];
kernel_size = 3; % um^2
kde_bins = linspace(0,100,1024);
slice_window = 73; % seconds

% Temporal slicing
[sliceID,tbins,Ninslice] = temporally_slice( ...
    embryo_wt(embryoID),slice_window);

% KDE
[est,est_bins,Nzeros,h] = kde_gauss( ...
    embryo_wt(embryoID), kde_bins, sliceID, kernel_size);

% C = varycolor(numel(tbins));
% set(gca,'ColorOrder',C);
% set(gca,'NextPlot','replacechildren')
% plot(est_bins,est);
imagesc(tbins,est_bins,est'); colormap hot; colorbar; axis tight xy;
xlabel('Time (sec)'); ylabel('Apical area (\mum^2)')
% legend(num2str(tbins(:)));

%% g: cta KDEs

embryoID = [3 4 6];
kernel_size = 3; % um^2
kde_bins = linspace(0,100,1024);
slice_window = 73; % seconds

% Temporal slicing
[sliceID,tbins,Ninslice] = temporally_slice( ...
    embryo_cta(embryoID),slice_window);

% KDE
[est,est_bins,Nzeros,h] = kde_gauss( ...
    embryo_cta(embryoID), kde_bins, sliceID, kernel_size);

% C = varycolor(numel(tbins));
% set(gca,'ColorOrder',C);
% set(gca,'NextPlot','replacechildren')
% plot(est_bins,est);
imagesc(tbins,est_bins,est'); colormap hot; colorbar; axis tight xy;
xlabel('Time (sec)'); ylabel('Apical area (\mum^2)')
% legend(num2str(tbins(:)));

