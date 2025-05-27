within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model GenericHysteresisTellinen "部分特利南滞后模型"
  extends BaseClasses.GenericHysteresis;

  //Real MagRel(start=0, min=-100, max=100) "初始化时的相对磁化率（-100-100）";
  output Boolean asc(start=true) "当 der(Hstat)>0 时为真";
protected
  SI.MagneticFluxDensity hystR "限幅磁滞回路的上升支路";
  SI.MagneticFluxDensity hystF "极限磁滞回路的下降支路";

  SI.MagneticFluxDensity diffHyst 
    "当前工作点的上升和下降极限滞后支路之间的距离";
  Real dHyst(final quantity="MagneticFluxDensitySlope", final unit="T/s") 
    "当前工作点的上升（当 der(H)>0 时）或下降（当 der(H)<0 时）限制迟滞支路的斜率";
  Real k;

  parameter Real mu0(final unit="N/A2") = mu_0;

initial equation

  B = (hystR+hystF)/2 + MagRel*diffHyst/2;

equation

  asc = der(Hstat) > 0;

  der(B) = k * dHyst + mu0 * der(Hstat);

  diffHyst = hystF - hystR;

  if initial() then
    k = 0.01;
    dHyst = 0;
  elseif asc then
    dHyst = der(hystR-mu0*Hstat);
    k = max(0.01,(hystF - B)/diffHyst);
  else
    dHyst = der(hystF-mu0*Hstat);
    k = max(0.01, (B - hystR)/diffHyst);
  end if;

  annotation (Documentation(info="<html>
<p>采用 Tellinen 磁滞模型的磁阻。主要磁滞环由双曲正切函数定义.</p>
<h4>特利宁滞后模型</h4>
<p>泰林磁滞模型是描述铁磁材料磁滞行为的一个简单模型。它只使用主要磁滞回线的上升（hystR）和下降（hystF）分支及其导数 der(hystR) 和 der(hystF)。有关泰林磁滞模型的简短描述，请参见图 1 和以下公式.</p>
<blockquote><pre>
diffHyst = hystF - hystR;
dhR = hystF - b;
dhF = b - hystR;
</pre></blockquote>
<p>如果磁场强度增加 (der(h)&gt;0)</p>
<blockquote><pre>
der(b) = dhR/diffHyst * der(hystR);
</pre></blockquote>
<p>如果磁场强度降低 (der(h)&lt;0)</p>
<blockquote><pre>
der(b) = dhF/diffHyst * der(hystF);
</pre></blockquote>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/TellinenDesc1.png\"/></div></td>
</tr>
</table>
<strong>Fig. 1:</strong> 特利宁滞后模型说明.
</html>"));
end GenericHysteresisTellinen;