% �}�E�X�̊����f�[�^�����
% cage.m�����s������ɂ����������s

% ���[�U�����͂���Ƃ���́A
% �EUI�ŉ�͂������t�@�C����I��
% �E�R�}���h�E�B���h�E�ŁAGet�������Ă��牽�b��Ƀ}�E�X����ꂽ�������
% �ł�

%% 0.��������̍� %%

% i)Get�������Ă���ŏ���5�b���炢�͉����u���Ȃ�
% �@�@�@���d���̃f�t�H���g�l�𒲐����邽��

% ii)�}�E�X������B���̎��̎��Ԃ̓������Ă���
% �@�@  �����s���ɓ��͂��Ă��炤����

%% 1.csv�t�@�C���̓ǂݍ��� & �d���l���� %%

% �t�@�C���ǂݍ���
[file,path] = uigetfile('*.csv');
if isequal(file,0)
    disp('selected Cancel');
else
    disp(['selected: ', fullfile(path,file)]);
end

m = readmatrix(file);

% Get�������Ă��牽�b��Ƀ}�E�X����ꂽ�������
prompt = "�}�E�X����ꂽ�͉̂��b��? : ";
t0= input(prompt);
t_main = t0*10;

% �ォ��Ach0(��)�Ach1(��)�Ach2(��)�Ach3(��)
m0 = m(:,1); 
m1 = m(:,2);  
m2 = m(:,3);
m3 = m(:,4);


% ���Ԃ��ƂɁA�ech�̓d�����v���b�g
% �T���v�����O���g��f = 10[Hz] �Ȃ̂�
% �����͎���(10^(-1)sec)�A�c���͊ech�̓d��
% �����O�̓d����`�悵�����Ƃ��͈ȉ��̃R�[�h�̃R�����g�������g��

% figure
% T = size(m,1);
% t = linspace(0,T,T);
% 
% hold on
% sz = 5;
% scatter(t,m0,sz,'MarkerEdgeColor','none','MarkerFaceColor','#EDB120');
% scatter(t,m1,sz,'MarkerEdgeColor','none','MarkerFaceColor','#0072BD');
% scatter(t,m2,sz,'MarkerEdgeColor','none','MarkerFaceColor','#D95319');
% scatter(t,m3,sz,'MarkerEdgeColor','none','MarkerFaceColor','#77AC30');
% title('�eCh�̌v���d���i�����O�j')
% legend
% ylim([-0.5, 0.5])
% hold off

% % �������̊eCh�̓d��
% figure
% T = t_main;
% t = linspace(0,T,T);
% 
% m_adjing0 = m0(1:T,1);
% m_adjing1 = m1(1:T,1);
% m_adjing2 = m2(1:T,1);
% m_adjing3 = m3(1:T,1);
% 
% hold on
% sz = 5;
% scatter(t,m_adjing0,sz,'MarkerEdgeColor','none','MarkerFaceColor','#EDB120');
% scatter(t,m_adjing1,sz,'MarkerEdgeColor','none','MarkerFaceColor','#0072BD');
% scatter(t,m_adjing2,sz,'MarkerEdgeColor','none','MarkerFaceColor','#D95319');
% scatter(t,m_adjing3,sz,'MarkerEdgeColor','none','MarkerFaceColor','#77AC30');
% title('�eCh�̌v���d���i�}�E�X�u���܂� & �����O�j')
% legend
% ylim([-0.5, 0.5])
% hold off


% �d���̃f�t�H���g�l�𒲐�
% �v���X�^�[�g����3�b��̒l��0�Ƃ���

m_adj0 = m0 - m(30,1); 
m_adj1 = m1 - m(30,2);  
m_adj2 = m2 - m(30,3);
m_adj3 = m3 - m(30,4);

% �������̊eCh�̓d���i������j
figure
T = t_main;
t = linspace(0,T,T);

m_adjed0 = m_adj0(1:T,1);
m_adjed1 = m_adj1(1:T,1);
m_adjed2 = m_adj2(1:T,1);
m_adjed3 = m_adj3(1:T,1);

hold on
sz = 5;
scatter(t,m_adjed0,sz,'MarkerEdgeColor','none','MarkerFaceColor','#EDB120');
scatter(t,m_adjed1,sz,'MarkerEdgeColor','none','MarkerFaceColor','#0072BD');
scatter(t,m_adjed2,sz,'MarkerEdgeColor','none','MarkerFaceColor','#D95319');
scatter(t,m_adjed3,sz,'MarkerEdgeColor','none','MarkerFaceColor','#77AC30');
title('�eCh�̌v���d���i������A�}�E�X�u���܂ł̎��ԁj')
legend
ylim([-0.5, 0.5])
hold off


% �������v���b�g
figure
T = size(m,1);
t = linspace(0,T,T);

hold on
sz = 5;
scatter(t,m_adj0,sz,'MarkerEdgeColor','none','MarkerFaceColor','#EDB120');
scatter(t,m_adj1,sz,'MarkerEdgeColor','none','MarkerFaceColor','#0072BD');
scatter(t,m_adj2,sz,'MarkerEdgeColor','none','MarkerFaceColor','#D95319');
scatter(t,m_adj3,sz,'MarkerEdgeColor','none','MarkerFaceColor','#77AC30');
title('�eCh�̌v���d���i������j')
legend
ylim([-0.5, 0.5])
hold off

%% 2.���W�֕ϊ�&�P�[�W�̃G�b�W�`�� %%

% 4�_�̓d���̍�����A�Q�[�W�̒��S�����_�Ƃ���
% ���ΓI��(x,y)���W���v�Z
x = ((m_adj3 - m_adj2) + (m_adj1 - m_adj0)) / 2;
y = ((m_adj3 - m_adj1) + (m_adj2 - m_adj0)) / 2;

% �ʒu���S��
figure
sz = 20;
hold on
scatter(x, y, sz);
rectangle('Position',[rec_x1 rec_y1 width height], 'EdgeColor', '#A2142F', 'LineWidth', 3)
title('�}�E�X�̈ʒu�ƃP�[�W')
xlim([-0.1, 0.1])
ylim([-0.1, 0.1])
hold off

% �}�E�X������O�̃f�[�^���폜
% �}�E�X�v�����̃f�[�^��x_main�ƌĂ�
m_main0 = m_adj0(t_main:end,:);
m_main1 = m_adj1(t_main:end,:);
m_main2 = m_adj2(t_main:end,:);
m_main3 = m_adj3(t_main:end,:);

x_main = ((m_main3 - m_main2) + (m_main1 - m_main0)) / 2;
y_main = ((m_main3 - m_main1) + (m_main2 - m_main0)) / 2;

%% 3.�G���[�|�C���g�̌��o&�폜 %%

% �G���[�������������̂�x_main_noerror�ƌĂ�
% �P�[�W�̊O�̈ʒu�ɂ�����̂͏����H���ǂ̗]�n���肻��
% �ʓ|�����ǁAx_main_noerror�̎��O���蓖�ĂƂ��̖��ň�xx_main,y_main�����������Ă���G���[�����o���A
% �G���[�łȂ����̂�x_main_noerror�ɑ�����Ă���

% �G���[�J�E���g(error_count�ƌĂ�)
e = size(x_main,1);
error_count = 0;
for l = 1:e
    if x_main(l,1) < rec_x1-0.02 || x_main(l,1) > rec_x2+0.02 || y_main(l,1) < rec_y1-0.02 || y_main(l,1) > rec_y2+0.02
        error_count = error_count+1;
            continue
    end
end

% ���O���蓖��
e_noerror = size(x_main,1) - error_count;
x_main_noerror = zeros(e_noerror,1); 
y_main_noerror = zeros(e_noerror,1);

% �G���[�|�C���g�����������̂���
n=1;
for l = 1:e
    if x_main(l,1) > rec_x1-0.02 && x_main(l,1) < rec_x2+0.02 && y_main(l,1) > rec_y1-0.02 && y_main(l,1) < rec_y2+0.02
        x_main_noerror(n,1) = x_main(l,1);
        y_main_noerror(n,1) = y_main(l,1);
        n = n+1;
    end
end

%% 4.�}�E�X�̈ʒu�̕`�� %%

% % �}�E�X�̈ʒu���̕`��i�G���[�|�C���g������j
% figure
% sz = 20;
% hold on
% scatter(x_main_noerror, y_main_noerror, sz);
% rectangle('Position',[rec_x1 rec_y1 width height], 'EdgeColor', '#A2142F', 'LineWidth', 3)
% title('�}�E�X�̈ʒu�i�G���[�|�C���g�����j�ƃP�[�W')
% xlim([-0.1, 0.1])
% ylim([-0.1, 0.1])
% hold off


% �P�b���̃f�[�^�ɕϊ�

% �P�b����x_main
% x_main_ps�ƌĂ�
% �v�Z�p�t�H�[�}���X����̂��߂̎��O���蓖��
e = size(x_main,1);
x_main_ps_size = fix(e / 10);
y_main_ps_size = fix(e / 10);
x_main_ps = zeros(x_main_ps_size,1);
y_main_ps = zeros(y_main_ps_size,1);

% �f�[�^�̑��
j = 1;
for i = 1:10:e
   x_main_ps(j,1) = x_main(i,1);
   y_main_ps(j,1) = y_main(i,1);
   j = j + 1;
end

% �P�b����x_main_noerror
% �v�Z�p�t�H�[�}���X����̂��߂̎��O���蓖��
e = size(x_main_noerror,1);
x_main_noerror_ps_size = fix(e / 10);
y_main_noerror_ps_size = fix(e / 10);
x_main_noerror_ps = zeros(x_main_ps_size,1);
y_main_noerror_ps = zeros(y_main_ps_size,1);

% �f�[�^�̑��
j = 1;
for i = 1:10:e
   x_main_noerror_ps(j,1) = x_main_noerror(i,1);
   y_main_noerror_ps(j,1) = y_main_noerror(i,1);
   j = j + 1;
end

% �P�b���̃}�E�X�̈ʒu��`��
figure
sz = 20;
hold on
scatter(x_main_ps, y_main_ps, sz);
rectangle('Position',[rec_x1 rec_y1 width height], 'EdgeColor', '#A2142F', 'LineWidth', 3)
title('�}�E�X�̈ʒu�ƃP�[�W�i�P�b���j')
xlim([-0.1, 0.1])
ylim([-0.1, 0.1])
hold off

%% 5.���ړ������̌v�Z[dsum] %%

% �G���[�|�C���g�͏��������ɑ��ړ��������v�Z����
% �P�b�Ԃɂ��܂�ɂ����ς��ړ��i�P�[�W���ӂ̂Q�{�̋����j�������Ă���G���[�Ƃ���
% ���̕����C�̎w�W�Ƃ��Ă����������H�ierror_count2�j

dsum = 0;
e = x_main_ps_size - 1;
error_count2 = 0;

for i = 1:e
    temp = sqrt((x_main_ps(i+1,1) - x_main_ps(i,1))^2 + (y_main_ps(i+1,1) - y_main_ps(i,1))^2) * d;
    if temp > width *2
        temp = 0;
        error_count2 = error_count2 + 1;
    end
    dsum = dsum + temp;
end


%% 6.1hour������̈ړ�����[hsum] %%

% �P�b�Ԃɂ��܂�ɂ����ς��ړ��i�P�[�W���ӂ�1.5�{�̋����j�������Ă���G���[�Ƃ���

h = fix(size(m,1) / 36000);
hsum = zeros(h,1); 
 
for k = 1:h
    p = 3600 *(k-1) + 2;
   for j = p:3600 *k 
       temp = sqrt((x_main_ps(j+1,1) - x_main_ps(j,1))^2 + (y_main_ps(j+1,1) - y_main_ps(j,1))^2) * d;
       if temp > width *1.5
        temp = 0;
       end
       hsum(k,1) = hsum(k,1) + temp;
   end
end

% ���Ԗ��̖_�O���t��\��
figure
hold on
hx = 1:h;
bar(hx,hsum(:,1))
ylim([0, 120])
title('�P���Ԃ�����̈ړ�����')
ylabel('Distance [m]')
xlabel('Time [hour]')
hold off

%% 7.1hour������̈ʒu�̂΂�� %%

% �P�b�Ԃɂ��܂�ɂ����ς��ړ��i�P�[�W���ӂ�1.5�{�̋����j�������Ă���G���[�Ƃ���
% x,y���ꂼ��̕W���΍������߁A�����ĂQ�Ŋ��������̂��w�W�Ƃ���
% �Q�l�ɂȂ邩�͂܂��s��

sx = zeros(h,1);
sy = zeros(h,1);

for k = 1:h
    p = 3600 *(k-1) + 2;
   for j = p:3600 *k 
       temp = sqrt((x_main_ps(j+1,1) - x_main_ps(j,1))^2 + (y_main_ps(j+1,1) - y_main_ps(j,1))^2) * d;
       if temp > width *1.5
        x_main_ps(j+1,1) = x_main_ps(j,1);
        y_main_ps(j+1,1) = y_main_ps(j,1);
       end
       sx(k,1) = std(x_main_ps(p:3600 *k));
       sy(k,1) = std(y_main_ps(p:3600 *k));
   end
end

s = (sx + sy) /2;

% ���Ԗ��̖_�O���t��\��
figure
hold on
hx = 1:h;
bar(hx,s(:,1))
title('�P���Ԃ�����̈ʒu�̂΂��')
ylabel('Standard deviation')
xlabel('Time[hour]')
hold off
