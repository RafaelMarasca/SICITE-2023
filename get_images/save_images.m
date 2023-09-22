function save_images(selpath, savepath, fun)
    
    arguments
        selpath (1,1) string
        savepath (1,1) string
        fun (1,1) string {mustBeMember(fun,{'chroma','scal'})}
            
    end

    dirs = dir(selpath); 

    dirs = dirs([dirs.isdir]);
    
    dirs = dirs(~ismember({dirs.name},{'.','..'}));
    
    for i = 1:length(dirs)
        fprintf("diretorio %s\n",dirs.name);
        mkdir(savepath,dirs(i).name);
        files = dir(fullfile(dirs(i).folder,dirs(i).name));
        files = files(~[files.isdir]);
        for j = 1:length(files)
            fprintf("arquivo %s\n",files(j).name);
            [X,Fs] = audioread(fullfile(files(j).folder,files(j).name));
            Y = splitvec(X);

            for k = 1:10
                if fun == "scal"
                    fig = scalogram(Y(:,k),Fs);
                elseif fun == "chroma"
                    [~,fig] = chroma(Y(:,k),Fs,"plot","false");
                end
                fprintf("ok\n");
                [~,filename,~] = fileparts(files(j).name);
                filename = strcat(filename,int2str(k));
                filename = strcat(filename,'.png');
                exportgraphics(fig,fullfile(savepath,dirs(i).name,filename));
                clear fig;
            end
            
        end
    end
end