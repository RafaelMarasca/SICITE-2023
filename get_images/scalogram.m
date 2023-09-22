function [fig] = scalogram(X, Fs)

    X = single(X);
    fig = figure('visible','off');
    tms = (0:(numel(X))-1)/Fs;
    [w, frq] = cwt(X, Fs);
    image("XData",tms,"YData",frq,"CData",abs(w),"CDataMapping","scaled");
    axis tight
    %surface(tms,frq,abs(w));
    %colormap(jet);
    %h = colorbar;
    %h.Label.String = 'Valor Absoluto da Transformada de Wavelet';
    %ylabel('Frequência (Hz)')
    %xlabel('Tempo (s)')
    %set(gca,"yscale","log")
    %xlim([0 inf]) 
    %ylim([1, 10e4])
    set(gca,'visible','off')

end

