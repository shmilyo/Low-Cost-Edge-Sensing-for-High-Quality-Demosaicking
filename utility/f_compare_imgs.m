%--------------------------------------------------------------------------
%
%  Yue M. Lu
%  Ecole Polytechnique Federale de Lausanne (EPFL)
% Modified by Yan Niu for fair comparison
%--------------------------------------------------------------------------
%
%  compare_imgs.m
%
%  First created: 06-08-2008
%  Last modified: 06-11-2009
%  Yan Niu modified it at 11-22-2017
%--------------------------------------------------------------------------

function [psnr_arr, SSIM,sCIELAB] = f_compare_imgs(x, y,exclude)


%  INPUT
%
%    x, y: two color images
%
%    exclude: the number of border pixels to exclude in computing the PSNR and
%    MSE.
%
%  OUTPUT
%
%    psnr_arr: a 1-by-4 array [PSNR_Red, PSNR_Green, PSNR_Blue, PSNR_total]
%    SSIM: the structual similarity measure 
%    sCIELAB: the S-CIELAB measure 

xNoBoundary = double(x(exclude+1:end-exclude, exclude+1:end-exclude, :));
yNoBoundary = double(y(exclude+1:end-exclude, exclude+1:end-exclude, :));

diff = xNoBoundary - yNoBoundary;

mse_arr = zeros(1, 4);

% calcuate the MSE for each channel            
mse_arr(1) = mean2(diff(:,:,1).^2);
mse_arr(2) = mean2(diff(:,:,2).^2);
mse_arr(3) = mean2(diff(:,:,3).^2);
mse_arr(4) = mean(diff(:).^2);

% calculate PSNR
if (max(x(:))<1.5)
    psnr_arr = 10 * log10(1./ mse_arr);
else
    psnr_arr = 10 * log10(255^2 ./ mse_arr);
end


% calculate SSIM
SSIM = ssim(xNoBoundary, yNoBoundary);
        
% calculte SCIELAB
if (max(x(:))<1.5)
    sCIELAB = f_scielab(255.*xNoBoundary, 255.*yNoBoundary);
else
    sCIELAB = f_scielab(xNoBoundary, yNoBoundary);
end

