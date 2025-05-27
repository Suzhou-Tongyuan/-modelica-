within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialNoise 
  "带有实数信号的 SISO 模块接口，可为信号添加噪声"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  annotation();
end PartialNoise;