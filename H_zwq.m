function [phi_veritical,H,R]= H_zwq(h,v_wind,m_zhongwuqiu)
%������ö�ٺ���
%%%���峣��%%%%%%%%%%%%%%��ʹ��SI�Ƶ�λ��
%�������ٶ�
g=9.8;
%��ˮ�ܶ�
rho_haishi = 1.025 * 10 ^(3);
%���ܶȣ��Ͻ�֣�
rho_gang = 7.9 * 10 ^ 3;
%��Ͱ����
m_gangtong = 100;
%��Ͱ���
V_gangtong = pi * (0.3/2)^2 * 1;
%��������
m_fubiao = 1000;
%ÿ��ê������
l_maolian = 105 * 10 ^(-3);
m_maolian_for_everymile = 7;
%ê���ܳ���
l_total_maolian = 22.05;
%��ѭ��������
n=floor(l_total_maolian / l_maolian) + 5;
%�ֹܳ���
l_gangguan = 1;
%%%%%%%%%%%%%%%%%

%%%�������%%%%%%%%%%%%%%
%%��������h������ˮ���
%h=0.684;
%%�ֹ�����
m_gangguan = 10;
%%�ֹ�������ֹܹ�4�ڣ�ÿ�ڳ���1m��ֱ��Ϊ50mm��ÿ�ڸֹܵ�����Ϊ10kg��
v_gangguan = l_gangguan *(pi*(50/2 * 10^(-3))^2);
%%����������
%m_zhongwuqiu = 1200;
%%�����������ѡ�ø�����Ϊʵ�ģ�
V_zhongwuqiu = m_zhongwuqiu / rho_gang;
%ÿ��ê��������
m_maolian = l_maolian * m_maolian_for_everymile;
%ÿ��ê�����������Ϊʵ�ģ�
v_maolian = m_maolian / rho_gang;
%����ֹܡ���Ͱ��ê������б�Ƕȴ�������
phi_veritical = [];
phi = [];
%������б�ǶȻ��ȱ���
arc_tan_inner = [];
%����ˮ���ʼ����ˮ����ڸ����û��ȣ�
H = h;
%�����ζ��뾶����ʼֵ��
R=0;
%%%%%%%%%%%%%%%%%

%%%����������
%D�Ƿ���ͶӰ
D = 2 * ( 2 - h);
%���ٴ�С��<1>����12��24<2>����36<3>����36��
%v_wind = 12;
%ˮƽ����T1cos_theta = F_��
T_cos_theta = 0.625.*D * (v_wind)^2;
%��ֱ����T1sin_theta = ���� - ��������
T_sin_theta = rho_haishi * g * ( h* pi * 1^2) - m_fubiao * g;
%����T_sin��T_cos��Ϊ��һ�ڸֹܵĳ�ʼֵ
arc_tan_inner = ( (2 *T_sin_theta - ( m_gangguan * g -  rho_haishi * g * v_gangguan))) / (2* T_cos_theta);
phi = atan(arc_tan_inner);
H = [H , l_gangguan*sin(phi)];
R = [R , l_gangguan*cos(phi)];
phi_veritical = [phi_veritical 90-phi*180/pi];
T_sin_theta = T_sin_theta - ( m_gangguan * g -  rho_haishi * g * v_gangguan);

for i_bianli = 2 : n
    if(i_bianli <= 4)
     %%�ֹܼ��㲿��
     %�ֹܹ�4�ڣ�ÿ�ڳ���1m��ֱ��Ϊ50mm��ÿ�ڸֹܵ�����Ϊ10kg��
     %ǰ����T_sin_theta��Ӧi_bianli
     arc_tan_inner = ( (2 *T_sin_theta - ( m_gangguan * g -  rho_haishi * g * v_gangguan))) / (2* T_cos_theta);
     %������б�Ƕ�
     phi = atan(arc_tan_inner);
     H = [H , l_gangguan*sin(phi)];
     R = [R , l_gangguan*cos(phi)];
     phi_veritical = [phi_veritical 90-phi*180/pi];
     T_sin_theta = T_sin_theta - ( m_gangguan * g -  rho_haishi * g * v_gangguan);
    elseif(i_bianli == 5)
     %%������͸�Ͱ���㲿��
     
     %������͸�Ͱ������-������
     arc_tan_inner = ( (2 *T_sin_theta - (m_zhongwuqiu * g - rho_haishi * g * V_zhongwuqiu) )) / (2* T_cos_theta);
     %������б�Ƕ�phi_5
     phi = atan(arc_tan_inner);
     H = [H , l_gangguan*sin(phi)];
     R = [R , l_gangguan*cos(phi)];
     phi_veritical = [phi_veritical 90-phi*180/pi];
     %����T6_sin_theta
     T_sin_theta = T_sin_theta - (m_zhongwuqiu * g - rho_haishi * g * V_zhongwuqiu) - (m_gangtong * g - rho_haishi * g * V_gangtong);
     
     %- (m_zhongwuqiu * g - rho_haishi * g * V_zhongwuqiu)
     %- (m_gangtong*g - rho_haishi * g * V_gangtong)
    elseif(i_bianli == 6)
     %%ê�����㲿��
     arc_tan_inner = ( (2 *T_sin_theta - ( m_maolian * g -  rho_haishi * g * v_maolian))) / (2* T_cos_theta);
     %- (m_zhongwuqiu * g - rho_haishi * g * V_zhongwuqiu)
     %������б�Ƕ�phi_6
     phi = atan(arc_tan_inner);
     H = [H , l_maolian*sin(phi)];
     R = [R , l_maolian*cos(phi)];
     phi_veritical = [phi_veritical 90-phi*180/pi];
     %����T7_sin_theta
     T_sin_theta = T_sin_theta - ( m_maolian * g -  rho_haishi * g * v_maolian);
    else
     %%ê�����㲿��
     arc_tan_inner = ( (2 *T_sin_theta - ( m_maolian * g -  rho_haishi * g * v_maolian))) / (2* T_cos_theta);
     %������б�Ƕ�phi_7����
     phi = atan(arc_tan_inner);
     H = [H , l_maolian*sin(phi)];
     R = [R , l_maolian*cos(phi)];
     phi_veritical = [phi_veritical 90-phi*180/pi];
     %����T8����_sin_theta
     T_sin_theta = T_sin_theta - ( m_maolian * g -  rho_haishi * g * v_maolian);
    end
end
end
