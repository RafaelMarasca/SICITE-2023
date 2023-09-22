function [C_norm] = norm_chroma(C,options)

    arguments
        C (:,:) double {mustBeNumeric}
        options.epsilon (1,1) double {mustBeNumeric} = mean(mean(C))/1e6;
        options.norm_type (1,1) string {mustBeMember(options.norm_type,{'min-max','epsilon'})} = "min-max"
        
    end

    if options.norm_type == "epsilon"

        mod_C = sqrt(sum(C.^2));
    
        C(:,mod_C > options.epsilon) = C(:,mod_C > options.epsilon)./mod_C;

        if(C(:,mod_C <= options.epsilon))
            C(:,mod_C <= options.epsilon) = ones(12,length(mod_C<= options.epsilon))/sqrt(12);
        end
     
    elseif options.norm_type == "min-max"
        C = (C-min(C))./(max(C)-min(C));
    end

    C_norm = C;

end