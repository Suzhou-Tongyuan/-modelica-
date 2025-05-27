within Modelica.Electrical.Machines.Examples.Transformers;
model IMC_Transformer 
  "测试示例：鼠笼型感应电机-变压器起动"
  extends Machines.Examples.InductionMachines.IMC_Transformer;
  annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<p>
在起始时间 tStart1，通过变压器向带有松鼠笼的感应电机供电；
电机从静止开始运行，惯性加速度受速度的二次依赖负载扭矩的影响；
在起始时间 tStart2，电机直接从电压源供电，最终达到额定速度。</p>
模拟2.5秒并绘制(相对于时间)：
<ul>
<li>currentQuasiRMSSensor.I：定子电流有效值</li>
<li>aimc.wMechanical：电机速度</li>
<li>aimc.tauElectrical：电机扭矩</li>
</ul>
模型<em>IM_SquirrelCage</em>的默认电机参数被使用。
</html>"));
end IMC_Transformer;