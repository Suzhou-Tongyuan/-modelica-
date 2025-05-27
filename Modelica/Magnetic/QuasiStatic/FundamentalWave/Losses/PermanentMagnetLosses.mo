within Modelica.Magnetic.QuasiStatic.FundamentalWave.Losses;
model PermanentMagnetLosses 
  "取决于电流和速度的永磁损耗模型"
  extends Modelica.Electrical.Machines.Interfaces.FlangeSupport;
  import Modelica.Electrical.QuasiStatic.Polyphase.Functions.quasiRMS;
  parameter Integer m(min=1) = 3 "阶段数" annotation(Evaluate=true);
  parameter
    Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters 
    permanentMagnetLossParameters "永磁损耗参数";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  input SI.ComplexCurrent is[m] 
    "瞬时定子电流";
  SI.Current iRMS=quasiRMS(is);
equation
  if (permanentMagnetLossParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -permanentMagnetLossParameters.tauRef*(permanentMagnetLossParameters.c + (1 - permanentMagnetLossParameters.c)* 
      (iRMS/permanentMagnetLossParameters.IRef)^permanentMagnetLossParameters.power_I)* 
      sign(w)*(abs(w)/permanentMagnetLossParameters.wRef)^permanentMagnetLossParameters.power_w;
  end if;
  lossPower = -tau*w;
  annotation (defaultComponentName="magnetLoss", Icon(graphics={Ellipse(extent={{-40,-40},{40,40}}, lineColor= 
              {200,0,0})}), Documentation(info="<html>
<p>
永磁损耗模型取决于电流和速度.
</p>
<p>
永磁损耗的建模方式不会导致电路中的电压降。
相反，耗散的损耗通过轴上的等效制动扭矩来考虑.
</p>
<p>
永磁损耗扭矩为
</p>
<blockquote><pre>
tau = PRef/wRef * (c + (1 - c) * (i/IRef)^power_I) * (w/wRef)^power_w
</pre></blockquote>
<p>
其中<code>i</code>为机器的电流，<code>w</code>为实际角速度。
参数<code>c</code>表示即使在电流= 0时也存在的永磁体损耗部分，即与电流无关。
永磁体损耗转矩与定子电流的关系由指数<code>power_I</code>表示。
永磁体损耗转矩与角速度的关系由指数<code>power_w</code>表示。.
</p>
<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters\">Permanent magnet loss parameters</a>
</p>
<p>
如果希望忽略永磁体损耗，请设置<code>strayLoadParameters。PRef = 0</code>(这是默认值).
</p>
</html>"));
end PermanentMagnetLosses;