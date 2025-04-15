clear all
close all

%% ²ÎÊýÐÞ¸Ä
filepath= './';
I_example =  double(imread([filepath,'TIRF_561.tif'])); 
I_SIM = double(imread([filepath, 'SIM_mask.tif']));

%% mask 
I_SIM = I_SIM / 255;
I_mask = I_SIM;
I_example = I_example .* I_mask;

%% parameter setting
lamda = 488;   
n_i = 1.515;  
n_t = 1.42;  
n = n_t/n_i;
angle=72;   
dp = lamda./(4*pi*sqrt(n_i^2*sind(angle).^2-n_t^2));    
I0 = 4*cosd(angle).^2./(1-n.^2); 
figure(1);imshow(I_example,[]); title('Raw image');      


%% fitting
xsize=size(I_example(:,:),1); ysize=size(I_example(:,:),2);
z=zeros(xsize,ysize);
ratio=max(max(I_example))./I_example;
z=log(ratio).*dp;
figure(2);
z(isinf(z)) = 0;
custom_cmap = [0 0 0; hsv(255)];  

imagesc(z); 
colormap(custom_cmap); 
axis off;
% colormap("hsv");
colorbar;
title('Reconstructed depth'); 
