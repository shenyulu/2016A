function [phi_veritical,H,R]= H_zwq(h,v_wind,m_zhongwuqiu)
%重物球枚举函数
%%%定义常量%%%%%%%%%%%%%%（使用SI制单位）
%重力加速度
g=9.8;
%海水密度
rho_haishi = 1.025 * 10 ^(3);
%钢密度（合金钢）
rho_gang = 7.9 * 10 ^ 3;
%钢桶质量
m_gangtong = 100;
%钢桶体积
V_gangtong = pi * (0.3/2)^2 * 1;
%浮标质量
m_fubiao = 1000;
%每段锚链长度
l_maolian = 105 * 10 ^(-3);
m_maolian_for_everymile = 7;
%锚链总长度
l_total_maolian = 22.05;
%总循环遍历数
n=floor(l_total_maolian / l_maolian) + 5;
%钢管长度
l_gangguan = 1;
%%%%%%%%%%%%%%%%%

%%%定义变量%%%%%%%%%%%%%%
%%搜索变量h——吃水深度
%h=0.684;
%%钢管质量
m_gangguan = 10;
%%钢管体积：钢管共4节，每节长度1m，直径为50mm，每节钢管的质量为10kg。
v_gangguan = l_gangguan *(pi*(50/2 * 10^(-3))^2);
%%重物球质量
%m_zhongwuqiu = 1200;
%%重物球体积（选用钢球，认为实心）
V_zhongwuqiu = m_zhongwuqiu / rho_gang;
%每段锚链的质量
m_maolian = l_maolian * m_maolian_for_everymile;
%每段锚链的体积（认为实心）
v_maolian = m_maolian / rho_gang;
%定义钢管、钢桶和锚链的倾斜角度储存向量
phi_veritical = [];
phi = [];
%定义倾斜角度弧度变量
arc_tan_inner = [];
%计算水深（初始条件水深等于浮标浸没深度）
H = h;
%浮标游动半径（初始值）
R=0;
%%%%%%%%%%%%%%%%%

%%%浮标受力；
%D是法向投影
D = 2 * ( 2 - h);
%风速大小（<1>考虑12和24<2>考虑36<3>考虑36）
%v_wind = 12;
%水平方向，T1cos_theta = F_风
T_cos_theta = 0.625.*D * (v_wind)^2;
%竖直方向，T1sin_theta = 浮力 - 浮标重力
T_sin_theta = rho_haishi * g * ( h* pi * 1^2) - m_fubiao * g;
%浮标T_sin和T_cos即为第一节钢管的初始值
arc_tan_inner = ( (2 *T_sin_theta - ( m_gangguan * g -  rho_haishi * g * v_gangguan))) / (2* T_cos_theta);
phi = atan(arc_tan_inner);
H = [H , l_gangguan*sin(phi)];
R = [R , l_gangguan*cos(phi)];
phi_veritical = [phi_veritical 90-phi*180/pi];
T_sin_theta = T_sin_theta - ( m_gangguan * g -  rho_haishi * g * v_gangguan);

for i_bianli = 2 : n
    if(i_bianli <= 4)
     %%钢管计算部分
     %钢管共4节，每节长度1m，直径为50mm，每节钢管的质量为10kg。
     %前方的T_sin_theta对应i_bianli
     arc_tan_inner = ( (2 *T_sin_theta - ( m_gangguan * g -  rho_haishi * g * v_gangguan))) / (2* T_cos_theta);
     %计算倾斜角度
     phi = atan(arc_tan_inner);
     H = [H , l_gangguan*sin(phi)];
     R = [R , l_gangguan*cos(phi)];
     phi_veritical = [phi_veritical 90-phi*180/pi];
     T_sin_theta = T_sin_theta - ( m_gangguan * g -  rho_haishi * g * v_gangguan);
    elseif(i_bianli == 5)
     %%重物球和钢桶计算部分
     
     %重物球和钢桶的重力-浮力；
     arc_tan_inner = ( (2 *T_sin_theta - (m_zhongwuqiu * g - rho_haishi * g * V_zhongwuqiu) )) / (2* T_cos_theta);
     %计算倾斜角度phi_5
     phi = atan(arc_tan_inner);
     H = [H , l_gangguan*sin(phi)];
     R = [R , l_gangguan*cos(phi)];
     phi_veritical = [phi_veritical 90-phi*180/pi];
     %计算T6_sin_theta
     T_sin_theta = T_sin_theta - (m_zhongwuqiu * g - rho_haishi * g * V_zhongwuqiu) - (m_gangtong * g - rho_haishi * g * V_gangtong);
     
     %- (m_zhongwuqiu * g - rho_haishi * g * V_zhongwuqiu)
     %- (m_gangtong*g - rho_haishi * g * V_gangtong)
    elseif(i_bianli == 6)
     %%锚链计算部分
     arc_tan_inner = ( (2 *T_sin_theta - ( m_maolian * g -  rho_haishi * g * v_maolian))) / (2* T_cos_theta);
     %- (m_zhongwuqiu * g - rho_haishi * g * V_zhongwuqiu)
     %计算倾斜角度phi_6
     phi = atan(arc_tan_inner);
     H = [H , l_maolian*sin(phi)];
     R = [R , l_maolian*cos(phi)];
     phi_veritical = [phi_veritical 90-phi*180/pi];
     %计算T7_sin_theta
     T_sin_theta = T_sin_theta - ( m_maolian * g -  rho_haishi * g * v_maolian);
    else
     %%锚链计算部分
     arc_tan_inner = ( (2 *T_sin_theta - ( m_maolian * g -  rho_haishi * g * v_maolian))) / (2* T_cos_theta);
     %计算倾斜角度phi_7……
     phi = atan(arc_tan_inner);
     H = [H , l_maolian*sin(phi)];
     R = [R , l_maolian*cos(phi)];
     phi_veritical = [phi_veritical 90-phi*180/pi];
     %计算T8……_sin_theta
     T_sin_theta = T_sin_theta - ( m_maolian * g -  rho_haishi * g * v_maolian);
    end
end
end
