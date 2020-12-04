function zeroforcingLTE=zeroforcingLTE(enb,txSignal,N,noise,rxSignal)

%% Perform synchronization and OFDM demodulation.

offset = lteDLFrameOffset(enb,rxSignal);
rxGrid = lteOFDMDemodulate(enb,rxSignal(1+offset:end,:));

%% Create channel estimation configuration structure and perform channel estimation.

cec.FreqWindow = 9;
cec.TimeWindow = 9;
cec.InterpType = 'Cubic';
cec.PilotAverage = 'UserDefined';
cec.InterpWinSize = 3;
cec.InterpWindow = 'Causal';
hest = lteDLChannelEstimate(enb,cec,rxGrid);


%%  Equalize and plot received and equalized grids.

eqGrid = lteEqualizeZF(rxGrid,hest);
figure('Name','Zero Forcing Equalization','NumberTitle','off')
subplot(2,1,1);
surf(abs(rxGrid));
title('Received grid');
xlabel('OFDM symbol'); 
ylabel('Subcarrier');

subplot(2,1,2);
surf(abs(eqGrid));
title('Equalized grid');
xlabel('OFDM symbol'); 
ylabel('Subcarrier');
end
