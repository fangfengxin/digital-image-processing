clear;
close all;

% ��ȡ��ֵͼ��
img = imread('rice-bw.png');
img = double(img);
subplot(1, 2, 1), imshow(img), title('ԭͼ');

% �������ͼ��
[height, width] = size(img);
connected = zeros(height, width);   % ��Ǻ��ͼ
queue = [];     % �洢����Ϊ��ǰ��ͨ���Ա�ĵ�����
label = 1;  % ���ֵ����1��ʼ���
offsets = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1];   % ����������ĵ���������

for i = 1:height
    for j = 1:width
        if img(i, j) == 1 && connected(i, j) == 0
            connected(i, j) = label;
            if isempty(queue)
                queue = [i; j];
            else
                queue = [queue, [i; j]];
            end
            while ~isempty(queue)
                pix = [queue(1, 1), queue(2, 1)];
                % ��������
                for k = 1 : 8
                    neighbour = pix + offsets(k, :);   % ������������
                    if neighbour(1) >= 1 && neighbour(1) <= height && neighbour(2) >= 1 && neighbour(2) <= width
                        if img(neighbour(1), neighbour(2)) == 1 && connected(neighbour(1), neighbour(2)) == 0
                            connected(neighbour(1), neighbour(2)) = label;
                            queue = [queue, [neighbour(1); neighbour(2)]];  % �����������
                        end
                    end
                end
                queue(:, 1) = [];   % ��Ԫ�س��ӣ���pix����ӣ�������������һ���������
            end
            label = label + 1;  % ��Ǽ�1��������һ�����������
        end
    end
end

% ��ʾ��ǽ��
connected = mat2gray(connected);
subplot(1, 2, 2), imshow(connected), title('��ͨ�����ǽ��');