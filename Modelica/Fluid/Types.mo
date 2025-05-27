within Modelica.Fluid;
package Types "流体模型的常见类型"
  extends Modelica.Icons.TypesPackage;

  type HydraulicConductance = Modelica.Icons.TypeReal (
      final quantity="HydraulicConductance", 
      final unit="kg/(s.Pa)") "水力传导率" annotation();
  type HydraulicResistance = Modelica.Icons.TypeReal (
      final quantity="HydraulicResistance", 
      final unit="Pa.s/kg") "水力阻力" annotation();

  type Roughness = Modelica.Icons.TypeReal (final quantity="Length", final unit="m", displayUnit="mm", min=0) 
    "管道粗糙度" 
    annotation (Documentation(info="<html>
<p>
该 Real 型定义了管道或接头内表面的绝对粗糙度，即表面粗糙度的绝对平均高度。通常需要对其进行估算。
<em>[Idelchik 1994, pp. 105-109, Table 2-5; Miller 1990, p. 190, Table 8-1]</em> 中列举了许多例子。
简而言之：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"2\" align=\"center\"><strong>管道类型</strong></td>
    <td align=\"center\">粗糙度</td></tr>

<tr><td><strong>光滑管道</strong></td>
    <td>拉伸黄铜、铜、铝、玻璃等</td>
    <td> 0.0025 mm</td>
</tr>
<tr><td rowspan=\"3\"><strong>钢管</strong></td>
    <td>新的光滑管道</td>
    <td>0.025 mm</td>
</tr>
<tr><td>砂浆内衬，表面处理一般</td>
    <td>0.1 mm</td>
</tr>
<tr><td>严重生锈</td>
    <td>1 mm</td>
</tr>
<tr><td rowspan=\"3\"><strong>混凝土管</strong></td>
    <td>钢制模板，顶尖工艺</td>
    <td>0.025 mm</td>
</tr>
<tr><td>钢制模板，一般工艺</td>
    <td>0.1 mm</td>
</tr>
<tr><td>块状衬里</td>
    <td>1 mm</td>
</tr>
</table>

<h4>参考资料</h4>

<dl>
  <dt>Idelchik I.E. (1994):</dt>
  <dd><a href=\"http://www.bookfinder.com/dir/i/Handbook_of_Hydraulic_Resistance/0849399084/\"><strong>Handbook
      of Hydraulic Resistance</strong></a>. 3rd edition, Begell House, ISBN
      0-8493-9908-4</dd>
  <dt>Miller D. S. (1990):</dt>
  <dd><strong>Internal flow systems</strong>.
  2nd edition. Cranfield:BHRA(Information Services).</dd>
</dl>
</html>"  ));
  type Dynamics = enumeration(
    DynamicFreeInitial 
    "动态平衡，初始猜测值", 
    FixedInitial "动态平衡，固定初始值", 
    SteadyStateInitial 
    "动态平衡，带猜测值的稳态初始值", 

    SteadyState "稳态平衡，初始猜测值") 
    "用枚举法明确平衡方程" 
    annotation(Documentation(info = "<html>
<p>
枚举法用于定义平衡方程的公式(通过选择菜单选择)：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>动力学</strong></th><th><strong>意义</strong></th></tr>
<tr><td>DynamicFreeInitial</td><td>动态平衡，初始猜测值</td></tr>

<tr><td>FixedInitial</td><td>动态平衡，固定初始值</td></tr>

<tr><td>SteadyStateInitial</td><td>动态平衡，带猜测值的稳态初始值</td></tr>

<tr><td>SteadyState</td><td>稳态平衡，初始猜测值</td></tr>
</table>

<p>
枚举\"Dynamics \"分别用于质量、能量和动量平衡方程。这三个平衡方程的确切含义见下表：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"3\"><strong>质量平衡</strong> </td></tr>
<tr><td><strong>动力学</strong></td>
<td><strong>平衡方程</strong></td>
<td><strong>初始条件</strong></td></tr>

<tr><td> DynamicFreeInitial</td>
<td> 无限制 </td>
<td> 无初始条件 </td></tr>

<tr><td> FixedInitial</td>
<td> 无限制 </td>
<td> <strong>if</strong> Medium.singleState <strong>then</strong><br>
&nbsp;&nbsp;no initial condition<br>
<strong>else</strong> p=p_start </td></tr>

<tr><td> SteadyStateInitial</td>
<td> 无限制 </td>
<td> <strong>if</strong> Medium.singleState <strong>then</strong><br>
&nbsp;&nbsp;no initial condition<br>
<strong>else</strong> <strong>der</strong>(p)=0 </td></tr>

<tr><td> SteadyState</td>
<td> <strong>der</strong>(m)=0  </td>
<td> 无初始条件 </td></tr>
</table>

&nbsp;<br>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"3\"><strong>能量平衡</strong> </td></tr>
<tr><td><strong>动力学</strong></td>
<td><strong>平衡方程</strong></td>
<td><strong>初始条件</strong></td></tr>

<tr><td> DynamicFreeInitial</td>
<td> 无限制 </td>
<td> 无初始条件 </td></tr>

<tr><td> FixedInitial </td>
<td> 无限制 </td>
<td> T=T_start or h=h_start </td></tr>

<tr><td> SteadyStateInitial</td>
<td> 无限制 </td>
<td> <strong>der</strong>(T)=0 or <strong>der</strong>(h)=0 </td></tr>

<tr><td> SteadyState</td>
<td> <strong>der</strong>(U)=0  </td>
<td> 无初始条件 </td></tr>
</table>

&nbsp;<br>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"3\"><strong>动量平衡</strong> </td></tr>
<tr><td><strong>动力学</strong></td>
<td><strong>平衡方程</strong></td>
<td><strong>初始条件</strong></td></tr>

<tr><td> DynamicFreeInitial</td>
<td> 无限制 </td>
<td> 无初始条件 </td></tr>

<tr><td> FixedInitial</td>
<td> 无限制 </td>
<td> m_flow = m_flow_start </td></tr>

<tr><td> SteadyStateInitial</td>
<td> 无限制 </td>
<td> <strong>der</strong>(m_flow)=0 </td></tr>

<tr><td> SteadyState</td>
<td> <strong>der</strong>(m_flow)=0 </td>
<td> 无初始条件 </td></tr>
</table>

<p>
上表中给出的是单物质流体的方程式。对于多物质流体和微量物质，等效方程仍然成立。
</p>

<p>
Medium.singleState 是介质属性，用于定义介质是否仅有一种状态（多物质流体情况下还要有质量分数）。
在这种情况下，必须提供一个初始条件。例如，不可压缩介质的 Medium.singleState = <strong>true</strong>。
</p>

</html>"  ));

  type CvTypes = enumeration(
    Av "（公制）流量系数 Av", 
    Kv "（公制）流量系数 Kv", 
    Cv "（US）流量系数 Cv", 
    OpPoint "由工作点确定的 Av") 
    "枚举阀门流量系数" annotation(
    Documentation(info = "<html>

<p>
枚举阀门流量系数（通过选择菜单选择）：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>流量系数</strong></th>
<th><strong>意义</strong></th></tr>

<tr><td>Av</td>
<td> （公制）流量系数 Av </td></tr>

<tr><td>Kv</td>
<td> （公制）流量系数 Kv </td></tr>

<tr><td>Cv</td>
<td> （US）流量系数 Cv </td></tr>

<tr><td>OpPoint</td>
<td> 由工作点确定的 Av </td></tr>

</table>

<p>
有关系数的详细信息，请参阅
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">
用户指南 </a>。
</p>

</html>"      ));

  type PortFlowDirection = enumeration(
    Entering "流体只进入", 
    Leaving "流体只流出", 
    Bidirectional "流体流动不受限制 (可反向流动)") 
    "枚举是否允许反向流动" annotation(
    Documentation(info = "<html>

<p>
枚举用于定义模型对接口流体流动方向的假设（通过选择菜单选择）：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>流动方向</strong></th>
<th><strong>意义</strong></th></tr>

<tr><td>Entering</td>
<td>流体仅从外部进入接口</td></tr>

<tr><td>Leaving</td>
<td>流体只从接口流向外部</td></tr>

<tr><td>Bidirectional</td>
<td>流体流动不受限制（可反向流动）</td></tr>
</table>

<p>
默认设置为 \"PortFlowDirection.Bidirectional\"。
如果您完全确定流体仅单向流动，则其他设置可能会使您的模型仿真速度更快。
</p>

</html>"  ));

  type ModelStructure = enumeration(
      av_vb "port_a - 容积 - 流动模型 - 容积 - port_b", 
      a_v_b "port_a - 流动模型 - 容积 - 流动模型 - port_b", 
      av_b "port_a - 容积 - 流动模型 - port_b", 
      a_vb "port_a - 流动模型 - 容积 - port_b") 
    "枚举离散管道模型中的模型结构" 
    annotation (Documentation(info="<html>

<p>
根据交错网格方案枚举离散式管道模型的结构：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>ModelStructure.</strong></th>
  <th><strong>Meaning</strong></th></tr>

<tr><td>av_vb</td>
  <td>port_a - 容积 - 流动模型 - 容积 - port_b</td></tr>

<tr><td>a_v_b</td>
  <td>port_a - 流动模型 - 容积 - 流动模型 - port_b</td></tr>

<tr><td>av_b</td>
  <td>port_a - 容积 - 流动模型 - port_b</td></tr>

<tr><td>a_vb</td>
  <td>port_a - 流动模型 - 容积 - port_b</td></tr>
</table>

<p>
默认设置为 \"ModelStructure.av_vb\"，即离散管道的两端都有 \"容积\"。
这样做的好处是，管道与流量模型（如管接头）的连接会产生理想的交替体积和流量模型结构，这意味着不会出现非线性代数方程。
</p>

<p>
使用此选项直接连接离散管道意味着两个容积直接连接在一起。
根据流的概念，这意味着相连的两个容积的压力相同，但温度并不相等（这与连接距离很短的容积相对应，不同容积的温度需要一段时间才能达到平衡）。
由于两个体积的压力相同，因此状态数减少，指数减少（这意味着对取决于压力的介质方程进行微分，所需的初始条件数减少一个）。
</p>

<p>
如果动态管道连接到压力不可分的模型，如具有规定跳跃压力的 Sources.Boundary_pT，则不能使用默认选项 \"av_vb\"。
在这种情况下，可以适当配置模型结构，以便在管道压力状态和非可变边界条件之间实现动量平衡（例如，如果跳跃压力组件与 port_a 相连，则使用模型结构 ModelStructure.a_vb）。
</p>

</html>"  ));
  type CheckValveHomotopyType = enumeration(Open, Closed, NoHomotopy) 
   "枚举止回阀同伦" 
    annotation (Documentation(info="<html>
<p>如果知道止回阀是打开还是关闭，就可以简化初始化过程。</p>
<p>如果对单向阀一无所知，选择 <strong>NoHomotopy</strong> 会很有用。</p>
</html>"    ));

  annotation (preferredView="info", 
              Documentation(info="<html>

</html>"));
end Types;