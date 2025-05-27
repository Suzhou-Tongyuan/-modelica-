within Modelica.Electrical.Machines.Losses.InductionMachines;
model PermanentMagnetLosses 
  "依赖于电流和速度的永磁体损耗模型"
  extends Machines.Interfaces.FlangeSupport;
  import Modelica.Electrical.Polyphase.Functions.quasiRMS;
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters 
    "永磁体损耗参数";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  input SI.Current is[m] "瞬时定子电流";
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
  annotation (defaultComponentName="magnetLoss", 
    Icon(graphics={Ellipse(extent={{-40,-40},{40,40}}, 
          lineColor={200,0,0})}), Documentation(info="<html>
<p>
永磁体损耗模型依赖于电流和速度。
</p>
<p>
永磁体损耗模型不会导致电路中的电压下降。
相反，通过轴上的等效制动扭矩考虑耗散损耗。
</p>
<p>
永磁体损耗扭矩是
</p>
<blockquote><pre>
tau = PRef/wRef*(c+(1-c)*(i/IRef)^power_I)*(w/wRef)^power_w
</pre></blockquote>
<p>
其中<code>i</code>是机器的电流， <code>w</code> 是实际的角速度。
参数<code>c</code>指定了即使在电流为0时也存在的永磁体损耗的部分，即与电流无关。
永磁体损耗扭矩对定子电流的依赖性由指数<code>power_I</code>建模。
永磁体损耗扭矩对角速度的依赖性由指数<code>power_w</code>建模。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters\">永磁体损耗参数</a>
</p>
<p>
如果希望忽略永磁体损耗，请设置<code>strayLoadParameters.PRef=0</code>(这是默认值)。
</p>
</html>"));
end PermanentMagnetLosses;