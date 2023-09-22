function [stats] = glcm_stats(I)

img = im2gray(imread(I));

offsets = [ 0 1; 0 2; 0 3; 0 4;
           -1 1; -2 2; -3 3; -4 4;
           -1 0; -2 0; -3 0; -4 0;
           -1 -1; -2 -2; -3 -3; -4 -4];
glcms = graycomatrix(img, "Offset", offsets);
glcms_stats = graycoprops(glcms);

stats = [];

for i = 1:16
    stats = [stats; [glcms_stats.Contrast(i) glcms_stats.Correlation(i)  glcms_stats.Energy(i) glcms_stats.Homogeneity(i)]];
end

end