function [names, labels, M] = getFeatures()

    selpath = uigetdir;

    dirs = dir(selpath); 

    dirs = dirs([dirs.isdir]);
    
    dirs = dirs(~ismember({dirs.name},{'.','..'}));

    M = [];
    names = [];
    labels = [];
    for i = 1:length(dirs)
        %fprintf("diretorio %s\n",dirs.name);
        files = dir(fullfile(dirs(i).folder,dirs(i).name));
        files = files(~[files.isdir]);
        for j = 1:length(files)
            fprintf("arquivo %s\n",files(j).name);
            [~,~,G] = rede(fullfile(files(j).folder,files(j).name), 5);
            [cc,k,r] = graph_topology(G);
            M = [M; [cc, k, r]];
            names = [names;convertCharsToStrings(files(j).name)];
            labels = [labels;convertCharsToStrings(dirs(i).name)];
        end
    end
end