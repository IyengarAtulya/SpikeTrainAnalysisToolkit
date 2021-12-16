function spkfindr=vdat(time,ch,threshold)
% Find spikes from filtered data-- threshold signifies the minimum distance
% between non zero values required for spike differentiation. this is given
% in milliseconds and is usually around 2-- first column is spike times (in
% seconds) second column is spike duration (in ms) third column is maximum
%M- Nx2 filtered data
%threshold- minimum interspike interval
%Version 0.92 Last Updated 26 Apr 2012
M(:,1)=time;
M(:,2)=ch;
found=find(M(:,2));
spkstat=zeros(0,2);
if ~isempty(found)
L=size(found);
la=L(1);
spknum=1;
for i=2:la
    if (found(i)-found(i-1))>(threshold*20)
        spknum=spknum+1;
    end
end
spkstat=zeros(spknum,2);
[c, idx]=max(M([found(1):(found(1)+threshold*20)],2));
d=min(M([found(1):(found(1)+threshold*20)],2));
spkstat(1,1)=M(found(1)+idx,1);
spkstat(1,2)=c;
j=2;
if size(M,1)<(found(la)+threshold*20)
    while size(M,1)<(found(la)+threshold*20)
        la=la-1;
    end
end


for i=2:la
    if (found(i)-found(i-1))>(threshold*20)
        [c, idx]=max(M([found(i):(found(i)+threshold*20)],2));
        d=min(M([found(i):(found(i)+threshold*20)],2));
        spkstat(j,1)=M(found(i)+idx,1);
        spkstat(j,2)=c;
        j=j+1;
    end
end
end
spkfindr=spkstat;
    

        

   