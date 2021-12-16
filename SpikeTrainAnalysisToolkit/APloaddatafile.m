function abc=APloaddatafile(FILENAME)
fid=fopen(FILENAME);
ncol=numel(str2num(fgetl(fid)));
fseek(fid,0,'bof');
switch ncol
    case 7
        D=textscan(fid,'%f %f %f %f %f %f %f');
        abc=[D{1},D{2},D{3},D{4},D{5},D{6},D{7}];
        fclose(fid);
        
    case 6
        D=textscan(fid,'%f %f %f %f %f %f');
        abc=[D{1},D{2},D{3},D{4},D{5},D{6}];
        fclose(fid);
    otherwise
        D=textscan(fid,'%f %f %f %f %f');
        abc=[D{1},D{2},D{3},D{4},D{5}];
        fclose(fid);
end