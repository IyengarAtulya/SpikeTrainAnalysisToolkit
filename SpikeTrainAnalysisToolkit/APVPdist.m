function abc=APVPdist(ST1, ST2, q)
tic
G=nan(numel(ST1)+1,numel(ST2)+1);
G(1,1)=0;
G(2:end,1)=[1:numel(ST1)];
G(1,2:end)=[1:numel(ST2)]';
dcalc=0;
for i=2:numel(ST1)+1
    for j=2:numel(ST2)+1
        compvals=[G(i-1,j)+1,G(i,j-1)+1,G(i-1,j-1)+q*abs(ST1(i-1)-ST2(j-1))];
        G(i,j)=min(compvals);
    end
end
abc=G(end,end);
toc
