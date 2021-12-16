function abc=APmicfileanalysis(FILENAME,BinOl,F,SNRK,noisesubtract,Sho)
%FILENAME is .wav file
%500 ms bin size 75% overlap
BinSize=500;
Overlap=.75;
SNRco=1.65;
PKco=20;
if numel(BinOl)==1
    A=inputdlg({'Bin Size (ms)','Overlap (0=none,.999=max)'},'Spectrogram Parameters',1,{num2str(BinSize),num2str(Overlap)});
    bs=str2num(A{1});
    if ~isempty(bs)
        if bs>0
            BinSize=bs;
        end
    end
    olp=str2num(A{2});
    if ~isempty(olp)
        if olp>=0
            if olp<0.9999;
                Overlap=olp;
            end
        end
    end
else
    BinSize=BinOl(1);
    Overlap=BinOl(2);
end
if numel(F)==1
    F=[100:2:300];
end
if numel(SNRK)==1
    A=inputdlg({'Power cutoff (dB)','Skew cutoff'},'WBF ID Parameters',1,{num2str(SNRco),num2str(PKco)});
    bs=str2num(A{1});
    if ~isempty(bs)
        if bs>0
            cco=bs;
        end
    end
    olp=str2num(A{2});
    if ~isempty(olp)
        if olp>0
            PKco=olp;
        end
    end
else
    cco=SNRK(1);
    PKco=SNRK(2);
end


[Y fs]=audioread(FILENAME);
%Low pass butterworth filter Zero Phase Distort
tic
%16th order butterworth filter defined by 2 3dB points
h=fdesign.bandpass('N,F3db1,F3dB2',16,60/22050,600/22050);
d1=design(h,'butter');
fY=filtfilt(d1.sosMatrix,d1.ScaleValues,Y(:,1));
% fY=Y(:,1);
toc
olp=round(Overlap*fs*BinSize/1000);
Overlap=(1000*olp)/(fs*BinSize);
[SS,FF,TT,PP]=spectrogram(fY,fs*BinSize/1000,Overlap*fs*BinSize/1000,F,fs);
 toc

nPer=nan(size(F));
nPP=PP;

 
 abc.spectrogram=PP;
 abc.TT=TT;
 abc.FF=FF;
 
 
 
 abc.nPP=nPP;
 toc
 
 
 [c idx]=nanmax(nPP);
 SNR=nansum(PP)./sum(nPer);
 abc.SNR=SNR;
 PK=skewness(PP);
 abc.Pkurt=PK;
 abc.cc=c;
 
 SNRok=(SNR>SNRco);
 PKok=(PK>PKco);
 cok=(c>10.^(cco/10));
 
 isflying=cok.*PKok;
 ddisf=diff(diff(isflying));
 
 
 
 WBF=F(1)+(F(2)-F(1))*idx;
 isflying(find(ddisf==-2)+1)=0;
  
 WBF(~isflying)=nan;
 ddisf=diff(diff(isflying));
 fddisf=find(ddisf==2);
 for i=1:numel(fddisf)
     WBF(fddisf(i)+1)=(WBF(fddisf(i))+WBF(fddisf(i)+2))/2;
     isflying(fddisf(i)+1)=1;
 end
 
 abc.WBF=WBF;
 
 if Sho==1
     
     figure;
     
     imagesc(TT,F,10*log10(PP));
     axis('xy')
     xlabel('Time (s)')
     ylabel('Frequency (Hz)')
     colorbar;
     caxis([-55 -35]);
     
     
     
     
     figure
     subplot(3,1,1)
     plot(TT,PK)
     hold all
     plot([0 max(TT)],[PKco PKco],'r--')
     xlabel('Time (s)')
     ylabel('Skew')
     axis([0 max(TT) 0 10])
     subplot(3,1,2)
     plot(TT,log10(c))
     hold all
     plot([0 max(TT)],[(cco/10) (cco/10)],'r--')
     axis([0 max(TT) -6 -2])
     xlabel('Time (s)')
     ylabel('log(power)')
     subplot(3,1,3)
     plot(TT,F(1)+(F(2)-F(1))*idx,'b.')
     hold all
     plot(TT,WBF,'g-','LineWidth',2)
     axis([0 max(TT) 100 300])
     xlabel('Time(s)')
     ylabel('WBF (Hz)')
     
     
     figure
     plot(TT,WBF)
     axis([0 max(TT) 150 250])
 end
 

    
    
