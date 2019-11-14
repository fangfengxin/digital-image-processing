clear;
close all;

% ��ȡ��ֵͼ��
src = imread('rice-bw.png');
[h, w] = size(src);

% ��ͼ������Χ��һȦ�ڱߣ�ʹ���е���ͨ���򶼰�����ͼ���ڲ�
h = h + 2;
w = w + 2;
img = zeros(h, w);
img(2 : h - 1, 2 : w - 1) = src;

% �߽���ͼ��
edge = zeros(h, w);

% ����������꣬��������Ϊ˳ʱ�룬���Ϸ����ؿ�ʼ
directs = [-1, -1; 0, -1; 1, -1; 1, 0; 1, 1; 0, 1; -1, 1; -1, 0];

% �߽���
for i = 2 : h -1
    for j = 2 : w - 1
        if img(i, j) == 1   % �����ǰ������ǰ������
            neighbour = [i, j] + directs;   % ���㵱ǰ���ص����а���������
            for k = 1 : 8   % ������ǰ���صİ�����
                pix = neighbour(k, :);
                if img(pix(1), pix(2)) == 0     % ������������Ǳ�������
                    edge(pix(1), pix(2)) = 1;   % �߽���ͼ����Ӧ���ؽ��б��
                end
            end
        end
    end
end

% ��ȥ���ϵ�����Χ��Ե
edge = edge(2 : h - 1, 2 : w - 1);

% ��ʾ���
subplot(1, 2, 1), imshow(src), title('ԭͼ');
subplot(1, 2, 2), imshow(edge), title('�߽���ٱ��');