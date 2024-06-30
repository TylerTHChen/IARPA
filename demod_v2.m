clear;
close all;

%% define parameters
fc = 10.3e6;        % carrier frequency
fsym = 100e3;       % symbol rate          
fsamp = 2.50e9;     % sampling rate
Nsym=500;           % Number of symbols

Tsym = 1 / fsym;    % Period of symbol
Tsamp = 1 / fsamp;  % Period of sample
t = 0 : Tsamp: (Tsym - Tsamp); % time sequence 



%% load measured BPSK signal
load('Iant2.mat');
sig_BPSK = Iant(1:fsamp/fsym*Nsym);

%% gen. ideal BPSK signal
% sym0 = cos(2 * pi * fc * t);
% sym1 = cos(2 * pi * fc * t + pi);
% symbols = zeros(Nsym, 1);
% symbols = (randn(Nsym, 1)) > 0.5;
% Nsps = length(sym0);
% sig_BPSK = zeros(Nsps * Nsym, 1);
% % figure();
% % plot(symbols, 'o'); title('symbols');
% for n = 1 : Nsym
%     if symbols(n) == 0
%         sig_BPSK((1 : Nsps) + (n-1) * Nsps) = sym0;
%     else
%         sig_BPSK((1 : Nsps) + (n-1) * Nsps) = sym1;
%     end
% end
% % figure();
% % plot(sig_BPSK);
% % xlim([7e4, 8e4])

%% down-convert to baseband (IF = 0 Hz)
Nds1 = 100;
sig_BPSK = downsample(sig_BPSK, Nds1);
% plot(abs(fft(sig_BPSK)))
flo = 10.3e6;
Tsamp = Tsamp * Nds1;
fsamp1 = 1 / Tsamp;
t = (0 : Tsamp: (Nsym * Tsym - Tsamp))';
sig_IF = exp(-1i * 2 * pi * flo * t) .* sig_BPSK;
[n,fo,ao,w] = firpmord([500e3 2000e3],[1 0],[0.001 0.01], fsamp1);
b = firpm(n,fo,ao,w);
% freqz(b, 1, [], fsamp1);
%% demod, BPSK, accombination of Costas loop and frequency synchronization
Nds2 = 250;
sig_BB = downsample(filter(b, 1, sig_IF), Nds2, 100);
fsamp2 = fsamp1 * Nds2;
Tsamp2 = 1 / fsamp2;
N = length(sig_BB); % length of downsampled baseband signal
ph_comp = 0;        % phase compensation
F_srch = 0.7;       % loop bandwidth of phase-locked loop, in searching period
F_lock = 0.1;       % loop bandwidth of phase-locked loop, after locked
F_pll = F_srch;     % current loop bandwidth
avg_ph = 0;         % averaged phase change between adjacent samples
F_fll = 0.3;        % loop bandwidth of frequency-locked loop
flag_lock = 0;      % flag indicating whether PLL is locked, 0-searching, 1-locked 
nco = zeros(N, 1);  % Numerical controled oscillator （NCO)
ph_err = zeros(N, 1);% Phase error between NCO and baseband signal
Nf = 5;             % length for determine whether PLL is locked
for n = 1:N
    nco(n) = exp(1i * (-ph_comp  ));
    da = angle(nco(n) * conj(sig_BB(n))); % da \in [-pi, pi]
    % costas loop, phase error, BPSK
    if da > pi/2 % left half plane in IQ plot
        ph_err(n) = da -  pi;
    elseif da < -pi/2 
        ph_err(n) = da +  pi;
    else % right half plane
        ph_err(n) = da;
    end
    % Frequency error
    if n > 1
        avg_ph = (avg_ph + F_fll * angle(nco(n) * nco(n-1)')) / (1 + F_fll);
    end
    % determine whether PLL is locked
    if flag_lock == 0 && n > Nf && mean(abs(ph_err(n-Nf+1:n)))<0.1
        F_pll = F_lock;
        flag_lock = 1
        n 
    end
    ph_comp = F_pll * ph_err(n) + ph_comp - avg_ph;
end
% figure();
% plot(phase(sig_BB)); hold on; plot(phase(nco));
sig_BB = sig_BB .* conj(nco);
sig_BB = sig_BB / (norm(sig_BB)/sqrt(Nsym));
figure();
plot(ph_err);
figure();
plot(sig_BB, 'o');
axis([-1.5 1.5 -1.5 1.5]);
xlabel('I channel');
ylabel('Q channel');
title('Constellation of measured antenna current');


