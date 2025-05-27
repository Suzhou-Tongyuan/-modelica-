within Modelica.Electrical.Batteries.ParameterRecords;
record CellData "电池单体的参数"
  extends Modelica.Electrical.Batteries.Icons.BaseCellRecord;
  parameter SI.ElectricCharge Qnom(displayUnit="A.h") 
    "额定(最大)电荷";
  parameter Boolean useLinearSOCDependency=true 
    "使用线性SOC依赖的OCV，否则基于表格" 
    annotation(Dialog(group="OCV versus SOC"));
  parameter SI.Voltage OCVmax(final min=0) "SOC = SOCmax 时的OCV" 
    annotation(Dialog(group="OCV versus SOC"));
  parameter SI.Voltage OCVmin(final min=0, start=0) "SOC = SOCmin 时的OCV" 
    annotation(Dialog(group="OCV versus SOC", enable=useLinearSOCDependency));
  parameter Real SOCmax(final max=1)=1 "最大充电状态" 
    annotation(Dialog(group="OCV versus SOC"));
  parameter Real SOCmin(final min=0)=0 "最小充电状态" 
    annotation(Dialog(group="OCV versus SOC"));
  parameter Real OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1] "OCV/OCVmax versus SOC 表格" 
    annotation(Dialog(group="OCV versus SOC", enable=not useLinearSOCDependency));
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments 
    "表格插值的平滑度" 
    annotation(Dialog(group="OCV versus SOC", enable=not useLinearSOCDependency));
  final parameter Real OCV_SOC_internal[:,2]= 
    if useLinearSOCDependency then [SOCmin,OCVmin/OCVmax; SOCmax,1] else OCV_SOC 
    "内部使用的OCV/OCVmax versus SOC 表格" 
    annotation(Dialog(group="OCV versus SOC"));
  parameter SI.Resistance Ri "总内阻(=OCVmax/Isc)";
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 "在T_ref时的阻力温度系数";
  parameter SI.Current Idis=0 "SOC = SOCmax 时的自放电电流" 
    annotation(Evaluate=true);
  parameter SI.Resistance R0=Ri 
    "无并联C时的内阻";
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>收集电池单体的参数：</p>
<ul>
<li>额定电荷</li>
<li>OCV versus SOC 特性</li>
<li>内阻；可以从OCVmax/短路电流(在OCVmax处)计算</li>
</ul>
<h4>注意</h4>
<p>
如果<code>useLinearSOCDependency=true</code>，则OCV versus SOC表格将在内部从<code>OCVmax, OCVmin, SOCmax, SOCmin</code>建立。<br>
否则，必须指定OCV versus SOC表格：第一列=按升序排列的SOC值，第二列=相应于OCVmax的OCV值。
</p>
</html>"));
end CellData;