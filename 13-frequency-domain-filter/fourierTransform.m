clear;
close all;

% ��ȡͼƬ��ת���ɻҶ�ͼƬ
src = imread('lena.jpg');
gray = rgb2gray(src);

% ��ͼƬ���и���Ҷ�任
gray_fft = fft2(gray);
% ��Ƶ��ȡģ����������
grayfft = log(abs(gray_fft) + 1);

% ��Ƶ������Ƶ�ʷ����ƶ���Ƶ������ [1,2;3,4] --> [4,3;2,1]
gray_fft_shift = fftshift(gray_fft);
% ��Ƶ�ƺ��Ƶ��ȡģ������
grayfftshift = log(abs(gray_fft_shift) + 1);

% ����Ҷ���任��Ƶ��任�����򣬲�ȡʵ��
dst = real(ifft2(ifftshift(gray_fft_shift)));

% ��ʾ����Ҷ�任���
subplot(2, 2, 1), imshow(src), title('ԭͼ');
subplot(2, 2, 2), imshow(grayfft, []), title('����ҶƵ��');
subplot(2, 2, 3), imshow(grayfftshift, []), title('Ƶ�ƺ�ĸ���ҶƵ��');
subplot(2, 2, 4), imshow(dst, []), title('����Ҷ���任���');