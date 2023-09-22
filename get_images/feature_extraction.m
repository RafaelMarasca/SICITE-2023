selpath = uigetdir;
savepath = uigetdir;

dirs = dir(selpath); 

dirs = dirs([dirs.isdir]);

dirs = dirs(~ismember({dirs.name},{'.','..'}));

for i = 1:length(dirs)
    
    mkdir(savepath,dirs(i).name);
    files = dir(fullfile(dirs(i).folder,dirs(i).name));
    files = files(~[files.isdir]);
    for j = 1:length(files)
        [X,Fs] = audioread(fullfile(files(j).folder,files(j).name));
        [~,fig] = chroma(X,Fs,"plot","false");
        [~,filename,~] = fileparts(files(j).name); 
        filename = strcat(filename,'.png');
        exportgraphics(fig,fullfile(savepath,dirs(i).name,filename));
    end
end