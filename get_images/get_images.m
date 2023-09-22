function get_images()

    selpath = uigetdir;
    savepath = uigetdir;

    chroma_save_path = fullfile(savepath,"chroma");
    scalogram_save_path = fullfile(savepath,"scalogram");

    mkdir(chroma_save_path);
    mkdir(scalogram_save_path);

    save_images(selpath,chroma_save_path,"chroma");
    save_images(selpath,scalogram_save_path,"scal");

    
end