clear;
close all;

I = imread('rice-bw.png');%����ͼ��
[h, w] = size(I);
bw = bwlabel(I); %����ͨ�������������

boundaries = cell(0,0);     % ��������߽�
direction = [-1, 0; -1, 1; 0, 1; 1, 1; 1, 0; 1, -1; 0, -1; -1, -1];    %����Ϊ˳ʱ��

% ��ʼ��¼����ʼ�㣬�Լ������һ���߽��
% ��ѭ����ͬһ����ʼ������һ���߽����ͬʱ���˱߽�������
flag = [];
judge_flag = [];

for i = 1 : h
    for j = 1 : w
        if bw(i, j) >= 1           
            flag = [i, j, -100, -100];
            label = bw(i, j);    % ��ͨ����
            start = 1;    % ��ʼ��������
            point = [i, j;];    % ������������
            judge_flag = [-100, -100, -100, -100];
            get_next = 0 ;  %�Ƿ��ȡ����ʼ������һ���߽��       
            center_x = i;
            center_y = j;

        while ~isequal(flag, judge_flag) 
            k = start;
            while(1)                       
                %(x,y)Ϊ��Χ��������������
                x = center_x + direction(k, 1);
                y = center_y + direction(k, 2);
                %�ж������Ƿ�Խ��
                if x >0  && x <= h && y > 0 && y <= w
                    if bw(x, y) == label  %�ҵ���һ���߽��
                        center_x = x;
                        center_y = y;
                        point = [point; [x, y]]; 
                        judge_flag = [i, j, x, y];
                        if get_next == 0    %ȷ����ʼ�㼰�䷽��
                            flag(3) = x;
                            flag(4) = y;
                            get_next = 1;
                            judge_flag = [];
                        end
                        break;  %�Ѿ��ҵ��߽�㣬��������Χ������������һ��ı߽������
                    end
                end
                k = mod(k, 8) + 1;
            end
            %��һ���߽�����������
            start = mod((k + 4), 8) + 1;
        end
        
        boundaries = [boundaries, point];
        bw = bw - (bw == label) * label;
    end
end

end

imshow(label2rgb(I, @gray, [.5 .5 .5]))%��ʾͼ��
hold on
for k = 1 : length(boundaries)
	boundary = boundaries{k};
	plot(boundary(:, 2), boundary(:, 1), 'w', 'LineWidth', 2)
end%����ѭ����ʾ�������