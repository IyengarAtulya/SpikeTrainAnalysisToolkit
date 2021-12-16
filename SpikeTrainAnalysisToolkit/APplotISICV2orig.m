function abc=APplotISICV2orig(FILENAME,mint,filtsz)
[a b c]= xlsread(FILENAME);
oST=a(4:end,1);
sST=oST(oST>mint);
dST=diff(sST);
dST=-1*log10(dST);
sdST=[dST;0]+[0;dST];
CV2=log10(2*abs(diff(dST))./sdST(2:end-1));
CV2(CV2<-3)=nan;
nCV2=1:numel(CV2);
nanCV2=isnan(CV2)|isinf(CV2);
nnCV2=real(CV2);
nnCV2(nanCV2)=interp1(nCV2(~nanCV2),nnCV2(~nanCV2),nCV2(nanCV2));
CV2=nnCV2;
ISI=(sdST(2:end-1)./2);
CV2=CV2(~isnan(CV2));
ISI=ISI(~isnan(CV2));
ST=sST(2:end-1);
ST=ST(~isnan(CV2));

if filtsz>0
    %filtering
    bb=(1/filtsz)*ones(1,filtsz);
    aa=1;
    fCV2=(filtfilt(bb,aa,(CV2)));
    fISI=(filtfilt(bb,aa,(ISI)));
else
    fCV2=(CV2);
    fISI=(ISI);
end

%plotting

figure
hold all
plot((ISI),(CV2),'ko','MarkerFaceColor',[.5 .5 .5])
%patch(ISI,CV2,1:numel(ST),'FaceColor','none','EdgeColor','none','Marker','o','MarkerFaceColor','flat');
%plot(real(fISI),real(fCV2),'r-')
patch(([fISI;nan]),([fCV2;nan]),[1:numel(ST),nan],'facecolor','none','edgecolor','interp','LineWidth',2);
colormap jet;
axis([-0.5 2.5 -2.5 0.5]);

%export 2 ws
%abc=[ST,ISI,fISI,fCV2,CV2];
%export2wsdlg({'ISI-CV2'},{'ISI_CV2'},{abc},'Export to Workspace');
