%% Equalize the received signal for RMC R.4 after channel estimation. Use the MMSE equalizer.
%Create cell-wide configuration structure and generate transmit signal. Configure propagation channel.

enb = lteRMCDL('R.4');
[txSignal,~,info] = lteRMCDLTool(enb,[1;0;0;1]);
% Channel Configuration
chcfg.DelayProfile = 'EPA';
chcfg.NRxAnts = 1; %number of receiving antenna
chcfg.DopplerFreq = 70;
chcfg.MIMOCorrelation = 'Low';
chcfg.SamplingRate = info.SamplingRate;
chcfg.Seed = 1;
chcfg.InitPhase = 'Random';
chcfg.InitTime = 0;

txSignal = [txSignal; zeros(15,1)];
N = length(txSignal);

%% Change the noise to see the difference , i.e 1e-3 to 1e-2
noise = 1e-2*complex(randn(N,chcfg.NRxAnts),randn(N,chcfg.NRxAnts));

rxSignal = lteFadingChannel(chcfg,txSignal)+noise; %based on multipath rayleigh

MmseLTE(enb,txSignal,N,noise,rxSignal);
zeroforcingLTE(enb,txSignal,N,noise,rxSignal);
