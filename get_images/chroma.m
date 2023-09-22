function [C,fig] =  chroma(X, Fs, options)

    arguments
        X (:,1) double {mustBeNumeric}
        Fs (1,1) double {mustBeNumeric}
        options.N (1,1) uint32 {mustBeNumeric} = 4096
        options.H (1,1) uint32 {mustBeNumeric} = 2048
        options.gama (1,1) double {mustBeNumeric} = 100
        options.norm_type (1,1) string = 'min-max'
        options.epsilon (1,1) double {mustBeNumeric} = 1e-6;
        options.plot (1,1) string {mustBeMember(options.plot,{'true','false'})} = 'true'
    end

    
    [s,f,t] = stft(X, Fs, "Window", hann(options.N), ...
        "OverlapLength", options.H,"FFTLength", options.N);
    s = s(f>=0,:);
    f = f(f>=0);
    s = abs(s).^2;
    s(f~=0,:) = 2*s(f~=0,:);
    
    P = pool_frequency(4096,Fs);

    y = P*s;

    aux = repmat(0:127,12,1);
    
    for i = 0:11
        aux(1+i,:) = mod(0:127,12)==i;  
    end

    C = aux*y;

    C = log10(1 + options.gama*C);

    C = norm_chroma(C, norm_type = options.norm_type, epsilon = options.epsilon);
   
    if options.plot == "false"
        fig = figure('visible','off');
        imagesc(C);
        set(gca,'visible','off');
    else
        fig = figure();
        imagesc(C);
        %h = colorbar;
        %h.Label.String = "Intensidade Normalizada";
        %yticks([1 2 3  4 5 6 7 8 9 10 11 12]);
        %yticklabels({'C', 'C#','D','D#' 'E','F', 'F#','G','G#','A','A#', 'B'});
        %ylabel('Classe Cromática')
        %xticks(((numel(C)/12)/6)*[1, 2, 3, 4, 5, 6]);
        %xticklabels([1,2,3,4,5,6]);
        %xticks(((numel(C)/12)/30)*[5,10,15,20,25,30]);
        %xticklabels([5,10,15,20,25,30]);
 
        %xlabel('Tempo (s)');

        %xlabel('Tempo (s)');
        axis off
    end

    colormap(hot);
    pbaspect([2 1 1]);

end
