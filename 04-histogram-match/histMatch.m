clear;
close all;

% ��ȡͼƬ��ת��Ϊ�Ҷ�ͼ��
src = imread('cameraman.jpg');
mask = imread('lena.jpg');
src = rgb2gray(src);
mask = rgb2gray(mask);
[h_src, w_src] = size(src);
[h_mask, w_mask] = size(mask);

% ����Ҷ�ֱ��ͼ
% pdf_src = imhist(src);
% pdf_mask = imhist(mask);
pdf_src = zeros(1, 256);
pdf_mask = zeros(1, 256);

for x = 1 : h_src
    for y  = 1 : w_src
        pdf_src(src(x, y) + 1) = pdf_src(src(x, y) + 1) + 1;
    end
end

for x = 1 : h_mask
    for y  = 1 : w_mask
        pdf_mask(mask(x, y) + 1) = pdf_mask(mask(x, y) + 1) + 1;
    end
end

pdf_src = pdf_src / (h_src * w_src);
pdf_mask = pdf_mask / (h_mask * w_mask);

% �����ۻ����ʷֲ�
% ʹ��cumsum���������ۻ���
cdf_src = cumsum(pdf_src);
cdf_mask = cumsum(pdf_mask);

% ʹ����ӳ�������лҶ�ӳ��
% �ҵ�ԭʼ�ۼ�ֱ��ͼ�о���涨�ۻ�ֱ��ͼ�Ҷ�ֵ����ĻҶ�ֵ����ԭʼ�ۼ�ֱ��ͼ�ûҶ�ֵ֮ǰ�ĻҶ�ֵ��ӳ��Ϊ�ù涨�ۼ�ֱ��ͼ�Ҷ�ֵ
record = 1;   % ��¼��һ��ӳ��ĻҶȼ�λ�õ���һ���Ҷ�
differ = zeros(256, 1);
dst = uint8(zeros(h_src, w_src));

for x = 1 : 256
    % ���˹涨ֱ��ͼ�����ܶ�Ϊ0�ĻҶȼ�
    if pdf_mask(x)
        for y = 1 : 256
            differ(y) = abs(cdf_mask(x) - cdf_src(y));
        end
        % �ҵ���ֵ��С�ĻҶ�ֵλ�ã������ڶ����������и����ܶ�Ϊ0��λ�ã�ȡ���һλ
        gml = find(differ == min(differ));
        
        % ����һ��ӳ��Ҷȼ������λҶȼ�֮��ĻҶȽ���ӳ��
        for z = record : gml(end)
            % �ҵ�ԭͼ�лҶ�ֵΪz-1���������أ���Ӧλ�õĻҶ�ֵ��ӳ��Ϊx-1
            match = find(src == z - 1);
            dst(match) = x - 1;
        end
        record = gml(end) + 1;
    end
end

% ��ʾ���
subplot(3, 3, 1); imshow(src); title('ԭͼ');
subplot(3, 3, 2); imshow(mask); title('��׼ͼ');
subplot(3, 3, 3); imshow(dst); title('ֱ��ͼ�涨�����');

% ��ʾ�Ҷ�ֱ��ͼ
subplot(3, 3, 4); imhist(src); title('ԭͼֱ��ͼ');
subplot(3, 3, 5); imhist(mask); title('��׼ֱ��ͼ');
subplot(3, 3, 6); imhist(dst); title('ֱ��ͼƥ�䵽��׼ͼ');

% ��ʾ�Ҷ�ֱ��ͼ
pdf_dst = imhist(dst) / numel(dst);
cdf_dst = cumsum(pdf_dst);
subplot(3, 3, 7); bar(cdf_src); title('ԭͼ�ۻ�ֱ��ͼ');
subplot(3, 3, 8); bar(cdf_mask); title('��׼�ۻ�ֱ��ͼ');
subplot(3, 3, 9); bar(cdf_dst); title('ֱ��ͼƥ�䵽��׼ͼ');