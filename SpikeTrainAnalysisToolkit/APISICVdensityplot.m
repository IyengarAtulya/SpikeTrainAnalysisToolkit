function abc=APISICVdensityplot(overalldata,gridedges)
h=figure;
x=overalldata(:,3:4);
abc.hist=histogram2(real(x(:,1)),real(x(:,2)),gridedges{1},gridedges{2},'Normalization','probability','DisplayStyle','tile','ShowEmptyBins','off');
grid off
hold on
colormap(flipud(hot))
colorbar
caxis([0 .0005])
xlabel('ISI^{-1} (Hz)')
ylabel('CV_2')
axis('square')
%%% Burst Analysis
GBA=questdlg('Gauss Burst Analsyis?');
if strcmp(GBA,'Yes')
    mu_i=[.6 -1; 1.5 -.6];
    sigma_i(:,:,1)=[.1 .01; .01 .1];
    sigma_i(:,:,2)=[.1 .01; .01 .1];
    PC=[0.5 0.5];
    S=struct('mu',mu_i,'Sigma',sigma_i,'ComponentProportion',PC);
   abc.gm=fitgmdist(real(x),2,'Start',S);
   [ex ey]=meshgrid(gridedges{1},gridedges{2});
   F=abc.gm.ComponentProportion(1)*mvnpdf([ex(:),ey(:)],abc.gm.mu(1,:),abc.gm.Sigma(:,:,1));
   F=reshape(F,length(ey),length(ex));
   G=abc.gm.ComponentProportion(2)*mvnpdf([ex(:),ey(:)],abc.gm.mu(2,:),abc.gm.Sigma(:,:,2));
   G=reshape(G,length(ey),length(ex));
   contour(ex, ey,F);
   contour(ex, ey,G);
   contour(ex,ey, G./(F+G))
   abc.RhythmF=F;
   abc.BurstF=G;
   abc.BurstLikelyhood=G./(F+G);
end
