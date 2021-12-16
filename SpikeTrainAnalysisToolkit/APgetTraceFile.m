function abc = APgetTraceFile(FILENAME)
TraceFolder = 'D:\Recordings Hold\';
[p n e] =fileparts(FILENAME)
[D R] = strtok(n,'_')
N = strtok(R,'_')
TraceFile = [TraceFolder,D,'_',N,'.txt'];
abc = TraceFile;


