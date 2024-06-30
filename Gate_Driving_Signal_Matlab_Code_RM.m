clear;
close all;
% set up parameter
fc = 10.3e6;        % carrier freq
fsym = 100e3;       % symbol rate          
fsamp = 250e6;        % sampling rate
d1 = 50;            % duty cycle 1
d2 = 35;            % duty cycle 2
d3 = 30;
d4 = 27;
p_d1 = 0.15;        % percentage of duty cycle 1
p_d2 = 0.10;    % percentage of duty cycle 2
p_d3 = 0.10;
% p_d4 = 1 - p_d1 - p_d2 - p_d3;
T0 = 0.1/fsym;    % time of zeros
T_offset = 0; % offset of Q mod sig

% calculate time steps
Tc = 1 / fc;        % period of carrier
Tsym = 1 / fsym;    % period of symbol
Tsamp = 1 / fsamp;  % period of sampling
T1 = round((Tsym * p_d1) / Tc) * Tc; % period of duty cycle 1, rounded to integer number of carrier period
T2 = round((Tsym * p_d2) / Tc) * Tc; % period of duty cycle 1, rounded to integer number of carrier period
T3 = round((Tsym * p_d3) / Tc) * Tc;
T4 = Tsym - T1 - T2 - T3 - T0;
t1 = 0 : Tsamp: (T1 - Tsamp); % time steps of duty cycle 1
t2 = 0 : Tsamp: (T2 - Tsamp); % time steps of duty cycle 2
t3 = 0 : Tsamp: (T3 - Tsamp); % time steps of duty cycle 3
t4 = 0 : Tsamp: (T4 - Tsamp); % time steps of duty cycle 3
% Gate driving sigal of symbol 0
x1 = 0.5 + 0.5 * square(2 * pi * fc * t1, d1); % signal of duty cycle 1
x2 = 0.5 + 0.5 * square(2 * pi * fc * t2, d2); % signal of duty cycle 2
x3 = 0.5 + 0.5 * square(2 * pi * fc * t3, d3);
x4 = 0.5 + 0.5 * square(2 * pi * fc * t4, d4);
x0 = zeros(1, round(T0 / Tsamp));
sym0 = [x1 x2 x3 x4 x0];
% Gate driving  sigal of symbol 1
x1 = 0.5 + 0.5 * square(2 * pi * fc * t1 + pi, d1); % signal of duty cycle 1
x2 = 0.5 + 0.5 * square(2 * pi * fc * t2 + pi, d2); % signal of duty cycle 2
x3 = 0.5 + 0.5 * square(2 * pi * fc * t3 + pi, d3);
x4 = 0.5 + 0.5 * square(2 * pi * fc * t4 + pi, d4);
x0 = zeros(1, round(T0 / Tsamp));
sym1 = [x1 x2 x3 x4 x0];

plot(square(2 * pi * (0:0.01:1) + pi, d1))

% saving results
GDS_1 = [sym1];
fname = sprintf('GDS_1_%d_d%d_%d_d%d_%d_d%d_%d_%.1fu_%dk.csv', ...
    round(d1), round(p_d1*100), round(d2), round(p_d2*100), ...
    round(d3), round(p_d2*100), round(d4), ...
    T0*1e6, round(fsym/1e3));
writematrix(GDS_1',fname)

GDS_0 = [sym0];
fname = sprintf('GDS_0_%d_d%d_%d_d%d_%d_d%d_%d_%.1fu_%dk.csv', ...
    round(d1), round(p_d1*100), round(d2), round(p_d2*100), ...
    round(d3), round(p_d2*100), round(d4), ...
    T0*1e6, round(fsym/1e3));
writematrix(GDS_0',fname)

% Q modulation control signal
Qmod = [ones(length(x1) + length(x2) + length(x3) + length(x4), 1); zeros(length(x0), 1)];
Qmod2 = [Qmod];
fname = sprintf('Qmod_%.1fu_%dk_%d.csv', T0*1e6, round(fsym/1e3), length(Qmod2));
writematrix(Qmod2,fname);

% length(Qmod)

figure();
tp = (0:length(Qmod)-1) * Tsamp * 1e6;
subplot(2, 1, 1); hold off; plot(tp, sym0); hold on; plot(tp, sym1); 
title('Gate driving signal'); xlabel('Time (us)'); ylim([-0.2,1.2]); 
legend('Symbol 0', 'Symbol 1');
subplot(2, 1, 2); plot(tp, Qmod, 'k'); ylim([-0.2,1.2]); 
xlabel('Time (us)'); title('Q-mod signal');

% legend('GDS Symbol 0', 'GDS Symbol 1', 'Q mod');

% 
% % modulation
% Nsym=200;
% symbols = (randn(Nsym, 1)) > 0.5;
% Nsps = length(sym0);
% data = zeros(Nsps * Nsym, 1);
% figure();
% plot(symbols);
% for n = 1 : Nsym
%     if symbols == 0
%         data((1 : Nsps) + (n-1) * Nsps) = sym0;
%     else
%         data((1 : Nsps) + (n-1) * Nsps) = sym1;
%     end
% end
% 
% figure();
% plot(data);
% 
% 
% 
% 
% 
