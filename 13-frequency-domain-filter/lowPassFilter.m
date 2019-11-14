clear;
close all;

% ��ȡͼ��
src = imread('lena.jpg');
gray = rgb2gray(src);

% ����Ҷ�任
grayfft = fft2(gray);
grayfftshift = fftshift(grayfft);

% ����Ƶ������
[M, N] = size(grayfftshift);     % Ƶ��ߴ�
m = fix(M/2);
n = fix(N/2);
[u, v] = meshgrid(-M/2 : M/2 - 1, -N/2 : N/2 - 1);   % ����Ƶ������
d = sqrt(u.^2 + v.^2);  % ����Ƶ����㵽Ƶ�����ĵľ���
d0 = 50;    % ��ֹƵ��

% �����ͨ�˲�
% for i = 1 : M
%     for j = 1 : N
%         
%         if d <= d0
%             h = 1;
%         else
%             h = 0;
%         end
%         ideal(i, j) = h * grayfftshift(i, j);     % �����˲����
%     end
% end
h_ideal = double(d <= d0);    % ����ת�ƺ���
ideal = h_ideal .* grayfftshift;
ideal = uint8(real(ifft2(ifftshift(ideal))));

% ������˹��ͨ�˲�
order = 4;  % 4�װ�����˹��ͨ�˲�
% for i = 1 : M
%     for j = 1 : N
%         d = sqrt((i - m)^2 + (j - n)^2);    % ���㵱ǰƵֵ��Ƶ�����ĵľ���
%         h = 1 / (1 + (d / d0)^(2 * order));     % ���������˹��ͨ�˲�����ת�ƺ���
%         btw(i, j) = h * grayfftshift(i, j);     % �����˲����
%     end
% end
h_btw = 1 ./ (1 + (d ./ d0).^(2 * order));
btw = h_btw .* grayfftshift;
btw = uint8(real(ifft2(ifftshift(btw))));

% ��˹��ͨ�˲�
h_gauss = exp(-(d.^2)./(2 * (d0^2)));
gauss = h_gauss .* grayfftshift;
gauss = uint8(real(ifft2(ifftshift(gauss))));

% ��ʾ���
subplot(2,2,1), imshow(gray), title('ԭͼ');
subplot(2,2,2), imshow(ideal), title('�����ͨ�˲�');
subplot(2,2,3), imshow(btw), title('������˹��ͨ�˲�');
subplot(2,2,4), imshow(gauss), title('��˹��ͨ�˲�');