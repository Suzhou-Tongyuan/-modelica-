within Modelica.Electrical;
package Spice3 "Berkeley SPICE3模拟器组件库"
  extends Modelica.Icons.Package;

  package UsersGuide "用户指南"
    extends Modelica.Icons.Information;

  class Overview "概览"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<h4>Spice3库概览</h4>
<p>Spice3库是一个Modelica库，其中包含了一些伯克利SPICE3模拟器的模型。</p>
<p><u>关于模拟电路模拟器SPICE3的一般信息</u></p>
<p>SPICE(具有集成电路重点的仿真程序)是用于模拟模拟电路的模拟器。它是伯克利大学最早的模拟模拟器之一。SPICE电路列表至今仍然是事实上的标准。几乎每个电气电路都有一个SPICE电路列表。今天SPICE的当前版本是SPICE3e/SPICE3f。SPICE包含基本元件(电阻器、电感器、电容器)、源和半导体器件(二极管、双极型晶体管、结型场效应晶体管、MOS场效应晶体管)以及线路模型。根据提供的元素池，要模拟的电路被构建为SPICE电路列表。</p>
<p><u>Modelica的Spice3库</u></p>
<p>Spice3库是从原始SPICE3 C++代码中提取出来的。为确保Modelica模型的正确性，模拟结果与SPICE3进行了比较。选择这种方式是因为SPICE3是唯一的开源Spice模拟器。</p>
<p>Spice3库是根据SPICE中的模型结构构建的。它包含以下包：</p>
<ul>
<li>示例</li>
<li>基础(R、C、L、受控源)</li>
<li>半导体(MOS(P、N)、BJT(NPN、PNP)、二极管、半导体电阻器)</li>
<li>源(恒定、正弦、指数、脉冲、分段线性、单频率FM，分别对应V和I)</li>
<li>附加功能(来自SPICE2的有用功能)</li>
<li>接口</li>
<li>内部(用于建模半导体器件所需的函数和数据)<br></li>
</ul>
<p>由于半导体模型，特别是MOS和BJT，是非常复杂的模型，因此需要许多函数、数据和参数来描述它们。因此，创建了一个名为Internal的特殊库，其中包含了用于半导体模型所需的所有函数和记录，以及参数。不需要该库的用户在该库内工作，因此它不适用于用户访问。Additionals库也是一个特殊的库。它不是SPICE3的原始组成部分。尽管如此，它包含了像SPICE2的多项式源之类的有用模型或功能，这些功能经常被要求。</p>
<p>有许多商业SPICE模拟器(如PSPICE、NgSPICE、HSPICE等)，它们是从伯克利SPICE衍生出来的，或者与之有某种关系。这些SPICE衍生产品的电路列表可能与伯克利SPICE3的电路列表不同。如果使用此包的电路列表(其参数名称)，则必须考虑这一点。</p>
</html>"    ));
  end Overview;

  class Useofsemiconductors "半导体使用"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>在半导体器件中，SPICE3区分技术参数和器件参数。器件参数可以为每个模型实例选择，例如，晶体管的沟道长度。在模型卡片(.model)中指定的技术参数可同时调整多个元件，例如，晶体管的类型。通常情况下，在Modelica中，可以在参数列表中设置模型卡片的参数。</p>
<p>有两种方式可以对多个模型进行参数化：</p>
<ol>
<li>分开记录：<br>为电路中的每个晶体管提供一个包含技术参数的记录，作为record模型卡片MOS的一个实例。在示例“inverterApartRecord”中，更详细地解释了这种方式。</li>
<li>扩展模型：<br>必须为每组技术参数定义一个分开模型。在示例“inverterExtendedModel”中，更详细地解释了这种方式。</li>
</ol>
</html>"    ));

  end Useofsemiconductors;

  class Spicenetlist "SPICE3电路网络"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<h4>将SPICE3电路网络翻译成Modelica </h4>
<p>因为几乎每个电路都可以使用SPICE3电路网络，所以将SPICE3电路网络功能翻译成Modelica语言是可行的。通过反相器电路示例，将解释一种可能的翻译方式。</p>

<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\">
<caption>表1：SPICE3电路网络(左侧)到Modelica(右侧)的翻译</caption>
<tr>
<td><blockquote><pre>
inverter

Mp1 11 1 13 11 MPmos
Mp2 11 13 2 11 MPmos
Mn1 13 1 0 0 MNmos
Mn2 2 13 0 0 MNmos
Vgate 1 0 PULSE(0 5 2s 1s)
Vdrain 11 0 PULSE(0 5 0s 1s)
.model MPmos PMOS (gamma=0.37)
.model MNmos NMOS (gamma=0.37 lambda=0.02)
.tran 0.01 5
.end
</pre></blockquote></td>
<td><blockquote><pre>
model inverter
Spice3.Basic.Ground g;
Spice3&hellip;M Mp1(mtype=true, M(GAMMA=0.37));
Spice3&hellip;M Mp2(mtype=true, M(GAMMA=0.37));
Spice3&hellip;M Mn1(M(LAMBDA=0.02, GAMMA=0.37));
Spice3&hellip;M Mn2(p(LAMBDA=0.02, GAMMA=0.37));
Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1);
Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1);
Spice3.Interfaces.Pin p_in, p_out;
protected
Spice3.Interfaces.Pin n0, n1, n2, n11, n13;
equation
connect(p_in, n1);    connect(p_out, n2);
connect(g.p, n0);
connect(vdrain.n,n0); connect(vdrain.p,n11);
connect(Mp1.B,n11);   connect(Mp1.D, n11);
connect(Mp1.G, n1);   connect(Mp1.S, n13);
connect(Mp2.B,n11);   connect(Mp2.D, n11);
connect(Mp2.G, n13);  connect(Mp2.S, n2);
connect(Mn1.B,n0);    connect(Mn1.D, n13);
connect(Mn1.G, n1);   connect(Mn1.S, n0);
connect(Mn2.B,n0);    connect(Mn2.D, n2);
connect(Mn2.G, n13);  connect(Mn2.S, n0);
end inverter;
</pre></blockquote></td>
</tr>
</table>

<p>给出了一个包含两个反相器电路的SPICE3电路网络。该电路网络功能应该被翻译成Modelica语言，在该Modelica语言中，第一个反相器的输入电压(节点编号1)和第二个反相器的输出电压(节点编号2)将会与周围的电路连接。</p>
<p>需要以下步骤：</p>
<ol>
<li>必须选择一个Modelica模型的名称。可以从SPICE3电路网络的第一行中选择。</li>
<li>必须实例化地面节点(即，<code>Spice3.Basic.Ground</code>)。</li>
<li>对于电路网络的每个组件，必须创建一个实例。根据电路网络中SPICE3模型标识符的第一个字母，需要选择所需的组件，并根据给定的参数进行参数化，例如，SPICE行Vdrain 11 0 PULSE(0 5 0 1)变成以下Modelica行：<code>Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1);</code></li>
<li>必须为所有节点号创建内部引脚。例如，来自SPICE3电路网络的节点号2在Modelica中变成
<blockquote><pre>
protected Spice3.Interfaces.Pin n2;
</pre></blockquote>
代码字母(这里是<code>n</code>)是必需的，因为单个数字在Modelica中不是名称。</li>
<li>根据电路网络，必须将内部引脚连接到组件，例如，<code>connect(Mp1.D, n11)</code>。</li>
<li>在最后一步，必须分配并连接外部引脚到相应的内部引脚。在表1中，这样做如下：
<blockquote><pre>
Spice3.Interfaces.Pin p_in, p_out;
connect(p_in, n1);
connect(p_out, n2);
</pre></blockquote>
</li>
</ol>
</html>"    ));
  end Spicenetlist;

  class NamingPrinciple "命名原则"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>在SPICE3中，我们有一个预定义的模型池。每个模型设备都有一个代码字母(例如，电阻-R)。类比于SPICE3模型，Spice3库中的模型也在其名称中带有相应的代码字母。以下例子展示了它们之间的关系：</p>
<p>一个典型的SPICE3行可能是：</p>
<p><strong>C</strong>1 3 2 1pF</p>
<p>第一个字母是代码字母(这里是 <strong>C</strong>)。它指定了模型组件的类型(这里是电容)。为了看到 Spice3 库中的模型与 SPICE3 模型之间的类比，转换后的电容的名称为 <strong>C</strong>_Capacitance。根据这个命名规则，Spice3 库的组件具有以下名称(第一个字母是必须在SPICE3中使用的代码字母)：</p>
<ul>
<li>R_Resistor</li>
<li>C_Capacitance</li>
<li>L_Inductor</li>
<li>E_VCV, E_VCV_POLY</li>
<li>G_VCC, G_VCC_POLY</li>
<li>H_CCV, H_CCV_POLY</li>
<li>F_CCC, F_CCC_POLY</li>
<li>M_PMOS</li>
<li>M_NMOS</li>
<li>Q_NPNBJT</li>
<li>Q_PNPBJT</li>
<li>D_Diode</li>
<li>V_constant, I_constant</li>
<li>V_sin, I_sin</li>
<li>V_exp, I_exp</li>
<li>V_pulse, I_pulse</li>
<li>V_pwl, I_pwl</li>
<li>V_sffm, I_sffm<br><strong><br></strong></li>
</ul>
</html>"    ));
  end NamingPrinciple;

  class ParameterHandling "参数处理"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>在SPICE3中，了解参数是否由用户设置是很重要的，因为某些值的计算取决于这些信息。由于在Modelica中没有设置检查这一点的功能，因此选择了一种变通方法。相关参数将获得一个不现实的值(-1e40)作为它们的默认值。在函数内部，检查参数是否仍然具有此值(即参数未被用户设置)或者是否具有新值(参数已被用户设置)。</p>
</html>"    ));
  end ParameterHandling;

  class Literature "参考文献"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><p>[B&ouml;hme2009]</p></td>
<td><p>S. B&ouml;hme, K. Majetta, C. Clauss, and P. Schneider, &quot;<a href=\"https://2009.international.conference.modelica.org/proceedings/pages/papers/0019/0019_FI.pdf\">SPICE3 Modelica Library</a>&quot;, <em>7th Modelica Conference</em>, Como, Italy, 2009.</p></td>
</tr>
<tr>
<td><p>[Antognetti1988]</p></td>
<td><p>P. Antognetti, G. Massobrio, <em>Semiconductor Device Modeling with SPICE</em>, McGraw-Hill Book Company, USA, 1988.</p></td>
</tr>
<tr>
<td><p>[Connelly1992]</p></td>
<td><p>A. Connelly, A, P. Choi, <em>Macromodeling with SPICE</em>, Prentice-Hall, New Jersey, USA, 1992.</p></td>
</tr>
<tr>
<td><p>[Johnson1991]</p></td>
<td><p>B. Johnson, T. Quarles, A. R. Newton, D. O. Pederson, A. Sangiovanni-Vincentelli, <em>SPICE3 Version 3f User's Manual</em>, University of Berkeley, Department of Electrical Engineering and Computer Sciences, USA, 1991, <a href=\"modelica://Modelica/Resources/Documentation/Electrical/Spice3/Spice_3f3_Users_Manual.pdf\">SPICE3 user's manual</a> (&copy; Regents of the University of California).</p></td>
</tr>
<tr>
<td><p>[Kielkowski1994]</p></td>
<td><p>R. Kielkowski, <em>Inside SPICE - Overcoming the obstacles of circuit simulation</em>, McGraw-Hill, USA, 1994.</p></td>
</tr>
</table>
</html>"    ));
  end Literature;

  class ReleaseNotes "发布说明"
    extends Modelica.Icons.ReleaseNotes;

    annotation (Documentation(info="<html>
<p>本部分总结了对Spice3库进行的更改。</p>
<ul>
<li>版本1.0(2010年2月18日)：发布了该库的第一个版本</li>
</ul>
</html>"    , revisions="<html>
<ul>
<li><em>2012年3月15日，Kristin Majetta</em><br>创建了SPICE3基准RTL反相器</li>
<li><em>2012年3月14日，Kristin Majetta</em><br>创建了SPICE3基准MOSFET特性化</li>
<li><em>2012年3月14日，Kristin Majetta</em><br>实现了SPICE3基准差分对添加</li>
<li><em>2012年3月12日，Kristin Majetta</em><br>改进了BJT模型</li>
<li><em>2012年3月9日，Kristin Majetta</em><br>添加了MOS Level 2模型</li>
<li><em>2012年2月24日，Kristin Majetta</em><br>添加了JFET模型</li>
<li><em>2012年2月23日，Kristin Majetta</em><br>添加了半导体电容器</li>
<li><em>2012年2月21日，Kristin Majetta</em><br>添加了耦合电感(K)</li>
<li><em>2010年3月，Kristin Majetta</em><br>应用了指南，添加了用户指南</li>
<li><em>2010年2月，Kristin Majetta</em><br>将Spice3库添加到MSL中，并修订了示例</li>
<li><em>2009年9月，Kristin Majetta</em><br>实现了双极晶体管</li>
<li><em>2009年8月，Jonathan Kress</em><br>改进了源的默认值</li>
<li><em>2009年8月，Kristin Majetta</em><br>开始了双极晶体管</li>
<li><em>2009年4月，Kristin Majetta</em><br>实现了半导体电阻器</li>
<li><em>2009年3月，Kristin Majetta</em><br>实现了二极管</li>
<li><em>2009年2月25日，Kristin Majetta</em><br>实现了MOS Level 2</li>
<li><em>2008年10月15日，Kristin Majetta</em><br>修复了L_Inductor、I_Pulse和SpiceRoot中的一些小错误</li>
<li><em>2008年4月，Sandra Boehme</em><br>最初创建<br></li>
</ul>
</html>"    ));

  end ReleaseNotes;

  class Contact "联系方式"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<h4>主要作者</h4>

<dl>
<dt><strong>Kristin Majetta</strong></dt>
<dd>邮箱：<a href=\"mailto:Kristin.Majetta@eas.iis.fraunhofer.de\">Kristin Majetta@eas.iis.fraunhofer.de</a></dd>
<dt><strong>Christoph Clauss</strong></dt>
<dd>邮箱：<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a></dd>
<dt><strong>Sandra Boehme</strong></dt>
<dd>邮箱：<a href=\"mailto:Sandra.Boehme@eas.iis.fraunhofer.de\">Sandra.Boehme@eas.iis.fraunhofer.de</a></dd>
</dl>

<dl>
<dt>地址：</dt>
<dd>Fraunhofer Institute Integrated Circuits<br />
Design Automation Division<br />
Zeunerstra&szlig;e 38<br />
01069 Dresden, Germany</dd>
</dl>

<h4>致谢</h4>

<ul>

<li>此库的开发是基于欧洲ITEA2项目EUROSYSLIB和MODELISA完成的。</li>

<li>感谢Jonathan Gerbet先生对于此库创建的贡献。</li>
</ul>

</html>"    ));
  end Contact;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>Spice3库是一个<strong>免费的</strong>Modelica库</p>
<p><strong>User's Guide(用户指南)</strong>是对Spice3库的一个说明指南。
</p>
</html>"  ,   revisions="<html>
<ul>
<li><em>2010年2月</em>Kristin Majetta书写</li>
</ul>
</html>"  ));
  end UsersGuide;

  package Examples "回路示例"
  extends Modelica.Icons.ExamplesPackage;

    model Inverter "简单反相器电路"
    //--------------------------------------------------------------------------------------------------------------

    //--------------------------------------------------------------------------------------------------------------
      extends Modelica.Icons.Example;

      Semiconductors.M_PMOS mp(modelcard(
          RD=0, 
          RS=0, 
          CBD=0, 
          CBS=0), Sinternal(start=0),IC=-1e40) 
        annotation (Placement(transformation(extent={{-14,8},{6,28}})));
      Semiconductors.M_NMOS mn(modelcard(
          RD=0, 
          RS=0, 
          CBD=0, 
          CBS=0), IC=-1e40) 
        annotation (Placement(transformation(extent={{-14,-34},{6,-14}})));
      Basic.Ground ground 
        annotation (Placement(transformation(extent={{-14,-60},{6,-40}})));
      Sources.V_pulse vin(
        V2=5, 
        TD=4e-12, 
        TR=0.1e-12, 
        TF=0.1e-12, 
        PW=1e-12, 
        PER=2e-12) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-40,-16})));
      Sources.V_pulse v(V2=5, TR=0.1e-12) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={40,-4})));
    equation
      connect(mn.D, mp.S) annotation (Line(
          points={{-4,-14},{-4,8}}, color={0,0,255}));
      connect(mp.G, mn.G) annotation (Line(
          points={{-14,17.9},{-14,-24.1}}, color={0,0,255}));
      connect(mn.S, mn.B) annotation (Line(
          points={{-4,-34},{6,-34},{6,-24}}));
      connect(mp.B, mp.D) annotation (Line(
          points={{6,18},{6,28},{-4,28}}, color={0,0,255}));
      connect(mn.S, ground.p) annotation (Line(
          points={{-4,-34},{-4,-40}}));
      connect(v.p, mp.D) annotation (Line(
          points={{40,6},{40,28},{-4,28}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(points={{40,-14},{40,-40},{-4,-40}}, 
            color={0,0,255}));
      connect(vin.p, mp.G) annotation (Line(
          points={{-40,-6},{-40,17.9},{-14,17.9}}, color={0,0,255}));
      connect(vin.n, ground.p) annotation (Line(points={{-40,-26},{-40,-40},{-4, 
              -40}}, color={0,0,255}));
      annotation (experiment(
          StopTime=1e-11, 
          Interval=5e-15, 
          Tolerance=1e-7), 
        Documentation(info="<html>
<p>反相器是由PMOS和NMOS晶体管组成的电路。其任务是将输入电压从高电势转换为低电势，反之亦然。</p>
<p>示例的仿真时长为1e-11秒。示例会在特定界面显示输入电压vin.p.v以及输出电压mp.S.v的图像。图像显示输入电压被反相。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2009年3月</em>由Kristin Majetta创建</li>
</ul>
</html>"      ));
    end Inverter;

    model InvertersApartRecord 
      "使用不同的模型参数实例的两个反相器"
      extends Modelica.Icons.Example;

      Basic.Ground ground annotation (Placement(transformation(extent={{-38,-80}, 
                {-18,-60}})));
    //--------------------------------------------------------------------------------------------------------------
    /*独立记录：对于电路中的每个晶体管，都可以通过记录模型卡片参数的实例来提供记录*/
      parameter Semiconductors.ModelcardMOS MPmos(GAMMA=0.37, CBD=0, CBS=0) 
        "MPmos的指定模型卡片MOS"; //记录模型卡片的实例
      parameter Semiconductors.ModelcardMOS MNmos(GAMMA=0.37, LAMBDA=0.02, CBD=0, CBS=0) 
        "MNmos的指定模型卡片MOS"; //记录模型卡片的实例
      Semiconductors.M_PMOS mp1(modelcard=MPmos, IC=-1e40) 
                annotation (Placement(transformation(extent={{-38,20},{-18,40}})));
      Semiconductors.M_NMOS mn1(modelcard=MNmos, IC=-1e40) 
                annotation (Placement(transformation(extent={{-38,-30},{-18,-10}})));
      Semiconductors.M_PMOS mp2(modelcard=MPmos, IC=-1e40) 
                annotation (Placement(transformation(extent={{2,20},{22,40}})));
      Semiconductors.M_NMOS mn2(modelcard=MNmos, IC=-1e40) 
                annotation (Placement(transformation(extent={{2,-30},{22,-10}})));
    //--------------------------------------------------------------------------------------------------------------

      Basic.C_Capacitor c1(C=1e-5, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(
            origin={-8,-30}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Basic.C_Capacitor c2(C=1e-5, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(
            origin={34,-30}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));

      Sources.V_pulse vin(
        V2=5, 
        TD=2, 
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-60,-32})));
      Sources.V_pulse v(V2=5, TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={60,-32})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-18,30},{-18,40},{-28, 
              40}}, color={0,0,255}));
      connect(mn1.S, ground.p) 
        annotation (Line(points={{-28,-30},{-28,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D) 
        annotation (Line(points={{-28,20},{-28,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-38,-20.1},{-38,29.9}}, color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-18,-20},{-18,-30},{-28, 
              -30}}, color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{22,30},{22,40},{12,40}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{12,-30},{12,-60},{-28, 
              -60}}, color={0,0,255}));
      connect(mp2.S, mn2.D) 
        annotation (Line(points={{12,20},{12,-10}}, color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{2,-20.1},{2,29.9}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{22,-20},{22,-30},{12, 
              -30}}, color={0,0,255}));
      connect(mp2.G, mn1.D) annotation (Line(points={{2,29.9},{2,0},{-28,0},{
              -28,-10}}, color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-8,-20},{-8,0},{-28,0},{
              -28,-10}}, color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{12,-10},{12,0},{34,0},{34, 
              -20}}, color={0,0,255}));
      connect(c2.n, ground.p) annotation (Line(points={{34,-40},{34,-60},{-28, 
              -60}}, color={0,0,255}));
      connect(c1.n, ground.p) annotation (Line(points={{-8,-40},{-8,-60},{-28, 
              -60}}, color={0,0,255}));
      connect(mp1.G, vin.p) annotation (Line(
          points={{-38,29.9},{-60,29.9},{-60,-32}}, color={0,0,255}));
      connect(vin.n, ground.p) annotation (Line(points={{-60,-42},{-60,-60},{-28, 
              -60}}, color={0,0,255}));
      connect(v.p, mp2.D) annotation (Line(
          points={{60,-32},{60,40},{12,40}}, color={0,0,255}));
      connect(mp1.D, mp2.D) annotation (Line(
          points={{-28,40},{12,40}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(points={{60,-42},{60,-60},{-28,-60}}, 
            color={0,0,255}));
      annotation (experiment(StopTime=5), 
        Documentation(info="<html>
<p>反相器是由PMOS和NMOS组成的电路。其任务是将输入电压从高电势转换为低电势，反之亦然。这个电路<em>InverterApartModel</em>包含两个反相器。第一个反相器的输入电压几乎等于第二个反相器的输出电压。电容引起了一些差异。</p>

<p>为了查看电路的典型行为，用户可以在特定界面通过勾选查看输入电压和输出电压的图像。此外，在观察第一个反相器的输出电压后，用户对该示例的工作特性也会有新的认识。示例的仿真时长为5秒。</p>

<p>示例的相关补充信息：输入电压：vin.p.v、v.p.v；第一个反相器的输出电压：mn1.D.v；第二个反相器的输出电压：mn2.D.v</p>

<p>此示例显示了使技术参数记录应用在多个晶体管的一种可能性。对于电路中的每个晶体管，都可以通过记录模型卡片参数的实例来提供记录。在这个电路中，我们需要两种不同的记录来记录技术参数，一个用于PMOS(MPmos)，另一个用于NMOS(MNmos)。记录技术参数的这些实例为每个晶体管提供了一个参数(Spice3.Repository.MOS mn1(mtype=0, modelcard=MNmos)。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2009年4月</em>由Kristin Majetta创建</li>
</ul>
</html>"      ));
    end InvertersApartRecord;

    model InvertersExtendedModel 
      "具有MOS模型的两个反相器(MOS模型的延申)"
      extends Modelica.Icons.Example;

      Basic.Ground ground annotation (Placement(transformation(extent={{-40,-80}, 
                {-20,-60}})));
    //--------------------------------------------------------------------------------------------------------------
    /*扩展模型：针对每组技术参数，必须定义一个独立的模型。每个晶体管都扩展
    该模型。在此过程中，指定所需的技术参数。*/

      model MPmos "带有指定模型卡片的PMOS晶体管"
        parameter Semiconductors.ModelcardMOS M(GAMMA=0.37, CBD=0, CBS=0);
        extends Semiconductors.M_PMOS(modelcard=M);
        annotation (Documentation(info="<html>
<p>此模型 MPmos 被模型 <em>InverterExtendedModel</em> 继承，用于构建反相器电路。详细信息请参见 <em>InverterExtendedModel</em>。</p>
</html>"          ));
      end MPmos;

      model MNmos "带有指定模型卡片的NMOS晶体管"
        parameter Semiconductors.ModelcardMOS M(GAMMA=0.37, LAMBDA=0.02, CBD=0, CBS=0);
        extends Semiconductors.M_NMOS(modelcard=M);
        annotation (Documentation(info="<html>
<p>此模型MNmos被模型<em>InverterExtendedModel</em>继承，用于构建反相器电路。详细信息请参见<em>InverterExtendedModel</em>。</p>
</html>"          ));
      end MNmos;

      MPmos mp1(IC=-1e40) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      MNmos mn1(IC=-1e40) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
      MPmos mp2(IC=-1e40) annotation (Placement(transformation(extent={{0,20},{20,40}})));
      MNmos mn2(IC=-1e40) annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
    //--------------------------------------------------------------------------------------------------------------

      Basic.C_Capacitor c1(C=1e-5, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(
            origin={-10,-30}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Basic.C_Capacitor c2(C=1e-5, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(
            origin={32,-30}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));

      Sources.V_pulse vin(
        V2=5, 
        TD=2, 
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-60,-22})));
      Sources.V_pulse v(V2=5, TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={56,-22})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-20,30},{-20,40},{-30,40}}, color={0,0,255}));
      connect(mn1.S, ground.p) 
        annotation (Line(points={{-30,-30},{-30,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D) 
        annotation (Line(points={{-30,20},{-30,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-40,-20.1},{-40,29.9}}, color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-20,-20},{-20,-30},{-30,-30}}, color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{20,30},{20,40},{10,40}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{10,-30},{10,-60},{-30,-60}}, color={0,0,255}));
      connect(mp2.S, mn2.D) 
        annotation (Line(points={{10,20},{10,-10}}, color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{0,-20.1},{0,29.9}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{20,-20},{20,-30},{10,-30}}, color={0,0,255}));
      connect(mp2.G, mn1.D) annotation (Line(points={{0,29.9},{0,0},{-30,0},{-30,-10}}, color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-10,-20},{-10,0},{-30,0},{
              -30,-10}}, color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{10,-10},{10,0},{32,0},{32,-20}}, color={0,0,255}));
      connect(c2.n, ground.p) annotation (Line(points={{32,-40},{32,-60},{-30, 
              -60}}, color={0,0,255}));
      connect(c1.n, ground.p) annotation (Line(points={{-10,-40},{-10,-60},{-30, 
              -60}}, color={0,0,255}));
      connect(vin.p, mp1.G) annotation (Line(
          points={{-60,-12},{-60,26},{-40,26},{-40,29.9}}, color={0,0,255}));
      connect(vin.n, ground.p) annotation (Line(points={{-60,-32},{-60,-60},{-30, 
              -60}}, color={0,0,255}));
      connect(v.p, mp2.D) annotation (Line(
          points={{56,-12},{56,40},{10,40}}, color={0,0,255}));
      connect(mp2.D, mp1.D) annotation (Line(
          points={{10,40},{-30,40}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(points={{56,-32},{56,-60},{-30,-60}}, 
            color={0,0,255}));
      annotation (experiment(StopTime=5), 
        Documentation(info="<html>
<p>反相器是由PMOS和NMOS组成的电路。其任务是将输入电压从高电势转换为低电势，反之亦然。这个电路<em>InverterExtendedModel</em>包含两个反相器。第一个反相器的输入电压几乎等于第二个反相器的输出电压。电容引起了一些差异。</p>
<p>为了查看电路的典型行为，用户应该在特定界面通过勾选输入电压和输出电压查看相关图像。此外，用户也能观察第一个反相器的输出电压，以对该示例的工作性能有新的认识。示例的仿真时长为5秒。</p>

<p>示例的补充信息：输入电压：vin.p.v和v.p.v；第一个反相器的输出电压：mn1.D.v；第二个反相器的输出电压：mn2.D.v
</p>

<p>此示例显示了使技术参数记录应用在多个晶体管的一种可能性。必须为每组技术参数定义一个独立的模型(在此示例中：MPmos和MNmos)。在模型定义内指定技术参数(Spice3.Semiconductors.modelcardMOS M(GAMMA=0.37, LAMBDA=0.02))。每个模型扩展一个晶体管。在此过程中，指定了所需的技术参数(extends Spice3.Repository.MOS(final mtype=1, modelcard=M))。为了使晶体管在电路中可用，应用了定义模型的实例(MPmos mp1; MNmos mn1; MPmos mp2; MNmos mn2;)。</p>
</html>"          , revisions="<html>
<ul>
<li><em>2009年4月</em>由Kristin Majetta创建</li>
</ul>
</html>"          ));
    end InvertersExtendedModel;

    model FourInverters 
      "四个使用MOSFET级别1的反相器，使用私有记录作为模型卡片"
      extends Modelica.Icons.Example;

      Basic.Ground ground annotation (Placement(transformation(extent={{-74,-80}, 
                {-54,-60}})));

      parameter Semiconductors.ModelcardMOS modp(CBD=0, CBS=0) 
        "私有PMOS模型卡片";
      parameter Semiconductors.ModelcardMOS modn(CBD=0, CBS=0) 
        "私有NMOS模型卡片";

      Semiconductors.M_PMOS mp1(modelcard=modp, IC=-1e40) 
                annotation (Placement(transformation(extent={{-74,20},{-54,40}})));
      Semiconductors.M_NMOS mn1(modelcard=modn, IC=-1e40) 
                annotation (Placement(transformation(extent={{-74,-30},{-54,-10}})));
      Semiconductors.M_PMOS mp2(modelcard=modp, IC=-1e40) 
                annotation (Placement(transformation(extent={{-34,20},{-14,40}})));
      Semiconductors.M_NMOS mn2(modelcard=modn, IC=-1e40) 
                annotation (Placement(transformation(extent={{-34,-30},{-14,-10}})));
      Semiconductors.M_PMOS mp3(modelcard=modp, IC=-1e40) 
                annotation (Placement(transformation(extent={{6,20},{26,40}})));
      Semiconductors.M_NMOS mn3(modelcard=modp, IC=-1e40) 
                annotation (Placement(transformation(extent={{6,-30},{26,-10}})));
      Semiconductors.M_PMOS mp4(modelcard=modn, IC=-1e40) 
                annotation (Placement(transformation(extent={{46,20},{66,40}})));
      Semiconductors.M_NMOS mn4(modelcard=modn, IC=-1e40) 
                annotation (Placement(transformation(extent={{46,-30},{66,-10}})));
      Basic.C_Capacitor c1(C=10e-6, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(
            origin={-44,-30}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Basic.C_Capacitor c2(C=10e-6, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(
            origin={-2,-30}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Basic.C_Capacitor c3(C=10e-6, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(
            origin={36,-30}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Basic.C_Capacitor c4(C=10e-6, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(
            origin={76,-30}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Sources.V_pulse vin(
        V2=5, 
        TD=2, 
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-86,-42})));
      Sources.V_pulse v(V2=5, TR=1) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={92,-48})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-54,30},{-54,40},{-64, 
              40}}, color={0,0,255}));
      connect(mn1.S, ground.p) 
        annotation (Line(points={{-64,-30},{-64,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D) 
        annotation (Line(points={{-64,20},{-64,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-74,-20.1},{-74,29.9}}, color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-54,-20},{-54,-30},{-64, 
              -30}}, color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{-14,30},{-14,40},{-24, 
              40}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{-24,-30},{-24,-60},{
              -64,-60}}, color={0,0,255}));
      connect(mp2.S, mn2.D) 
        annotation (Line(points={{-24,20},{-24,-10}}, color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{-34,-20.1},{-34,29.9}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{-14,-20},{-14,-30},{-24, 
              -30}}, color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-44,-20},{-44,0},{-64,0}, 
              {-64,-10}}, color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{-24,-10},{-24,0},{-2,0},{
              -2,-20}}, color={0,0,255}));
      connect(c2.n, ground.p) annotation (Line(points={{-2,-40},{-2,-60},{-64, 
              -60}}, color={0,0,255}));
      connect(c1.n, ground.p) annotation (Line(points={{-44,-40},{-44,-60},{-64, 
              -60}}, color={0,0,255}));
      connect(c3.n, ground.p) annotation (Line(points={{36,-40},{36,-60},{-64, 
              -60}}, color={0,0,255}));
      connect(c4.n, ground.p) annotation (Line(points={{76,-40},{76,-60},{-64, 
              -60}}, color={0,0,255}));
      connect(mn4.B, mn4.S) annotation (Line(points={{66,-20},{66,-30},{56, 
              -30}}, color={0,0,255}));
      connect(mn3.B, mn3.S) annotation (Line(points={{26,-20},{26,-30},{16, 
              -30}}, color={0,0,255}));
      connect(mp3.B, mp3.D) annotation (Line(points={{26,30},{26,40},{16,40}}, color={0,0,255}));
      connect(mp4.B, mp4.D) annotation (Line(points={{66,30},{66,40},{56,40}}, color={0,0,255}));
      connect(mp3.S, mn3.D) 
        annotation (Line(points={{16,20},{16,-10}}, color={0,0,255}));
      connect(mp4.S, mn4.D) 
        annotation (Line(points={{56,20},{56,-10}}, color={0,0,255}));
      connect(mn3.S, ground.p) annotation (Line(points={{16,-30},{16,-60},{-64, 
              -60}}, color={0,0,255}));
      connect(mn4.S, ground.p) annotation (Line(points={{56,-30},{56,-60},{-64, 
              -60}}, color={0,0,255}));
      connect(c3.p, mn3.D) annotation (Line(points={{36,-20},{36,0},{16,0},{16, 
              -10}}, color={0,0,255}));
      connect(c4.p, mn4.D) annotation (Line(points={{76,-20},{76,0},{56,0},{56, 
              -10}}, color={0,0,255}));
      connect(c2.p, mn3.G) annotation (Line(points={{-2,-20},{2,-20},{2,-20.1}, 
              {6,-20.1}}, color={0,0,255}));
      connect(mn3.G, mp3.G) annotation (Line(points={{6,-20.1},{6,29.9}}, color={0,0,255}));
      connect(c3.p, mn4.G) annotation (Line(points={{36,-20},{41,-20},{41, 
              -20.1},{46,-20.1}}, color={0,0,255}));
      connect(mn4.G, mp4.G) annotation (Line(points={{46,-20.1},{46,29.9}}, color={0,0,255}));
      connect(c1.p, mn2.G) annotation (Line(points={{-44,-20},{-39,-20},{-39, 
              -20.1},{-34,-20.1}}, color={0,0,255}));
      connect(vin.p, mn1.G) annotation (Line(
          points={{-86,-32},{-86,0},{-74,0},{-74,-20.1}}, color={0,0,255}));
      connect(vin.n, ground.p) annotation (Line(points={{-86,-52},{-86,-60},{-64, 
              -60}}, color={0,0,255}));
      connect(v.p, mp4.D) annotation (Line(
          points={{92,-38},{92,40},{56,40}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(points={{92,-58},{92,-60},{-64,-60}}, 
            color={0,0,255}));
      connect(mp3.D, mp4.D) annotation (Line(
          points={{16,40},{56,40}}, color={0,0,255}));
      connect(mp2.D, mp3.D) annotation (Line(
          points={{-24,40},{16,40}}, color={0,0,255}));
      connect(mp1.D, mp2.D) annotation (Line(
          points={{-64,40},{-24,40}}, color={0,0,255}));
      annotation (experiment(StopTime=5), 
        Documentation(info="<html>
<p>这个包含四个反相器的电路设计能用于展示MOS晶体管模型的功能。要查看电路的行为，用户应该在特定界面查看每个反相器的输出电压(mp1.S.v、mp2.S.v、mp3.S.v、mp4.S.v)。第二个和第四个反相器的输出电压以及第一个反相器的输入电压具有相同的电势。第一个和第三个反相器的输出电压与反相器2和4相反。</p>
<p>该示例的仿真时长为5秒。示例在仿真结束后的输出以下结果变量的图像：mp1.S.v、mp2.S.v、mp3.S.v和mp4.S.v</p>
</html>"      , revisions="<html>
<ul>
<li><em>2009年4月</em>由Kristin Majetta创建</li>
</ul>
</html>"      ));
    end FourInverters;

    model Nand "MOS与非门电路"
      extends Modelica.Icons.Example;

      Semiconductors.M_PMOS mp1(
        L=2e-5, 
        W=1e-5, 
        modelcard(PHI=0.7, CBD=0, CBS=0), Sinternal(start=0), IC=-1e40) annotation (Placement(transformation(
              extent={{-22,24},{-2,44}})));
      Semiconductors.M_PMOS mp2(modelcard(PHI=0.7,CBD=0, CBS=0), IC=-1e40) 
                                           annotation (Placement(transformation(
              extent={{24,24},{44,44}})));
      Semiconductors.M_NMOS mn2(Dinternal(start=0), modelcard(CBD=0, CBS=0), IC=-1e40) annotation (Placement(transformation(
              extent={{-24,-44},{-4,-24}})));
      Semiconductors.M_NMOS mn1(modelcard(CBD=0, CBS=0), IC=-1e40) annotation (Placement(transformation(
              extent={{-24,-10},{-4,10}})));
      Sources.V_constant vconstant(V=5) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}}, 
                                                     rotation=270, 
            origin={62,34})));
      Basic.Ground ground annotation (Placement(transformation(extent={{20,-100}, 
                {40,-80}})));
      Sources.V_pulse vin1(
        TR=1e-9, 
        TF=1e-9, 
        V2=5, 
        TD=2e-8, 
        PW=4e-8, 
        PER=8e-8) annotation (Placement(transformation(
            origin={-50,24}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Sources.V_pulse vin2(
        V2=5, 
        TR=1e-9, 
        TF=1e-9, 
        TD=1e-8, 
        PW=4e-8, 
        PER=8e-8) annotation (Placement(transformation(
            origin={-52,-44}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));

    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-2,34},{-2,44},{
              -12,44}}, color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{44,34},{44,44}, 
              {34,44}}, color={0,0,255}));
      connect(vconstant.p, mp2.D) annotation (Line(points={{62,44},{62,44}, 
              {34,44}}, color={0,0,255}));
      connect(mp2.D, mp1.D) 
        annotation (Line(points={{34,44},{-12,44}}, color={0,0,255}));
      connect(mp1.G, mn1.G) annotation (Line(points={{-22,33.9},{-22, 
              16},{-24,16},{-24,-0.1}}, color={0,0,255}));
      connect(mp1.G, vin1.p) annotation (Line(points={{-22,33.9},{-38,33.9}, 
              {-38,34},{-50,34}}, color={0,0,255}));
      connect(vin1.n, ground.p) annotation (Line(points={{-50,14},{-62,14},{
              -62,-80},{30,-80}}, color={0,0,255}));
      connect(mp2.G, mn2.G) annotation (Line(points={{24,33.9},{24,14}, 
              {-32,14},{-32,-34.1},{-24,-34.1}}, color={0,0,255}));
      connect(mn2.G, vin2.p) annotation (Line(points={{-24,-34.1},{-38, 
              -34.1},{-38,-34},{-52,-34}}, color={0,0,255}));
      connect(vin2.n, ground.p) annotation (Line(points={{-52,-54},{-52,-80},{
              30,-80}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{-14,-44},{-14,-80}, 
              {30,-80}}, color={0,0,255}));
      connect(mn1.B, mn2.B) 
        annotation (Line(points={{-4,0},{-4,-34}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{-4,-34},{-4,-44}, 
              {-14,-44}}, color={0,0,255}));
      connect(mn1.S, mn2.D) 
        annotation (Line(points={{-14,-10},{-14,-24}}, color={0,0,255}));
      connect(mp1.S, mn1.D) 
        annotation (Line(points={{-12,24},{-12,18},{-14,18},{-14,10}}, color={0,0,255}));
      connect(mp2.S, mn1.D) annotation (Line(points={{34,24},{34,10}, 
              {-14,10}}, color={0,0,255}));
      connect(vconstant.n, ground.p) annotation (Line(points={{62,24},{62,-80}, 
              {30,-80}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>在几乎每个电子学中，基本电路“nand”都被使用。Nand 包含两个PMOS和两个NMOS。用户可以在图形模式下看到错误的接线。当且仅当两个输入电压具有高电位时，输出电压才具有低电位，否则输出电压具有高电位。</p>

<p>Nand(与非门)真值表(1代表真，由5V电压表示)：</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p>输入电压 vin1</p></td>
<td><p>输入电压 vin2</p></td>
<td><p>输出电压 mn1.D</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
</table>
<p>示例的仿真时长为2e-7秒。用户可以在特定界面看到输入电压vin1.p.v、vin2.p.v，输出电压mn1.D.v的图像。仅当两个输入值均为高时才为零。</p>
</html>"              , revisions="<html>
<ul>
<li><em>2009年5月</em>由Kristin Majetta创建</li>
</ul>
</html>"              ), 
        experiment(StopTime=2e-007));
    end Nand;

    model Nor "MOS或非门电路"
      extends Modelica.Icons.Example;

      Semiconductors.M_PMOS mp1(modelcard(
          RD=1e-4, 
          RS=1e-4, 
          CBD=1e-5, 
          CBS=1e-5, 
          CGSO=1e-5, 
          CGDO=1e-5, 
          CGBO=1e-5), Dinternal(start=0,fixed=true), Sinternal(start=0,fixed=true), IC=-1e40) 
        annotation (Placement(transformation(
              extent={{-16,24},{4,44}})));
      Semiconductors.M_PMOS mp2(modelcard(
          RD=1e-4, 
          RS=1e-4, 
          CBD=1e-5, 
          CBS=1e-5, 
          CGSO=1e-5, 
          CGDO=1e-5, 
          CGBO=1e-5), Dinternal(start=0,fixed=true), Sinternal(start=0,fixed=true), IC=-1e40) 
        annotation (Placement(transformation(
              extent={{-16,-6},{4,14}})));
      Semiconductors.M_NMOS mn1(modelcard(
          RD=1e-4, 
          RS=1e-4, 
          CBD=1e-5, 
          CBS=1e-5, 
          CGSO=1e-5, 
          CGDO=1e-5, 
          CGBO=1e-5), Dinternal(start=0,fixed=true), Sinternal(start=0,fixed=true), IC=-1e40) 
        annotation (Placement(transformation(
              extent={{-16,-44},{4,-24}})));
      Semiconductors.M_NMOS mn2(modelcard(
          RD=1e-4, 
          RS=1e-4, 
          CBD=1e-5, 
          CBS=1e-5, 
          CGSO=1e-5, 
          CGDO=1e-5, 
          CGBO=1e-5), Dinternal(start=0,fixed=true), Sinternal(start=0,fixed=true), IC=-1e40) 
        annotation (Placement(transformation(
              extent={{32,-44},{52,-24}})));
      Basic.Ground ground 
        annotation (Placement(transformation(extent={{28,-100}, 
                {48,-80}})));
      Sources.V_pulse vin1(
        V2=5, 
        TR=0.001, 
        TF=0.001, 
        PW=2, 
        PER=10, 
        TD=2) 
        annotation (Placement(transformation(
            origin={-42,24}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Sources.V_pulse vin2(
        V2=5, 
        TR=0.001, 
        TF=0.001, 
        PW=2, 
        PER=10, 
        TD=1) 
        annotation (Placement(transformation(
            origin={-44,-44}, 
            extent={{-10,-10},{10,10}}, 
            rotation=270)));
      Sources.V_pulse v(
        TD=0.5, 
        TR=0.1, 
        V2=5) 
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={62,34})));
    equation
      connect(mn1.B, mn1.S) annotation (Line(points={{4,-34},{4,-44},{
              -6,-44}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{52,-34},{52,-44}, 
              {42,-44}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{42,-44},{38,-44}, 
              {38,-80}}, color={0,0,255}));
      connect(mn1.S, ground.p) annotation (Line(points={{-6,-44},{-6,-80},{
              38,-80}}, color={0,0,255}));
      connect(vin2.p, mn1.G) annotation (Line(points={{-44,-34},{-29, 
              -34},{-29,-34.1},{-16,-34.1}}, color={0,0,255}));
      connect(vin2.n, ground.p) annotation (Line(points={{-44,-54},{-44,-80}, 
              {38,-80}}, color={0,0,255}));
      connect(vin1.p, mp1.G) annotation (Line(points={{-42,34},{-29,34}, 
              {-29,33.9},{-16,33.9}}, color={0,0,255}));
      connect(vin1.n, ground.p) annotation (Line(points={{-42,14},{-64,14},{
              -64,-80},{38,-80}}, color={0,0,255}));
      connect(mp1.S, mp2.D) 
        annotation (Line(points={{-6,24},{-6,14}}, color={0,0,255}));
      connect(mp2.S, mn1.D) annotation (Line(points={{-6,-6},{-6,-24}}, color={0,0,255}));
      connect(mn2.D, mn1.D) annotation (Line(points={{42,-24},{-6,-24}}, color={0,0,255}));
      connect(vin2.p, mp2.G) annotation (Line(points={{-44,-34},{-44,4}, 
              {-16,4},{-16,3.9}}, color={0,0,255}));
      connect(vin1.p, mn2.G) annotation (Line(points={{-42,34},{-28,34}, 
              {-28,-18},{32,-18},{32,-34.1}}, color={0,0,255}));
      connect(mp1.B, mp1.D) annotation (Line(
          points={{4,34},{4,44},{-6,44}}, color={0,0,255}));
      connect(mp2.B, mp1.B) annotation (Line(
          points={{4,4},{4,34}}, color={0,0,255}));
      connect(v.p, mp1.D) annotation (Line(
          points={{62,44},{-6,44}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(points={{62,24},{62,-80},{38,-80}}, 
            color={0,0,255}));
      annotation (Documentation(info="<html>
<p>几乎在每个电子器件中都使用基本电路“nor”。一个与非门包含两个PMOS和两个NMOS。用户可以在图形模式下可以看到错误的布线。仅当两个输入电压具有低电位时，输出电压才具有高电位，否则输出电压具有低电位。</p>
<p>Nor(与非门)真值表(1表示真，由5V电压表示)：</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p>输入电压 vin1</p></td>
<td><p>输入电压 vin2</p></td>
<td><p>输出电压 mp1.S</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
</table>
<p>示例的仿真时长为5秒。示例会在特定界面显示两个输入电压vin1.p.v和vin2.p.v以及输出电压mp1.S.v。</p>
<p>示例中的输出值表现出与真值表“接近”的行为，因为电容很大。因此，在下一个输入变化之前，负载尚未完成。</p>
</html>"          , revisions="<html>
<ul>
<li><em>2009年3月</em>由Kristin Majetta创建</li>
</ul>
</html>"          ), 
        experiment(StopTime=5));
    end Nor;

    model Graetz "Graetz整流器电路"
      extends Modelica.Icons.Example;

      Semiconductors.D_DIODE D1(IC=-1e40, SENS_AREA=false,modelcarddiode(CJO=1e-7),pin(start=0, fixed=true)) 
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            origin={0,14})));
      Semiconductors.D_DIODE D3(IC=-1e40, SENS_AREA=false,modelcarddiode(CJO=1e-7), n(v(start=0, fixed=true))) 
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={20,-8})));
      Semiconductors.D_DIODE D4(IC=-1e40, SENS_AREA=false,modelcarddiode(CJO=1e-7)) 
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            origin={1,-30})));
      Semiconductors.D_DIODE D2(IC=-1e40, SENS_AREA=false,modelcarddiode(CJO=1e-7)) 
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-20,-8})));
      Semiconductors.R_Resistor rout(R=10) 
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=90, 
            origin={42,-7})));
      Sources.V_sin vsin(VA=10, FREQ=200) 
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-44,-8})));
      Basic.Ground ground 
        annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
    equation
      connect(D1.n, D3.p) annotation (Line(points={{10,14},{20,14},{20,2}}, 
            color={0,0,255}));
      connect(D2.p, D1.p) annotation (Line(
          points={{-20,2},{-20,14},{-10,14}}, color={0,0,255}));
      connect(D4.n, D3.n) annotation (Line(points={{11,-30},{20,-30},{20,-18}}, 
            color={0,0,255}));
      connect(D4.p, D2.n) annotation (Line(
          points={{-9,-30},{-20,-30},{-20,-18}}, color={0,0,255}));
      connect(D4.p, ground.p) annotation (Line(
          points={{-9,-30},{-20,-30},{-20,-40}}, color={0,0,255}));
      connect(vsin.n, ground.p) annotation (Line(points={{-44,-18},{-44,-40},{-20, 
              -40}}, color={0,0,255}));
      connect(D4.n, rout.p) annotation (Line(points={{11,-30},{42,-30},{42,-17}}, 
            color={0,0,255}));
      connect(rout.n, D1.p) annotation (Line(
          points={{42,3},{42,26},{-20,26},{-20,14},{-10,14}}, color={0,0,255}));
      connect(D3.p, vsin.p) annotation (Line(
          points={{20,2},{20,40},{-44,40},{-44,2}}, color={0,0,255}));
      annotation (
        experiment(StopTime=0.025), 
        Documentation(info="<html>
<p>Graetz整流器电路用于展示二极管的工作行为。</p>
<p>该示例的仿真时长为0.025秒。然后在特定界面会显示输入电压vsin.p.v的图像。rout.p.v电压是整流后的结果，大部分情况下处于正范围内脉动。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2010年1月</em>由Kristin Majetta创建</li>
</ul>
</html>"      ));
    end Graetz;

    model Oscillator "振荡器电路"
      extends Modelica.Icons.Example;

      Basic.R_Resistor r(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=90, 
            origin={-36,20})));
      Basic.C_Capacitor c(
        C=1e-7, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(extent={{-32,0},{-12,20}})));
      Basic.C_Capacitor c1(
        C=1e-7, 
        IC=0, 
        UIC=true) 
        annotation (Placement(transformation(extent={{24,0},{44,20}})));
      Basic.R_Resistor r1(R=22000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=90, 
            origin={-6,20})));
      Basic.R_Resistor r2(R=22000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=90, 
            origin={18,20})));
      Basic.R_Resistor r3(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=90, 
            origin={50,20})));
      Semiconductors.Q_NPNBJT T1(modelcard(CJE=1e-9, CJC=1e-9), vbe(start=0, fixed=true)) 
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=180, 
            origin={-30,-24})));
      Semiconductors.Q_NPNBJT T2(modelcard(CJE=1e-9, CJC=1e-9), vbe(start=0, fixed=true)) 
        annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
      Basic.Ground ground1 
        annotation (Placement(transformation(extent={{-78,-34},{-58,-14}})));
      Basic.Ground ground2 
        annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
      Basic.R_Resistor r4(R=10000) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={64,-2})));
      Sources.V_pulse v(
        V2=8, 
        TD=0.0005, 
        TR=0.01, 
        PW=1000, 
        PER=1000, 
        TF=0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-68,20})));

    equation
      connect(r.n, r1.n) annotation (Line(
          points={{-36,30},{-6,30}}, color={0,0,255}));
      connect(r1.n, r2.n) annotation (Line(
          points={{-6,30},{18,30}}, color={0,0,255}));
      connect(r2.n, r3.n) annotation (Line(
          points={{18,30},{50,30}}, color={0,0,255}));
      connect(r.p, c.p) annotation (Line(
          points={{-36,10},{-32,10}}, color={0,0,255}));
      connect(c.n, r1.p) annotation (Line(
          points={{-12,10},{-6,10}}, color={0,0,255}));
      connect(r2.p, c1.p) annotation (Line(
          points={{18,10},{24,10}}, color={0,0,255}));
      connect(c1.n, r3.p) annotation (Line(
          points={{44,10},{50,10}}, color={0,0,255}));
      connect(r1.p, T2.B) annotation (Line(
          points={{-6,10},{-6,-30},{30.4,-30}}, color={0,0,255}));
      connect(r2.p, T1.B) annotation (Line(
          points={{18,10},{18,-24},{-20.4,-24}}, color={0,0,255}));
      connect(T1.C, r.p) annotation (Line(
          points={{-33,-34},{-48,-34},{-48,10},{-36,10}}, color={0,0,255}));
      connect(T1.E, ground1.p) annotation (Line(
          points={{-33,-14},{-68,-14}}, color={0,0,255}));
      connect(T2.E, ground2.p) annotation (Line(
          points={{43,-40},{60,-40}}, color={0,0,255}));
      connect(r3.p, T2.C) annotation (Line(
          points={{50,10},{50,-20},{43,-20}}, color={0,0,255}));
      connect(r3.p, r4.p) annotation (Line(
          points={{50,10},{58,10},{58,8},{64,8}}, color={0,0,255}));
      connect(ground2.p, r4.n) annotation (Line(
          points={{60,-40},{60,-12},{64,-12}}, color={0,0,255}));
      connect(v.p, r.n) annotation (Line(
          points={{-68,30},{-36,30}}, color={0,0,255}));
      connect(v.n, ground1.p) annotation (Line(
          points={{-68,10},{-68,-14}}, color={0,0,255}));
      annotation (
        experiment(StopTime=0.025), 
        Documentation(info="<html>
<p>振荡器电路演示了BJT晶体管的使用。</p>
<p>示例的仿真时长为0.025秒。在特定界面用户可以观察到v.p.v的数值上升到5V。此外，用户还能观察到r4.p.v在仿真启动后它开始振荡。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2010年1月</em>由Jonathan Gerbet创建</li>
</ul>
</html>"      ));
    end Oscillator;

    model CoupledInductors"耦合电感器"
      extends Modelica.Icons.Example;
      Modelica.Electrical.Spice3.Basic.Ground ground 
        annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
      Modelica.Electrical.Spice3.Sources.V_sin sineVoltage(VA=220, FREQ=50) 
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-90,20})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R1(R=1) 
        annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Electrical.Spice3.Basic.L_Inductor L1(L=1, UIC=false) 
                           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-40,40})));
      Modelica.Electrical.Spice3.Basic.L_Inductor L2(L=0.01) 
                              annotation (Placement(transformation(
            extent={{-10,10},{10,-10}}, 
            rotation=270, 
            origin={20,60})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R2(R=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=180, 
            origin={42,80})));
      Modelica.Electrical.Spice3.Basic.K_CoupledInductors k1(k=0.1) 
        annotation (Placement(transformation(extent={{-20,50},{0,70}})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R3(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={60,50})));
      Modelica.Electrical.Spice3.Basic.C_Capacitor C1(
        C=1e-6, 
        IC=0, 
        UIC=true) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={80,50})));
      Modelica.Electrical.Spice3.Basic.L_Inductor L3(L=0.01) 
                              annotation (Placement(transformation(
            extent={{-10,10},{10,-10}}, 
            rotation=270, 
            origin={20,-40})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R4(R=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=180, 
            origin={42,-20})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R5(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={60,-50})));
      Modelica.Electrical.Spice3.Basic.C_Capacitor C2(
        C=2.e-3, 
        IC=0, 
        UIC=true) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={80,-50})));
      Modelica.Electrical.Spice3.Basic.K_CoupledInductors k2(k=0.05) 
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
      Modelica.Electrical.Spice3.Basic.K_CoupledInductors k3(k=0.05) 
                                  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}}, 
            rotation=90, 
            origin={6,10})));
    equation
      connect(sineVoltage.n, ground.p) annotation (Line(
          points={{-90,10},{-90,-80}}, color={0,0,255}));
      connect(R1.p, sineVoltage.p) annotation (Line(
          points={{-80,80},{-90,80},{-90,30}}, color={0,0,255}));
      connect(R1.n, L1.p) annotation (Line(
          points={{-60,80},{-40,80},{-40,50}}, color={0,0,255}));
      connect(L1.n, ground.p) annotation (Line(
          points={{-40,30},{-40,-80},{-90,-80}}, color={0,0,255}));
      connect(C1.n, R3.n) annotation (Line(
          points={{80,40},{60,40}}, color={0,0,255}));
      connect(L2.n, R3.n) annotation (Line(
          points={{20,50},{20,40},{60,40}}, color={0,0,255}));
      connect(C1.p, R2.p) annotation (Line(
          points={{80,60},{80,80},{52,80}}, color={0,0,255}));
      connect(R3.p, R2.p) annotation (Line(
          points={{60,60},{60,80},{52,80}}, color={0,0,255}));
      connect(R2.n, L2.p) annotation (Line(
          points={{32,80},{20,80},{20,70}}, color={0,0,255}));
      connect(C2.n, R5.n) annotation (Line(
          points={{80,-60},{60,-60}}, color={0,0,255}));
      connect(L3.n, R5.n) annotation (Line(
          points={{20,-50},{20,-60},{60,-60}}, color={0,0,255}));
      connect(C2.p, R4.p) annotation (Line(
          points={{80,-40},{80,-20},{52,-20}}, color={0,0,255}));
      connect(R5.p, R4.p) annotation (Line(
          points={{60,-40},{60,-20},{52,-20}}, color={0,0,255}));
      connect(R4.n, L3.p) annotation (Line(
          points={{32,-20},{20,-20},{20,-30}}, color={0,0,255}));
      connect(C1.n, ground.p) annotation (Line(
          points={{80,40},{90,40},{90,-80},{-90,-80}}, color={0,0,255}));
      connect(C2.n, ground.p) annotation (Line(
          points={{80,-60},{90,-60},{90,-80},{-90,-80}}, color={0,0,255}));
      connect(L1.ICP, k2.inductiveCouplePin1) annotation (Line(
          points={{-31.6,40},{-28,40},{-28,-40},{-20,-40}}, color={170,85,255}));
      connect(k2.inductiveCouplePin2, L3.ICP) annotation (Line(
          points={{0,-40},{11.6,-40}}, color={170,85,255}));
      connect(L3.ICP, k3.inductiveCouplePin1) annotation (Line(
          points={{11.6,-40},{6,-40},{6,0}}, color={170,85,255}));
      connect(k3.inductiveCouplePin2, L2.ICP) annotation (Line(
          points={{6,20},{6,60},{11.6,60}}, color={170,85,255}));
      connect(L2.ICP, k1.inductiveCouplePin2) annotation (Line(
          points={{11.6,60},{0,60}}, color={170,85,255}));
      connect(L1.ICP, k1.inductiveCouplePin1) annotation (Line(
          points={{-31.6,40},{-28,40},{-28,60},{-20,60}}, color={170,85,255}));
      annotation (
        experiment(StopTime=0.2), 
        Documentation(info="<html>
<p>耦合电感器电路展示了如何使用Basic库中的K_CoupledInductors组件将不同的电感器进行耦合。
</p>

<p>仿真时长为0.2秒，示例会在特定界面显示通过K耦合部分的行为，例如C1.p.v和C2.p.v的图像。
</p>

</html>"      ));
    end CoupledInductors;

    model CascodeCircuit"共栅电路"
      extends Modelica.Icons.Example;

      Modelica.Electrical.Spice3.Semiconductors.J_NJFJFET 
                                  J1(S(
                                     v(  start=0)), modelcard(CGS=0, CGD=0), AREA=1) 
        annotation (Placement(transformation(extent={{-54,38},{-34,58}})));
      Modelica.Electrical.Spice3.Semiconductors.J_NJFJFET 
                                  J2(modelcard(CGS=0, CGD=0), AREA=1) 
        annotation (Placement(transformation(extent={{-54,4},{-34,24}})));
      Modelica.Electrical.Spice3.Basic.R_Resistor RC(R=200, v(start=0)) 
        annotation (Placement(transformation(extent={{-44,60},{-24,80}})));
      Modelica.Electrical.Spice3.Basic.Ground ground 
        annotation (Placement(transformation(extent={{-54,-26},{-34,-6}})));
      Modelica.Electrical.Spice3.Sources.V_constant UDD(V=10) 
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-10,60})));
      Modelica.Electrical.Spice3.Sources.V_constant U0(V=2) 
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-72,38})));
      Modelica.Electrical.Spice3.Sources.V_sin v_sin(FREQ=10, VA=2) 
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
            rotation=270, 
            origin={-66,4})));
    equation
      connect(J2.D, J1.S) annotation (Line(
          points={{-44,24},{-44,38}}, color={0,0,255}));
      connect(ground.p, J2.S) annotation (Line(
          points={{-44,-6},{-44,4}}, color={0,0,255}));
      connect(v_sin.p, J2.G) annotation (Line(
          points={{-66,14},{-60,14},{-60,13.9},{-54,13.9}}, color={0,0,255}));
      connect(v_sin.n, ground.p) annotation (Line(
          points={{-66,-6},{-44,-6}}, color={0,0,255}));
      connect(U0.p, J1.G) annotation (Line(
          points={{-72,48},{-63,48},{-63,47.9},{-54,47.9}}, color={0,0,255}));
      connect(U0.n, ground.p) annotation (Line(
          points={{-72,28},{-80,28},{-80,-6},{-44,-6}}, color={0,0,255}));
      connect(J1.D, RC.p) annotation (Line(
          points={{-44,58},{-44,70}}, color={0,0,255}));
      connect(UDD.p, RC.n) annotation (Line(
          points={{-10,70},{-24,70}}, color={0,0,255}));
      connect(UDD.n, ground.p) annotation (Line(
          points={{-10,50},{-10,-6},{-44,-6}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>这个模型是一个简单的JFET共栅电路。J2的栅极变化(v_sin.p.v)被转换为J2的漏极变化(J2.D.v)。</p>
<p>示例的仿真时长为0.2秒，在特定界面示例会显示相关电压的图像。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2011年8月</em>，Kristin Majetta创建</li>
</ul>
</html>"      ),experiment(
          StopTime=0.2, 
          Interval=2e-4, 
          Tolerance=1e-007));
    end CascodeCircuit;

    model Spice3BenchmarkDifferentialPair "简单差分对"
      extends Modelica.Icons.Example;
      Sources.V_pulse VCC( V1=0, V2=12, TD=0, TR=2e-009, TF=2e-009, PW=3); // 脉冲电压源
      Sources.V_pulse VEE( V1=0, V2=-12, TD=0, TR=2e-009, TF=2e-009, PW=3); // 脉冲电压源
      Sources.V_sin VIN( VO=0, VA=0.01, FREQ=5); // 正弦电压源
      Basic.R_Resistor RS1(R=1000, v(start=0)); // 电阻
      Basic.R_Resistor RS2(R=1000); // 电阻
      Semiconductors.Q_NPNBJT Q1(modelcard=MOD1, Binternal(start=0), vbe(start=0, fixed=true)); // NPN 双极型晶体管
      Semiconductors.Q_NPNBJT Q2(modelcard=MOD1, icapbe(start=0), vbc(start=0), vbe(start=0, fixed=true)); // NPN 双极型晶体管
      Basic.R_Resistor RC1(R=10000, v(start=0)); // 电阻
      Basic.R_Resistor RC2(R=10000); // 电阻
      Basic.R_Resistor RE(R=10000); // 电阻
      Sources.V_constant VIE(V=0); // 常数电压源
      parameter Semiconductors.ModelcardBJT MOD1(BF=50, VAF=50, IS=1e-012, RB=100, CJC=5e-09, TF=6e-010) "晶体管 Q1 和 Q2 的模型参数"; // 晶体管模型参数
      Basic.Ground g; //接地

      Real OutputVoltage; // 输出电压

    protected
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n42;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n41;

    initial equation
      der(Q1.vbc)=0;
      der(Q2.vbc)=0;

    equation
      OutputVoltage=Q2.C.v - Q1.C.v; // 输出电压等于晶体管 Q2 的集电极电压减去晶体管 Q1 的集电极电压
      connect(g.p,n0); // 连接地接
      connect(VCC.p, n7); // 连接脉冲电压源正极
      connect(VCC.n, n0); // 连接脉冲电压源负极
      connect(VEE.p, n8); // 连接脉冲电压源正极
      connect(VEE.n, n0); // 连接脉冲电压源负极
      connect(VIN.p, n1); // 连接正弦电压源正极
      connect(VIN.n, n0); // 连接正弦电压源负极
      connect(RS1.p, n1); // 连接电阻端口1
      connect(RS1.n, n2); // 连接电阻端口2
      connect(RS2.p, n6); // 连接电阻端口1
      connect(RS2.n, n0); // 连接电阻端口2
      connect(Q1.C, n3); // 连接晶体管Q1的集电极
      connect(Q1.B, n2); // 连接晶体管Q1的基极
      connect(Q1.E, n42); // 连接晶体管Q1的发射极
      connect(Q2.C, n5); // 连接晶体管Q2的集电极
      connect(Q2.B, n6); // 连接晶体管Q2的基极
      connect(Q2.E, n42); // 连接晶体管Q2的发射极
      connect(RC1.p, n7); // 连接电阻端口1
      connect(RC1.n, n3); // 连接电阻端口2
      connect(RC2.p, n7); // 连接电阻端口1
      connect(RC2.n, n5); // 连接电阻端口2
      connect(RE.p, n41); // 连接电阻端口1
      connect(RE.n, n8); // 连接电阻端口2
      connect(VIE.p, n41); // 连接常数电压源正极
      connect(VIE.n, n42); // 连接常数电压源负极

      annotation (experiment(StopTime=1, Interval=0.001, 
          Tolerance=1e-005), 
          Documentation(info="<html>
<p>这个差分对模型是SPICE3版本e3用户手册中描述的五个基准电路之一(请参阅Spice3库的信息)。</p>
<p>差分对电路以差分模式运行。这意味着仅在一个晶体管上施加的输入电压VIN被放大。为了理解这种行为，建议用户对示例进行仿真，并观察从t=0到t=1秒时输入电压\"VIN.p.v\" 和被放大的输出电压\"OutputVoltage\"。</p>
<p>差分对的原始SPICE3网表：</p>
<blockquote><pre>
SIMPLE DIFFERENTIAL PAIR<br>
VCC 7 0 12<br>
VEE 8 0 -12<br>
VIN 1 0 AC 1<br>
RS1 1 2 1K<br>
RS2 6 0 1K<br>
Q1 3 2 4 MOD1<br>
Q2 5 6 4 MOD1<br>
RC1 7 3 10K<br>
RC2 7 5 10K<br>
RE 4 8 10K<br>
.MODEL MOD1 NPN BF=50 VAF=50 IS=1.E-12 RB=100 CJC=.5PF TF=.6NS<br>
.TF V(5) VIN<br>
.AC DEC 10 1 100MEG<br>
.END
</pre></blockquote>
<p>在Modelica表示中，微小的电容CJC被设置为1e-9F，以获得更高的数值鲁棒性。在恢复原始值CJC=.5PF之前，需要分析数值行为。</p>
</html>"      ));
    end Spice3BenchmarkDifferentialPair;

    model Spice3BenchmarkMosfetCharacterization "Mos输出特性"
      extends Modelica.Icons.Example;

      Sources.V_pulse VDS( V1=0, V2=10, TD=0, TR=1e-008, TF=1e-008, PW=1, PER=1); // 驱动电压源
      Sources.V_pulse VGS( V1=0, V2=5, TD=4e-008, TR=1e-009, TF=1e-009, PW=1e-008, PER=2e-008); // 栅极电压源
      Semiconductors.M_NMOS M1(modelcard=MOD1, L=4e-006, W=6e-006, AD=1e-011, AS=1e-011, IC=-1e40); // N型金属氧化物半导体场效应晶体管
      // *VIDS会测量ID,我们本可以使用VDS来测量电流ID，但是这样测得的电流值将会是负数。
      Sources.V_constant VIDS(V=0); // 常数电压源
      parameter Semiconductors.ModelcardMOS MOD1(VTO=-2, NSUB=1e+015, UO=550, CBD=0, CBS=0) "晶体管M1的模型参数";

    record SpiceConstants"Spice 常量"
      annotation();
    // NODE(节点)
    // NOPAGE(无页面)
    end SpiceConstants;

      Basic.Ground g; //接地

    protected
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n1;

    equation
      connect(g.p,n0); // 接地
      connect(VDS.p, n3); // 连接驱动电压源正极
      connect(VDS.n, n0); // 连接驱动电压源负极
      connect(VGS.p, n2); // 连接栅极电压源正极
      connect(VGS.n, n0); // 连接栅极电压源负极
      connect(M1.D, n1); // 连接晶体管漏极
      connect(M1.G, n2); // 连接晶体管栅极
      connect(M1.S, n0); // 连接晶体管源极
      connect(M1.B, n0); // 连接晶体管基极
      connect(VIDS.p, n3); // 连接常数电压源正极
      connect(VIDS.n, n1); // 连接常数电压源负极

      annotation (experiment(StopTime=1e-007, Interval=1e-009), 
        Documentation(info="<html>
<p>这个MOS输出特性模型是SPICE3版本e3用户手册中描述的五个基准电路之一(请参阅Spice3库的信息)。</p>
<p>该电路非常简单，由一个N型MOS场效应晶体管级联组成，该晶体管与栅极和漏极处的电压源相连，而漏极电压源提供工作电压。为理解这一特性，建议用户从示例仿真开始后观察到t=1e-7秒时相关变量的图像，并观察栅极电压(\"VGS.p.v\")和晶体管电流(\"M1.D.i\")的变化趋势。可以看到，随着栅极电压的增加，电流增加，这意味着晶体管的导电性增加。相反的情况发生在栅极电压减小的情况下。</p>
<p>MOSFET特性电路的原始SPICE3网表：</p>
<blockquote><pre>
MOS OUTPUT CHARACTERISTICS<br>
.OPTIONS NODE NOPAGE<br>
VDS 3 0<br>
VGS 2 0<br>
M1 1 2 0 0 MOD1 L=4U W=6U AD=10P AS=10P<br>
*VIDS MEASURES ID, WE COULD HAVE USED VDS, BUT IT WOULD BE NEGATIVE VIDS 3 1
.MODEL MOD1 NMOS VTO=-2 NSUB=1.0E15 UO=550<br>
.DC VDS 0 10 .5 VGS 0 5 1<br>
.END
</pre></blockquote>
</html>"      ));
    end Spice3BenchmarkMosfetCharacterization;

    model Spice3BenchmarkRtlInverter "简单RTL反相器"
      extends Modelica.Icons.Example;
      Sources.V_constant VCC(V=5); //常数电压源
      Sources.V_pulse VIN( V1=0, V2=5, TD=2e-009, TR=2e-009, TF=2e-009, PW=3e-008); // 脉冲电压源
      Basic.R_Resistor RB(R=10000); //电阻
      Semiconductors.Q_NPNBJT Q1(modelcard=Q11, vbc(start=0, fixed=true), vbe(start=0, fixed=true)); // NPN 双极型晶体管
      Basic.R_Resistor RC(R=1000); //电阻
      parameter Semiconductors.ModelcardBJT Q11(BF=20, RB=100, TF=1e-010, CJC=2e-012) "晶体管 Q1 的模型参数"; // 晶体管模型参数
      Basic.Ground g; //接地

    protected
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;

    equation
      connect(g.p,n0); // 连接地接
      connect(VCC.p, n4); // 连接常数电压源正极
      connect(VCC.n, n0); // 连接常数电压源负极
      connect(VIN.p, n1); // 连接脉冲电压源正极
      connect(VIN.n, n0); // 连接脉冲电压源负极
      connect(RB.p, n1); // 连接电阻端口1
      connect(RB.n, n2); // 连接电阻端口2
      connect(Q1.C, n3); // 连接晶体管集电极
      connect(Q1.B, n2); // 连接晶体管基极
      connect(Q1.E, n0); // 连接晶体管发射极
      connect(RC.p, n3); // 连接电阻端口1
      connect(RC.n, n4); // 连接电阻端口2

      annotation (experiment(
          StopTime=1e-007, 
          Interval=1e-010, 
          Tolerance=1e-008), 
        Documentation(info="<html>
<p>这个RTL反相器模型是SPICE3版本e3用户手册中描述的五个基准电路之一(请参阅Spice3库的信息)。</p>
<p>这个简单的RTL反相器(电阻-晶体管逻辑)用于反转输入电压，这意味着如果输入电压为低电位，则输出电压为高电位，反之亦然。为了理解这种行为，建议用户可以观察示例在t=0到t=1e-7秒时相关变量的图像，并观察输入电压(VIN.p.v)和输出电压(Q1.C.v)。</p>
<p>RTL反相器的原始SPICE3网表：</p>
<blockquote><pre>
SIMPLE RTL INVERTER<br>
VCC 4 0 5<br>
VIN 1 0 PULSE 0 5 2NS 2NS 2NS 30NS<br>
RB 1 2 10K<br>
Q1 3 2 0 Q1<br>
RC 3 4 1K<br>
.MODEL Q1 NPN BF 20 RB 100 TF .1NS CJC 2PF<br>
.DC VIN 0 5 0.1<br>
.TRAN 1NS 100NS<br>
.END
</pre></blockquote>
</html>"      ));
    end Spice3BenchmarkRtlInverter;

    model Spice3BenchmarkFourBitBinaryAdder 
      "加法器-4位全与非门二进制加法器"
      extends Modelica.Icons.Example;


      output Real X1_p9_v =  X1.p9.v;
      output Real X1_p10_v = X1.p10.v;
      output Real X1_p11_v = X1.p11.v;
      output Real X1_p12_v = X1.p12.v;
      output Real X1_p14_v = X1.p14.v;
      output Real X1_p1_v =  X1.p1.v;
      output Real X1_p2_v =  X1.p2.v;
      output Real X1_p3_v =  X1.p3.v;
      output Real X1_p4_v =  X1.p4.v;
      output Real X1_p5_v =  X1.p5.v;
      output Real X1_p6_v =  X1.p6.v;
      output Real X1_p7_v =  X1.p7.v;
      output Real X1_p8_v =  X1.p8.v;

      // *** SUBCIRCUIT DEFINITIONS

    model NAND ".SUBCKT(子电路):与非门1 2 3 4"

      parameter Semiconductors.ModelcardDIODE DMOD;
      parameter Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);

      //*节点:输入(2),输出,电源电压
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q1(modelcard=QMOD);
      Modelica.Electrical.Spice3.Semiconductors.D_DIODE D1CLAMP(modelcarddiode=DMOD, SENS_AREA=false, IC=-1e40);
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q2(modelcard=QMOD);
      Modelica.Electrical.Spice3.Semiconductors.D_DIODE D2CLAMP(modelcarddiode=DMOD, SENS_AREA=false, IC=-1e40);
      Modelica.Electrical.Spice3.Basic.R_Resistor RB(R=4000);
      Modelica.Electrical.Spice3.Basic.R_Resistor R1(R=1600);
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q3(modelcard=QMOD);
      Modelica.Electrical.Spice3.Basic.R_Resistor R2(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RC(R=130);
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q4(modelcard=QMOD);
      Modelica.Electrical.Spice3.Semiconductors.D_DIODE DVBEDROP(modelcarddiode=DMOD, SENS_AREA=false, IC=-1e40);
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q5(modelcard=QMOD);
      Modelica.Electrical.Spice3.Basic.Ground g;
      Modelica.Electrical.Analog.Interfaces.Pin p1;
      Modelica.Electrical.Analog.Interfaces.Pin p2;
      Modelica.Electrical.Analog.Interfaces.Pin p3;
      Modelica.Electrical.Analog.Interfaces.Pin p4;

      protected
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n10;
      annotation();

    equation
      connect(g.p,n0);
      connect(p1,n1);
      connect(p2,n2);
      connect(p3,n3);
      connect(p4,n4);
      connect(Q1.C, n9);
      connect(Q1.B, n5);
      connect(Q1.E, n1);
      connect(D1CLAMP.p, n0);
      connect(D1CLAMP.n, n1);
      connect(Q2.C, n9);
      connect(Q2.B, n5);
      connect(Q2.E, n2);
      connect(D2CLAMP.p, n0);
      connect(D2CLAMP.n, n2);
      connect(RB.p, n4);
      connect(RB.n, n5);
      connect(R1.p, n4);
      connect(R1.n, n6);
      connect(Q3.C, n6);
      connect(Q3.B, n9);
      connect(Q3.E, n8);
      connect(R2.p, n8);
      connect(R2.n, n0);
      connect(RC.p, n4);
      connect(RC.n, n7);
      connect(Q4.C, n7);
      connect(Q4.B, n6);
      connect(Q4.E, n10);
      connect(DVBEDROP.p, n10);
      connect(DVBEDROP.n, n3);
      connect(Q5.C, n3);
      connect(Q5.B, n8);
      connect(Q5.E, n0);

    end NAND;

    model ONEBIT ".SUBCKT(子电路)一位二级制数1 2 3 4 5 6"

      parameter Semiconductors.ModelcardDIODE DMOD;
      parameter Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);

      //*节点:输入(2),进位输入,输出,进位输出,电源电压
      NAND X1;
      NAND X2;
      NAND X3;
      NAND X4;
      NAND X5;
      NAND X6;
      NAND X7;
      NAND X8;
      NAND X9;
      Modelica.Electrical.Analog.Interfaces.Pin p1;
      Modelica.Electrical.Analog.Interfaces.Pin p2;
      Modelica.Electrical.Analog.Interfaces.Pin p3;
      Modelica.Electrical.Analog.Interfaces.Pin p4;
      Modelica.Electrical.Analog.Interfaces.Pin p5;
      Modelica.Electrical.Analog.Interfaces.Pin p6;

      protected
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n10;
      Modelica.Electrical.Analog.Interfaces.Pin n11;
      Modelica.Electrical.Analog.Interfaces.Pin n12;
      Modelica.Electrical.Analog.Interfaces.Pin n13;
      annotation();

    equation
      connect(p1,n1);
      connect(p2,n2);
      connect(p3,n3);
      connect(p4,n4);
      connect(p5,n5);
      connect(p6,n6);
      connect(X1.p1, n1);
      connect(X1.p2, n2);
      connect(X1.p3, n7);
      connect(X1.p4, n6);
      connect(X2.p1, n1);
      connect(X2.p2, n7);
      connect(X2.p3, n8);
      connect(X2.p4, n6);
      connect(X3.p1, n2);
      connect(X3.p2, n7);
      connect(X3.p3, n9);
      connect(X3.p4, n6);
      connect(X4.p1, n8);
      connect(X4.p2, n9);
      connect(X4.p3, n10);
      connect(X4.p4, n6);
      connect(X5.p1, n3);
      connect(X5.p2, n10);
      connect(X5.p3, n11);
      connect(X5.p4, n6);
      connect(X6.p1, n3);
      connect(X6.p2, n11);
      connect(X6.p3, n12);
      connect(X6.p4, n6);
      connect(X7.p1, n10);
      connect(X7.p2, n11);
      connect(X7.p3, n13);
      connect(X7.p4, n6);
      connect(X8.p1, n12);
      connect(X8.p2, n13);
      connect(X8.p3, n4);
      connect(X8.p4, n6);
      connect(X9.p1, n11);
      connect(X9.p2, n7);
      connect(X9.p3, n5);
      connect(X9.p4, n6);

    end ONEBIT;

    model TWOBIT ".SUBCKT(子电路):两位二进制数1 2 3 4 5 6 7 8 9"

      parameter Semiconductors.ModelcardDIODE DMOD;
      parameter Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);

      // *节点:输入-位0(2)/位1(2),输出-位0/位1,
      // *进位输入,进位输出,电源电压
      ONEBIT X1;
      ONEBIT X2;
      Modelica.Electrical.Analog.Interfaces.Pin p1;
      Modelica.Electrical.Analog.Interfaces.Pin p2;
      Modelica.Electrical.Analog.Interfaces.Pin p3;
      Modelica.Electrical.Analog.Interfaces.Pin p4;
      Modelica.Electrical.Analog.Interfaces.Pin p5;
      Modelica.Electrical.Analog.Interfaces.Pin p6;
      Modelica.Electrical.Analog.Interfaces.Pin p7;
      Modelica.Electrical.Analog.Interfaces.Pin p8;
      Modelica.Electrical.Analog.Interfaces.Pin p9;

      protected
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n10;
      annotation();

    equation
      connect(p1,n1);
      connect(p2,n2);
      connect(p3,n3);
      connect(p4,n4);
      connect(p5,n5);
      connect(p6,n6);
      connect(p7,n7);
      connect(p8,n8);
      connect(p9,n9);
      connect(X1.p1, n1);
      connect(X1.p2, n2);
      connect(X1.p3, n7);
      connect(X1.p4, n5);
      connect(X1.p5, n10);
      connect(X1.p6, n9);
      connect(X2.p1, n3);
      connect(X2.p2, n4);
      connect(X2.p3, n10);
      connect(X2.p4, n6);
      connect(X2.p5, n8);
      connect(X2.p6, n9);

    end TWOBIT;

    model FOURBIT ".SUBCKT(子电路):四位二进制数1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"

      parameter Semiconductors.ModelcardDIODE DMOD;
      parameter Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);

      //*节点:输入-位0(2)/位1(2)/位2(2)/位3(2),
      //*输出-位0/位1/位2/位3,进位输入,进位输出,电源电压
      TWOBIT X1;
      TWOBIT X2;
      Modelica.Electrical.Analog.Interfaces.Pin p1;
      Modelica.Electrical.Analog.Interfaces.Pin p2;
      Modelica.Electrical.Analog.Interfaces.Pin p3;
      Modelica.Electrical.Analog.Interfaces.Pin p4;
      Modelica.Electrical.Analog.Interfaces.Pin p5;
      Modelica.Electrical.Analog.Interfaces.Pin p6;
      Modelica.Electrical.Analog.Interfaces.Pin p7;
      Modelica.Electrical.Analog.Interfaces.Pin p8;
      Modelica.Electrical.Analog.Interfaces.Pin p9;
      Modelica.Electrical.Analog.Interfaces.Pin p10;
      Modelica.Electrical.Analog.Interfaces.Pin p11;
      Modelica.Electrical.Analog.Interfaces.Pin p12;
      Modelica.Electrical.Analog.Interfaces.Pin p13;
      Modelica.Electrical.Analog.Interfaces.Pin p14;
      Modelica.Electrical.Analog.Interfaces.Pin p15;

      protected
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n10;
      Modelica.Electrical.Analog.Interfaces.Pin n11;
      Modelica.Electrical.Analog.Interfaces.Pin n12;
      Modelica.Electrical.Analog.Interfaces.Pin n13;
      Modelica.Electrical.Analog.Interfaces.Pin n14;
      Modelica.Electrical.Analog.Interfaces.Pin n15;
      Modelica.Electrical.Analog.Interfaces.Pin n16;
      annotation();

    equation
      connect(p1,n1);
      connect(p2,n2);
      connect(p3,n3);
      connect(p4,n4);
      connect(p5,n5);
      connect(p6,n6);
      connect(p7,n7);
      connect(p8,n8);
      connect(p9,n9);
      connect(p10,n10);
      connect(p11,n11);
      connect(p12,n12);
      connect(p13,n13);
      connect(p14,n14);
      connect(p15,n15);
      connect(X1.p1, n1);
      connect(X1.p2, n2);
      connect(X1.p3, n3);
      connect(X1.p4, n4);
      connect(X1.p5, n9);
      connect(X1.p6, n10);
      connect(X1.p7, n13);
      connect(X1.p8, n16);
      connect(X1.p9, n15);
      connect(X2.p1, n5);
      connect(X2.p2, n6);
      connect(X2.p3, n7);
      connect(X2.p4, n8);
      connect(X2.p5, n11);
      connect(X2.p6, n12);
      connect(X2.p7, n16);
      connect(X2.p8, n14);
      connect(X2.p9, n15);

    end FOURBIT;

      // *** DEFINE NOMINAL CIRCUIT
      parameter Modelica.Electrical.Spice3.Semiconductors.ModelcardDIODE DMOD "Modelcard for diodes";
      parameter Modelica.Electrical.Spice3.Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012) "Modelcard for transistors";
      Modelica.Electrical.Spice3.Sources.V_constant VCC(V=5);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN1A( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=1e-008, PER=5e-008);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN1B( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=2e-008, PER=1e-007);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN2A( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=4e-008, PER=2e-007);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN2B( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=8e-008, PER=4e-007);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN3A( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=1.6e-007, PER=8e-007);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN3B( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=3.2e-007, PER=1.6e-006);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN4A( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=6.4e-007, PER=3.2e-006);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN4B( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=1.28e-006, PER=6.4e-006);
      FOURBIT X1( X1(   X1( X1( Q1(vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true),vbe(start=0))), 
                            X2( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))), 
                            X3( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X4( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X5( Q1(vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X6( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0))), 
                            X7( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true), vbc(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X8( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0),vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))), 
                            X9( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0)))), 
                         X2(X1( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=false)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true))), 
                            X2( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X3( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X4( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))), 
                            X5( Q1(vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X6( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X7( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X8( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true),vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))), 
                            X9( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0))))), 
                  X2(   X1( X1( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true))), 
                            X2( Q1(vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X3( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X4( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))), 
                            X5( Q1(vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X6( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X7( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X8( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))), 
                            X9( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0)))), 
                        X2( X1( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X2( Q1(vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X3( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X4( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))), 
                            X5( Q1(vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X6( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbe(start=0, fixed=true))), 
                            X7( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                RC(v(start=0))), 
                            X8( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))), 
                            X9( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q4(Binternal(start=0),icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)), 
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))))));

      Modelica.Electrical.Spice3.Basic.R_Resistor RBIT0(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RBIT1(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RBIT2(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RBIT3(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RCOUT(R=1000);
      Modelica.Electrical.Spice3.Basic.Ground g;

    protected
      Modelica.Electrical.Analog.Interfaces.Pin n99;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n10;
      Modelica.Electrical.Analog.Interfaces.Pin n11;
      Modelica.Electrical.Analog.Interfaces.Pin n12;
      Modelica.Electrical.Analog.Interfaces.Pin n13;

    equation
      connect(g.p,n0);
      connect(VCC.p, n99);
      connect(VCC.n, n0);
      connect(VIN1A.p, n1);
      connect(VIN1A.n, n0);
      connect(VIN1B.p, n2);
      connect(VIN1B.n, n0);
      connect(VIN2A.p, n3);
      connect(VIN2A.n, n0);
      connect(VIN2B.p, n4);
      connect(VIN2B.n, n0);
      connect(VIN3A.p, n5);
      connect(VIN3A.n, n0);
      connect(VIN3B.p, n6);
      connect(VIN3B.n, n0);
      connect(VIN4A.p, n7);
      connect(VIN4A.n, n0);
      connect(VIN4B.p, n8);
      connect(VIN4B.n, n0);
      connect(X1.p1, n1);
      connect(X1.p2, n2);
      connect(X1.p3, n3);
      connect(X1.p4, n4);
      connect(X1.p5, n5);
      connect(X1.p6, n6);
      connect(X1.p7, n7);
      connect(X1.p8, n8);
      connect(X1.p9, n9);
      connect(X1.p10, n10);
      connect(X1.p11, n11);
      connect(X1.p12, n12);
      connect(X1.p13, n0);
      connect(X1.p14, n13);
      connect(X1.p15, n99);
      connect(RBIT0.p, n9);
      connect(RBIT0.n, n0);
      connect(RBIT1.p, n10);
      connect(RBIT1.n, n0);
      connect(RBIT2.p, n11);
      connect(RBIT2.n, n0);
      connect(RBIT3.p, n12);
      connect(RBIT3.n, n0);
      connect(RCOUT.p, n13);
      connect(RCOUT.n, n0);

      annotation (experiment(StopTime=1e-006, Interval=1e-009), 
        Documentation(info="<html>
<p>这个四位二进制加法器模型是SPICE3 Version e3用户手册中描述的五个基准电路之一(请参阅Spice3库的信息)。
</p>

<p>该模型将两个4位数(数A和数B)相加。它有八个输入，其中第一个是第一个数的最低位(Number A Bit0)，第二个是第二个数的最低位(Number B Bit0)，第三个是第一个数的第二位(Number A Bit1)，依此类推。四位二进制加法器有四个输出，其中第一个(Sum Bit0)是最低位，第二个和第三个(Sum Bit1 和 Sum Bit2)是接下来的两位，最后一个(Sum Bit3)是最高位。以下图片说明了引脚分配。
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Spice3/FourBitBinaryAdder.jpg\"
alt=\"segment.png\">
</blockquote>

<p>模型内部，输入名称如下所示：
<p>X1_p1_v --> Number A Bit0</p>
<p>X1_p2_v --> Number B Bit0</p>
<p>X1_p3_v --> Number A Bit1</p>
<p>X1_p4_v --> Number B Bit1</p>
<p>X1_p5_v --> Number A Bit2</p>
<p>X1_p6_v --> Number B Bit2</p>
<p>X1_p7_v --> Number A Bit3</p>
<p>X1_p8_v --> Number B Bit3</p>
<p>X1_p9_v --> Sum Bit0</p>
<p>X1_p10_v --> Sum Bit1</p>
<p>X1_p11_v --> Sum Bit2</p>
<p>X1_p12_v --> Sum Bit3</p>
<p>X1_p14_v --> Cout</p>

<p>这个四位二进制加法器由两个两位加法器构成，而每个两位加法器又由两个一位加法器构成。一个一位加法器由九个与非门电路构建而成。
</p>

<p>请注意，由于其巨大规模(11387个方程式)，四位二进制加法器的模拟时间可能需要数小时。
</p>

<p>模型仿真时长为1e-6秒，用户可以在特定界面观察八个输入(X1_p1_v，...，X1_p8_v)、四个输出(X1_p9_v，...，X1_p12_v)和进位输出(X1_p14_v)。
</p>

<p><strong>加法器中单个晶体管的时序引起了延迟，这使得很难识别加法器的行为。由于四位二进制加法器是SPICE3的基准电路，电路未做更改，以便更好地观察加法器的行为。</strong>
</p>

<p>四位二进制加法器的原始SPICE3网表如下：
</p>


<blockquote><pre>
ADDER - 4 BIT ALL-NAND-GATE BINARY ADDER

*** SUBCIRCUIT DEFINITIONS
.SUBCKT NAND 1 2 3 4
*   NODES:  INPUT(2), OUTPUT, VCC
Q1        9  5  1 QMOD
D1CLAMP   0  1    DMOD
Q2        9  5  2 QMOD
D2CLAMP   0  2    DMOD
RB        4  5    4K
R1        4  6    1.6K
Q3        6  9  8 QMOD
R2        8  0    1K
RC        4  7    130
Q4        7  6 10 QMOD
DVBEDROP 10  3    DMOD
Q5        3  8  0 QMOD
.ENDS NAND

.SUBCKT ONEBIT 1 2 3 4 5 6
*   NODES:  INPUT(2), CARRY-IN, OUTPUT, CARRY-OUT, VCC
X1   1  2  7  6   NAND
X2   1  7  8  6   NAND
X3   2  7  9  6   NAND
X4   8  9 10  6   NAND
X5   3 10 11  6   NAND
X6   3 11 12  6   NAND
X7  10 11 13  6   NAND
X8  12 13  4  6   NAND
X9  11  7  5  6   NAND
.ENDS ONEBIT

.SUBCKT TWOBIT 1 2 3 4 5 6 7 8 9
*   NODES:  INPUT - BIT0(2) / BIT1(2), OUTPUT - BIT0 / BIT1,
*           CARRY-IN, CARRY-OUT, VCC
X1   1  2  7  5 10  9   ONEBIT
X2   3  4 10  6  8  9   ONEBIT
.ENDS TWOBIT

.SUBCKT FOURBIT 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
*   NODES:  INPUT - BIT0(2) / BIT1(2) / BIT2(2) / BIT3(2),
*           OUTPUT - BIT0 / BIT1 / BIT2 / BIT3, CARRY-IN, CARRY-OUT, VCC
X1   1  2  3  4  9 10 13 16 15   TWOBIT
X2   5  6  7  8 11 12 16 14 15   TWOBIT
.ENDS FOURBIT

*** DEFINE NOMINAL CIRCUIT
.MODEL DMOD D
.MODEL QMOD NPN(BF=75 RB=100 CJE=1PF CJC=3PF)
VCC   99  0   DC 5V
VIN1A  1  0   PULSE(0 3 0 10NS 10NS   10NS   50NS)
VIN1B  2  0   PULSE(0 3 0 10NS 10NS   20NS  100NS)
VIN2A  3  0   PULSE(0 3 0 10NS 10NS   40NS  200NS)
VIN2B  4  0   PULSE(0 3 0 10NS 10NS   80NS  400NS)
VIN3A  5  0   PULSE(0 3 0 10NS 10NS  160NS  800NS)
VIN3B  6  0   PULSE(0 3 0 10NS 10NS  320NS 1600NS)
VIN4A  7  0   PULSE(0 3 0 10NS 10NS  640NS 3200NS)
VIN4B  8  0   PULSE(0 3 0 10NS 10NS 1280NS 6400NS)
X1     1  2  3  4  5  6  7  8  9 10 11 12  0 13 99 FOURBIT
RBIT0  9  0   1K
RBIT1 10  0   1K
RBIT2 11  0   1K
RBIT3 12  0   1K
RCOUT 13  0   1K

*** (FOR THOSE WITH MONEY (AND MEMORY) TO BURN)
.TRAN 1NS 6400NS UIC

.control
run
set options no break

*plot v(1) v(2)
*plot v(3) v(4)
*plot v(5) v(6)
*plot v(7) v(8)
*plot v(9) v(10)
*plot v(11) v(12)
*plot v(13)
*print v(9) v(10)
print v(11) v(12) v(13)

.endc

.END
</pre></blockquote>

<p>模型由几个子电路构建，这些子电路仅被描述一次，但被多次使用。
</p>
</html>"      ));
    end Spice3BenchmarkFourBitBinaryAdder;
    annotation (Documentation(info="<html>
<p>这个电路示例库包含一些有用的示例，用于演示库的工作原理以及模型如何使用。
</p>
  

</html>"  ));
  end Examples;

  package Basic "基本电气元件"
    extends Modelica.Icons.Package;


    model Ground "接地节点"

      Modelica.Electrical.Analog.Interfaces.Pin p "地引脚" annotation (Placement(transformation(
            origin={0,100}, 
            extent={{10,-10},{-10,10}}, 
            rotation=270)));
    equation
      p.v = 0;
      annotation (
        Documentation(info="<html>
<p>
电路的地地节点的电位为零。每个电气电路都必须包含至少一个地对象。
</p>
<p>
SPICE没有地节点(质量)的元件。在SPICE网表中，地由节点号0指定。
这个Modelica SPICE库要求用这个地元件描述地节点。
</p>
</html>"      ), 
        Icon(coordinateSystem(
            preserveAspectRatio=true, 
            extent={{-100,-100},{100,100}}), graphics={
            Line(
              points={{0,100},{0,40}}, 
              color={0,0,255}), 
            Line(
              points={{-60,40},{60,40}}, 
              color={0,0,255}), 
            Line(
              points={{-40,20},{40,20}}, 
              color={0,0,255}), 
            Line(
              points={{-20,0},{20,0}}, 
              color={0,0,255}), 
            Text(
              extent={{-150,-14},{150,-54}}, 
              textColor={0,0,255}, 
              textString="%name")}));
    end Ground;

    model R_Resistor "理想线性电阻"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Resistance R(start=1000) "电阻";
    equation
      R*i = v;
      annotation (
        Documentation(info="<html>
<p>
理想电阻通过<em>i*R=v</em> 将分支电压<em>v</em>与分支电流<em>i</em>连接起来。
电阻<em>R</em>允许为正、零或负。
</p>
</html>"      ), 
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,30},{70,-30}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{-90,0},{-70,0}}, color={0,0,255}), 
            Line(points={{70,0},{90,0}}, color={0,0,255}), 
            Text(extent={{-150,-40},{150,-80}}, textString="R=%R"), 
            Text(
              extent={{-150,90},{150,50}}, 
              textString="%name", 
              textColor={0,0,255})}));
    end R_Resistor;

    model C_Capacitor "理想线性电容"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Types.Capacitance C(start=0) "电容";
      parameter SI.Voltage IC=0 "电压的初始值" annotation(Dialog(enable=UIC));
      parameter Boolean UIC=false 
        "使用初始条件：如果使用初始条件，则为true";
    protected
      SI.Voltage vinternal "电容器电压";
    initial equation
      if UIC then
        vinternal = IC;
      end if;

    equation
        vinternal = p.v - n.v;
        i = C*der(vinternal);
      annotation (
        Documentation(info="<html>
<p>
理想电容器通过<em>i=C*dv/dt</em> 将分支电压<em>v</em>与分支电流<em>i</em>连接起来。
电容<em>C</em>允许为正、零或负。
</p>
</html>"      ), Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Line(
              points={{-6,28},{-6,-28}}, 
              color={0,0,255}), 
            Line(
              points={{6,28},{6,-28}}, 
              color={0,0,255}), 
            Line(points={{-90,0},{-6,0}}, 
              color={0,0,255}), 
            Line(points={{6,0},{90,0}}, 
              color={0,0,255}), 
            Text(extent={{-150,-40},{150,-80}}, textString="C=%C"), 
            Text(
              extent={{-150,90},{150,50}}, 
              textString="%name", 
              textColor={0,0,255})}));
    end C_Capacitor;

    model L_Inductor "理想线性电感"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Inductance L(start=0) "电感";
      parameter SI.Current IC=0 "初始值；如果UIC为true，则使用" annotation(Dialog(enable=UIC));
      parameter Boolean UIC=false "使用初始条件";
      SI.Current iinternal;

      Modelica.Electrical.Spice3.Interfaces.InductiveCouplePinOut ICP 
        "用于耦合电感的引脚" 
        annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
            rotation=-90, 
            origin={0,80}), 
            iconTransformation(extent={{-16,-16},{16,16}}, 
            rotation=270, 
            origin={0,84})));

    initial equation
      if UIC then
        iinternal = IC;
      else
        der(iinternal) = 0;
      end if;

    equation
      iinternal = p.i;
      L*der(iinternal) = v + ICP.v;
      ICP.L=L;
      ICP.di = der(iinternal);
      annotation (
        Documentation(info="<html>
<p>理想电感器通过<em>v=L*di/dt</em> 将分支电压<em>v</em>与分支电流<em>i</em>连接起来。电感<em>L</em>允许为正、零或负。</p>
</html>"      ), 
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{60,0},{90,0}}, 
              color={0,0,255}), 
            Line(points={{-90,0},{-60,0}}, 
              color={0,0,255}), 
            Text(extent={{-150,-40},{150,-80}}, textString="L=%L"), 
            Text(
              extent={{-150,80},{150,40}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Line(
              points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}}, 
              color={0,0,255}, 
              smooth=Smooth.Bezier), 
            Line(
              points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}}, 
              color={0,0,255}, 
              smooth=Smooth.Bezier), 
            Line(
              points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}}, 
              color={0,0,255}, 
              smooth=Smooth.Bezier), 
            Line(
              points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}}, 
              color={0,0,255}, 
              smooth=Smooth.Bezier)}));
    end L_Inductor;

    model K_CoupledInductors "通过耦合系数的感应耦合"
      parameter Real k(start=0, min=0, max=1) "耦合系数";
      Modelica.Electrical.Spice3.Interfaces.InductiveCouplePinIn inductiveCouplePin1 
        "感应耦合的耦合引脚" 
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.Spice3.Interfaces.InductiveCouplePinIn inductiveCouplePin2 
        "感应耦合的耦合引脚" 
          annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
            rotation=180, 
            origin={100,0}), iconTransformation(
            extent={{-10,-10},{10,10}}, 
            rotation=180, 
            origin={100,0})));
    SI.Inductance M "互感";
    equation
      assert(k>=0,"耦合系数必须为非负数");
      assert(k<=1,"耦合系数必须小于或等于1");
      M = k*sqrt(inductiveCouplePin1.L*inductiveCouplePin2.L);
      inductiveCouplePin1.v = - M*inductiveCouplePin2.di;
      inductiveCouplePin2.v = - M*inductiveCouplePin1.di;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), 
                       graphics={
            Polygon(
              points={{-60,0},{0,20},{60,0},{0,-20},{-60,0}}, 
              lineColor={170,85,255}), 
            Line(
              points={{-60,0},{-96,0},{-98,0}}, 
              color={170,85,255}), 
            Line(
              points={{60,0},{100,0}}, 
              color={170,85,255}), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name"), 
            Text(extent={{-150,-40},{150,-80}}, textString="k=%k")}), 
        Documentation(info="<html>
<p>
<code>K_CoupledInductors</code>是一个允许两个电感进行耦合的组件。<code>k</code>是耦合系数，必须在[0,1]范围内。
</p>
<p>
该使用方法在示例<a href=\"modelica://Modelica.Electrical.Spice3.Examples.CoupledInductors\">CoupledInductors</a>中演示。
</p>
</html>"      ));
    end K_CoupledInductors;

    model E_VCV "线性电压控制电压源"
      extends Interfaces.TwoPortControlledSources;
      parameter Real gain(start=0) "电压增益";
    equation
      v2 = v1*gain;
      i1 = 0;
      annotation (
        Documentation(info="<html>
<p>
线性电压控制电压源是一个双端口模型。
通过以下公式，端口2(p2.v)的右端口电压由端口1(p1.v)的左端口电压控制：
</p>
<blockquote><pre>
p2.v=p1.v*gain。
</pre></blockquote>
<p>
左端口电流为零。可以选择任何电压增益。
</p>
<p>
对应的SPICE描述
</p>
<blockquote><pre>
Ename N+ N- NC+ NC- VALUE
</pre></blockquote>
<p>在Modelica中的翻译：</p>
<blockquote><pre>
Ename -> Spice3.Basic.E_VCV Ename
(Ename是Modelica实例的名称)
N+ -> p2.v
N- -> n2.v
NC+ -> p1.v
NC- -> n1.v
VALUE -> gain
</pre></blockquote>
</html>"      ), Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-150,-80},{150,-120}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Line(points={{-90,50},{-30,50}}, color={0,0,255}), 
            Line(points={{-30,-50},{-90,-50}}, color={0,0,255}), 
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}), 
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}), 
            Line(points={{-20,60},{20,60}}, color={0,0,255}), 
            Polygon(
              points={{20,60},{10,63},{10,57},{20,60}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}));
    end E_VCV;

    model G_VCC "线性电压控制电流源"
      extends Interfaces.TwoPortControlledSources;
      parameter SI.Conductance transConductance(start=0) "传导电导";
    equation
      i2 = v1*transConductance;
      i1 = 0;
      annotation (
        Documentation(info="<html>
<p>线性电压控制电流源是一个双端口模型。</p>
<p>通过以下公式，端口2(p2.i)的右端口电流由端口1(p1.v)的左端口电压控制：</p>
<blockquote><pre>
p2.i=p1.v*transConductance。
</pre></blockquote>
<p>左端口电流为零。可以选择任何传导电导。</p>
<p>对应的SPICE描述：</p>
<blockquote><pre>
Gname N+ N- NC+ NC- VALUE
</pre></blockquote>
<p>在Modelica中的翻译：</p>
<blockquote><pre>
Gname->Spice3.Basic.G_VCC Gname
(Gname是Modelica实例的名称)
N+ -> p2.i
N- -> n2.i
NC+ -> p1 .v
NC- -> n1.v
VALUE->transConductance
</pre></blockquote>
</html>"      ), Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-150,-80},{150,-120}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Line(points={{-90,50},{-30,50}}, color={0,0,255}), 
            Line(points={{-30,-50},{-90,-50}}, color={0,0,255}), 
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}), 
            Line(points={{-20,60},{20,60}}, color={0,0,255}), 
            Polygon(
              points={{20,60},{10,63},{10,57},{20,60}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{90,50},{30,50},{30,20}}, color={0,0,255}), 
            Line(points={{90,-50},{30,-50},{30,-20}}, color={0,0,255}), 
            Line(points={{10,0},{50,0}}, color={0,0,255})}));
    end G_VCC;

    model H_CCV "线性电流控制电压源"
      extends Interfaces.TwoPortControlledSources;

      parameter SI.Resistance transResistance(start=0) "传导电阻";
    equation
      v2 = i1*transResistance;
      v1 = 0;
      annotation (
        Documentation(info="<html>
<p>线性电流控制电压源是一个双端口模型。通过以下公式，端口2(p2.v)的电压由端口1(p1.i)的电流控制：</p>
<blockquote><pre>
p2.v=p1.i*transResistance。
</pre></blockquote>
<p>控制端口的电压为零。可以选择任何传导电阻。</p>
<p>对应的SPICE描述：</p>
<blockquote><pre>
Hname N+ N- VNAM VALUE
</pre></blockquote>
<p>在Modelica中的翻译：</p>
<blockquote><pre>
Hname -&gt; Spice3.Basic.H_CCV Hname
(Hname是Modelica实例的名称)
N+-&gt;p2.v
N--&gt;n2.v
</pre></blockquote>
<p>电压源VNAM有两个节点NV+和NV-：</p>
<blockquote><pre>
VNAM VN+ VN- VALUE_V
</pre></blockquote>
<p>通过 VNAM的电流必须通过CCV。</p>
<p>因此，必须断开VNAM 并添加一个额外的节点NV_AD。</p>
<blockquote><pre>
NV_AD-&gt;p1.i
NV--&gt;n1.i
</pre></blockquote>
<p>通过这种方式，通过电压源VNAM流动的电流通过CCV。</p>
<blockquote><pre>
VALUE-&gt;transResistance
</pre></blockquote>
</html>"      ), 
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-150,-80},{150,-120}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}), 
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}), 
            Line(points={{-20,60},{20,60}}, color={0,0,255}), 
            Polygon(
              points={{20,60},{10,63},{10,57},{20,60}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{-90,50},{-30,50},{-30,-50},{-90,-50}}, color={0,0,255})}));
    end H_CCV;

    model F_CCC "线性电流控制电流源"
      extends Interfaces.TwoPortControlledSources;
      parameter Real gain(start=0) "电流增益";
    equation
      i2 = i1*gain;
      v1 = 0;
      annotation (
        Documentation(info="<html>
<p>线性电流控制电流源是一个双端口模型。通过以下公式，端口2(p2.i)的电流由端口1(p1.i)的电流控制：</p>

<blockquote><pre>
p2.i=p1.i*gain。
</pre></blockquote>

<p>控制端口的电压为零。可以选择任何电流增益。</p>

<p>对应的SPICE 描述：</p>
<blockquote><pre>
Fname N+ N- VNAM VALUE
</pre></blockquote>

<p>在 Modelica中的翻译：</p>
<blockquote><pre>
Fname-&gt;Spice3.Basic.F_CCC Fname
(Fname是Modelica实例的名称)
N+ -&gt; p2.i
N- -&gt; n2.i
</pre></blockquote>

<p>电压源VNAM有两个节点NV+和NV-：</p>

<blockquote><pre>
VNAM NV+ NV- VALUE_V
</pre></blockquote>

<p>通过VNAM的电流必须通过CCC。</p>

<p>因此，必须断开VNAM并添加一个额外的节点NV_AD。</p>

<blockquote><pre>
NV_AD -&gt; p1.i
NV- -&gt; n1.i
</pre></blockquote>

<p>通过这种方式，通过电压源VNAM流动的电流通过CCC。</p>

<blockquote><pre>
VALUE -&gt; gain
</pre></blockquote>
</html>"      ), 
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{-100,50},{-30,50},{-30,-50},{-100,-50}}, color={0,0,255}), 
            Text(
              extent={{-150,-80},{150,-120}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}), 
            Line(points={{-20,60},{20,60}}, color={0,0,255}), 
            Polygon(
              points={{20,60},{10,63},{10,57},{20,60}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{90,50},{30,50},{30,20}}, color={0,0,255}), 
            Line(points={{91,-50},{30,-50},{30,-20}}, color={0,0,255}), 
            Line(points={{10,0},{50,0}}, color={0,0,255})}));
    end F_CCC;

    annotation(preferredView="info", 
  Documentation(info="<html>
<p>这个库包含了SPICE3模型的基本组件。组件名的首字母表示了SPICE名称，例如，<strong>R</strong>_Resistor: <strong>R</strong>是SPICE中电阻元件的名称，这种表示方式一般在SPICE网表中使用。</p>


</html>"  , 
     revisions="<html>
<dl>
<dt>
<strong>主要作者：</strong>
</dt>
<dd>
Christoph Clau&szlig;
  &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>

  Fraunhofer Institute for Integrated Circuits<br>
  Design Automation Department<br>
  Zeunerstra&szlig;e 38<br>
  D-01069 Dresden
</dd>
</dl>
</html>"  ));
  end Basic;

  package Semiconductors "半导体器件和模型参数表"
    extends Modelica.Icons.Package;

    model M_PMOS "PMOS MOSFET器件"
      extends Modelica.Electrical.Spice3.Internal.MOS(
                              final mtype=1);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                -100},{100,100}}), graphics={Polygon(
              points={{60,0},{40,5},{40,-5},{60,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>模型M_PMOS是具有固定级别1的P通道MOSFET晶体管(Shichman-Hodges)模型</p>
<p>来自Semiconductors库的模型能访问存储了所有所需的函数、记录和数据的Repository库，这些数据用于半导体模型。</p>
<p>Semiconductors库供用户访问，但Repository库不能。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2008年3月</em>由Kristin Majetta创建</li>
</ul>
</html>"      ));
    end M_PMOS;

    model M_NMOS "NMOS MOSFET器件"
      extends Modelica.Electrical.Spice3.Internal.MOS(
                              final mtype=0);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                -100},{100,100}}), graphics={Polygon(
              points={{40,0},{60,5},{60,-5},{40,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>模型M_NMOS是具有固定级别1的N通道MOSFET晶体管(Shichman-Hodges模型)</p>
<p>来自Semiconductors库的模型能直接访问存储了所有所需的函数、记录和数据的Repository库，这些数据能用于半导体模型。</p>
<p>Semiconductors库供用户访问，但Repository库无法直接访问。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2008年3月</em> 由 Kristin Majetta 实现</li>
</ul>
</html>"      ));
    end M_NMOS;

    record ModelcardMOS "用于模型卡参数规范的记录"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardMOS;
      annotation (Documentation(info="<html>
<p>具有固定级别1的MOSFET晶体管的技术模型参数(Shichman-Hodges模型)</p>
<p>在典型的SPICE3模型卡中，存储着所谓的技术参数。这些参数通常与电路中的多个半导体器件有关，例如整个电路的温度。</p>
</html>"      ));
    end ModelcardMOS;

    model M_NMOS2 "NMOS MOSFET器件"
      extends Modelica.Electrical.Spice3.Internal.MOS2(
                              final mtype=0);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                -100},{100,100}}), graphics={Polygon(
              points={{40,0},{60,5},{60,-5},{40,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}), 
        Documentation(info="<html>
<p>模型M_NMOS是一个固定为级别2的N通道MOSFET晶体管：</p>
<p>该模型从Semiconductors库中访问Internal库，其中存储和建模了所有必要的函数、记录和数据，这些数据对于半导体模型是必需的。</p>
<p>Semiconductors库是供用户访问的，但Internal库无法供用户使用。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2008年3月</em>由Kristin Majetta <br>创建</li>
</ul>
</html>"      ));
    end M_NMOS2;

    model M_PMOS2 "PMOS MOSFET器件"
      extends Modelica.Electrical.Spice3.Internal.MOS2(
                              final mtype=1);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                -100},{100,100}}), graphics={Polygon(
              points={{60,0},{40,5},{40,-5},{60,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}), 
        Documentation(info="<html>
<p>模型M_PMOS是一个固定为级别2的P通道MOSFET晶体管：</p>
<p>该模型能从Semiconductors库中访问Internal库，它存储和建模了所有必要的函数、记录和数据，这些数据对于半导体模型是必需的。</p>
<p>Semiconductors库是供用户访问的(但不包括Internal库)。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2008年3月</em>由Kristin Majetta<br>创建</li>
</ul>
</html>"      ));
    end M_PMOS2;

    record ModelcardMOS2 "用于规范模型卡参数的记录"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardMOS2;
      annotation (Documentation(info="<html>
<p>具有固定级别1的MOSFET晶体管的技术模型参数(Shichman-Hodges)模型</p>
<p>在SPICE3中典型的模型卡中，存储了所谓的技术参数。这些参数通常与电路中多个半导体器件有关，例如整个电路的温度。</p>
</html>"          ));
    end ModelcardMOS2;

    model Q_NPNBJT "双极晶体管"
     extends Modelica.Electrical.Spice3.Internal.BJT2(
                            final TBJT=1);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Polygon(
              points={{8,-68},{2,-55},{-4,-62},{8,-68}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}), 
        Documentation(info="<html>
<p>模型Q_NPNBJT是NPN双极晶体管模型：它是Gummel-Poon修改后的模型。</p>
<p>来自Semiconductors库的模型能直接访问Internal库，其中存储和建模了所有所需的函数，</p>
<p>该模型能记录和数据，这些对于半导体模型是必要的。</p>
<p>Semiconductors库能供用户直接访问，但是Internal库不行。</p>
</html>"      , revisions="<html>
<ul>
<li><em>August 2009</em>由Kristin Majetta创建</li>
</ul>
</html>"      ));

    end Q_NPNBJT;

    model Q_PNPBJT "双极晶体管"
     extends Modelica.Electrical.Spice3.Internal.BJT2(
                            final TBJT=-1);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Polygon(
              points={{0,-60},{14,-67},{8,-74},{0,-60}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}), 
        Documentation(info="<html>
<p>模型Q_PNPBJT是PNP双极晶体管模型：它是Gummel-Poon修改后的模型。</p>
<p>来自Semiconductors库的模型能直接访问Internal库，其中存储和建模了所有所需的函数，</p>
<p>该模型会记录和数据，这些对于半导体模型是必要的。</p>
<p>Semiconductors库是供用户访问的，而Internal库无法直接访问。</p>
</html>"      , revisions="<html>
<ul>
<li><em>August 2009</em>由Kristin Majetta创建</li>
</ul>
</html>"      ));

    end Q_PNPBJT;

    record ModelcardBJT "记录用于模型卡参数的记录"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardBJT2;
      annotation (Documentation(info="<html>
<p>在典型的SPICE3模型卡中，存储着所谓的技术参数。这些参数通常与电路中的多个半导体器件设置有关，例如整个电路的温度。</p>
<p>修改后的Gummel-Poon双极晶体管模型的技术参数如下：</p>
</html>"          ));
    end ModelcardBJT;

    model J_PJFJFET "P沟道结型场效应晶体管模型 (JFET)"
     extends Modelica.Electrical.Spice3.Internal.JFET(final mtype=1);

      annotation (
        Documentation(info="<html>
<p>J_PJFJFET是一个P沟道结型场效应晶体管。</p>
<p>该结型场效应晶体管源于Shichman和Hodges的FET模型。</p>
<p>Semiconductors的模型能直接访问Internal库，它存储了所有需要的函数、记录和数据，用于半导体模型。Semiconductors库能供用户访问，但Internal库无法供用户访问。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2011年9月</em>由Sandra B&ouml;hme修订</li>
<li><em>2009年8月</em>由Kristin Majetta创建</li>
</ul>
</html>"      ), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Polygon(
              points={{8,-68},{2,-55},{-4,-62},{8,-68}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}));

    end J_PJFJFET;

    model J_NJFJFET "N沟道结型场效应晶体管模型(JFET)"
      extends Modelica.Electrical.Spice3.Internal.JFET(final mtype=0);

      annotation (
        Documentation(info="<html>
<p>J_NJFJFET是一个N沟道结型场效应晶体管。</p>
<p>该结型场效应晶体管源于Shichman和Hodges的FET模型。</p>
<p>Semiconductors的模型能访问Internal库，它存储了所有需要的函数、记录和数据，用于半导体模型。Semiconductors库供用户访问，但是Internal库无法供用户访问。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2011年9月</em>由Sandra B&ouml;hme修订</li>
<li><em>2009年8月</em>由Kristin Majetta创建</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Polygon(
              points={{8,-68},{2,-55},{-4,-62},{8,-68}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid)}));

    end J_NJFJFET;

    record ModelcardJFET 
      "用于JFET型号参数规范的记录"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardJFET;
      annotation (Documentation(info="<html>
<p>结型场效应晶体管模型的技术参数。</p>
<p>在SPICE3中，典型的模型卡(modelcards)中存储着所谓的技术参数。这些参数通常与电路中的多个半导体器件设置有关，例如整个电路的温度。</p>
</html>"          ));
    end ModelcardJFET;

   model D_DIODE "二极管模型"
     extends Modelica.Electrical.Spice3.Internal.DIODE;

     annotation (
       Documentation(info="<html>
<p>模型D_DIODE是结型二极管模型</p>
<p>来自半导体库(Semiconductors)的模型访问存储库(Repository)，其中存储和建模了所有所需的函数、记录和数据，这些数据是半导体模型所需的。</p>
<p>半导体库(Semiconductors)供用户访问，但是存储库(Repository)无法供用户访问。</p>
</html>"     , revisions="<html>
<ul>
<li><em>2008年11月</em>由Kristin Majetta编写并创建</li>
</ul>
</html>"     ));

   end D_DIODE;

   record ModelcardDIODE "用于规范模型卡参数的记录"
     extends Modelica.Icons.Record;
     extends Modelica.Electrical.Spice3.Internal.ModelcardDIODE;
     annotation (Documentation(info="<html>
<p>在典型的SPICE3模型卡中，存储了所谓的技术参数。这些参数通常与电路中的多个半导体器件设置有关，例如整个电气电路的温度。</p>
<p>结型二极管模型的技术参数</p>
</html>"        ));
   end ModelcardDIODE;

    model R_Resistor "来自SPICE3的半导体电阻器"
      extends Modelica.Electrical.Spice3.Internal.R_SEMI;
      annotation (Documentation(info="<html>
<p>R_Resistor模型是一个半导体电阻器模型。</p>
<p>来自Semiconductors库的模型访问Repository库，其中存储和建模了所有需要用于半导体模型的函数、记录和数据。</p>
<p>Semiconductors库供用户访问，但不包括Repository库。</p>
</html>"      , revisions="<html>
<ul>
<li><em>April 2009</em> by Kristin Majetta <br>初始实现</li>
</ul>
</html>"      ));
    end R_Resistor;

    record ModelcardRESISTOR 
      "用于规范模型卡参数的记录"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardR;
      annotation (Documentation(info="<html>
<p>在SPICE3典型的模型卡中，存储着所谓的技术参数。这些参数通常与电路中的多个半导体器件设置有关，例如整个电路的温度。</p>
<p>半导体电阻器模型的技术参数如下：</p>
</html>"          ));
    end ModelcardRESISTOR;

    model C_Capacitor 
      "半导体电容器"
      extends Modelica.Electrical.Spice3.Internal.C_SEMI;
      annotation (
        Documentation(info="<html>
<p>C_Capacitor是一个半导体电容器模型。</p>
<p>该电容器模型允许从严格的几何信息和工艺规范计算实际的电容值。</p>
<p>该模型从Semiconductors库中访问Repository库，其中存储和建模了所有半导体模型所需的函数、记录和数据。Semiconductors库供用户访问，但Repository库不可访问。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2011年9月</em>Sandra B&ouml;hme修订</li>
<li><em>2009年4月</em>Kristin Majetta创建</li>
</ul>
</html>"      ));
    end C_Capacitor;

    record ModelcardCAPACITOR 
      "用于半导体电容器模型的模型卡参数的记录"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardC;
      annotation (Documentation(info="<html>
<p>半导体电容器模型的技术参数。</p>
<p>在典型的SPICE3模型卡中，存储了所谓的技术参数。这些参数通常与电路中的多个半导体器件有关，例如整个电路的温度。</p>
</html>"          ));
    end ModelcardCAPACITOR;
    annotation(preferredView="info", 
      Documentation(info="<html>
<p>该库含有SPICE3中可用的半导体器件模型及其模型卡。用户应用该库中的模型。</p>

<p>该库中的所有模型都扩展自库Repository中的模型，后者包含了对建模半导体器件行为所必需的函数、参数和数据。模型卡记录包含了SPICE3的技术参数，它可同时调整多个MOS的参数。</p>

</html>"  ));
  end Semiconductors;

  package Sources "时间相关的SPICE3电压和电流源"


    extends Modelica.Icons.SourcesPackage;

    model V_constant "恒定独立电压源"
      parameter SI.Voltage V=1 "恒定电压值";
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
    equation
      v = V;
      annotation (
        Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-50,50},{50,-50}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{-90,0},{-50,0}}, color={0,0,255}), 
            Line(points={{-50,0},{50,0}}, color={0,0,255}), 
            Line(points={{50,0},{90,0}}, color={0,0,255}), 
            Text(
              extent={{-120,60},{-20,0}}, 
              textColor={0,0,255}, 
              textString="+"), 
            Text(
              extent={{20,60},{120,0}}, 
              textColor={0,0,255}, 
              textString="-"), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
    Documentation(info="<html>
<p>V_constant源是一个简单的恒定电压源，用于提供理想的恒定电压，该电压由参数提供。</p>
</html>"        ));
    end V_constant;

    model V_sin "正弦电压源"
      import Modelica.Constants.pi;
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Voltage VO=0.0 "偏移";
      parameter SI.Voltage VA=0.0 "幅值";
      parameter SI.Frequency FREQ(start=1) "频率";
      parameter SI.Time TD=0.0 "延迟";
      parameter SI.Damping THETA=0.0 "阻尼系数";
    equation
        assert(FREQ>0, "频率小于或等于零");
        v = VO + (if time < TD then 0 else VA* 
        Modelica.Math.exp(-(time - TD)*THETA)*Modelica.Math.sin(2*pi 
        *FREQ*(time - TD)));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                -100},{100,100}}), graphics={
            Text(
              extent={{-120,60},{-20,0}}, 
              textColor={0,0,255}, 
              textString="+"), 
            Text(
              extent={{20,60},{120,0}}, 
              textColor={0,0,255}, 
              textString="-"), 
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-90,0},{50,0}}, color={0,0,255}), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
            Line(points={{-80,4},{-75.2,36.3},{-72,54.3},{-68.7,68.5},{-65.5, 
                  78.2},{-62.3,83.3},{-59.1,83.6},{-55.9,79.3},{-52.7,71.1},{
                  -48.6,56.2},{-43,29.8},{-35,-9.9},{-30.2,-29.7},{-26.1,-41.9}, 
                  {-22.1,-49.2},{-18.1,-51.3},{-14.1,-48.5},{-10.1,-41.3},{
                  -5.23,-28.1},{8.44,17.7},{13.3,30.4},{18.1,38.8},{22.1,42},{
                  26.9,41.2},{31.8,35.8},{38.2,23.4},{51.1,-6.5},{57.5,-17.2},{
                  63.1,-21.9},{68.7,-21.9},{75.2,-16.5},{80,-9.8}}, 
                                                         color={192,192,192}), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}),  Documentation(info="<html>
<p>阻尼正弦源</p>
<h4>注意</h4>
<ul>
<li>应明确设置源的所有参数。</li>
<li>由于Modelica中不可用于建模的TSTEP和TSTOP，因此如果未设置所有参数，则可能会与SPICE产生差异。<br></li>
</ul>
</html>"        ));
    end V_sin;

    model V_exp "指数电压源"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;

      parameter SI.Voltage V1=0 "初始值";
      parameter SI.Voltage V2=0 "脉冲值";
      parameter SI.Time TD1=0.0 "上升延迟时间";
      parameter SI.Time TAU1=1 "上升时间常数";
      parameter SI.Time TD2=1 "下降延迟时间";
      parameter SI.Time TAU2=1 "下降时间常数";

    equation
    v = V1 + (if (time < TD1) then 0 else if (time < (TD2)) then 
              (V2-V1)*(1 - Modelica.Math.exp(-(time - TD1)/TAU1)) else 
              (V2-V1)*(1 - Modelica.Math.exp(-(time - TD1)/TAU1)) + 
              (V1-V2)*(1 - Modelica.Math.exp(-(time - TD2)/TAU2)));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-120,60},{-20,0}}, 
              textColor={0,0,255}, 
              textString="+"), 
            Text(
              extent={{20,60},{120,0}}, 
              textColor={0,0,255}, 
              textString="-"), 
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-90,0},{50,0}}, color={0,0,255}), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
            Line(points={{-70,-48},{-67.2,-33.3},{-64.3,-20.1},{-60.8,-5.6},{
                  -57.3,7},{-53.7,17.92},{-49.5,29.18},{-45.3,38.7},{-40.3,48}, 
                  {-34.6,56.5},{-28.3,64.1},{-21.2,70.6},{-12.7,76.3},{-2.1, 
                  81.2},{0,82},{2.12,69.5},{4.95,54.7},{7.78,41.8},{10,31},{
                  14.14,18.3},{17.68,8},{21.9,-2.2},{26.2,-10.6},{31.1,-18.5},{
                  36.8,-25.4},{43.1,-31.3},{50.9,-36.5},{60.8,-40.8},{70,-43.4}}, 
                                                                      color={
                  192,192,192}), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>上升和下降指数源。</p>
<h4>注意</h4>
<ul>
<li>应明确设置源的所有参数。</li>
<li>由于Modelica中不可用于建模的TSTEP和TSTOP，因此如果未设置所有参数，则可能会与SPICE产生差异。</li>
</ul>
</html>"        ));
    end V_exp;

    model V_pulse "脉冲电压源"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;

      parameter SI.Voltage V1 = 0 "初始值";
      parameter SI.Voltage V2 = 0 "脉冲值";
      parameter SI.Time TD = 0.0 "延迟时间";
      parameter SI.Time TR(start=1) "上升时间";
      parameter SI.Time TF = TR "下降时间";
      parameter SI.Time PW = Modelica.Constants.inf "脉冲宽度";
      parameter SI.Time PER= Modelica.Constants.inf "周期";

    protected
      parameter SI.Time Trising=TR "一个周期内上升阶段的结束时间";
      parameter SI.Time Twidth=Trising + PW 
        "一个周期内宽度阶段的结束时间";
      parameter SI.Time Tfalling=Twidth + TF 
        "一个周期内下降阶段的结束时间";
      SI.Time T0(final start=TD, fixed=true) "当前周期的起始时间";
      Integer counter(start=-1, fixed=true) "周期计数器";
      Integer counter2(start=-1, fixed=true);

    equation
      when pre(counter2) <> 0 and sample(TD, PER) then
        T0 = time;
        counter2 = pre(counter);
        counter = pre(counter) - (if pre(counter) > 0 then 1 else 0);
      end when;
      v = V1 + (if (time < TD or counter2 == 0 or time >= T0 + 
        Tfalling) then 0 else if (time < T0 + Trising) then (time - T0)* 
        (V2-V1)/Trising else if (time < T0 + Twidth) then V2-V1 else 
        (T0 + Tfalling - time)*(V2-V1)/(Tfalling - Twidth));

      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-120,60},{-20,0}}, 
              textColor={0,0,255}, 
              textString="+"), 
            Text(
              extent={{20,60},{120,0}}, 
              textColor={0,0,255}, 
              textString="-"), 
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-90,0},{50,0}}, color={0,0,255}), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
            Line(points={{-86,-74},{-65,-74},{-35,66},{-4,66},{25,-74},{46,-74}, 
                  {75,66}}, color={192,192,192}), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>周期性脉冲源，周期数不受限制。</p>
<p>单个脉冲由以下表格描述：</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><h4>时间</h4></td>
<td><h4>值</h4></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>V1</p></td>
</tr>
<tr>
<td><p>TD</p></td>
<td><p>V1</p></td>
</tr>
<tr>
<td><p>TD+TR</p></td>
<td><p>V2</p></td>
</tr>
<tr>
<td><p>TD+TR+PW</p></td>
<td><p>V2</p></td>
</tr>
<tr>
<td><p>TD+TR+PW+TF</p></td>
<td><p>V1</p></td>
</tr>
<tr>
<td><p>TSTOP</p></td>
<td><p>V1</p></td>
</tr>
</table>
<p>中间点由线性插值确定。</p>
<p>脉冲看起来像一个锯齿形，例如使用以下参数：</p>
<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>参数</h4></td>
<td><h4>值</h4></td>
</tr>
<tr>
<td><p>V1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>V2</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>TD</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>TR</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>TF</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>PW</p></td>
<td><p>2</p></td>
</tr>
<tr>
<td><p>PER</p></td>
<td><p>1</p></td>
</tr>
</table>
<h4>注意</h4>
<ul>
<li>应明确设置源的所有参数。</li>
<li>由于Modelica中不可用于建模的TSTEP和TSTOP，因此如果未设置所有参数，则可能会与SPICE产生差异。</li>
</ul>
</html>"        ));
    end V_pulse;

    model V_pwl "分段线性电压源"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Real table[:, :]=[0, 0; 1, 1; 2, 4] 
        "表格矩阵(时间=第一列，电压=第二列)";
    protected
      parameter Integer x= size(table,1);
      parameter Real tlast = table[x,1] + 1;
      parameter Real valuelast = table[x,2];
      parameter Real lastvaluematrix[1,2]=[tlast, valuelast];
      parameter Real tablenew[:,2]=cat(1,table,lastvaluematrix);
      Modelica.Blocks.Sources.TimeTable tab(table=tablenew);
    equation
      v = tab.y;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-120,60},{-20,0}}, 
              textColor={0,0,255}, 
              textString="+"), 
            Text(
              extent={{20,60},{120,0}}, 
              textColor={0,0,255}, 
              textString="-"), 
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-90,0},{50,0}}, color={0,0,255}), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
                                   Line(points={{-40,-50},{-40,70},{60,70},{60, 
                  -50},{-40,-50},{-40,-20},{60,-20},{60,10},{-40,10},{-40,40},{
                  60,40},{60,70},{10,70},{10,-51}}, color={192,192,192}), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>该模型通过给定的表格中的<strong>线性插值</strong>生成电压。时间点和电压值存储在矩阵<strong>table[i,j]</strong>中，其中第一列 table[:,1] 包含时间点，第二列包含要插值的电压。表格插值具有以下特性：</p>
<ul>
<li>时间点需要<strong>单调递增</strong>。</li>
<li>允许<strong>不连续性</strong>，通过在表格中两次提供相同的时间点来实现。</li>
<li>在表格范围<strong>之外</strong>的值通过表格的最后两个或第一个点进行<strong>外推</strong>计算。</li>
<li>如果表格只有<strong>一行</strong>，则不执行插值，电压值独立于实际时间瞬间返回，即这是一个恒定电压源。</li>
<li>表格通过在间隔边界生成<strong>时间事件</strong>以数字上的合理方式实现。
这为积分器生成了连续可微的值。</li>
</ul>
<p>示例：</p>
<blockquote><pre>
table = [0  0
    1  0
    1  1
    2  4
    3  9
    4 16]
如果，例如，时间 = 1.0，则电压 v =  0.0(事件前)，1.0(事件后)
例如，时间 = 1.5，则电压 v =  2.5，
例如，时间 = 2.0，则电压 v =  4.0，
例如，时间 = 5.0，则电压 v = 23.0(即，外推)。
</pre></blockquote>
</html>"        ));
    end V_pwl;

    model V_sffm "单频率FM电压源"
      import Modelica.Constants.pi;
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Voltage VO = 0 "偏置";
      parameter SI.Voltage VA = 0 "幅值";
      parameter SI.Frequency FC( start=0) "载波频率";
      parameter Real MDI=0 "调制指数";
      parameter SI.Frequency FS= FC "信号频率";
    equation
      v = VO + VA *Modelica.Math.sin( 2 *pi * FC *time + MDI *Modelica.Math.sin(2 *pi *FS *time));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true, 
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-120,60},{-20,0}}, 
              textColor={0,0,255}, 
              textString="+"), 
            Text(
              extent={{20,60},{120,0}}, 
              textColor={0,0,255}, 
              textString="-"), 
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-90,0},{50,0}}, color={0,0,255}), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
            Text(
              extent={{-60,-50},{60,-90}}, 
              textColor={0,0,255}, 
              textString="SFFM"), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>单频率频率调制源产生频率为FC的载波信号。该信号由信号频率FS进行调制。具体请查看Modelica文本中的公式。</p>
<h4>注意</h4>
<ul>
<li>所有源的参数都应明确设置。</li>
<li>由于Modelica中无法建模TSTEP和TSTOP，如果未设置所有参数，则可能与SPICE产生差异。</li>
</ul>
</html>"        ));
    end V_sffm;

   model I_constant "常数独立电流源"
      parameter SI.Current I=1 "常数电流的值";
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
   equation
      i = I;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-50,50},{50,-50}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{-90,0},{-50,0}}, color={0,0,255}), 
            Line(points={{50,0},{90,0}}, color={0,0,255}), 
            Line(points={{0,-50},{0,50}}, color={0,0,255}), 
                                                      Polygon(
             points={{90,0},{60,10},{60,-10},{90,0}}, 
             lineColor={0,0,255}, 
             fillColor={0,0,255}, 
             fillPattern=FillPattern.Solid), 
           Text(
             extent={{-150,90},{150,50}}, 
             textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>I_constant源是一个简单的常数电流源，用于提供理想的恒定电流，其值由一个参数提供。</p>
</html>"       ));
   end I_constant;

    model I_sin "正弦电流源"
      import Modelica.Constants.pi;
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Current IO=0 "偏移";
      parameter SI.Current IA=0 "幅值";
      parameter SI.Frequency FREQ(start=1) "频率";
      parameter SI.Time TD=0.0 "延迟";
      parameter SI.Damping THETA=0.0 "阻尼系数";
    equation
        assert(FREQ>0, "频率小于或等于零");
        i = IO + (if time < TD then 0 else IA* 
        Modelica.Math.exp(-(time - TD)*THETA)*Modelica.Math.sin(2*pi 
        *FREQ*(time - TD)));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-90,0},{-50,0}}, color={0,0,255}), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
             Line(points={{0,-50},{0,50}}, color={0,0,255}), 
                                   Line(points={{-77,-12},{-72.2,20.3},{-69, 
                  38.3},{-65.7,52.5},{-62.5,62.2},{-59.3,67.3},{-56.1,67.6},{
                  -52.9,63.3},{-49.7,55.1},{-45.6,40.2},{-40,13.8},{-32,-25.9}, 
                  {-27.2,-45.7},{-23.1,-57.9},{-19.1,-65.2},{-15.1,-67.3},{
                  -11.1,-64.5},{-7.1,-57.3},{-2.23,-44.1},{11.44,1.7},{16.3, 
                  14.4},{21.1,22.8},{25.1,26},{29.9,25.2},{34.8,19.8},{41.2,7.4}, 
                  {54.1,-22.5},{60.5,-33.2},{66.1,-37.9},{71.7,-37.9},{78.2, 
                  -32.5},{83,-25.8}}, 
                color={192,192,192}), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>阻尼正弦源</p>
<h4>注意</h4>
<ul>
<li>所有源的参数都应明确设置。</li>
<li>由于Modelica中没有TSTEP和TSTOP的建模，如果没有设置所有参数，则可能与SPICE有所不同。</li>
</ul>
</html>"        ));
    end I_sin;

    model I_exp "指数电流源"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Current I1=0 "初始值";
      parameter SI.Current I2=0 "脉冲值";
      parameter SI.Time TD1=0.0 "上升延迟时间";
      parameter SI.Time TAU1=1 "上升时间常数";
      parameter SI.Time TD2=2 "下降延迟时间";
      parameter SI.Time TAU2=1 "下降时间常数";
    equation
    i = I1 + (if (time < TD1) then 0 else if (time < (TD2)) then 
              (I2-I1)*(1 - Modelica.Math.exp(-(time - TD1)/TAU1)) else 
              (I2-I1)*(1 - Modelica.Math.exp(-(time - TD1)/TAU1)) + 
              (I1-I2)*(1 - Modelica.Math.exp(-(time - TD2)/TAU2)));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-89,0},{-50,0}}, color={0,0,255}), 
             Line(points={{50,0},{91,0}}, color={0,0,255}), 
             Line(points={{0,-50},{0,50}}, color={0,0,255}), 
                                   Line(points={{-79,-53},{-76.2,-38.3},{-73.3, 
                  -25.1},{-69.8,-10.6},{-66.3,2},{-62.7,12.92},{-58.5,24.18},{
                  -54.3,33.7},{-49.3,43},{-43.6,51.5},{-37.3,59.1},{-30.2,65.6}, 
                  {-21.7,71.3},{-11.1,76.2},{-9,77},{-6.88,64.5},{-4.05,49.7},{
                  -1.22,36.8},{1.606,25.45},{5.14,13.3},{8.68,3},{12.9,-7.2},{
                  17.2,-15.6},{22.1,-23.5},{27.8,-30.4},{34.1,-36.3},{41.9, 
                  -41.5},{51.8,-45.8},{61,-48.4}}, 
                                           color={192,192,192}), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>上升和下降指数源。</p>
<h4>注意</h4>
<ul>
<li>所有源的参数都应明确设置。</li>
<li>由于Modelica中没有TSTEP和TSTOP的建模，如果没有设置所有参数，则可能与SPICE有所不同。</li>
</ul>
</html>"        ));
    end I_exp;

    model I_pulse "脉冲电流源"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;

      parameter SI.Current I1 = 0 "初始值";
      parameter SI.Current I2 = 0 "脉冲值";
      parameter SI.Time TD = 0.0 "延迟时间";
      parameter SI.Time TR(start=1) "上升时间";
      parameter SI.Time TF = TR "下降时间";
      parameter SI.Time PW = Modelica.Constants.inf "脉冲宽度";
      parameter SI.Time PER = Modelica.Constants.inf "周期";

    protected
      parameter SI.Time Trising = TR "一个周期内上升阶段的结束时间";
      parameter SI.Time Twidth = Trising + PW 
        "一个周期内宽度阶段的结束时间";
      parameter SI.Time Tfalling = Twidth + TF 
        "一个周期内下降阶段的结束时间";
      SI.Time T0(final start=TD, fixed=true) "电流周期的开始时间";
      Integer counter(start=-1) "周期计数器";
      Integer counter2(start=-1);

    equation
      when pre(counter2) <> 0 and sample(TD, PER) then
        T0 = time;
        counter2 = pre(counter);
        counter = pre(counter) - (if pre(counter) > 0 then 1 else 0);
      end when;
      i = I1 + (if (time < TD or counter2 == 0 or time >= T0 + 
        Tfalling) then 0 else if (time < T0 + Trising) then (time - T0)* 
        (I2-I1)/Trising else if (time < T0 + Twidth) then I2-I1 else 
        (T0 + Tfalling - time)*(I2-I1)/(Tfalling - Twidth));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, 
              extent={{-100,-100},{100,100}}), graphics={
                                  Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-90,0},{-50,0}}, color={0,0,255}), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
             Line(points={{0,-50},{0,50}}, color={0,0,255}), 
                                    Line(points={{-85,-60}, 
                  {-64,-60},{-34,80},{-3,80},{26,-60},{47,-60},{76,80}}, color= 
                  {192,192,192}), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>具有不受限制的周期数量的周期性脉冲源。</p>
<p>单个脉冲由以下表格描述：</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><h4>时间</h4></td>
<td><h4>值</h4></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>I1</p></td>
</tr>
<tr>
<td><p>TD</p></td>
<td><p>I1</p></td>
</tr>
<tr>
<td><p>TD+TR</p></td>
<td><p>I2</p></td>
</tr>
<tr>
<td><p>TD+TR+PW</p></td>
<td><p>I2</p></td>
</tr>
<tr>
<td><p>TD+TR+PW+TF</p></td>
<td><p>I1</p></td>
</tr>
<tr>
<td><p>TSTOP</p></td>
<td><p>I1</p></td>
</tr>
</table>
<p>中间点由线性插值确定。</p>
<p>脉冲看起来像锯齿，可以使用以下参数：</p>
<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>参数</h4></td>
<td><h4>值</h4></td>
</tr>
<tr>
<td><p>I1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>I2</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>TD</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>TR</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>TF</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>PW</p></td>
<td><p>2</p></td>
</tr>
<tr>
<td><p>PER</p></td>
<td><p>1</p></td>
</tr>
</table>
<h4>注意</h4>
<ul>
<li>所有源的参数都应明确设置。</li>
<li>由于Modelica中没有TSTEP和TSTOP的建模，如果没有设置所有参数，则可能与SPICE有所不同。</li>
</ul>
</html>"        ));
    end I_pulse;

    model I_pwl "分段线性电流源"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Real table[:, :] = [0, 0; 1, 1; 2, 4] 
        "表格矩阵(时间=第一列，电流=第二列)";
    protected
      parameter Integer x = size(table, 1);
      parameter Real tlast = table[x, 1] + 1;
      parameter Real valuelast = table[x, 2];
      parameter Real lastvaluematrix[1, 2] = [tlast, valuelast];
      parameter Real tablenew[:, 2] = cat(1, table, lastvaluematrix);
      Modelica.Blocks.Sources.TimeTable tab(table = tablenew);
    equation
      i = tab.y;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{-90,0},{-50,0}}, color={0,0,255}), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
             Line(points={{0,-50},{0,50}}, color={0,0,255}), 
             Line(points={{-44,-39},{-44,81},{56,81},{56, 
                  -39},{-44,-39},{-44,-9},{56,-9},{56,21},{-44,21},{-44,51},{56, 
                  51},{56,81},{6,81},{6,-40}}, color={192,192,192}), 
             Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>该模型通过给定表格中的<strong>线性插值</strong>生成电流。时间点和电流值存储在矩阵<strong>table[i,j]</strong>中，其中第一列 table[:,1] 包含时间点，第二列包含要插值的电流。表格插值具有以下属性：</p>

<ul>
<li>时间点需要<strong>单调递增</strong>。</li>
<li>通过在表格中两次提供相同的时间点来允许<strong>不连续性</strong>。</li>
<li>在表格范围<strong>外</strong>的值通过表格的最后或前两个点进行<strong>外推</strong>计算。</li>
<li>如果表格只有<strong>一行</strong>，则不执行插值，电流值独立于实际时间瞬间返回，即这是一个恒定电流源。</li>
<li>通过在间隔边界生成<strong>时间事件</strong>，以数值上的方式实现了表格。这会为积分器生成连续可微的值。</li>
</ul>

<p>示例：</p>
<blockquote><pre>
table = [0  0
    1  0
    1  1
    2  4
    3  9
    4 16]
例如，当时间=1.0时，电流i=0.0(事件前)，1.0(事件后)
例如，当时间=1.5时，电流i=2.5，
例如，当时间=2.0时，电流i=4.0，
例如，当时间=5.0时，电流i=23.0(即，外推)。
</pre></blockquote>
</html>"        ));
    end I_pwl;

    model I_sffm "单频FM电流源"
      import Modelica.Constants.pi;
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Current IO = 0 "偏移量";
      parameter SI.Current IA = 0 "幅度";
      parameter SI.Frequency FC(start=0) "载波频率";
      parameter Real MDI = 0 "调制指数";
      parameter SI.Frequency FS = FC "信号频率";
    equation
      i = IO + IA * Modelica.Math.sin(2 * pi * FC * time + MDI * Modelica.Math.sin(2 * pi * FS * time));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false, 
            extent={{-100,-100},{100,100}}), graphics={
             Ellipse(
               extent={{-50,50},{50,-50}}, 
               lineColor={0,0,255}, 
               fillColor={255,255,255}, 
               fillPattern=FillPattern.Solid), 
             Line(points={{50,0},{90,0}}, color={0,0,255}), 
             Line(points={{-90,0},{-50,0}}, color={0,0,255}), 
             Line(points={{0,-50},{0,50}}, color={0,0,255}), 
                                  Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-60,-50},{60,-90}}, 
              textColor={0,0,255}, 
              textString="SFFM"), 
            Text(
              extent={{-150,90},{150,50}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
        Documentation(info="<html>
<p>单频率调制源产生频率为FC的载波信号。该信号由信号频率FS进行调制。请参阅Modelica文本中的公式。</p>
<h4>注意</h4>
<ul>
<li>源的所有参数都应明确设置。</li>
<li>由于Modelica中不支持TSTEP和TSTOP进行建模，如果没有设置所有参数，则可能与SPICE有所不同。</li>
</ul>
</html>"        ));
    end I_sffm;

    annotation(preferredView="info", Documentation(info= 
                   "<html>
<p>这个库包含了SPICE源的定义文件。</p>
<p><strong>注意：</strong>关于参数的默认值，SPICE3和Modelica之间存在差异。因此建议对<strong>所有</strong>源的参数进行明确指定。</p>
</html>"    , revisions="<html>
<ul>
<li><em>2009年8月 </em>Jonathan Kress改进了默认值<br></li>
<li><em>2008年10月</em>Christoph Clauss创建</li>
</ul>

</html>"    ));
  end Sources;

  package Additionals 
    "一些有用的附加模型，例如，来自SPICE2的多项式源"
      extends Modelica.Icons.Package;

    function poly "SPICE2的POLY函数"
      extends Modelica.Icons.Function;
      input Real s[:] "变量";
      input Real a[:] "系数";
      output Real v "多项式的值";
    protected
      Integer n "多项式变量的数量，类似于POLY(n)";
      Integer na "多项式系数的数量，类似于POLY(n)";
      Integer ia "系数使用状态";
    algorithm
      n := size(s,1);
      na := size(a,1);
      assert(n > 0,"poly: 变量数量为零");
      assert(na > 0,"poly: 系数数量为零");
      ia := 0;

    // 一元一次情况
      if n == 1 and na == 1 then
        /* 注意：如果多项式是一维的，并且恰好指定了一个系数，则SPICE假定它为p1(且p0=0.0)，以便
           便于输入线性控制源。
         */
        v := a[1] * s[1];
        return;
      end if;

    // 常数项
      v := a[1];
      ia := 1;

    // 一次项
      for i1 in 1:n loop
        ia := ia + 1;
        if ia > na then
          return;
        end if;
        v := v + a[ia] * s[i1];
      end for;

    // 二次项
      for i1 in 1:n loop
        for i2 in i1:n loop
          ia := ia + 1;
          if ia > na then
             return;
          end if;
          v := v + a[ia] * s[i1] * s[i2];
        end for;
      end for;

    // 三次项
      for i1 in 1:n loop
        for i2 in i1:n loop
          for i3 in i2:n loop
            ia := ia + 1;
            if ia > na then
              return;
            end if;
            v := v + a[ia] * s[i1] * s[i2] * s[i3];
          end for;
        end for;
      end for;

    // 四次项
      for i1 in 1:n loop
        for i2 in i1:n loop
          for i3 in i2:n loop
            for i4 in i3:n loop
              ia := ia + 1;
              if ia > na then
                return;
              end if;
              v := v + a[ia] * s[i1] * s[i2] * s[i3] * s[i4];
            end for;
          end for;
        end for;
      end for;

     // 五次项
      for i1 in 1:n loop
        for i2 in i1:n loop
          for i3 in i2:n loop
            for i4 in i3:n loop
              for i5 in i4:n loop
                ia := ia + 1;
                if ia > na then
                  return;
                end if;
                v := v + a[ia] * s[i1] * s[i2] * s[i3] * s[i4] * s[i5];
              end for;
            end for;
          end for;
        end for;
      end for;

      v := na;
     annotation (Documentation(info="<html>
<p>用于多项式插值的函数，用于POLY控制源：</p>
<ul>
<li>E_VCV_POLY</li>
<li>G_VCC_POLY</li>
<li>H_CCV_POLY</li>
<li>F_CCC_POLY</li>
</ul>
</html>"      ));
    end poly;

    model E_VCV_POLY 
      "多项式电压控制电压源(类似于SPICE2)"

      parameter Integer N(final min=1) = 1 "控制电压的数量";
      parameter Real coeff[:] = {1} "多项式系数";
      Modelica.Electrical.Analog.Interfaces.PositivePin p 
        "被控端口(通常右侧)的正引脚(电压降v2.v>n2.v为正)" annotation (Placement(
            transformation(extent={{110,40},{90,60}}), 
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n 
        "被控端口(通常右侧)的负引脚" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}), 
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N] 
        "控制引脚向量(通常左侧)" 
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}), iconTransformation(extent={
                {-90,-80},{-70,80}})));

      Real control[N];
    equation
      p.i + n.i = 0;
      for i in 1:2*N loop
        pc[i].i = 0;
      end for;
      for i in 1:N loop
        control[i] = pc[2*i-1].v - pc[2*i].v;
      end for;
      p.v - n.v = poly(control, coeff);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid, 
              lineColor={0,0,255}), 
            Text(
              extent={{-100,-62},{99,-112}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}), 
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}), 
            Line(points={{-20,50},{20,50}}, color={0,0,255}), 
            Polygon(
              points={{20,50},{10,53},{10,47},{20,50}}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid, 
              lineColor={0,0,255}), 
            Text(
              extent={{-54,-26},{22,-60}}, 
              textColor={0,0,255}, 
              textString="VCV")}), 
        Documentation(info="<html>
<p>多项式源是一个SPICE2模型，也被其他SPICE派生版本所称知。</p>
<p>非线性电压控制电压源。被控端口引脚p2和n2之间的“右”端口电压(=p2.v-n2.v)通过左端口引脚向量pc[:]上的电压通过以下方式控制：</p>
<blockquote><pre>
p2.v-n2.v=f(pc[1].v-pc[2].v,pc[3].v-pc[4].v,...)
</pre></blockquote>
<p>控制端口(左侧)的电流向量为零。</p>
<p>f是关于N个变量s1...sN的多项式，形式如下，具有M+1个系数a0、a1、a2，...aM。</p>
<blockquote><pre>
f = a0 +
a1s1 + a2s2 + ... + aNsN +
a(N+1)s1&sup2; + a(N+2)s1s2 + ... + a(.)s1sN +
a(.)s2&sup2; + a(.)s2s3 + ... + a(.)s2sN +
a(.)s3&sup2; + s3s4 + ... + a(.)s4sN +
... +
a(.)sN&sup2; +
a(.)s1&sup3; + a(.)s1&sup2;s2 + a(.)s1&sup2;s3 + ... + a(.)s1&sup2;sN +
a(.)s1s2&sup2; + a(.)s1s2s3 + ... + a(.)s1s2sN +
... +
a(.)sN&sup3; + ...
</pre></blockquote>
<p>系数a(.)按照这个顺序进行计数。达到M时，特定的和将被取消。</p>
<p>与VCV相关联，s1...sN是控制端的电压：s1=pc[1].v - pc[2].v, s2=pc[3].v - pc[4].v, s3=...</p>
<p>多项式电压控制电压源的对应 SPICE 描述如下：</p>
<blockquote><pre>
Ename A1 A2 POLY(N) E11 E21 ... E1N E2N P0 P1...
</pre></blockquote>
<p>其中Ename是实例的名称，A1和A2是控制电压被捕获的节点，</p>
<p>N是控制电压的数量，E11 E12 ... E1N E2N是控制电压被捕获的节点对，</p>
<p>P0、P1... 是多项式f中的系数，称为a0、a1、... aM。</p>
<p>为了在Modelica中描述SPICE行，以下说明可能会有用：</p>
<blockquote><pre>
Ename -&gt; E_VCV_POLY name
A1, A2 -&gt; pins name.p2, name.p1
N -&gt; parameter N
E11 -&gt; name.pc[2]
E12 -&gt; name.pc[1]
...
E1N -&gt; name.pc[N]
E2N -&gt; name.pc[N-1]
P0, P1 -&gt; polynomial coefficients name.coeff(coeff={P0,P1,...})
</pre></blockquote>
</html>"      , revisions="<html>
<ul>
<li><em>2008年9月</em>由Kristin Majetta<br>创建</li>
</ul>
</html>"      ));
    end E_VCV_POLY;

    model G_VCC_POLY 
      "多项式电压控制电流源(类似于SPICE2)"

      parameter Integer N(final min=1) = 1 "控制电压的数量";
      parameter Real coeff[:] = {1} "多项式系数";
      Modelica.Electrical.Analog.Interfaces.PositivePin p 
        "右端口的正引脚(电压降v2.v>n2.v为正)" annotation (Placement(
            transformation(extent={{110,40},{90,60}}), 
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n 
        "右端口的负引脚" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}), 
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N] 
        "控制引脚向量" 
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}), iconTransformation(extent={
                {-90,-80},{-70,80}})));

      Real control[N];
    equation
      p.i + n.i = 0;
      for i in 1:2*N loop
        pc[i].i = 0;
      end for;
      for i in 1:N loop
        control[i] = pc[2*i-1].v - pc[2*i].v;
      end for;
      p.i = poly(control, coeff);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid, 
              lineColor={0,0,255}), 
            Text(
              extent={{-100,-62},{99,-112}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}), 
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}), 
            Line(points={{-20,50},{20,50}}, color={0,0,255}), 
            Polygon(
              points={{20,50},{10,53},{10,47},{20,50}}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid, 
              lineColor={0,0,255}), 
            Text(
              extent={{-60,-24},{16,-58}}, 
              textColor={0,0,255}, 
              textString="VCC")}), 
        Documentation(info="<html>
<p>多项式源是一个SPICE2模型，也被其他SPICE派生版本所称知。</p>
<p>非线性电压控制电流源。右端口引脚p2上的电流(=p2.i)由左端口引脚向量pc[:]上的电压通过以下方式控制：</p>
<blockquote><pre>
p2.i=f(pc[1].v-pc[2].v, pc[3].v-pc[4].v,...)
</pre></blockquote>
<p>控制端口左侧的电流向量为零。</p>
<p>f是关于N个变量s1...sN的多项式，形式如下，具有M+1个系数 a0、a1、a2，...aM。</p>
<blockquote><pre>
f = a0 +
a1s1 + a2s2 + ... + aNsN +
a(N+1)s1&sup2; + a(N+2)s1s2 + ... + a(.)s1sN +
a(.)s2&sup2; + a(.)s2s3 + ... + a(.)s2sN +
a(.)s3&sup2; + s3s4 + ... + a(.)s4sN +
... +
a(.)sN&sup2; +
a(.)s1&sup3; + a(.)s1&sup2;s2 + a(.)s1&sup2;s3 + ... + a(.)s1&sup2;sN +
a(.)s1s2&sup2; + a(.)s1s2s3 + ... + a(.)s1s2sN +
... +
a(.)sN&sup3; + ...
</pre></blockquote>

<p>系数a(.)按照这个顺序进行计数。达到M时，特定的和将被取消。</p>

<p>与VCC相关联，s1...sN是控制端的电压：s1=pc[1].v-pc[2].v,s2=pc[3].v-pc[4].v,s3=...</p>

<p>多项式电压控制电流源的对应SPICE 描述如下：</p>
<blockquote><pre>
Gname A1 A2 POLY(N) E11 E21 ... E1N E2N P0 P1...
</pre></blockquote>

<p>其中Gname是实例的名称，A1和A2是计算其电流的电流源所在的节点，</p>

<p>N是控制电压的数量，E11 E12 ... E1N E2N是控制电压被捕获的节点对，</p>

<p>P0、P1... 是多项式f中的系数，称为a0、a1、... aM。</p>

<p>为了在Modelica中描述SPICE行，以下说明可能会有用：</p>

<blockquote><pre>
Gname -&gt; G_VCC_POLY name
A1, A2 -&gt; pins name.p2, name.p1
N -&gt; parameter N
E11 -&gt; name.pc[2]
E12 -&gt; name.pc[1]
...
E1N -&gt; name.pc[N]
E2N -&gt; name.pc[N-1]
P0, P1 -&gt; polynomial coefficients name.coeff(coeff={P0,P1,...})
</pre></blockquote>
</html>"          , revisions="<html>
<ul>
<li><em>2008年9月</em>由Kristin Majetta<br>创建</li>
</ul>
</html>"          ));
    end G_VCC_POLY;

    model H_CCV_POLY 
      "多项式电流控制电压源(类似于SPICE2)"

      parameter Integer N(final min=1) = 1 "控制电压的数量";
      parameter Real coeff[:] = {1} "多项式的系数";
      Modelica.Electrical.Analog.Interfaces.PositivePin p 
        "右侧端口的正极(对于正电压降v2，p2.v>n2.v)" annotation (Placement(
            transformation(extent={{110,40},{90,60}}), 
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n 
        "右侧端口的负极" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}), 
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N] 
        "控制引脚的引脚向量" 
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}), iconTransformation(extent={
                {-90,-80},{-70,80}})));

      Real control[N];
    equation
      p.i + n.i = 0;
      for i in 1:N loop
        pc[2*i-1].i + pc[2*i].i = 0;
        pc[2*i-1].v - pc[2*i].v = 0;
      end for;
      for i in 1:N loop
        control[i] = pc[2*i-1].i;
      end for;
      p.v - n.v = poly(control, coeff);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid, 
              lineColor={0,0,255}), 
            Text(
              extent={{-100,-62},{99,-112}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}), 
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}), 
            Line(points={{-20,50},{20,50}}, color={0,0,255}), 
            Polygon(
              points={{20,50},{10,53},{10,47},{20,50}}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid, 
              lineColor={0,0,255}), 
            Text(
              extent={{-60,-26},{16,-60}}, 
              textColor={0,0,255}, 
              textString="CCV")}), 
        Documentation(info="<html>
<p>多项式源是SPICE2模型，在其他SPICE派生版本中被称为多项式源。</p>
<p>非线性电流控制电压源。右侧端口p2和n2之间的电压(=p2.v-n2.v)由左侧端口引脚pc上的电流向量(=pc.i)控制：</p>

<blockquote><pre>
p2.v - n2.v = f(pc[2].i, pc[4].i,...)
</pre></blockquote>

<p>控制端口(左侧)的电流向量为零。</p>
<p>对应的SPICE描述如下</p>

<blockquote><pre>
Hname A1 A2 POLY(N) V1...VN P0 P1...
</pre></blockquote>

<p>f是N个变量s1...sN的多项式，形式如下，具有M+1个系数a0、a1、a2,...aM。</p>

<blockquote><pre>
f = a0 +
a1s1 + a2s2 + ... + aNsN +
a(N+1)s1&sup2; + a(N+2)s1s2 + ... + a(.)s1sN +
a(.)s2&sup2; + a(.)s2s3 + ... + a(.)s2sN +
a(.)s3&sup2; + s3s4 + ... + a(.)s4sN +
... +
a(.)sN&sup2; +
a(.)s1&sup3; + a(.)s1&sup2;s2 + a(.)s1&sup2;s3 + ... + a(.)s1&sup2;sN +
a(.)s1s2&sup2; + a(.)s1s2s3 + ... + a(.)s1s2sN +
... +
a(.)sN&sup3; + ...
</pre></blockquote>

<p>系数a(.)按此顺序计算。达到M，特定的和被取消。</p>

<p>在Modelica中，控制引脚必须以使所需电流流经CCV的相应引脚的方式连接到CCV中：</p>

<p>s1=pc[2].i，s2=pc[4].i，s3=pc[6].i，...</p>

<p>pc[1].i和pc[2].i，pc[3].i和pc[4].i...形成具有pc[2].i+pc[1].i= 0，pc[4].i+pc[3].i=0，...的端口</p>

<p>CCV多项式源的相应SPICE描述如下：</p>

<blockquote><pre>
Hname A1 A2 POLY(N) V1...VN P0 P1...
</pre></blockquote>

<p>其中Hname是实例的名称，A1和A2是被控制电压夹持的节点。</p>

<p>N是控制电流的数量，V1...VN是在SPICE中必要的电压源，以提供控制电流，</p>

<p>P0、P1...是上面多项式f 描述中称为a0、a1、... aM的系数。</p>


<p>要在Modelica中描述SPICE行，以下解释会有所帮助：</p>

<blockquote><pre>
Hname -&gt; H_CCV_POLY name
A1, A2 -&gt; 引脚 name.p2, name.p1
N -&gt; 参数 N
</pre></blockquote>

<p>V1(...VN)在SPICE中被声明：</p>

<blockquote><pre>
V1 V1+ V1- 电压源的类型(常数、脉冲、正弦...)
</pre></blockquote>

<p>在Modelica 中，通过V1...VN的电流必须通过CCV。因此，必须断开V1...VN并添加额外的节点</p>

<blockquote><pre>
V1_AD...VN_AD
</pre></blockquote>

<p>在SPICE源为</p>
<blockquote><pre>
V1 n+ n- 0,
</pre></blockquote>

<p>的情况下，此源可以被消除。</p>
<blockquote><pre>
V1_AD -&gt; name.pc[2]
V1- -&gt; name.pc[1]
...
VN_AD -&gt; name.pc[N]
VN- -&gt; name.pc[N-1]
P0, P1 -&gt; 多项式系数 name.coeff(coeff={P0,P1,...})
</pre></blockquote>
</html>"      , revisions="<html>
<ul>
<li><em>2008年9月</em>由Kristin Majetta创建</li>
</ul>
</html>"      ));
    end H_CCV_POLY;

    model F_CCC_POLY 
      "多项式电流控制电流源(类似于SPICE2)"

      parameter Integer N(final min=1) = 1 "控制电压的数量";
      parameter Real coeff[:] = {1} "多项式的系数";
      Modelica.Electrical.Analog.Interfaces.PositivePin p 
        "右侧端口的正极(对于正电压降v2，p2.v>n2.v)" annotation (Placement(
            transformation(extent={{110,40},{90,60}}), 
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n 
        "右侧端口的负极" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}), 
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N] 
        "控制引脚的引脚向量" 
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}), iconTransformation(extent={
                {-90,-80},{-70,80}})));

      Real control[N];
    equation
      p.i + n.i = 0;
      for i in 1:N loop
        pc[2*i-1].i + pc[2*i].i = 0;
        pc[2*i-1].v - pc[2*i].v = 0;
      end for;
      for i in 1:N loop
        control[i] = pc[2*i-1].i;
      end for;
      p.i = poly(control, coeff);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid, 
              lineColor={0,0,255}), 
            Text(
              extent={{-100,-62},{99,-112}}, 
              textString="%name", 
              textColor={0,0,255}), 
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}), 
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}), 
            Line(points={{-20,50},{20,50}}, color={0,0,255}), 
            Polygon(
              points={{20,50},{10,53},{10,47},{20,50}}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid, 
              lineColor={0,0,255}), 
            Text(
              extent={{-60,-24},{16,-58}}, 
              textColor={0,0,255}, 
              textString="CCC")}), 
        Documentation(info="<html>
<p>多项式源是 SPICE2 模型，在其他 SPICE 派生版本中也被称为。</p>
<p>非线性电流控制电流源。在端口 p2(=p2.i)的“右侧”，其电流由端口 pc[:] 上的电流向量“左侧”控制：</p>
<blockquote><pre>
p2.i = f(pc[2].i, pc[4].i,...)
</pre></blockquote>
<p>对于每对来说，控制端口(左侧)的电压为零：pc[2].v-pc[1].v=0，...</p><p>此外，每对的电流分别为 pc[2].i + pc[1].i = 0，...</p>
<p>f是N个变量 s1...sN的多项式，形式如下，具有M+1个系数a0、a1、a2，...aM。</p>
<blockquote><pre>
f = a0 +
a1s1 + a2s2 + ... + aNsN +
a(N+1)s1&sup2; + a(N+2)s1s2 + ... + a(.)s1sN +
a(.)s2&sup2; + a(.)s2s3 + ... + a(.)s2sN +
a(.)s3&sup2; + s3s4 + ... + a(.)s4sN +
... +
a(.)sN&sup2; +
a(.)s1&sup3; + a(.)s1&sup2;s2 + a(.)s1&sup2;s3 + ... + a(.)s1&sup2;sN +
a(.)s1s2&sup2; + a(.)s1s2s3 + ... + a(.)s1s2sN +
... +
a(.)sN&sup3; + ...
</pre></blockquote>

<p>系数a(.)是按照这个顺序计算的。达到M时，特定的总和被取消。</p><p>在Modelica中，控制引脚必须以这种方式连接到CCC，以便所需的电流通过CCC的相应引脚流动：</p><p>s1=pc[2].i，s2=pc[4].i，s3=pc[6].i，...</p>

<p>对于每对，pc[1].i和pc[2].i，pc[3].i和pc[4].i...形成带有pc[2].i+pc[1].i=0，pc[4].i+pc[3].i=0，...的端口</p>

<p>CCC多项式源的相应SPICE描述如下：</p>

<blockquote><pre>
Fname A1 A2 POLY(N) V1...VN P0 P1...
</pre></blockquote>

<p>Fname是实例的名称，A1和A2是在它们之间安排电流源的节点，其电流被计算。</p>

<p>N是控制电流的数量，V1...VN是在SPICE中需要用来供应控制电流的电压源，</p>

<p>而P0、P1...是称为f上述多项式系数的系数a0、a1，... aM。</p>

<p>为了在Modelica中描述SPICE行，以下解释可能会有所帮助：</p>

<blockquote><pre>
Fname -&gt; F_CCC_POLY name
A1, A2 -&gt; pins name.p2, name.p1
N -&gt; parameter N
</pre></blockquote>
<p>V1(...VN)在SPICE中被声明：</p>
<blockquote><pre>
V1 V1+ V1- 电压源的类型(常数、脉冲、正弦...)
</pre></blockquote>

<p>在Modelica 中，通过V1...VN的电流必须通过CCC。因此，必须断开V1...VN并添加额外的节点</p>

<blockquote><pre>
V1_AD...VN_AD
</pre></blockquote>

<p>在SPICE源为</p>
<blockquote><pre>
V1 n+ n- 0,
</pre></blockquote>

<p>的情况下，此源可以被消除。</p>
<blockquote><pre>
V1_AD -&gt; name.pc[2]
V1- -&gt; name.pc[1]
...
VN_AD -&gt; name.pc[N]
VN- -&gt; name.pc[N-1]
P0,P1-&gt;多项式系数name.coeff(coeff={P0,P1,...})
</pre></blockquote>
</html>"          , revisions="<html>
<ul>
<li><em>2008年9月</em>Kristin Majetta创建 <br></li>
</ul>
</html>"          ));
    end F_CCC_POLY;
    annotation (Documentation(info="<html>
<p>该库包含额外的有用模型，这些模型不属于原始的SPICE3模型集。</p>

</html>"  ));
  end Additionals;

  package Interfaces "连接器、接口和部分模型"

    extends Modelica.Icons.InterfacesPackage;

    partial model TwoPortControlledSources 
      "具有两个电气端口的组件，包括电流"
      SI.Voltage v1 "控制端口上的电压降";
      SI.Voltage v2 "受控端口上的电压降";
      SI.Current i1 
        "从控制端口的正极到负极流动的电流";
      SI.Current i2 
        "从受控端口的正极到负极流动的电流";
      Modelica.Electrical.Analog.Interfaces.PositivePin p1 
        "控制端口的正极" annotation (Placement(
            transformation(extent={{-110,40},{-90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n1 
        "控制端口的负极" annotation (Placement(
            transformation(extent={{-90,-60},{-110,-40}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin p2 
        "受控端口的正极" annotation (Placement(
            transformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n2 
        "受控端口的负极" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}})));
    equation
      v1 = p1.v - n1.v;
      v2 = p2.v - n2.v;
      0 = p1.i + n1.i;
      0 = p2.i + n2.i;
      i1 = p1.i;
      i2 = p2.i;
      annotation (
        Documentation(info="<html>
<p>TwoPort是一个部分模型，由两个端口组成。假设流入正极的电流与流出负极的电流相同。每个端口的电流都以显式的方式提供，分别为i1和i2，电压分别为v1和v2。</p>
</html>"        ));
    end TwoPortControlledSources;

    connector InductiveCouplePinIn 
      "通过K耦合电感的引脚，K获取电感的值"
      input SI.Inductance L;
      SI.CurrentSlope di "di/dt";
      flow SI.Voltage v;
      annotation (Icon(graphics={Polygon(
              points={{0,0},{0,100},{100,0},{0,-100},{0,-100},{0,0}}, 
              lineColor={170,85,255}, 
              fillColor={170,85,255}, 
              fillPattern=FillPattern.Solid)}));
    end InductiveCouplePinIn;

    connector InductiveCouplePinOut 
      "通过K耦合电感的引脚，K设置电感的值"
      output SI.Inductance L;
      SI.CurrentSlope di "di/dt";
      flow SI.Voltage v;
      annotation (Icon(graphics={Polygon(
              points={{-100,0},{0,100},{0,0},{0,-100},{-2,-98},{-100,0}}, 
              lineColor={170,85,255}, 
              fillColor={170,85,255}, 
              fillPattern=FillPattern.Solid)}));
    end InductiveCouplePinOut;

    partial model ConditionalSubstrate 
      "包含条件基板节点的部分模型"

      parameter Boolean useSubstrateNode = false 
        "= true，如果SubstrateNode已启用" 
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      Modelica.Electrical.Analog.Interfaces.PositivePin S(v = substrateVoltage, i = -substrateCurrent) if useSubstrateNode 
        annotation (Placement(
            transformation(extent={{90,0},{110,20}}), 
            iconTransformation(extent={{90,-10}, {110,10}})
          ));
      SI.Voltage substrateVoltage;
      SI.Current substrateCurrent;

    equation
      if not useSubstrateNode then
        substrateVoltage = 0;
      end if;
      annotation (Documentation(revisions="<html>
<ul>
<li><em>2009年2月17日</em>
Christoph Clauss创建</li>
</ul>
</html>"        , 
          info="<html>
<p>
此部分模型提供了一个条件性的加热端口，用于连接到热网络。
</p>
<ul>
<li>如果<strong>useHeatPort</strong>设置为<strong>false</strong>(默认值)，则没有加热端口可用，并且热损耗功率会内部流向地。在这种情况下，参数<strong>T</strong>指定了固定的设备温度(默认为T=20°C)。</li>
<li>如果<strong>useHeatPort</strong>设置为<strong>true</strong>，则有一个加热端口可用。</li>
</ul>

<p>
如果使用此模型，损耗功率必须由从ConditionalHeatingPort模型继承的模型中的方程提供(<strong>lossPower =...</strong>)。代表设备温度的<strong>T_heatPort</strong>可用于描述设备温度对模型行为的影响。
</p>
</html>"        ));
    end ConditionalSubstrate;
    annotation(preferredView="info", 
        Documentation(info="<html>
<p>SPICE3库使用Modelica.Electrical.Analog接口。此Interfaces库中仅包含SPICE3库中使用的特殊部分模型。</p>
</html>"    ));
  end Interfaces;

  package Types "Spice3类型定义(额外部分)"
    extends Modelica.Icons.TypesPackage;
    type Capacitance = SI.Capacitance(min=-Modelica.Constants.inf) "无界电容" annotation();
    type VoltageSquare = Real (final quantity="ElectricalPotential2", final unit="V2") "电压的平方" annotation();
    type GapEnergyPerTemperature = Real (final quantity="Energy per Temperature", final unit="eV/K") "能量/温度" annotation();
    type GapEnergyPerEnergy = Real (final quantity="Energy per Energy", final unit="eV/J") "能量/能量" annotation();
    type PerVolume = Real (final quantity="PerVolume", final unit="1/m3") "/体积" annotation();
    type InverseElectricCurrent = Real (final quantity="InverseElectricCurrent", final unit="1/A") "电流的倒数" annotation();
    type ElectricFieldStrength_cm = Real (final quantity="ElectricFieldStrength", 
          final unit="V/cm") "电场强度" annotation();
    annotation (Documentation(info="<html>
<p>Types库包含在Spice3中模型中所需的单位。</p>
</html>"  ));
  end Types;

  package Internal 
    "从C++Spice库派生的函数和记录的集合"
    extends Modelica.Icons.InternalPackage;


  model MOS "金属-氧化物半导体场效应晶体管"

    Modelica.Electrical.Analog.Interfaces.PositivePin G "栅极节点" annotation (Placement(transformation(
              extent={{-110,-12},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin D "漏极节点" annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin S "源极节点" annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin B "衬底节点" annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));

    parameter Integer mtype(start = 0) 
        "MOSFET 类型: 0-N 通道, 1- P通道";
    parameter SI.Length L =  1e-4 "长度";
    parameter SI.Length W =  1e-4 "宽度";
    parameter SI.Area AD = 0 "漏极扩散面积";
    parameter SI.Area AS = 0 "源极扩散面积";
    parameter SI.Length PD =  0 "漏极结周长";
    parameter SI.Length PS =  0 "源极结周长";
    parameter Real NRD = 1 "漏极扩散方块数";
    parameter Real NRS = 1 "源极扩散方块数";
    parameter Integer OFF = 0 
        "可选的初始条件: 0-未使用IC, 1-使用IC, 尚未实现";
    parameter SI.Voltage IC( start = -1e40) 
        "初始条件值, 尚未实现";
    parameter Modelica.Units.NonSI.Temperature_degC TEMP = 27 "器件工作温度";

    parameter ModelcardMOS modelcard "MOSFET 模型卡片" annotation(Evaluate=true);
    constant SpiceConstants C "SPICE 仿真器的常数";
    final parameter Mos1.Mos1ModelLineParams p = Mos1.mos1RenameParameters(modelcard, C) 
        "模型线参数" annotation(Evaluate=true);
    final parameter Mosfet.Mosfet m = Mos1.mos1RenameParametersDev(
      modelcard, 
      mtype, 
      W, 
      L, 
      AS, 
      AS, 
      PD, 
      PS, 
      NRD, 
      NRS, 
      OFF, 
      IC, 
      TEMP) "重命名参数" annotation(Evaluate=true);
    final parameter Integer m_type = if (m.m_bPMOS > 0.5) then -1 else 1 
        "晶体管类型";
    final parameter Mos.MosModelLineVariables vp = Mos1.mos1ModelLineParamsInitEquations(
          p, 
          C, 
          m_type) "模型线变量";
    final parameter Mos1.Mos1Calc c1 = Mos.mosCalcInitEquations(
          p, 
          C, 
          vp, 
          m) "预计算参数";
    final parameter Mos1.Mos1Calc c2 = Mos.mosCalcCalcTempDependencies(
          p, 
          C, 
          vp, 
          m, 
          c1, 
          m_type) "预计算参数";

    Mos.CurrrentsCapacitances cc;
    parameter Mos.CurrrentsCapacitances cc_ = Mos.mosCalcNoBypassCode(
    m, 
    m_type, 
    c2, 
    p, 
    C, 
    vp, 
    m_bInit, 
    {0, 0, 0, 0}) annotation (Evaluate = true);

    constant Boolean m_bInit = false;

    SI.Voltage Dinternal;  //内部漏极节点
    SI.Voltage Sinternal;  //内部源极节点
    SI.Current ird;
    SI.Current irs;
    SI.Current ibdgmin;
    SI.Current ibsgmin;

    SI.Current icBD;
    SI.Current icBS;
    SI.Current icGB;
    SI.Current icGS;
    SI.Current icGD;
    SI.Voltage vDS "漏极 - 源极电压";
    SI.Voltage vGS "栅极 - 源极电压";

  equation
    assert( NRD > 0, "NRD，漏极方块的长度，必须大于零");
    assert( NRS > 0, "NRS，源极方块的长度，必须大于零");

    vDS = D.v - S.v;
    vGS = G.v - S.v;

    cc = Mos.mosCalcNoBypassCode(
      m, 
      m_type, 
      c2, 
      p, 
      C, 
      vp, 
      m_bInit, 
      {G.v, B.v, Dinternal, Sinternal});

    // 漏极和源极电阻
    // ----------------------------
    ird * c1.m_drainResistance = (D.v - Dinternal);
    irs * p.m_sourceResistance = (S.v - Sinternal);

    // 电容
    // ------------

     //icBD = cc_.cBD * (der(B.v) - der(Dinternal));
     //icBS = cc_.cBS * (der(B.v) - der(Sinternal));
     //icGB = cc_.cGB * (der(G.v) - der(B.v));
     //icGD = cc_.cGD * (der(G.v) - der(Dinternal));
     //icGS = cc_.cGS * (der(G.v) - der(Sinternal));
     if cc_.cBD <= 0 then
        icBD = 0;
    else
        icBD = cc.cBD * (der(B.v) - der(Dinternal));
    end if;
    if cc_.cBS <= 0 then
        icBS = 0;
    else
        icBS = cc.cBS * (der(B.v) - der(Sinternal));
    end if;
    if cc_.cGB <= 0 then
        icGB = 0;
    else
        icGB = cc.cGB * (der(G.v) - der(B.v));
    end if;
    if cc_.cGD <= 0 then
        icGD = 0;
    else
        icGD = cc.cGD * (der(G.v) - der(Dinternal));
    end if;
    if cc_.cGS <= 0 then
        icGS = 0;
    else
        icGS = cc.cGS * (der(G.v) - der(Sinternal));
    end if;

    // 电流
    // --------
     ibsgmin = SpiceConstants.CKTgmin * (B.v - Sinternal);
     ibdgmin = SpiceConstants.CKTgmin * (B.v - Dinternal);
    G.i = icGB + icGD + icGS;
    B.i = cc.iBD + cc.iBS + ibdgmin + ibsgmin - icGB + icBD + icBS;
    D.i = ird;
    S.i = irs;

  // 内部节点的电流总和
  //------------------------
    0    = -ird + cc.idrain - cc.iBD - ibdgmin - icGD - icBD;
    0    = -irs - cc.idrain - cc.iBS - ibsgmin - icGS - icBS;

    annotation (Documentation(info="<html>
<p>MOSFET模型，包括N型和P型通道(级别1：Shichman-Hodges)</p>
<p>库Repository不供用户访问。它存储了半导体模型建模所需的所有函数、记录和数据。</p>
</html>"    , revisions="<html>
<ul>
<li><em>2008年3月</em>Kristin Majetta<br>创建</li>
</ul>
</html>"    ), 
        Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,92},{0,40},{-12,40},{-12,-40},{0,-40},{0,-94}}, 
                color={0,0,255}), 
            Line(points={{-92,0},{-20,0}}, color={0,0,255}), 
            Line(points={{-12,0},{94,0}}, color={0,0,255}), 
            Line(points={{-20,40},{-20,-40}}, color={0,0,255}), 
            Text(
              extent={{8,-34},{92,-86}}, 
              textColor={0,0,255}, 
              textString="%name")}));
  end MOS;

     record ModelcardMOS "带有技术参数的记录(.model文件)"
       extends Modelica.Icons.Record;
       parameter SI.Voltage VTO=-1e40 "零偏阈值电压，默认为0";
       parameter SI.Transconductance KP=-1e40 
        "跨导参数，默认为2e-5";
       parameter Real GAMMA=-1e40 "衬底阈值参数，默认为0";
       parameter SI.Voltage PHI=-1e40 "表面电势，默认为0.6";  //衬底Sperrschicht电势
       parameter SI.InversePotential LAMBDA=0 
        "通道长度调制，默认为0";
       parameter SI.Resistance RD=-1e40 "漏极欧姆电阻，默认为0";
       parameter SI.Resistance RS=-1e40 "源极欧姆电阻，默认为0";
       parameter Types.Capacitance CBD=-1e40 
        "零偏B-D结电容，默认为0";
       parameter Types.Capacitance CBS=-1e40 
        "零偏B-S结电容，默认为0";
       parameter SI.Current IS=1e-14 "衬底结饱和电流";
       parameter SI.Voltage PB=0.8 "衬底结电势";
       parameter SI.Permittivity CGSO=0.0 
        "单位通道宽度的栅源重叠电容";
       parameter SI.Permittivity CGDO=0.0 
        "单位通道宽度的栅漏重叠电容";
       parameter SI.Permittivity CGBO=0.0 
        "单位通道宽度的栅衬底重叠电容";
       parameter SI.Resistance RSH=0.0 
        "漏极和源极扩散片电阻";
       parameter SI.CapacitancePerArea CJ=0.0 
        "单位结面积的零偏衬底结底部电容";
       parameter Real MJ=0.5 "衬底结底部分级系数";
       parameter SI.Permittivity CJSW=0.0 
        "单位结周长的零偏结侧壁电容";
       parameter Real MJSW=0.5 "衬底结侧壁分级系数";
       parameter SI.CurrentDensity JS=0.0 
        "单位结面积的衬底结饱和电流";
       parameter SI.Length TOX=-1e40 "氧化层厚度，默认为1e-7";
       parameter Real NSUB=-1e40 "衬底掺杂，默认为0";
       parameter Modelica.Units.NonSI.PerArea_cm NSS=0.0 
        "表面态密度";
       parameter Real TPG=1.0 
        "栅极材料类型：+1与衬底相反，-1与衬底相同，0铝栅";
       parameter SI.Length LD=0.0 "侧向扩散";
       parameter Modelica.Units.NonSI.Area_cmPerVoltageSecond UO=600 
        "表面迁移率";
       parameter Real KF=0 "闪烁噪声系数";
       parameter Real AF=1.0 "闪烁噪声指数";
       parameter Real FC=0.5 
        "正向偏置耗尽电容公式的系数";
       parameter Modelica.Units.NonSI.Temperature_degC TNOM=27 
        "参数测量温度，默认为27";
       constant Integer LEVEL=1 "模型级别：Shichman-Hodges";
       annotation (Documentation(info="<html>
<p>MOSFET模型的模型卡参数，包括N型和P型通道(模型级别-级别1:Shichman-Hodges)</p>
<p>库“Repository”不供用户访问。它存储了该包的半导体模型建模所需的所有函数、记录和数据。</p>
</html>"       ));
     end ModelcardMOS;

  model MOS2 "金属-氧化物半导体场效应晶体管"

    Modelica.Electrical.Analog.Interfaces.PositivePin G "栅极节点" 
                                          annotation (Placement(transformation(
              extent={{-110,-12},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin D "漏极节点" 
                                           annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin S "源极节点" 
                                            annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin B "衬底节点" 
                                          annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));

    parameter Integer mtype(start = 0) 
        "MOSFET类型: 0-N通道, 1-P通道";
    parameter SI.Length L = 1e-4 "长度";
    parameter SI.Length W = 1e-4 "宽度";
    parameter SI.Area AD = 0 "漏极扩散区域";
    parameter SI.Area AS = 0 "源极扩散区域";
    parameter SI.Length PD = 0 "漏极结周长";
    parameter SI.Length PS = 0 "源极结周长";
    parameter Real NRD = 1 "漏极扩散区域的方块数量";
    parameter Real NRS = 1 "源极扩散区域的方块数量";
  //--------------------------------------------------------------------------------------
    parameter Integer OFF(min=0, max=1) = 0 
        "可选初始条件: 0-未使用IC，1-使用IC，尚未实现";
  //--------------------------------------------------------------------------------------
    parameter SI.Voltage IC_VDS = -1e40 
        "初始条件值(VDS，尚未实现)";
    parameter SI.Voltage IC_VGS = -1e40 
        "初始条件值(VGS，尚未实现)";
    parameter SI.Voltage IC_VBS = -1e40 
        "初始条件值(VBS，尚未实现)";
    parameter Boolean UIC = false 
        "使用初始条件: 如果使用初始条件，则为true";
    parameter Modelica.Units.NonSI.Temperature_degC TEMP = 27 "器件的工作温度";

    parameter Spice3.Internal.ModelcardMOS2 
                            modelcard "MOSFET 模型卡" 
                annotation(Evaluate=true);

    final parameter Spice3.Internal.Mos2.Mos2ModelLineParams p= 
          Spice3.Internal.Mos2.mos2RenameParametersRevised(
          modelcard) "模型线参数" 
                      annotation(Evaluate=true);

    final parameter Spice3.Internal.Mosfet.Mosfet m= 
          Spice3.Internal.Mosfet.mosfetRenameParametersDev(
            W, 
            L, 
            AD, 
            AS, 
            PD, 
            PS, 
            NRD, 
            NRS, 
            OFF, 
            IC_VDS, 
            IC_VGS, 
            IC_VBS, 
            UIC, 
            TEMP) "重命名参数" 
                                  annotation(Evaluate=true);
    final parameter Spice3.Internal.Mosfet.Mosfet m1= 
          Spice3.Internal.Mosfet.mosfetInitEquations(m);

    final parameter Integer m_type = if (m.m_bPMOS > 0.5) then -1 else 1 
        "晶体管类型";

    final parameter Spice3.Internal.Mos2.Mos2ModelLineParams 
        p1= 
          Spice3.Internal.Mos2.mos2ModelLineParamsInitEquationsRevised(
           p, m_type) "模型线变量";
    final parameter Spice3.Internal.Mos2.Mos2Calc c11= 
          Spice3.Internal.Mos.mos2CalcInitEquationsRevised(
          p1, m1) "预计算参数";
    final parameter Spice3.Internal.Mos2.Mos2Calc c22= 
          Spice3.Internal.Mos.mos2CalcCalcTempDependenciesRevised(
            p1, 
            m1, 
            c11, 
            m_type) "预计算参数";

    Spice3.Internal.Mos.CurrrentsCapacitances cc;

    constant Boolean m_bInit = false;

    SI.Voltage Dinternal;
    SI.Voltage Sinternal;
    SI.Voltage vBD;
    SI.Voltage vBS;
    SI.Voltage vGB;
    SI.Voltage vGD;
    SI.Voltage vGS;
    SI.Current ird;
    SI.Current irs;
    SI.Current ibdgmin;
    SI.Current ibsgmin;

    SI.Current icBD;
    SI.Current icBS;
    SI.Current icGB;
    SI.Current icGS;
    SI.Current icGD;

  //-------------------------------obsolete-----------------------------------------------------------------------------------------------
    parameter SI.Voltage IC( start = -1e40) 
        "初始条件值，尚未实现";

  //-------------------------------------------------------------------------------------------------------------------------------------

    final parameter Spice3.Internal.Mos2.Mos2Calc 
                                   c1=Spice3.Internal.Mos.mos2CalcInitEquationsRevised(
             p, 
             m) "预计算参数";
    final parameter Spice3.Internal.Mos2.Mos2Calc 
                                   c2=Spice3.Internal.Mos.mos2CalcCalcTempDependenciesRevised(
             p, 
             m, 
             c1, 
             m_type) "预计算参数";

    final parameter Spice3.Internal.Mos2.Mos2ModelLineParams 
                                             p_obsolete=Spice3.Internal.Mos2.mos2RenameParametersRevised(
          modelcard) "模型线参数" 
                      annotation(Evaluate=true);

    constant Spice3.Internal.SpiceConstants C 
        "SPICE模拟器的通用常数";
  equation
    assert( NRD > 0, "漏极的长度必须大于零");
    assert( NRS > 0, "源极的长度必须大于零");

      cc = Spice3.Internal.Mos.mos2CalcNoBypassCodeRevised(
          m1, 
          m_type, 
          c22, 
          p1, 
          m_bInit, 
          {G.v,B.v,Dinternal,Sinternal});
    // 电压
    // --------
    vBD = B.v - Dinternal;
    vBS = B.v - Sinternal;
    vGB = G.v - B.v;
    vGD = G.v - Dinternal;
    vGS = G.v - Sinternal;

    // 漏极和源极电阻
    // ----------------------------
    ird * c11.m_drainResistance  = (D.v - Dinternal);
    irs * c11.m_sourceResistance = (S.v - Sinternal);

    // 电容
    // ------------

    icBD = cc.cBD * der(vBD);
    icBS = cc.cBS * der(vBS);
    icGB = cc.cGB * der(vGB);
    icGD = cc.cGD * der(vGD);
    icGS = cc.cGS * der(vGS);

    // 电流
    // --------
      ibsgmin = Spice3.Internal.SpiceConstants.CKTgmin*(B.v - 
        Sinternal);
      ibdgmin = Spice3.Internal.SpiceConstants.CKTgmin*(B.v - 
        Dinternal);
    G.i =  icGB + icGD + icGS;
    B.i = cc.iBD + cc.iBS+ ibdgmin + ibsgmin -icGB + icBD + icBS;
    D.i = ird;
    S.i = irs;

  //内部节点的电流和
  //------------------------
    0    = -ird + cc.idrain - cc.iBD - ibdgmin - icGD - icBD;
    0    = -irs - cc.idrain - cc.iBS - ibsgmin - icGS - icBS;

    annotation (Documentation(info="<html>
<p>MOSFET模型，包括N型和P型通道(级别2)</p>
<p>库“Repository”不供用户访问。它存储了该库的半导体模型建模所需的所有函数、记录和数据。</p>
</html>"    , revisions="<html>
<ul>
<li><em>January 2009</em>Kristin Majetta创建</li>
</ul>
</html>"    ), 
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,92},{0,40},{-12,40},{-12,-40},{0,-40},{0,-94}}, 
                color={0,0,255}), 
            Line(points={{-92,0},{-20,0}}, color={0,0,255}), 
            Line(points={{-12,0},{94,0}}, color={0,0,255}), 
            Line(points={{-20,40},{-20,-40}}, color={0,0,255}), 
            Text(
              extent={{8,-34},{92,-86}}, 
              textColor={0,0,255}, 
              textString="%name")}));
  end MOS2;

    record ModelcardMOS2 "带有技术参数的记录(.model)"
      extends Modelica.Icons.Record;
      extends Spice3.Internal.ModelcardMOS(MJSW = 0.33);

      parameter Modelica.Units.NonSI.PerArea_cm NFS = 0.0 
        "快速表面态密度";
      parameter SI.Length XJ = 0.0 "冶金结深度";
      parameter Types.ElectricFieldStrength_cm UCRIT = 1e4 
        "用于迁移率退化的临界场(仅适用于MOS2)";
      parameter Real UEXP = 0.0 
        "迁移率退化中的临界场指数(仅适用于MOS2)";
      parameter SI.Velocity VMAX = 0.0 "载流子的最大漂移速度";
      parameter Real NEFF = 1.0 
        "总通道电荷(固定和移动)系数(仅适用于MOS2)";
      parameter Real DELTA = 0.0 "阈值电压上的宽度效应";

      annotation(Documentation(info = "<html>
<p>MOSFET模型的模型卡参数，包括N型和P型通道(级别2)</p>
<p>库“Repository”不供用户访问。它存储了该库的半导体模型建模所需的所有函数、记录和数据。</p>
</html>"      ));
    end ModelcardMOS2;

    model BJT2 "双极晶体管"

      Modelica.Electrical.Analog.Interfaces.PositivePin B "基极节点" 
        annotation (Placement(transformation(extent={{-108,-10},{-88,10}}), 
            iconTransformation(extent={{-106,-10},{-86,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin C "集电极节点" 
        annotation (Placement(transformation(extent={{10,88},{30,108}}), 
            iconTransformation(extent={{20,90},{40,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin E "发射极节点" 
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}), 
            iconTransformation(extent={{20,-110},{40,-90}})));
      extends Spice3.Interfaces.ConditionalSubstrate;
      parameter Real TBJT( start = 1) "晶体管类型(NPN=1,PNP=-1)";
      parameter Real AREA = 1.0 "面积因子";
      parameter Boolean OFF = false 
        "可选的初始条件：false-未使用IC，true-使用IC，尚未实现";
      parameter SI.Voltage IC_VBE = -1e40 
        "初始条件值(VBC，尚未实现)";
      parameter SI.Voltage IC_VCE = -1e40 
        "初始条件值(VBE，尚未实现)";
      parameter Boolean UIC = false 
        "使用初始条件：true，如果使用了初始条件";
      parameter Modelica.Units.NonSI.Temperature_degC TEMP = 27 "器件的工作温度";
      parameter Boolean SENS_AREA = false 
        "请求相对于面积的敏感性的标志，尚未实现";

      parameter Modelica.Electrical.Spice3.Internal.ModelcardBJT2 
                             modelcard "BJT模型卡" annotation(Evaluate=true);

      final parameter Spice3.Internal.Bjt.BjtModelLineParams p= 
          Spice3.Internal.Bjt.bjtRenameParameters(modelcard, 
          TBJT) "模型线参数" annotation(Evaluate=true);
      final parameter Spice3.Internal.Bjt.Bjt dev= 
          Spice3.Internal.Bjt.bjtRenameParametersDev(
            AREA, 
            OFF, 
            IC_VBE, 
            IC_VCE, 
            UIC, 
            SENS_AREA, 
            TEMP) "重命名的参数" annotation(Evaluate=true);
      final parameter Spice3.Internal.Bjt.BjtModelLineParams p1= 
          Spice3.Internal.Bjt.bjtModelLineInitEquations(p) 
        "模型线变量";
      final parameter Spice3.Internal.Bjt.Bjt dev1= 
          Spice3.Internal.Bjt.bjtInitEquations(dev, p1) 
        "预计算参数";
      final parameter Spice3.Internal.Bjt.BjtCalc c= 
          Spice3.Internal.Bjt.bjtCalcTempDependencies(dev1, p1) 
        "预计算参数";

      constant Boolean m_bInit = false;
      Spice3.Internal.Bjt.CurrentsCapacitances cc;
      parameter Spice3.Internal.Bjt.CurrentsCapacitances cc_ = Spice3.Internal.Bjt.bjtNoBypassCode(
        dev1, 
        p1, 
        c, 
        {0, 0, 0, 0, 0, 0}) annotation (Evaluate = true);
      SI.Voltage Cinternal;    // 内部集电极节点
      SI.Voltage Binternal;    // 内部基极节点
      SI.Voltage Einternal;    // 内部发射极节点
      SI.Voltage vbe;
      SI.Voltage vbc;
      SI.Voltage vbx;
      SI.Voltage vcs;
      SI.Current irc;
      SI.Current ire;
      SI.Current irb;
      SI.Current ibcgmin;
      SI.Current ibegmin;
      SI.Current icapbe;
      SI.Current icapbc;
      SI.Current icapbx;
      SI.Current icapcs;
      SI.Current icaptt;

    equation
      cc = Spice3.Internal.Bjt.bjtNoBypassCode(
          dev1, 
          p1, 
          c, 
          {C.v,B.v,E.v,Cinternal,Binternal,Einternal});

      // 电压
      vbe = Binternal - Einternal;
      vbc = Binternal - Cinternal;
      vbx = B.v - Cinternal;
      vcs = Cinternal - substrateVoltage;

      // 通过电容的电流
      if cc_.capbe <= 0 then
        icapbe = 0;
      else
        icapbe = if (m_bInit) then 0.0 else cc.capbe * der(vbe);
      end if;
      if cc_.capbc <= 0 then
        icapbc = 0;
      else
        icapbc = if (m_bInit) then 0.0 else cc.capbc * der(vbc);
      end if;
      if cc_.captt <= 0 then
        icaptt = 0;
      else
        icaptt = if (m_bInit) then 0.0 else cc.captt * der(vbc);
      end if;
      if cc_.capbx <= 0 then
        icapbx = 0;
      else
        icapbx = if (m_bInit) then 0.0 else cc.capbx * der(vbx);
      end if;
      if cc_.capcs <= 0 then
        icapcs = 0;
      else
        icapcs = if (m_bInit) then 0.0 else cc.capcs * der(vcs);
      end if;

      // 电阻
      irc * p1.m_collectorResist = (C.v - Cinternal);
      ire * p1.m_emitterResist = (E.v -Einternal);
    //  irb * cc.rx = (B.v - Binternal);  // 精确电阻
      irb * p.m_baseResist = (B.v - Binternal); // 错误电阻

      // 电流
      ibcgmin = Spice3.Internal.SpiceConstants.CKTgmin*(
        Binternal - Cinternal);
      ibegmin = Spice3.Internal.SpiceConstants.CKTgmin*(
        Binternal - Einternal);
      C.i = irc;
      E.i = ire;
      B.i = irb + icapbx;
      // 内部节点的电流和
      0 =  ibcgmin + irc -cc.iCC + cc.iBCN + cc.iBC + icapbc + icapbx - icapcs + icaptt; // 内部节点 Cinternal 的电流和
      0 =  ibegmin + ire + cc.iCC + cc.iBEN + cc.iBE + icapbe;          // 内部节点 Einternal 的电流和
      0 = - ibcgmin - ibegmin + irb - cc.iBC - cc.iBE - cc.iBCN - cc.iBEN -icapbc - icapbe - icaptt; // 内部节点 Binternal 的电流和
      substrateCurrent = icapcs;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={
            Line(
              points={{-20,60},{-20,-60}}, 
              color={0,0,255}), 
            Line(
              points={{-20,0},{-86,0}}, 
              color={0,0,255}), 
            Line(
              points={{34,94},{-20,40}}, 
              color={0,0,255}), 
            Line(
              points={{-20,-40},{32,-92}}, 
              color={0,0,255}), 
            Text(
              extent={{-94,56},{206,16}}, 
              textString="%name", 
              textColor={0,0,255})}), 
        Documentation(info="<html>
<p>双极晶体管模型，包括NPN和PNP</p>
<p>库“Internal”不供用户访问。其中存储了该库的半导体模型建模所需的所有函数、记录和数据。</p>
</html>"      ,     revisions="<html>
<ul>
<li><em>2009年8月</em>，Kristin Majetta创建
</ul>
</html>"      ));
    end BJT2;

    record ModelcardBJT2 "记录技术参数(.model)"
      extends Modelica.Icons.Record;
      parameter Modelica.Units.NonSI.Temperature_degC TNOM = 27 "参数测量温度";
      parameter SI.Current IS = 1e-16 "传输饱和电流";
      parameter Real BF = 100.00 "理想最大正向增益F";
      parameter Real NF = 1.0 "正向电流发射系数F";
      parameter Real NE = 1.5 "B-E泄漏发射系数";
      parameter SI.Current ISE = -1e40 
        "B-E泄漏饱和电流，默认值 = 0";
      constant Real C2 = -1e40 "废弃参数名称，默认值=0";
      parameter SI.Current ISC = -1e40 
        "B-C泄漏饱和电流，默认值=0";
      constant Real C4 = -1e40 "废弃参数名称，默认值=0";
      parameter Real BR = 1.0 "理想最大反向增益";
      parameter Real NR = 1.0 "反向电流发射系数";
      parameter Real NC = 2.0 "B-C 泄漏发射系数";
      parameter SI.Voltage VAF=0.0 "正向早期电压";
      parameter SI.Current IKF=0.0 "正向增益下降拐点电流";
      parameter SI.Voltage VAR=0.0 "反向早期电压";
      parameter SI.Current IKR=0.0 "反向增益下降拐点电流";
      parameter SI.Resistance RE=0.0 "发射极电阻";
      parameter SI.Resistance RC=0.0 "集电极电阻";
      parameter SI.Current IRB=0.0 "基极电阻电流=(rb+rbm)/2";
      parameter SI.Resistance RB=0.0 "零偏置基极电阻";
      parameter SI.Resistance RBM=0.0 "最小基极电阻，默认值=0.0";
      parameter Types.Capacitance CJE=0.0 "零偏置B-E耗尽电容";
      parameter SI.Voltage VJE=0.75 "B-E内建电位";
      parameter Real MJE = 0.33 "B-E结指数因子";
      parameter SI.Time TF=0.0 "理想正向过渡时间";
      parameter Real XTF = 0.0 "TF偏置依赖系数";
      parameter SI.Current ITF=0.0 "TF的高电流依赖性";
      parameter SI.Voltage VTF=0.0 "给定VBC依赖性的电压";
      parameter SI.Frequency PTF=0.0 "在 freq=1/(TF*2*Pi)Hz时的超额相位";
      parameter Types.Capacitance CJC=0.0 "零偏置B-C耗尽电容";
      parameter SI.Voltage VJC=0.75 "B-C内建电位";
      parameter Real MJC = 0.33 "B-C结分级系数";
      parameter Real XCJC = 1.0 "B-C电容占内部基极的比例";
      parameter SI.Time TR=0.0 "理想反向过渡时间";
      parameter Types.Capacitance CJS=0.0 "零偏置C-S电容";
      parameter SI.Voltage VJS=0.75 "基底结内建电位";
      parameter Real MJS = 0.0 "基底结分级系数";
      parameter Real XTB = 0.0 "正向和反向增益温度指数";
      parameter SI.GapEnergy EG=1.11 
        "IS温度效应对IS的能隙";
      parameter Real XTI = 3.0 "IS的温度指数";
      parameter Real KF = 0.0 "闪烁噪声系数";
      parameter Real AF = 1.0 "闪烁噪声指数";
      parameter Real FC = 0.5 "正向偏置结拟合参数";

      annotation (Documentation(info="<html>
<p>BJT模型的模型卡参数，包括PNP和NPN</p>
<p>库“Internal”不供用户访问。其中存储了该库的半导体模型建模所需的所有函数、记录和数据。</p>
</html>"      ));
    end ModelcardBJT2;

  model JFET "结型场效应晶体管"

    Modelica.Electrical.Analog.Interfaces.PositivePin G "栅极节点" annotation (Placement(transformation(
              extent={{-110,-12},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin D "漏极节点" annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin S "源极节点" annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));

    parameter Integer mtype( start = 0) 
        "JFET类型: 0-N通道, 1-P通道";
    parameter Real AREA( start = 1) 
        "并联连接的相同元件数量";
    parameter Boolean OFF = false 
        "可选的初始条件: 0-未使用IC, 1-使用IC，但尚未实现";
    parameter SI.Voltage IC_VDS = -1e40 
        "初始条件值(VDS，尚未实现）";
    parameter SI.Voltage IC_VGS = -1e40 
        "初始条件值(VGS，尚未实现）";
    parameter Boolean UIC = false 
        "使用初始条件: true表示使用初始条件";
    parameter Modelica.Units.NonSI.Temperature_degC TEMP=27 "设备的工作温度";

    parameter Modelica.Electrical.Spice3.Internal.ModelcardJFET modelcard 
        "JFET模型卡" annotation(Evaluate=true);
    final parameter Modelica.Electrical.Spice3.Internal.Jfet.JfetModelLine p= 
          Modelica.Electrical.Spice3.Internal.Jfet.jfetRenameParameters(modelcard) 
        "模型行参数" annotation(Evaluate=true);
    final parameter Modelica.Electrical.Spice3.Internal.Fet.Fet m= 
          Modelica.Electrical.Spice3.Internal.Fet.fetRenameParametersDev(
            AREA, 
            OFF, 
            IC_VDS, 
            IC_VGS, 
            UIC, 
            TEMP) "重命名的参数" annotation(Evaluate=true);

    final parameter Integer m_type = if (mtype > 0.5) then -1 else 1 
        "晶体管类型";
    //    enum fet_type{NFET=1, PFET=-1};

    final parameter Modelica.Electrical.Spice3.Internal.Jfet.JfetModelLine p1= 
          Modelica.Electrical.Spice3.Internal.Jfet.jfetInitEquations(m, p) 
        "预计算参数";
    final parameter Modelica.Electrical.Spice3.Internal.Jfet.JfetModelLine p2= 
          Modelica.Electrical.Spice3.Internal.Jfet.jfetModelLineInitEquations(p1) 
        "模型行变量";
    final parameter Modelica.Electrical.Spice3.Internal.Fet.Fet m1= 
          Modelica.Electrical.Spice3.Internal.Jfet.jfetCalcTempDependencies(m, p2) 
        "预计算参数";
    Modelica.Electrical.Spice3.Internal.Fet.CurrrentsCapacitances cc;
    parameter Modelica.Electrical.Spice3.Internal.Fet.CurrrentsCapacitances cc_ = Modelica.Electrical.Spice3.Internal.Jfet.jfetNoBypassCode(
    m1, 
    p2, 
    m_type, 
    m_bInit, 
    {0, 0, 0})annotation (Evaluate = true);

    constant Boolean m_bInit = false;

    SI.Voltage Dinternal;  //内部漏极节点
    SI.Voltage Sinternal;  //内部源极节点
    SI.Voltage vGD;
    SI.Voltage  vGS;
    SI.Current ird;
    SI.Current irs;
    SI.Current igdgmin;
    SI.Current igsgmin;

    SI.Current icGS;
    SI.Current icGD;

  equation
      cc = Modelica.Electrical.Spice3.Internal.Jfet.jfetNoBypassCode(
          m1, 
          p2, 
          m_type, 
          m_bInit, 
          {G.v,Dinternal,Sinternal});

    // 电压
    // --------
    vGD = G.v - Dinternal;
    vGS = G.v - Sinternal;

    // 漏极和源极电阻
    // ----------------------------
    ird * p2.m_drainResist = (D.v - Dinternal);
    irs * p2.m_sourceResist = (S.v - Sinternal);

    // 电容
    // ------------
    //icGD = cc.cGD * der(vGD);
    //icGS = cc.cGS * der(vGS);
    if cc_.iGD <= 0 then
        icGD = 0;
    else
        icGD = cc.cGD * der(vGD);
    end if;
    if cc_.iGS <= 0 then
        icGS = 0;
    else
        icGS = cc.cGS * der(vGS);
    end if;

    // 电流
    // --------
      igsgmin = Modelica.Electrical.Spice3.Internal.SpiceConstants.CKTgmin*(G.v - 
        Sinternal);
      igdgmin = Modelica.Electrical.Spice3.Internal.SpiceConstants.CKTgmin*(G.v - 
        Dinternal);
    G.i = icGD + icGS + cc.iGD + igdgmin + cc.iGS + igsgmin;
    D.i = ird;
    S.i = irs;

    // 内部节点的电流总和
    //------------------------
    0    = -ird + cc.idrain - cc.iGD - igdgmin - icGD;
    0    = -irs - cc.idrain - cc.iGS - igsgmin - icGS;

    annotation (Documentation(info="<html>
<p>JFET模型，包括N型和P型通道</p>
<p>库“Internal”不供用户访问。其中存储了该库的半导体模型建模所需的所有函数、记录和数据。</p>
</html>"      , revisions="<html>
<ul>
<li><em>2008年3月</em>由Kristin Majetta<br>创建</li>
</ul>
</html>"      ), 
        Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,92},{0,40},{-12,40},{-12,-40},{0,-40},{0,-94}}, 
                color={0,0,255}), 
            Line(points={{-92,0},{-20,0}}, color={0,0,255}), 
            Line(points={{-20,40},{-20,-40}}, color={0,0,255}), 
            Text(
              extent={{8,-34},{96,-54}}, 
              textColor={0,0,255}, 
              textString="%name")}));
  end JFET;

    record ModelcardJFET "记录技术参数(.model)"
    extends Modelica.Icons.Record;
      parameter Types.Capacitance CGS=-1e40 
        "零偏置G-S结电容，默认为0";
      parameter Types.Capacitance CGD=-1e40 
        "零偏置G-D结电容，默认为0";
      parameter SI.Current IS=1e-14 "PN结的饱和电流";
      parameter Real FC=0.5 
        "正向偏置耗尽电容公式的系数";
      parameter SI.Resistance RD=-1e40 "漏极欧姆电阻，默认为0";
      parameter SI.Resistance RS=-1e40 "源极欧姆电阻，默认为0";
      parameter Modelica.Units.NonSI.Temperature_degC TNOM=27 "参数测量温度";
      parameter SI.Voltage VTO=-1e40 "零偏置阈值电压，默认为-2";
      parameter SI.InversePotential B=-1e40 
        "掺杂剂变化参数，默认为1";
      parameter Real BETA=-1e40 "输出导纳参数，默认为1e-4";
      parameter SI.InversePotential LAMBDA=0 
        "通道长度调制，默认为0";
      parameter SI.Voltage PB=1.0 "PN结的结电位";
      parameter Real AF=1.0 "闪烁噪声指数";
      parameter Real KF=0 "闪烁噪声系数";

     annotation (Documentation(info="<html>
<p>JFET模型的模型卡参数，包括N型和P型通道</p>
<p>库“Internal”不供用户访问。其中存储了该库的半导体模型建模所需的所有函数、记录和数据。</p>
</html>"      ));
    end ModelcardJFET;

   model DIODE "二极管模型"

     extends Modelica.Electrical.Analog.Interfaces.TwoPin;

     function diodeNoBypassCode_
        input Diode.DiodeModelLineParams in_p;
        input Diode.DiodeParams in_dp;
        input Diode.DiodeCalc in_c;
        input Model.Model in_m;
        input Boolean in_m_mbInit;

        output SI.Capacitance m_dCap;
       annotation();
     algorithm
        (, m_dCap) := Diode.diodeNoBypassCode(
         in_p, 
         in_dp, 
         in_c, 
         in_m, 
         in_m_mbInit, 
         {0, 0});
     end diodeNoBypassCode_;

     parameter Real AREA = 1 "面积因子";
     parameter Boolean OFF = false 
        "可选的初始条件：false - 未使用IC，true - 使用IC，尚未实现";
     parameter SI.Voltage IC( start = -1e40) 
        "初始条件值（VD，尚未实现";
     parameter Modelica.Units.NonSI.Temperature_degC TEMP = 27 "器件的工作温度";
     parameter Boolean SENS_AREA( start = false) 
        "请求WRT区域的灵敏度的标志，尚未实现";

     parameter ModelcardDIODE modelcarddiode "DIODE模型卡" annotation(Evaluate=true);
     constant SpiceConstants C "SPICE模拟器的常规常数";
     final parameter Diode.DiodeModelLineParams param= 
          Diode.diodeRenameParameters(modelcarddiode, C) 
        "模型线参数";
     final parameter Diode.DiodeParams dp=Diode.diodeRenameParametersDev(
             TEMP, 
             AREA, 
             IC, 
             OFF, 
             SENS_AREA) "重命名的参数" 
                      annotation(Evaluate=true);
     final parameter Model.Model m=Diode.diodeRenameParametersDevTemp(TEMP) 
        "重命名的参数" 
                 annotation(Evaluate=true);
     final parameter Diode.DiodeVariables c1=Diode.diodeInitEquations(param) 
        "预计算的值";
     final parameter Diode.DiodeCalc c2=Diode.diodeCalcTempDependencies(
             param, 
             dp, 
             m, 
             c1) "预计算的值";
     constant Boolean m_mbInit = false;

     Diode.CurrentsCapacitances cc;
     Real icap;
     Real m_dCap;
     Real pin;
     Real ir;
     Real igmin;
     parameter Real m_dCap_ = diodeNoBypassCode_(param, 
        dp, 
        c2, 
        m, 
        m_mbInit);

   equation
      (cc,m_dCap) = Diode.diodeNoBypassCode(
           param, 
           dp, 
           c2, 
           m, 
           m_mbInit, 
           {pin,n.v});

     //电容器的电流
     //icap = if (m_mbInit) then 0.0 else m_dCap*(der(pin)-der(n.v));
     if m_dCap_ <= 0 then
        icap = 0;
     else
        icap = if (m_mbInit) then 0.0 else m_dCap * (der(pin) - der(n.v));
     end if;
     //电阻
       ir*param.m_resist = (p.v - pin);

     //gmin
      igmin = SpiceConstants.CKTgmin*(pin - n.v);

     p.i =  ir;
     n.i =  -(cc.m_dCurrent +igmin) -icap;

   //内部节点的电流总和
     0 =  -ir + cc.m_dCurrent + igmin +icap;

     annotation (
       Icon(graphics={
            Line(points={{90,0},{-90,0}}, color={0,0,255}), 
           Polygon(
             points={{30,0},{-30,40},{-30,-40},{30,0}}, 
             lineColor={0,0,255}, 
             fillColor={255,255,255}, 
             fillPattern=FillPattern.Solid), 
           Line(points={{-90,0},{40,0}}, color={0,0,255}), 
           Line(points={{40,0},{90,0}}, color={0,0,255}), 
           Line(points={{30,40},{30,-40}}, color={0,0,255}), 
           Text(
             extent={{-154,100},{146,60}}, 
             textString="%name", 
             textColor={0,0,255})}), 
       Documentation(info="<html>
<p>二极管模型</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"     , revisions="<html>
<ul>
<li><em>Nov. 2008</em> by Kristin Majetta <br>initially implemented</li>
</ul>
</html>"     ));
   end DIODE;

   record ModelcardDIODE "具有技术参数的记录(.model)"
     extends Modelica.Icons.Record;
    parameter SI.Current IS=1e-14 "饱和电流";
    parameter SI.Resistance RS=0.0 "欧姆电阻";
    parameter Real N=1.0 "发射系数";
    parameter SI.Time TT=0.0 "过渡时间";
    parameter Types.Capacitance CJO=0.0 "结电容";
    parameter SI.Voltage VJ=1.0 "结电位";
    parameter Real M=0.5 "分级系数";
    parameter SI.ActivationEnergy EG=1.11 "激活能";
    parameter Real XTI=3.0 "饱和电流温度指数";
    parameter Real FC=0.5 "正向偏置结拟合参数";
    parameter SI.Voltage BV=-1e40 "反向击穿电压，默认为无穷大";
    parameter SI.Current IBV=1e-3 "反向击穿电流";
    parameter Modelica.Units.NonSI.Temperature_degC TNOM=27 "参数测量温度";
    parameter Real KF=0.0 "闪烁噪声系数";
    parameter Real AF=1.0 "闪烁噪声指数";
    parameter SI.Conductance G=0 "欧姆导纳";
     annotation (Documentation(info="<html>
<p>DIODE模型的模型卡参数</p>
<p>库Repository不对用户开放。那里存储了Semiconductors库的半导体模型所需的所有函数、记录和数据。</p>
</html>"     ));
   end ModelcardDIODE;

    model R_SEMI "半导体电阻器"

      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Resistance R= -1e40 
        "电阻，如果指定，几何信息将被覆盖";
      parameter Modelica.Units.NonSI.Temperature_degC TEMP = -1e40 "电阻的温度";
      parameter SI.Length L = -1e40 "电阻的长度";
      parameter SI.Length W = -1e40 
        "电阻的宽度，默认为 DEFW(模型卡)";
      parameter Boolean SENS_AREA= false 
        "用于灵敏度分析的参数，尚未实现";
      parameter ModelcardR modelcard "电阻模型卡";
      constant SpiceConstants C "SPICE模拟器的常数";
      final parameter Rsemiconductor.ResistorModelLineParams lp= 
          Rsemiconductor.resistorRenameParameters(modelcard, C) 
        "模型线参数";
      final parameter Rsemiconductor.ResistorParams rp= 
          Rsemiconductor.resistorRenameParametersDev(
              R, 
              W, 
              L, 
              TEMP, 
              SENS_AREA, 
              C) "重命名参数";

        Rsemiconductor.ResistorVariables vp;

    algorithm
      vp := Rsemiconductor.resistorInitEquations(rp, lp);

      (vp.m_dConduct,vp.m_dCond_dTemp) := 
        Modelica.Electrical.Spice3.Internal.Functions.resDepTemp(
            vp.m_dResist, 
            rp.m_dTemp, 
            lp.m_dTnom, 
            lp.m_dTC1, 
            lp.m_dTC2);

     i :=vp.m_dConduct*v;

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,28},{70,-32}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Line(
              points={{-70,0},{-90,0}}, 
              color={0,0,255}), 
            Line(
              points={{70,0},{90,0}}, 
              color={0,0,255}), 
            Text(
              extent={{-150,64},{150,24}}, 
              textString="%name", 
              textColor={0,0,255})}),Documentation(revisions="<html>
<dl>
<dt><em>2009年4月</em></dt>
<dd>Kristin Majetta创建</dd>
</dl>
</html>"          , info="<html>
<p>半导体电阻模型</p>
<p>库Repository不对用户开放。那里存储了Semiconductors库的半导体模型所需的所有函数、记录和数据。</p>
</html>"          ));
    end R_SEMI;

    record ModelcardR "记录技术参数(.model)"
      extends Modelica.Icons.Record;
      parameter SI.LinearTemperatureCoefficientResistance TC1 = 0.0 
        "一阶温度系数";
      parameter SI.QuadraticTemperatureCoefficientResistance TC2 = 0.0 
        "二阶温度系数";
      parameter SI.Resistance RSH = -1e40 "片上电阻";
      parameter Modelica.Units.NonSI.Temperature_degC TNOM = -1e40 
        "参数测量温度，默认为27";
      parameter SI.Length DEFW = 1e-5 "默认器件宽度";
      parameter SI.Length NARROW = 0 "由于侧蚀而导致的电阻缩窄";
      annotation (Documentation(info="<html>
<p>半导体电阻模型的模型卡参数</p>
<p>库Repository不对用户开放。那里存储了Semiconductors库的半导体模型所需的所有函数、记录和数据。</p>
</html>"          ));
    end ModelcardR;

    model C_SEMI "半导体电容器(.model)"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Types.Capacitance C = -1e40 
        "电容，如果指定了，几何信息将被覆盖";
      parameter Modelica.Units.NonSI.Temperature_degC TEMP = 27 "电容器的温度";
      parameter SI.Length  L(start = 0) "电容器的长度";
      parameter SI.Length  W = -1e40 
        "电容器的宽度，默认为DEFW（模型卡）";
      parameter Boolean SENS_AREA = false 
        "用于灵敏度分析的参数，尚未实现";
      parameter SI.Voltage IC = 0 "初始值" annotation(Dialog(enable=UIC));
      parameter Boolean UIC = false 
        "使用初始条件：如果使用了初始条件，则为true";
      parameter Modelica.Electrical.Spice3.Internal.ModelcardC modelcard 
        "电容器模型卡";
      final parameter
        Modelica.Electrical.Spice3.Internal.Csemiconductor.CapacitorModelLineParams lp= 
          Modelica.Electrical.Spice3.Internal.Csemiconductor.capacitorRenameParameters(
           modelcard) "模型线参数";
      final parameter
        Modelica.Electrical.Spice3.Internal.Csemiconductor.Capacitor               cp= 
          Modelica.Electrical.Spice3.Internal.Csemiconductor.capacitorRenameParametersDev(
              C, 
              W, 
              L, 
              TEMP, 
              SENS_AREA, 
              lp) "重命名参数";

      Modelica.Electrical.Spice3.Internal.Csemiconductor.Capacitor vp;

    protected
      SI.Voltage vinternal;

    initial equation
      if UIC then
        vinternal = IC;
      else
        der(vinternal) = 0;
      end if;

    algorithm
      if (cp.m_dCapIsGiven < 0.5) then
        assert( L > 0, "电容器的长度必须大于零");
      end if;

      vp := Modelica.Electrical.Spice3.Internal.Csemiconductor.capacitorInitEquations(
         cp, lp);

      vinternal := p.v - n.v;
      i         := vp.m_dCapac*der(vinternal);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={
            Line(
              points={{-14,28},{-14,-28}}, 
              color={0,0,255}, 
              thickness=0.5), 
            Line(
              points={{14,28},{14,-28}}, 
              color={0,0,255}, 
              thickness=0.5), 
            Line(points={{-90,0},{-14,0}}, color={0,0,255}), 
            Line(points={{14,0},{90,0}}, color={0,0,255}), 
            Text(
              extent={{-130,-40},{134,-60}}, 
              textString="C=%C"), 
            Text(extent={{-138,42},{136,62}}, textString="%name")}), 
                                     Documentation(revisions="<html>
<ul>
<li><em>2009年4月</em>，Kristin Majetta
<br>创建</li>
</ul>
</html>"          , info="<html>
<p>半导体电容器模型</p>
<p><br>库Repository不对用户开放。那里存储了Semiconductors库的半导体模型所需的所有函数、记录和数据。</p>
</html>"          ));
    end C_SEMI;

    record ModelcardC "技术参数记录"
      extends Modelica.Icons.Record;
      parameter SI.CapacitancePerArea CJ = 0.0 
        "结底电容F/米2";
      parameter SI.Permittivity CJSW = 0.0 
        "结侧电容F/米";
      parameter SI.Length  DEFW=1e-5 "默认器件宽度";
      parameter SI.Length  NARROW=0 "由侧蚀造成的变窄";
      annotation (Documentation(info="<html>
<p>半导体电容模型的模型卡参数</p>
<p>库Repository不对用户开放。那里存储了Semiconductors库的半导体模型所需的所有函数、记录和数据。</p>
</html>"      ));
    end ModelcardC;

     record SpiceConstants "SPICE模拟器的常用常数"
       extends Modelica.Icons.Record;
       constant Real EPSSIL =     (11.7 * 8.854214871e-12);
       constant Real EPSOX =      3.453133e-11;
       constant SI.Charge CHARGE =     (1.6021918e-19);
       constant SI.Temperature CONSTCtoK =  (273.15);
       constant SI.HeatCapacity CONSTboltz = (1.3806226e-23); // J/K
       constant SI.Temperature REFTEMP =    300.15;  /* 27 deg C */

       constant Real CONSTroot2 =  sqrt(2.0);
       constant Real CONSTvt0(   final unit= "(J)/(A.s)") = Modelica.Constants.k * Modelica.Units.Conversions.from_degC(27)  / CHARGE; // deg C
       constant Real CONSTKoverQ(  final unit= "(J/K)/(A.s)")= Modelica.Constants.k / CHARGE;
       constant Real CONSTe =      exp(1.0);

       // 选项

       constant SI.Conductance CKTgmin =         1e-12;
       constant SI.Temperature CKTnomTemp =      300.15;
       constant SI.Temperature CKTtemp =         300.15;
       constant SI.Area CKTdefaultMosAD = 0.0;
       constant SI.Area CKTdefaultMosAS = 0.0;
       constant SI.Length CKTdefaultMosL =  100e-6;
       constant SI.Length CKTdefaultMosW =  100e-6;
       constant Real CKTreltol =       1e-10;
       constant Real CKTabstol =       1e-15;
       constant Real CKTvolttol =      1e-10;
       constant Real CKTtemptol =      1e-3;
      annotation (Documentation(info="<html>
<p>SPICE使用的通用常数</p>
<p>Internal库不是用户访问的。那里存储了Semiconductors库的半导体模型所需的所有函数、记录和数据。</p>
</html>"       ));
     end SpiceConstants;

    record MaterialParameters"材料参数"
    extends Modelica.Icons.Record;
      // 硅的能隙
      constant SI.GapEnergy EnergyGapSi = 1.16;
      // 硅的第一带隙校正因子
      constant Types.GapEnergyPerTemperature FirstBandCorrFactorSi = 7.02e-4;
      // 硅的第二带隙校正因子
      constant SI.Temperature SecondBandCorrFactorSi = 1108;
      // T = 300K时的带隙校正因子
      constant SI.GapEnergy BandCorrFactorT300 = 1.1150877;
      // 内禀导电载流子密度
      constant Types.PerVolume IntCondCarrDensity = 1.45e16;
     annotation (Documentation(info="<html>
<p>Material参数的定义</p>
<p>Repository库不是用户访问的。所有用于Semiconductors库的半导体模型所需的函数、记录和数据都存储在那里。</p>
</html>"          ));
    end MaterialParameters;

  package Functions "半导体计算函数"
    extends Modelica.Icons.InternalPackage;


      function junctionPotDepTemp 
        "结节电势的温度依赖性"
        extends Modelica.Icons.Function;

        input SI.Voltage phi0;
        input SI.Temperature temp "设备温度";
        input SI.Temperature tnom "标称温度";

        output SI.Voltage ret "输出电压";

      protected
        SI.GapEnergy phibtemp;
        SI.GapEnergy phibtnom;
        SI.Voltage vt;
        constant SI.GapEnergy unitGapEnergy = 1;
        constant SI.Voltage unitVoltage = 1;

      algorithm
        phibtemp := 
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(temp);
        phibtnom := 
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(tnom);
        vt := Spice3.Internal.SpiceConstants.CONSTKoverQ* 
          temp;
        ret := (phi0 - phibtnom*(unitVoltage/unitGapEnergy)) * temp / tnom + phibtemp*(unitVoltage/unitGapEnergy) + vt * 3 * Modelica.Math.log( tnom / temp);

        annotation (Documentation(info="<html>
<p>这个内部函数基于实际和标称温度计算了温度相关的结节电势。</p>
</html>"          ));
      end junctionPotDepTemp;

      function saturationCurDepTempSPICE3MOSFET 
        "饱和电流的温度依赖性"
      extends Modelica.Icons.Function;
        input SI.Current satcur0 "饱和电流";
        input SI.Temperature temp "设备温度";
        input SI.Temperature tnom "标称温度";

        output Real ret "输出电流"; //单位为电流

      protected
        SI.Voltage vt;
        SI.Voltage vtnom;
        SI.GapEnergy energygaptnom;
        SI.GapEnergy energygaptemp;
        constant SI.GapEnergy unitGapEnergy = 1;
        constant SI.Voltage unitVoltage = 1;

      algorithm
        vt := Spice3.Internal.SpiceConstants.CONSTKoverQ* 
          temp;
        vtnom := Spice3.Internal.SpiceConstants.CONSTKoverQ* 
          tnom;
        energygaptnom := 
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(tnom);
        energygaptemp := 
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(temp);
        ret           := satcur0 * exp( energygaptnom*(unitVoltage/unitGapEnergy) / vtnom - energygaptemp*(unitVoltage/unitGapEnergy) / vt);

        annotation (Documentation(info="<html>
<p>这个内部函数基于实际和标称温度计算了温度相关的饱和电流。</p>
</html>"          ));
      end saturationCurDepTempSPICE3MOSFET;

      function junctionVCrit "电压限制"
      extends Modelica.Icons.Function;
        input SI.Temperature temp "温度";
        input Real ncoeff "系数";
        input SI.Current satcur "饱和电流";

        output Real ret "输出值";

      protected
        SI.Voltage vte;

      algorithm
        vte := Spice3.Internal.SpiceConstants.CONSTKoverQ* 
          temp*ncoeff;
        ret := vte * Modelica.Math.log( vte / (sqrt(2) * satcur));
        ret := if ( ret > 1e10) then  1e10 else ret;

        annotation (Documentation(info="<html>
<p>这个内部函数限制了结电压。如果它增加到1e10，它将保持在该值上。</p>
</html>"          ));
      end junctionVCrit;

      function junctionParamDepTempSPICE3 
        "结温度依赖的结参数"
      extends Modelica.Icons.Function;
        input SI.Voltage phi0 "开路电势";
        input Real cap0 "初始电容";
        input Real mcoeff "m系数";
        input SI.Temperature temp "器件温度";
        input SI.Temperature tnom "标称温度";

        output SI.Voltage junctionpot "结电势";
        output Real junctioncap "结电容";

      protected
        SI.GapEnergy phibtemp;
        SI.GapEnergy phibtnom;
        SI.Voltage vt;
        SI.Voltage vtnom;
        Real arg;
        Real fact2;
        Real pbfact;
        Real arg1;
        Real fact1;
        Real pbfact1;
        Real pbo;
        Real gmaold;
        Real gmanew;

      algorithm
        phibtemp := 
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(temp);
        phibtnom := 
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(tnom);
        vt          := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp;
        vtnom       := Spice3.Internal.SpiceConstants.CONSTKoverQ * tnom;
        arg         := -phibtemp/(2*Modelica.Constants.k*temp) + 
                       1.1150877/(Modelica.Constants.k*(2*Spice3.Internal.SpiceConstants.REFTEMP));
        fact2       := temp/Spice3.Internal.SpiceConstants.REFTEMP;
        pbfact      := -2*vt*(1.5*Modelica.Math.log(fact2)+Spice3.Internal.SpiceConstants.CHARGE*arg);
        arg1        := -phibtnom/(Modelica.Constants.k*2*tnom) + 
                       1.1150877/(2*Modelica.Constants.k*Spice3.Internal.SpiceConstants.REFTEMP);
        fact1       := tnom/Spice3.Internal.SpiceConstants.REFTEMP;
        pbfact1     := -2 * vtnom*(1.5*Modelica.Math.log(fact1)+Spice3.Internal.SpiceConstants.CHARGE*arg1);
        pbo         := (phi0-pbfact1)/fact1;
        junctionpot := pbfact+fact2*pbo;
        gmaold      := (phi0 -pbo)/pbo;
        gmanew      := (junctionpot-pbo)/pbo;
        junctioncap := cap0 / 
                       (1+mcoeff* (400e-6*(tnom-Spice3.Internal.SpiceConstants.REFTEMP)-gmaold))  * 
                       (1+mcoeff* (400e-6*(temp-Spice3.Internal.SpiceConstants.REFTEMP)-gmanew));

        annotation (Documentation(info="<html>
<p>这个内部函数基于实际和标称温度计算几个温度依赖的结参数。</p>
</html>"          ));
      end junctionParamDepTempSPICE3;

      function junctionCapCoeffs "系数计算"
      extends Modelica.Icons.Function;
        input Real mj "mj";
        input Real fc "fc";
        input SI.Voltage phij "phij";

        output SI.Voltage f1 "f1";
        output Real f2 "f2";
        output Real f3 "f3";

      protected
        Real xfc;

      algorithm
        xfc := Modelica.Math.log(1 - fc);
        f1  := phij * (1 - exp((1 - mj) * xfc)) / (1 - mj);
        f2  := exp((1 + mj) * xfc);
        f3  := 1 - fc * (1 + mj);

        annotation (Documentation(info="<html>
<p>这个内部辅助函数计算一些系数，这些系数对于计算结电容是必要的。</p>
</html>"          ));
      end junctionCapCoeffs;

    function junction2SPICE3MOSFETRevised 
        "结电流和导纳计算"
    extends Modelica.Icons.Function;
      input SI.Voltage voltage "输入电压";
      input SI.Temperature temp "器件温度";
      input Real ncoeff;
      input SI.Current satcur "饱和电流";

      output SI.Current out_current "计算电流";
      output SI.Conductance out_cond "计算导纳";

      protected
      SI.Voltage vte;
      Real max_exponent;
      Real evbd;
      Real evd;
      constant Real max_exp = 50.;
      constant SI.Current max_current = 1e4;

    algorithm
      if (satcur > 1e-101) then
        vte := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp * ncoeff;

        max_exponent := Modelica.Math.log(max_current / satcur);
        max_exponent := min(max_exp, max_exponent);

        if (voltage <= 0) then
          out_cond := satcur / vte;
          out_current := out_cond * voltage;
          out_cond := out_cond + Spice3.Internal.SpiceConstants.CKTgmin;
        elseif (voltage >= max_exponent * vte) then
          evd := exp(max_exponent);
          out_cond := satcur * evd / vte;
          out_current := satcur * (evd - 1) + out_cond * (voltage - max_exponent * vte);

        else
          evbd := exp(voltage / vte);
          out_cond := satcur * evbd / vte + Spice3.Internal.SpiceConstants.CKTgmin;
          out_current := satcur * (evbd - 1);
        end if;
      else
        out_current := 0.;
        out_cond := 0.;
      end if;

      annotation (Documentation(info="<html>
<p>这个内部函数根据给定的电压计算结电流和结导纳。</p>
</html>"        ));
    end junction2SPICE3MOSFETRevised;

    function junctionCapRevised "结压缩电容"
      extends Modelica.Icons.Function;
    input Types.Capacitance capin "输入电容";
    input SI.Voltage voltage "输入电压";
    input SI.Voltage depcap;
    input Real mj;
    input Real phij;
    input SI.Voltage f1;
    input Real f2;
    input Real f3;

    output Types.Capacitance capout "输出电容";
    output SI.Charge charge "输出电荷";

    protected
    Real arg;
    Real sarg;
    Real czof2;

    algorithm
      if (voltage < depcap) then
        arg  := 1 - (voltage / phij);
        if (mj == 0.5) then
          sarg := 1 / sqrt(arg);
        else
          sarg := exp(-1 * mj * Modelica.Math.log(arg));
        end if;
        capout := capin * sarg;
        charge := phij * (capin * (1 - arg * sarg) / (1 - mj));
      else
        czof2  := capin / f2;
        capout := czof2 * (f3 + mj * voltage / phij);
        charge := capin * f1 + czof2 * 
                  (f3 * (voltage - depcap) + (mj / (2 * phij)) * (voltage ^ 2 - depcap ^ 2));
      end if;

    annotation (Documentation(info="<html>
<p>这个内部函数计算了给定电压下的电荷和结压缩电容。</p>
</html>"        ));
    end junctionCapRevised;

    function saturationCurDepTempSPICE3 "饱和电流的温度依赖性"
      extends Modelica.Icons.Function;
    input SI.Current satcur0 "饱和电流";
    input SI.Temperature temp "器件温度";
    input SI.Temperature tnom "标称温度";
    input Real emissioncoeff;
    input Real energygap;
    input Real satcurexp;

    output SI.Current ret "输出值";

    protected
    SI.Voltage vt;
    SI.Voltage vte;

    algorithm
      vt := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp;
      vte := emissioncoeff * vt;
      ret := satcur0 * exp(((temp / tnom) - 1) * energygap / vte 
             + satcurexp / emissioncoeff * Modelica.Math.log(temp / tnom));

    annotation (Documentation(info="<html>
<p>这个内部函数基于实际温度和标称温度计算温度依赖的饱和电流。</p>
</html>"            ));
    end saturationCurDepTempSPICE3;

    function junctionVoltage23SPICE3 "PN结电压"
      extends Modelica.Icons.Function;
    input SI.Voltage vb;
    input SI.Current ivb;
    input SI.Current satcur "饱和电流";
    input SI.Temperature temp "器件温度";
    input Real ncoeff;

    output SI.Voltage v23 "输出值";

    protected
    SI.Voltage vt;
    SI.Current cbv;
    Real tol;
    Integer iter;

    algorithm
      vt := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp;
      v23 := vb;
      cbv := ivb;

      if (cbv < satcur * vb / vt) then
        cbv := satcur * vb / vt;
      else
        tol := Spice3.Internal.SpiceConstants.CKTreltol * cbv;
        v23 := vb - vt * Modelica.Math.log(1 + cbv / satcur);
        for iter in 0:24 loop
          v23 := vb - vt * Modelica.Math.log(cbv / satcur + 1 - v23 / vt);
          if (abs(satcur * (exp((vb - v23) / vt) - 1 + v23 / vt) - cbv) <= tol) then

          end if;
        end for;
      end if;

    annotation (Documentation(info="<html>
<p>这个内部函数基于实际温度、电压和饱和电流计算PN结电压。</p>
</html>"            ));
    end junctionVoltage23SPICE3;

    function junction3 "PN结电流和导纳计算"
      extends Modelica.Icons.Function;
    input SI.Voltage voltage "输入电压";
    input SI.Temperature temp "器件温度";
    input Real ncoeff;
    input SI.Current satcur "饱和电流";
    input SI.Voltage v23;

    output SI.Current current "输出电流";
    output SI.Conductance cond "输出导纳";

    protected
    constant Real max_exp = 50.0;
    constant SI.Current max_current = 1.0e4;
    SI.Voltage vte;
    Real max_exponent;
    Real evd;
    Real arg;
    Real evrev;
    SI.Voltage vr;

    algorithm
      if (satcur > 1.0e-101) then
        vte := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp * ncoeff;
        max_exponent := Modelica.Math.log(max_current / satcur);
        max_exponent := min(max_exp, max_exponent);
        if (voltage >= max_exponent * vte) then
          evd := exp(max_exponent);
          cond := satcur * evd / vte;
          current := satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
        elseif (voltage >= -3 * vte) then
          evd := exp(voltage / vte);
          current := satcur * (evd - 1) + Spice3.Internal.SpiceConstants.CKTgmin * voltage;
          cond := satcur * evd / vte + Spice3.Internal.SpiceConstants.CKTgmin;
        elseif (voltage >= -v23) then
          arg := 3 * vte / (voltage * Spice3.Internal.SpiceConstants.CONSTe);
          arg := arg * arg * arg;
          current := -1. * satcur * (1 + arg) + Spice3.Internal.SpiceConstants.CKTgmin * voltage;
          cond := satcur * 3 * arg / voltage + Spice3.Internal.SpiceConstants.CKTgmin;
        else
          vr := -(v23 + voltage);
          if (vr > max_exponent * vte) then
            evd := exp(max_exponent);
            cond := satcur * evd / vte;
            current := -1. * (satcur * (evd - 1) + cond * (vr - max_exponent * vte));
          else
            evrev := exp(vr / vte);
            current := -1. * satcur * evrev + Spice3.Internal.SpiceConstants.CKTgmin * voltage;
            cond := satcur * evrev / vte + Spice3.Internal.SpiceConstants.CKTgmin;
          end if;
        end if;
      else
        current := 0.0;
        cond := 0.0;
      end if;

    annotation (Documentation(info="<html>
<p>根据给定的电压计算PN结电流和导纳。</p>
</html>"        ));
    end junction3;

    function junctionCapTransTime 
      "PN结电容的传输时间计算"
      extends Modelica.Icons.Function;
    input Types.Capacitance capin "输入电容";
    input SI.Voltage voltage "输入电压";
    input SI.Voltage depcap;
    input Real mj;
    input Real phij;
    input SI.Voltage f1;
    input Real f2;
    input Real f3;
    input SI.Time transittime;
    input SI.Conductance conduct "输入导纳";
    input SI.Current current "输入电流";

    output Types.Capacitance capout "输出电容";
    output SI.Charge charge "输出电荷";

    algorithm
        (capout,charge) := junctionCapRevised(
              capin, 
              voltage, 
              depcap, 
              mj, 
              phij, 
              f1, 
              f2, 
              f3);
      capout := capout + transittime * conduct;
      charge := charge + transittime * current;

      annotation (Documentation(info="<html>
<p>根据传输时间计算电容和电荷。</p>
</html>"        ));
    end junctionCapTransTime;

    function junction2 "PN结的电流和导纳计算"
      extends Modelica.Icons.Function;
    input SI.Voltage voltage "输入电压";
    input SI.Temperature temp "设备温度";
    input Real ncoeff;
    input SI.Current satcur "饱和电流";

    output SI.Current current "输出电流";
    output SI.Conductance cond "输出导纳";

    protected
    constant Real max_exp = 50.0;
    constant Real max_current = 1.0e4;
    SI.Voltage vte;
    Real max_exponent;
    Real evd;
    Real arg;

    algorithm
    if (satcur > 1.0e-101) then
        vte := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp * ncoeff;
      max_exponent := Modelica.Math.log(max_current / satcur);
      max_exponent := min(max_exp, max_exponent);
      if (voltage >= max_exponent * vte) then
        evd := exp(max_exponent);
        cond := satcur * evd / vte;
        current := satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
      elseif (voltage >= -5 * vte) then
        evd := exp(voltage / vte);
        current := satcur * (evd - 1) + Spice3.Internal.SpiceConstants.CKTgmin * voltage;
        cond := satcur * evd / vte + Spice3.Internal.SpiceConstants.CKTgmin;
      else
        arg := 3 * vte / (voltage * Spice3.Internal.SpiceConstants.CONSTe);
        arg := arg * arg * arg;
        current := -1 * satcur * (1 + arg) + Spice3.Internal.SpiceConstants.CKTgmin * voltage;
        cond := satcur * 3 * arg / voltage + Spice3.Internal.SpiceConstants.CKTgmin;
      end if;
    else
      current := 0.0;
      cond := 0.0;
    end if;

    annotation (Documentation(info="<html>
<p>根据给定的电压计算PN结的电流和导纳。</p>
</html>"        ));
    end junction2;

    function resDepTemp "温度相关的导纳"
      extends Modelica.Icons.Function;
    input SI.Resistance resist "输入电阻";
    input SI.Temperature temp "设备温度";
    input SI.Temperature tnom "名义温度";
    input Real tc1;
    input Real tc2;

    output SI.Conductance conduct "输出导纳";
    output Real dCond_dTemp "输出值";

    protected
    Real difference;
    Real factor;

    algorithm
    difference := temp - tnom;
    factor := 1.0 + tc1 * difference + tc2 * difference * difference;
    conduct := 1.0 / (resist * factor);
    dCond_dTemp := (tc1 + 2 * tc2 * difference) * conduct * conduct;

    annotation (Documentation(info="<html>
<p>这个内部函数根据温度计算导纳。</p>
</html>"        ));
    end resDepTemp;

    function resDepGeom "电阻与宽度和狭窄相关"
    extends Modelica.Icons.Function;
    input Real rsh "输入片上电阻";
    input SI.Length width "输入晶体管宽度";
    input SI.Length length "输入晶体管长度";
    input SI.Length narrow "输入狭窄";

    output Real out "输出值";

    algorithm
      out := rsh * (length - narrow) / (width - narrow);

      annotation (Documentation(info="<html>
<p>这个内部函数根据几何值(宽度、狭窄)和电阻率计算电阻。</p>
</html>"        ));
    end resDepGeom;

    function saturationCurDepTempSPICE3JFET 
      "饱和电流的温度依赖性"
      extends Modelica.Icons.Function;
    input SI.Current satcur0 "饱和电流";
    input SI.Temperature temp "设备温度";
    input SI.Temperature tnom "名义温度";

    output SI.Current ret "输出值";

    protected
    SI.Voltage vt;
      annotation();

    algorithm
    vt := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp;
    ret := satcur0 * exp((temp / tnom - 1) * 1.11 / vt);
    end saturationCurDepTempSPICE3JFET;

    function capDepGeom "电容与宽度和狭窄相关"
      extends Modelica.Icons.Function;
    input SI.CapacitancePerArea cap0 "结底电容";
    input SI.Permittivity capsw0 "结侧壁电容";
    input SI.Length width "输入电容器宽度";
    input SI.Length length "输入电容器长度";
    input SI.Length narrow "输入狭窄";

    output Types.Capacitance out "输出值";
      annotation();

    algorithm
      out := cap0 * (width - narrow) * (length - narrow) 
             + capsw0 * 2 * ((length - narrow) + (width - narrow));
    end capDepGeom;

    function energyGapDepTemp "能隙的温度依赖性"
      extends Modelica.Icons.Function;
    input SI.Temperature temp "温度";
    output SI.GapEnergy ret "输出能隙能量";

    algorithm
    ret := Spice3.Internal.MaterialParameters.EnergyGapSi - (
      Spice3.Internal.MaterialParameters.FirstBandCorrFactorSi 
      *temp*temp)/(temp + Spice3.Internal.MaterialParameters.SecondBandCorrFactorSi);

    annotation (Documentation(info="<html>
<p>根据实际温度和作为函数输入的两个系数计算温度相关的能隙。</p>
</html>"        ));
    end energyGapDepTemp;

    function junction2SPICE3BJT "结PNP二极管的电流和导纳计算"
      extends Modelica.Icons.Function;
      input SI.Voltage voltage "输入电压";
      input SI.Temperature temp "设备温度";
      input Real ncoeff1;
      input Real ncoeff2;
      input SI.Current satcur1 "饱和电流";
      input SI.Current satcur2 "饱和电流";

      output SI.Current current1 "输出电流";
      output SI.Conductance cond1 "输出导纳";
      output SI.Current current2 "输出电流";
      output SI.Conductance cond2 "输出导纳";

      protected
      SI.Voltage vte;
      SI.Voltage vtn;
      Real evd;
      annotation();

    algorithm
        vtn := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp * ncoeff1;
        vte := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp * ncoeff2;
      if (voltage > -5 * vtn) then
        evd     := exp(voltage / vtn);
        current1 := satcur1 * (evd - 1) + Spice3.Internal.SpiceConstants.CKTgmin * voltage;
        cond1 := satcur1 * evd / vtn + Spice3.Internal.SpiceConstants.CKTgmin;
        if (satcur2 == 0) then
          current2 := 0;
          cond2    := 0;
        else
          evd      := exp(voltage / vte);
          current2 := satcur2 * (evd - 1);
          cond2    := satcur2 * evd / vte;
        end if;
      else
        cond1 := -satcur1 / voltage + Spice3.Internal.SpiceConstants.CKTgmin;
        current1 := cond1 * voltage;
        cond2    := -satcur2 / voltage;
        current2 := -satcur2;
      end if;
    end junction2SPICE3BJT;

    function energyGapDepTemp_old "能隙的温度依赖性"
      extends Modelica.Icons.Function;
      input SI.Temperature temp "温度";
      output SI.Voltage ret "输出电压";

      protected
       SI.Voltage gap0 = 1.16;
       Real coeff1(final unit = "V/K") = 7.02e-4;
       SI.Temperature coeff2 = 1108.0;

    algorithm
      ret := gap0 - (coeff1 * temp * temp) / (temp + coeff2);

      annotation (Documentation(info="<html>
<p>根据实际温度和作为函数输入的两个系数计算温度相关的能隙。</p>
</html>"        ));
    end energyGapDepTemp_old;
      annotation (Documentation(info="<html>
<p>Equation库包含了建模半导体模型所需的函数。其中一些函数被多个半导体模型使用。</p>
</html>"    ));
  end Functions;

    package SpiceRoot "基本记录和函数"
      extends Modelica.Icons.InternalPackage;

      record SpiceRoot "插入矩阵的数据"
        extends Modelica.Icons.Record;
        SI.Current[6] m_pCurrentValues(start = zeros(6));
        Real[36] m_pResJacobi(start = zeros(36));
        Real[36] m_pCapJacobi(start = zeros(36));

        annotation (Documentation(info="<html>
<p>用于收集插入到类似SPICE矩阵的线性方程组的中间结果。</p>
</html>"            ));
      end SpiceRoot;

      function useInitialConditions "初始条件处理"
        extends Modelica.Icons.Function;
        output Boolean ret;

      algorithm
        ret := false;

        annotation (Documentation(info="<html>
<p>useInitialConditions指定是否使用描述中给定的初始条件。</p>
</html>"            ));
      end useInitialConditions;

      function limitJunctionVoltageRevised "限制结电压"
        extends Modelica.Icons.Function;
        input SI.Voltage voltage "输入电压";

        output SI.Voltage ret;

      algorithm
        ret := voltage;

        annotation (Documentation(info="<html>
<p>用于限制结电压，在当前库版本中被固定为false。</p>
</html>"                  ));
      end limitJunctionVoltageRevised;

      function initJunctionVoltagesRevised 
        "选择结电压处理方式"
        extends Modelica.Icons.Function;
        output Boolean ret;
      algorithm

        ret := false;

        annotation(Documentation(info = "<html>
<p>用于选择结电压处理方式，在当前库版本中被固定为false。</p>
</html>"                  ));
      end initJunctionVoltagesRevised;
      annotation (Documentation(info="<html>
<p>SpiceRoot库包含了在SPICE3中所需的基本记录和函数。</p>

</html>"      ));
    end SpiceRoot;

    package Model "设备温度"
      extends Modelica.Icons.InternalPackage;

    record Model "设备温度"
      extends Modelica.Icons.Record;
      SI.Temperature m_dTemp(start = SpiceConstants.CKTnomTemp) 
          "TEMP，设备温度";
        annotation (Documentation(info="<html>
<p>包含了设备温度，其默认值为27°C。</p>
</html>"          ));
    end Model;

      annotation (Documentation(info="<html>
<p>Model库包含了记录Model，其中包括设备温度。</p>

</html>"      ));

    end Model;

    package Mosfet "MOSFET的函数和记录"
      extends Modelica.Icons.InternalPackage;

      record Mosfet "Mosfet参数记录"
        extends Spice3.Internal.Model.Model;

        SI.Length m_len(start = 1e-4) "L，通道区域长度";
        SI.Length m_width(start = 1e-4) "W，通道区域宽度";
        SI.Area m_drainArea(start= Spice3.Internal.SpiceConstants.CKTdefaultMosAD) 
          "AD，漏极扩散区域";
        SI.Area m_sourceArea(start= Spice3.Internal.SpiceConstants.CKTdefaultMosAS) 
          "AS，源极扩散区域";
        Real m_drainSquares(start = 1.0) "NRD，漏极方面积";
        Real m_sourceSquares(start = 1.0) "NRS，源极方面积";
        SI.Length m_drainPerimeter(start = 0.0) "PD，漏极周长";
        SI.Length m_sourcePerimeter(start = 0.0) "PS，源极周长";
        SI.Voltage m_dICVDS(start = 0.0) "IC_VDS，初始漏源电压";
        Real m_dICVDSIsGiven "IC_VDS，IsGivenValue";
        SI.Voltage m_dICVGS(start = 0.0) "IC_VGS，初始栅源电压";
        Real m_dICVGSIsGiven "IC_VGS，IsGivenValue";
        SI.Voltage m_dICVBS(start = 0.0) "IC_VBS，初始栅垒电压";
        Real m_dICVBSIsGiven "IC_VBS，IsGivenValue";
        Integer m_off(start = 0) "设备初始关闭，非零表示设备关闭进行直流分析";

      //----------------------废弃-----------------------------------
        Integer m_bPMOS(start = 0) "P型MOSFET模型";
        Integer m_nLevel(start = 1) "MOS模型级别";
      //------------------------------------------------------------

        Boolean m_uic;

        annotation (Documentation(info="<html>
<p>包含了在SPICE3中用于所有类型的Mosfet晶体管的参数。</p>
</html>"            ));
      end Mosfet;

      record MosfetModelLineParams "用于Mosfet模型线参数的记录"
        extends Modelica.Icons.Record;
         Real m_jctSatCurDensity(start = 0.0) 
          "JS，漏极饱和电流密度，输入-使用tSatCurDens";
         SI.Resistance m_sheetResistance(start = 0.0) 
          "RSH，片上电阻";
         Real m_bulkJctPotential(start = 0.8) 
          "PB，衬底结势垒，输入-使用tBulkPot";
         SI.LinearTemperatureCoefficient m_bulkJctBotGradingCoeff(start = 0.5) 
          "MJ，底部分级系数";    //单位由maj检查
         SI.LinearTemperatureCoefficient m_bulkJctSideGradingCoeff(start = 0.5) 
          "MJSW，侧向分级系数";    //单位由 maj 检查
         Real m_oxideThickness(start = 1.0e-7) 
          "TOX，氧化层厚度，单位：微米";
       //--------------------------废弃------------------------
         Real m_oxideThicknessIsGiven "TOX，IsGiven 值";
      //-----------------------------------------------------------
         Real m_gateSourceOverlapCapFactor(start= 0.0) 
          "CGS0，栅源重叠电容系数";
         Real m_gateDrainOverlapCapFactor(start= 0.0) 
          "CGD0，栅漏重叠电容系数";
         Real m_gateBulkOverlapCapFactor(start= 0.0) 
          "CGB0，栅垒重叠电容系数";
         Real m_fNcoef(start = 0.0) 
          "KF，闪烁噪声系数";
        Real m_fNexp(start = 1.0) 
          "AF，闪烁噪声指数";
        Real m_mjswIsGiven "MJSW，给定值标志";
        Real m_cgsoIsGiven "CGSO，给定值标志";
        Real m_cgdoIsGiven "CGDO，给定值标志";
        Real m_cgboIsGiven "CGBO，给定值标志";
        Real m_pbIsGiven "PB，给定值标志";


        annotation (Documentation(info="<html>
<p>MosfetModelLineParams包含了在SPICE3中用于所有类型的Mosfet晶体管的模型线参数。</p>
</html>"            ));
      end MosfetModelLineParams;

      record MosfetModelLine "晶体管类型"
        extends Modelica.Icons.Record;
        Integer m_type(start = 1) "设备类型：1=n，-1=p";

        annotation (Documentation(info="<html>
<p>仅包含一个变量，提供有关晶体管类型(PMOS或NMOS)的信息。</p>
</html>"            ));
      end MosfetModelLine;

      record MosfetCalc "Mosfet变量"
        extends Modelica.Icons.Record;
        SI.Voltage m_vds "Vds，漏源电压";
        SI.Voltage m_vgs "Vgs，栅源电压";
        SI.Voltage m_vbs "Vbs，栅垒电压";
        SI.Current m_cbs "Ibs，B-S结电流";
        SI.Conductance m_gbs "Gbs，源极-衬底导纳";
        SI.Current m_cbd "Ibd，B-D结电流";
        SI.Conductance m_gbd "Gbd，漏极-衬底导纳";
        SI.Current m_cdrain "Ids";
        SI.Conductance m_gds "Gds，漏源导纳";
        SI.Transconductance m_gm "Gm，跨导";
        SI.Transconductance m_gmbs "Gmbs，源极-衬底跨导";
        Types.Capacitance m_capbsb "Cbsb";
        SI.Charge m_chargebsb "Qbsb";
        Types.Capacitance m_capbss "Cbss";
        SI.Charge m_chargebss "Qbss";
        Types.Capacitance m_capbdb "Cbdb";
        SI.Charge m_chargebdb "Qbdb";
        Types.Capacitance m_capbds "Cbds";
        SI.Charge m_chargebds "Qbds";
        Real m_Beta "Beta";
        Types.Capacitance m_capGSovl "Cgso，栅源重叠电容";
        Types.Capacitance m_capGDovl "Cgdo，栅漏重叠电容";
        Types.Capacitance m_capGBovl "Cgbo，栅垒重叠电容";
        Types.Capacitance m_capOx "Cox";
        SI.Voltage m_von "Von，开启电压";
        SI.Voltage m_vdsat "Vdsat";
        Integer m_mode(start = 1) "模式";
        SI.Length m_lEff;
        SI.Resistance m_sourceResistance "Rs";
        SI.Resistance m_drainResistance "Rd";

        annotation (Documentation(info="<html>
<p>MosfetCalc包含了在建模半导体模型中需要的变量。</p>
</html>"            ));
      end MosfetCalc;

      function mosfetInitEquations "MOSFET初始预计算"
        extends Modelica.Icons.Function;
        input Mosfet in_m "输入参数集";

        output Mosfet out_m "改变后的参数集";

      algorithm
        out_m := in_m;

        if (out_m.m_drainSquares == 0) then
          out_m.m_drainSquares  := 1.;
        end if;
        if (out_m.m_sourceSquares == 0) then
          out_m.m_sourceSquares := 1.;
        end if;

        annotation (Documentation(info="<html>
<p>这个函数最初为晶体管的面积预先计算了一些值，这些值可以用于所有晶体管模型。</p>
</html>"            ));
      end mosfetInitEquations;

      function mosfetModelLineInitEquations "类型转录"
        extends Modelica.Icons.Function;
        input Mosfet in_m "输入参数集";

        output MosfetModelLine out_ml "改变后的参数集";

      algorithm
        out_ml.m_type := if (in_m.m_bPMOS > 0.5) then -1 else 1;
        // -1: PMOS ; 1: NMOS

        annotation (Documentation(info="<html>
<p>在这个函数中，在初始化阶段，晶体管类型被转录为另一个参数以供进一步使用。</p>
</html>"            ));
      end mosfetModelLineInitEquations;

      function getNumberOfElectricalPins "引脚数量"
        extends Modelica.Icons.Function;
        output Integer ret "引脚数量";

      algorithm
        ret := 4;
        annotation (Documentation(info="<html>
<p>getNumberOfElectricalPins确定了电气引脚的数量。在当前库版本中，它被固定为4。</p>
</html>"            ));
      end getNumberOfElectricalPins;

      function mosfetRenameParametersDev 
        "设备参数重命名为内部名称"
        extends Modelica.Icons.Function;
        input SI.Length  W "通道宽度";
        input SI.Length  L "通道长度";
        input SI.Area AD "漏极扩散区域";
        input SI.Area AS "源极扩散区域";
        input SI.Length  PD "漏极结周长";
        input SI.Length  PS "源极结周长";
        input Real NRD "漏极扩散区域个数";
        input Real NRS "源极扩散区域个数";
        input Integer OFF 
          "可选的初始条件：0-不使用IC，1-使用 IC，但尚未实现";
        input SI.Voltage IC_VDS 
          "初始条件值VDS，但尚未实现";
        input SI.Voltage IC_VGS 
          "初始条件值VGS，但尚未实现";
        input SI.Voltage IC_VBS 
          "初始条件值VBS，但尚未实现";
        input Boolean UIC "使用初始条件，UIC";
        input Modelica.Units.NonSI.Temperature_degC TEMP "温度";

        output Modelica.Electrical.Spice3.Internal.Mosfet.Mosfet dev 
          "输出记录 Mosfet";

      algorithm
        /*设备参数*/
        dev.m_len             := L "L，通道区域长度";
        dev.m_width           := W "W，通道区域宽度";
        dev.m_drainArea       := AD "AD，漏极扩散区域";
        dev.m_sourceArea      := AS "AS，源极扩散区域";
        dev.m_drainSquares    := NRD "NRD，漏极方面积";
        dev.m_sourceSquares   := NRS "NRS，源极方面积";
        dev.m_drainPerimeter  := PD "PD，漏极周长";
        dev.m_sourcePerimeter := PS "PS，源极周长";

        dev.m_dICVDSIsGiven := if (IC_VDS > -1e40) then 1 else 0 
          "IC_VDS 是否给定值";
        dev.m_dICVDS := if (IC_VDS > -1e40) then IC_VDS else 0 
          "VDS 的初始条件";

        dev.m_dICVGSIsGiven := if (IC_VGS > -1e40) then 1 else 0 
          "IC_VGS 是否给定值";
        dev.m_dICVGS := if (IC_VGS > -1e40) then IC_VGS else 0 
          "VGS 的初始条件";

        dev.m_dICVBSIsGiven := if (IC_VBS > -1e40) then 1 else 0 
          "IC_VBS 是否给定值";
        dev.m_dICVBS := if (IC_VBS > -1e40) then IC_VBS else 0 
          "VBS 的初始条件";

        dev.m_off   := OFF "非零表示设备关闭进行直流分析";
        dev.m_uic   := UIC "使用初始条件";
        dev.m_dTemp := TEMP + Spice3.Internal.SpiceConstants.CONSTCtoK 
          "设备温度";

        annotation (Documentation(info="<html>
<blockquote><pre>
mosfetRenameParametersDev将外部(用户提供的)设备参数分配给内部参数。它还分析IsGiven值(级别1)。
</pre></blockquote>
</html>"            ));
      end mosfetRenameParametersDev;

      annotation (Documentation(info="<html>
<p>Mosfet库包含了所有在SPICE3中用于所有类型MOSFET晶体管的函数和记录。</p>

</html>"      ));
    end Mosfet;

    package Mos "MOSFETs级别1,2,3,6的记录和函数"
      extends Modelica.Icons.InternalPackage;


      record MosModelLineParams 
        "用于MOSFET模型线参数的记录(用于级别1、2、3和6)"
        extends Spice3.Internal.Mosfet.MosfetModelLineParams;

         Real m_oxideCapFactor(      start = 0.0) "氧化物容量系数";
         SI.Voltage m_vt0(                 start = 0.0) 
          "VTO，阈值电压";
         Real m_vtOIsGiven "VTO 是否给定值";
         Types.Capacitance m_capBD(               start = 0.0) 
          "CBD，漏极-漏极结电容";
         Real m_capBDIsGiven "CapBD 是否给定值";
         Types.Capacitance m_capBS(               start = 0.0) 
          "CBS，漏极-源极结电容";
         Real m_capBSIsGiven "CapBS 是否给定值";
         SI.CapacitancePerArea m_bulkCapFactor(       start = 0.0) 
          "CJ，单位面积底部结电容";
         Real m_bulkCapFactorIsGiven "Bulk cap factor 是否给定值";
         SI.Permittivity m_sideWallCapFactor(   start = 0.0) 
          "CJSW，侧壁调制系数";
         Real m_fwdCapDepCoeff(      start = 0.5) 
          "FC，正向偏置结拟合参数";
         SI.Voltage m_phi(                 start = 0.6) 
          "PHI，表面势";
         Real m_phiIsGiven "Phi 是否给定值";
         SI.Voltage m_gamma(               start = 0.0) 
          "GAMMA，阈值参数";
         Real m_gammaIsGiven "Gamma 是否给定值";
         SI.InversePotential m_lambda "沟道长度调制";
         Real m_substrateDoping(start = 0.0) "NSUB，衬底掺杂";
         Real m_substrateDopingIsGiven "Substrate doping 是否给定值";
         Real m_gateType(start = 1.0) "TPG，栅极类型";
         Modelica.Units.NonSI.PerArea_cm 
          m_surfaceStateDensity(start = 0.0) "NSS，表面态密度";
         //-----------------已过时--------------------------------------------
         Real m_surfaceStateDensityIsGiven(start=0) 
          "surfaceStateDensityIsGivenValue";
         //---------------------------------------------------------------------
         Modelica.Units.NonSI.Area_cmPerVoltageSecond 
          m_surfaceMobility( start = 600.0) "UO，表面迁移率";
         SI.Length m_latDiff(             start = 0.0) "LD，横向扩散";
         SI.Current m_jctSatCur(           start = 1.0e-14) 
          "IS，漏极饱和电流";
         SI.Resistance m_drainResistance(     start = 0) 
          "RD，漏极欧姆电阻";
         Real m_drainResistanceIsGiven "漏极电阻 是否给定值";
         SI.Resistance m_sourceResistance(    start = 0) 
          "RS，源极欧姆电阻";
         Real m_sourceResistanceIsGiven "源极电阻 是否给定值";
         SI.Transconductance m_transconductance "输入 - 使用 tTransconductance";
         Real m_transconductanceIsGiven "Transconductance 是否给定值";
         SI.Temperature m_tnom(start=Spice3.Internal.SpiceConstants.CKTnomTemp) 
          "TNOM，参数测量温度";

        annotation (Documentation(info="<html>
<p>MosModelLineParams包含了用于SPICE3中MOSFET晶体管级别1、2、3和6的模型线参数。</p>
</html>"            ));
      end MosModelLineParams;

      record MosModelLineVariables 
        "用于MOSFET模型线变量的记录(用于级别1)"
        extends Modelica.Icons.Record;
        Real m_oxideCapFactor;
        SI.Voltage m_vt0;
        SI.Voltage m_phi;
        Real m_gamma;
        SI.Transconductance m_transconductance;

        annotation (Documentation(info="<html>
<p>MosModelLineVariables包含了用于MOSFET晶体管级别1的SPICE3的模型线变量。</p>
</html>"            ));
      end MosModelLineVariables;

      record MosCalc "进一步的MOSFET变量(用于级别1、2、3和6)"
        extends Spice3.Internal.Mosfet.MosfetCalc;

        SI.Transconductance m_tTransconductance(start=0.);
        Modelica.Units.NonSI.Area_cmPerVoltageSecond m_tSurfMob(start=0.);
        SI.Voltage m_tPhi(start=0.7);
        SI.Voltage m_tVto(start=1.);
        SI.CurrentDensity m_tSatCurDens(start=0.);
        SI.Current m_tDrainSatCur(start=0.);
        SI.Current m_tSourceSatCur(start=0.);
        Types.Capacitance m_tCBDb(start=0.);
        Types.Capacitance m_tCBDs(start=0.);
        Types.Capacitance m_tCBSb(start=0.);
        Types.Capacitance m_tCBSs(start=0.);
        SI.CapacitancePerArea m_tCj(start=0.);
        SI.Permittivity m_tCjsw(start=0.);
        SI.Voltage m_tBulkPot(start=0.7);
        SI.Voltage m_tDepCap(start=0.35);
        SI.Voltage m_tVbi(start=1.);
        SI.Voltage m_VBScrit(start=0.7);
        SI.Voltage m_VBDcrit(start=0.7);
        SI.Voltage m_f1b(start=0.);
        Real m_f2b(start=0.);
        Real m_f3b(start=0.);
        SI.Voltage m_f1s(start=0.);
        Real m_f2s(start=0.);
        Real m_f3s(start=0.);
        SI.Voltage m_dVt(start=0.);

        Types.Capacitance m_capgd(start=0.);
        Types.Capacitance m_capgs(start=0.);
        Types.Capacitance m_capgb(start=0.);
        SI.Charge m_qgs(start=0.);
        SI.Charge m_qgd(start=0.);
        SI.Charge m_qgb(start=0.);

        annotation (Documentation(info="<html>
<blockquote><pre>
MosCalc包含了进一步的MOSFET变量(用于级别1、2、3和6)。
</pre></blockquote>
</html>"            ));
      end MosCalc;

      record DEVqmeyer "Meyer电容和电荷"
        extends Modelica.Icons.Record;
        Types.Capacitance qm_capgb(start = 0);
        Types.Capacitance qm_capgs(start = 0);
        Types.Capacitance qm_capgd(start = 0);
        SI.Charge qm_qgs(start = 0);
        SI.Charge qm_qgb(start = 0);
        SI.Charge qm_qgd(start = 0);
        SI.Voltage qm_vgs(start = 0);
        SI.Voltage qm_vgb(start = 0);
        SI.Voltage qm_vgd(start = 0);

        annotation (Documentation(info="<html>
<p>DEVqmeyer包含了用于计算Meyer电容和电荷的值。</p>
</html>"            ));
      end DEVqmeyer;

      record CurrrentsCapacitances "电流和电容"
        extends Modelica.Icons.Record;
        SI.Current idrain(start = 0);
        SI.Current iBD(start = 0);
        SI.Current iBS(start = 0);
        Types.Capacitance cGS(start = 0);
        Types.Capacitance cGB(start = 0);
        Types.Capacitance cGD(start = 0);
        Types.Capacitance cBS(start = 0);
        Types.Capacitance cBD(start = 0);
        Types.Capacitance m_capgd;

        annotation (Documentation(info="<html>
<p>CurrentsCapacitances包含了MOSFET模型级别1、2、3和6中的电流和电容的值。</p>
</html>"            ));
      end CurrrentsCapacitances;

      function mosCalcInitEquations "MOSFET参数的初始预计算(级别1)"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mos1.Mos1ModelLineParams in_p 
          "用于MOS1的模型线参数输入记录";
        input Spice3.Internal.SpiceConstants in_C 
          "SPICE常数的输入记录";
        input MosModelLineVariables in_vp "模型线变量的输入记录";
        input Spice3.Internal.Mosfet.Mosfet in_m 
          "MOSFET参数的输入记录";

        output Spice3.Internal.Mos1.Mos1Calc out_c 
          "计算出的Mos1记录";

      algorithm
         out_c.m_drainResistance := if 
                                      (in_p.m_drainResistanceIsGiven > 0.5) then 
             in_p.m_drainResistance else 
             in_p.m_sheetResistance * in_m.m_drainSquares;

         out_c.m_sourceResistance := if  (in_p.m_sourceResistanceIsGiven > 0.5) then 
             in_p.m_sourceResistance else 
             in_p.m_sheetResistance * in_m.m_sourceSquares;

        out_c.m_lEff := in_m.m_len - 2 * in_p.m_latDiff;

        if ( abs( out_c.m_lEff) < 1e-18) then
          out_c.m_lEff := 1e-6;
        end if;
        out_c.m_capGSovl := in_p.m_gateSourceOverlapCapFactor * in_m.m_width;
        out_c.m_capGDovl := in_p.m_gateDrainOverlapCapFactor * in_m.m_width;

        out_c.m_capGBovl := in_p.m_gateBulkOverlapCapFactor * out_c.m_lEff;
        out_c.m_capOx    := in_vp.m_oxideCapFactor * out_c.m_lEff * in_m.m_width;

        out_c.m_tTransconductance := 0;
        out_c.m_tSurfMob := 0;
        out_c.m_tPhi := 0.7;
        out_c.m_tVto := 1.;
        out_c.m_tSatCurDens := 0;
        out_c.m_tDrainSatCur := 0;
        out_c.m_tSourceSatCur := 0;
        out_c.m_tCBDb := 0;
        out_c.m_tCBDs := 0;
        out_c.m_tCBSb := 0;
        out_c.m_tCBSs := 0;
        out_c.m_tCj := 0;
        out_c.m_tCjsw := 0;
        out_c.m_tBulkPot := 0.7;
        out_c.m_tDepCap := 0.35;
        out_c.m_tVbi := 1.;
        out_c.m_VBScrit := 0.7;
        out_c.m_VBDcrit := 0.7;
        out_c.m_f1b := 0;
        out_c.m_f2b := 0;
        out_c.m_f3b := 0;
        out_c.m_f1s := 0;
        out_c.m_f2s := 0;
        out_c.m_f3s := 0;
        out_c.m_dVt := 0;

        out_c.m_capgd := 0;
        out_c.m_capgs := 0;
        out_c.m_capgb := 0;
        out_c.m_qgs := 0;
        out_c.m_qgd := 0;
        out_c.m_qgb := 0;

        out_c.m_vds := 0;
        out_c.m_vgs := 0;
        out_c.m_vbs := 0;
        out_c.m_cbs := 0;
        out_c.m_gbs := 0;
        out_c.m_cbd := 0;
        out_c.m_gbd := 0;
        out_c.m_cdrain := 0;
        out_c.m_gds := 0;
        out_c.m_gm := 0;
        out_c.m_gmbs := 0;
        out_c.m_capbsb := 0;
        out_c.m_chargebsb := 0;
        out_c.m_capbss := 0;
        out_c.m_chargebss := 0;
        out_c.m_capbdb := 0;
        out_c.m_chargebdb := 0;
        out_c.m_capbds := 0;
        out_c.m_chargebds := 0;
        out_c.m_Beta := 0;

        out_c.m_von := 0;
        out_c.m_vdsat := 0;
        out_c.m_mode := 1;

        annotation (Documentation(info="<html>
<p>mosCalcInitEquations对MOSFET参数进行初始预计算(一级)。</p>
</html>"                  ));
      end mosCalcInitEquations;

      function mosCalcCalcTempDependencies 
        "与温度相关的预计算"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mos1.Mos1ModelLineParams in_p 
          "输入MOS1模型线参数记录";
        input Spice3.Internal.SpiceConstants in_C 
          "输入SPICE常数记录";
        input MosModelLineVariables in_vp "输入模型线变量记录";
        input Spice3.Internal.Mosfet.Mosfet in_m 
          "输入MOSFET参数记录";
        input Spice3.Internal.Mos1.Mos1Calc in_c "输入Mos1Calc记录";
        input Integer in_m_type "MOS晶体管的类型";

        output Spice3.Internal.Mos1.Mos1Calc out_c 
          "包含计算值的输出记录";

      protected
         Real ratio;
         Real ratio4;
         Real res;

      algorithm
        out_c := in_c;

        ratio                     := in_m.m_dTemp / in_p.m_tnom;
        ratio4                    := ratio * sqrt(ratio);
        out_c.m_tTransconductance := in_vp.m_transconductance / ratio4;
        out_c.m_Beta              := out_c.m_tTransconductance * in_m.m_width / out_c.m_lEff;

        out_c.m_tSurfMob          := in_p.m_surfaceMobility / ratio4;

        out_c.m_tPhi := 
          Spice3.Internal.Functions.junctionPotDepTemp(
                in_vp.m_phi, 
                in_m.m_dTemp, 
                in_p.m_tnom);

        out_c.m_tVbi := in_vp.m_vt0 - in_m_type*(in_vp.m_gamma*sqrt(in_vp.m_phi)) 
           + 0.5*(Spice3.Internal.Functions.energyGapDepTemp_old(
          in_p.m_tnom) - 
          Spice3.Internal.Functions.energyGapDepTemp_old(               in_m.m_dTemp)) 
           + in_m_type*0.5*(out_c.m_tPhi - in_vp.m_phi);
        out_c.m_tVto := out_c.m_tVbi + in_m_type * in_vp.m_gamma * sqrt(out_c.m_tPhi);

        out_c.m_tBulkPot := Spice3.Internal.Functions.junctionPotDepTemp(
                in_p.m_bulkJctPotential, 
                in_m.m_dTemp, 
                in_p.m_tnom);
        out_c.m_tDepCap  := in_p.m_fwdCapDepCoeff * out_c.m_tBulkPot;

       if (in_p.m_jctSatCurDensity == 0.0 or in_m.m_sourceArea == 0.0 or in_m.m_drainArea == 0.0) then
          out_c.m_tDrainSatCur := 
            Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
                  in_p.m_jctSatCur, 
                  in_m.m_dTemp, 
                  in_p.m_tnom);
          out_c.m_tSourceSatCur := out_c.m_tDrainSatCur;
          out_c.m_VBScrit := 
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp, 
                  1.0, 
                  out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := out_c.m_VBScrit;
        else
          out_c.m_tSatCurDens := 
            Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
                  in_p.m_jctSatCurDensity, 
                  in_m.m_dTemp, 
                  in_p.m_tnom);
          out_c.m_tDrainSatCur  := out_c.m_tSatCurDens * in_m.m_drainArea;
          out_c.m_tSourceSatCur := out_c.m_tSatCurDens * in_m.m_sourceArea;
          out_c.m_VBScrit := 
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp, 
                  1.0, 
                  out_c.m_tSourceSatCur);
          out_c.m_VBDcrit := 
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp, 
                  1.0, 
                  out_c.m_tDrainSatCur);
        end if;

        if ( not (in_p.m_capBDIsGiven > 0.5) or not (in_p.m_capBSIsGiven > 0.5)) then
          (res,out_c.m_tCj) := 
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential, 
                  in_p.m_bulkCapFactor, 
                  in_p.m_bulkJctBotGradingCoeff, 
                  in_m.m_dTemp, 
                  in_p.m_tnom);
          (res,out_c.m_tCjsw) := 
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential, 
                  in_p.m_sideWallCapFactor, 
                  in_p.m_bulkJctSideGradingCoeff, 
                  in_m.m_dTemp, 
                  in_p.m_tnom);
          (out_c.m_f1s,out_c.m_f2s,out_c.m_f3s) := 
            Spice3.Internal.Functions.junctionCapCoeffs(
                  in_p.m_bulkJctSideGradingCoeff, 
                  in_p.m_fwdCapDepCoeff, 
                  out_c.m_tBulkPot);
        end if;

        if (in_p.m_capBDIsGiven > 0.5) then
          (res,out_c.m_tCBDb) := 
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential, 
                  in_p.m_capBD, 
                  in_p.m_bulkJctBotGradingCoeff, 
                  in_m.m_dTemp, 
                  in_p.m_tnom);
          out_c.m_tCBDs          := 0.0;
        else
          out_c.m_tCBDb := out_c.m_tCj * in_m.m_drainArea;
          out_c.m_tCBDs := out_c.m_tCjsw * in_m.m_drainPerimeter;
        end if;

        if (in_p.m_capBSIsGiven > 0.5) then
          (res,out_c.m_tCBSb) := 
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential, 
                  in_p.m_capBS, 
                  in_p.m_bulkJctBotGradingCoeff, 
                  in_m.m_dTemp, 
                  in_p.m_tnom);
          out_c.m_tCBSs          := 0.0;
        else
          out_c.m_tCBSb := out_c.m_tCj * in_m.m_sourceArea;
          out_c.m_tCBSs := out_c.m_tCjsw * in_m.m_sourcePerimeter;
        end if;
        (out_c.m_f1b,out_c.m_f2b,out_c.m_f3b) := 
          Spice3.Internal.Functions.junctionCapCoeffs(
                in_p.m_bulkJctBotGradingCoeff, 
                in_p.m_fwdCapDepCoeff, 
                out_c.m_tBulkPot);
        out_c.m_dVt := in_m.m_dTemp*Spice3.Internal.SpiceConstants.CONSTKoverQ;

        annotation (Documentation(info="<html>
<p>mosCalcCalcTempDependencies执行与温度相关的预计算(一级)。</p>
</html>"            ));
      end mosCalcCalcTempDependencies;

      function mosCalcNoBypassCode 
        "电流和电容的计算(级别1)"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mosfet.Mosfet in_m 
          "输入MOSFET参数记录";
        input Integer in_m_type "MOS晶体管的类型";
        input Spice3.Internal.Mos1.Mos1Calc in_c "输入Mos1Calc记录";
        input Spice3.Internal.Mos1.Mos1ModelLineParams in_p 
          "输入MOS1模型线参数记录";
        input Spice3.Internal.SpiceConstants in_C 
          "输入SPICE常数记录";
        input MosModelLineVariables in_vp "输入模型线变量记录";
        input Boolean in_m_bInit;
        input SI.Voltage[4] in_m_pVoltageValues;  /* 栅 漏 源 基 */

        output CurrrentsCapacitances out_cc;

      protected
        SI.Voltage vbd;
        SI.Voltage vgd;
        SI.Voltage vgb;
        SI.Current cur;
        Integer n;
        DEVqmeyer qm;
        Spice3.Internal.Mos1.Mos1Calc int_c;
        Real hlp;

      algorithm
        int_c := in_c;
        out_cc.m_capgd := 0;

        int_c.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[4]);  // ( G , SP)
        int_c.m_vbs := in_m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]);  // ( B , SP)
        int_c.m_vds := in_m_type * (in_m_pVoltageValues[3] - in_m_pVoltageValues[4]);  // ( DP, SP)

        if (Spice3.Internal.SpiceRoot.useInitialConditions()) and (in_m.m_dICVBSIsGiven 
          > 0.5) then
          int_c.m_vbs := in_m_type * in_m.m_dICVBS;
        elseif (
          Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          int_c.m_vbs := if (in_m.m_off > 0.5) then 0. else int_c.m_VBScrit;
        end if;
        if (Spice3.Internal.SpiceRoot.useInitialConditions()) 
          and (in_m.m_dICVDSIsGiven > 0.5) then
          int_c.m_vds := in_m_type * in_m.m_dICVDS;
        elseif (
          Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          int_c.m_vds := if (in_m.m_off > 0.5) then 0. else (int_c.m_VBDcrit - int_c.m_VBScrit);
        end if;
        if (Spice3.Internal.SpiceRoot.useInitialConditions()) 
          and (in_m.m_dICVGSIsGiven > 0.5) then
          int_c.m_vgs := in_m_type * in_m.m_dICVGS;
        elseif (
          Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          if (in_m.m_off > 0.5) then
            int_c.m_vgs := 0.;
          end if;
        end if;

        vbd := int_c.m_vbs - int_c.m_vds;
        vgd := int_c.m_vgs - int_c.m_vds;

        if (int_c.m_vds >= 0) then
          vbd := int_c.m_vbs - int_c.m_vds;
        else
          int_c.m_vbs := vbd + int_c.m_vds;
        end if;

        vgb := int_c.m_vgs - int_c.m_vbs;

        (int_c.m_cbd,int_c.m_gbd) := 
          Spice3.Internal.Functions.junction2SPICE3MOSFETRevised(
          vbd, 
          in_m.m_dTemp, 
          1.0, 
          int_c.m_tDrainSatCur);
        out_cc.iBD := in_m_type * int_c.m_cbd;
        (int_c.m_cbs,int_c.m_gbs) := 
          Spice3.Internal.Functions.junction2SPICE3MOSFETRevised(
          int_c.m_vbs, 
          in_m.m_dTemp, 
          1.0, 
          int_c.m_tSourceSatCur);
        out_cc.iBS := in_m_type * int_c.m_cbs;

        int_c.m_mode := if (int_c.m_vds >= 0) then 1 else -1;  // 1: 正常模式，-1: 反向模式

        if (int_c.m_mode == 1) then

          int_c := Spice3.Internal.Mos1.drainCur(
            int_c.m_vbs, 
            int_c.m_vgs, 
            int_c.m_vds, 
            int_c, 
            in_p, 
            in_C, 
            in_vp, 
            in_m_type);
        else
          int_c := Spice3.Internal.Mos1.drainCur(
            vbd, 
            vgd, 
            -int_c.m_vds, 
            int_c, 
            in_p, 
            in_C, 
            in_vp, 
            in_m_type);
        end if;

        n := if (int_c.m_mode == 1) then 6 else 5;
        out_cc.idrain := in_m_type * int_c.m_cdrain * int_c.m_mode;

        int_c.m_capbss := 0.0;
        int_c.m_chargebss := 0.0;
        int_c.m_capbds := 0.0;
        int_c.m_chargebds := 0.0;
        (int_c.m_capbsb,int_c.m_chargebsb) := 
          Spice3.Internal.Functions.junctionCapRevised(
          int_c.m_tCBSb, 
          int_c.m_vbs, 
          int_c.m_tDepCap, 
          in_p.m_bulkJctBotGradingCoeff, 
          int_c.m_tBulkPot, 
          int_c.m_f1b, 
          int_c.m_f2b, 
          int_c.m_f3b);

        (int_c.m_capbdb,int_c.m_chargebdb) := 
          Spice3.Internal.Functions.junctionCapRevised(
          int_c.m_tCBDb, 
          vbd, 
          int_c.m_tDepCap, 
          in_p.m_bulkJctBotGradingCoeff, 
          int_c.m_tBulkPot, 
          int_c.m_f1b, 
          int_c.m_f2b, 
          int_c.m_f3b);

        if (not (in_p.m_capBSIsGiven > 0.5)) then
          (int_c.m_capbss,int_c.m_chargebss) := 
            Spice3.Internal.Functions.junctionCapRevised(
            int_c.m_tCBSs, 
            int_c.m_vbs, 
            int_c.m_tDepCap, 
            in_p.m_bulkJctSideGradingCoeff, 
            int_c.m_tBulkPot, 
            int_c.m_f1s, 
            int_c.m_f2s, 
            int_c.m_f3s);
        end if;

        if (not (in_p.m_capBDIsGiven > 0.5)) then
          (int_c.m_capbds,int_c.m_chargebds) := 
            Spice3.Internal.Functions.junctionCapRevised(
            int_c.m_tCBDs, 
            vbd, 
            int_c.m_tDepCap, 
            in_p.m_bulkJctSideGradingCoeff, 
            int_c.m_tBulkPot, 
            int_c.m_f1s, 
            int_c.m_f2s, 
            int_c.m_f3s);
        end if;

        out_cc.cBS := if (in_m_bInit) then 1e-15 else (int_c.m_capbsb + int_c.m_capbss);

        out_cc.cBD := if (in_m_bInit) then 1e-15 else (int_c.m_capbdb + int_c.m_capbds);
        if (int_c.m_mode > 0) then
          qm := mosCalcDEVqmeyer(int_c.m_vgs, vgd, vgb, int_c);
        else
          qm := mosCalcDEVqmeyer(vgd, int_c.m_vgs, vgb, int_c);
          hlp := qm.qm_capgd;
          qm.qm_capgd := qm.qm_capgs;
          qm.qm_capgs := hlp;
        end if;

        int_c.m_capgd := 2 * qm.qm_capgd + int_c.m_capGDovl;
        int_c.m_capgs := 2 * qm.qm_capgs + int_c.m_capGSovl;
        int_c.m_capgb := 2 * qm.qm_capgb + int_c.m_capGBovl;

        out_cc.cGB := if (in_m_bInit) then -1e40 else int_c.m_capgb;
        out_cc.cGD := if (in_m_bInit) then -1e40 else int_c.m_capgd;
        out_cc.cGS := if (in_m_bInit) then -1e40 else int_c.m_capgs;

        annotation(Documentation(info = "<html>
<p>这个函数mosCalcNoBypassCode计算所需的电流(以及电容)，以使顶层模型中的电流总和(一级)。</p>
</html>"                  ));
      end mosCalcNoBypassCode;

      function mosCalcDEVqmeyer "Meyer电容的计算"
        extends Modelica.Icons.Function;
        input SI.Voltage vgs;
        input SI.Voltage vgd;
        input SI.Voltage vgb;
        input MosCalc in_c "输入变量集";

        output DEVqmeyer out_qm "Qmeyer值";

      protected
        SI.Voltage vds;
        SI.Voltage vddif;
        SI.Voltage vddif1;
        Types.VoltageSquare vddif2;
        SI.Voltage vgst;

      algorithm
        // 计算栅极-源极电压
        vgst := vgs - in_c.m_von;
        if (vgst <= -in_c.m_tPhi) then
          // 如果栅源电压小于等于-电位垒，则设置Qmeyer值
          out_qm.qm_capgb := in_c.m_capOx / 2.;
          out_qm.qm_capgs := 0.;
          out_qm.qm_capgd := 0.;
        elseif (vgst <= -in_c.m_tPhi / 2.) then
          // 如果栅源电压小于等于-电位垒的一半，则设置Qmeyer值
          out_qm.qm_capgb := -vgst * in_c.m_capOx / (2. * in_c.m_tPhi);
          out_qm.qm_capgs := 0.;
          out_qm.qm_capgd := 0.;
        elseif (vgst <= 0.) then
          // 如果栅源电压小于等于0，则设置Qmeyer值
          out_qm.qm_capgb := -vgst * in_c.m_capOx / (2. * in_c.m_tPhi);
          out_qm.qm_capgs := vgst * in_c.m_capOx / (1.5 * in_c.m_tPhi) + in_c.m_capOx / 3.;
          out_qm.qm_capgd := 0.;
        else
          // 否则，继续计算
          vds := vgs - vgd;
          if (in_c.m_vdsat <= vds) then
            // 如果饱和电压小于等于漏极-源极电压，则设置Qmeyer值
            out_qm.qm_capgs := in_c.m_capOx / 3.;
            out_qm.qm_capgd := 0.;
            out_qm.qm_capgb := 0.;
          else
            // 否则，继续计算
            vddif  := 2.0 * in_c.m_vdsat - vds;
            vddif1 := in_c.m_vdsat - vds;
            vddif2 := vddif * vddif;
            out_qm.qm_capgd := in_c.m_capOx * (1. - in_c.m_vdsat  * in_c.m_vdsat  / vddif2) / 3.;
            out_qm.qm_capgs := in_c.m_capOx * (1. - vddif1 * vddif1 / vddif2) / 3.;
            out_qm.qm_capgb := 0.;
          end if;
        end if;

        // 设置Qmeyer其他值为0
        out_qm.qm_qgs := 0.0;
        out_qm.qm_qgb := 0.0;
        out_qm.qm_qgd := 0.0;
        out_qm.qm_vgs := 0.0;
        out_qm.qm_vgb := 0.0;
        out_qm.qm_vgd := 0.0;

        annotation (Documentation(info="<html>
<p>mosCalcDEVqmeyer计算Meyer模型的电容和电荷。</p>
</html>"            ));
      end mosCalcDEVqmeyer;

      function mos2CalcInitEquationsRevised 
        "MOSFET初始预计算(级别2)"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mos2.Mos2ModelLineParams in_p 
          "输入记录Mos2值";
        input Spice3.Internal.Mosfet.Mosfet in_m 
          "输入记录MOSFET参数";

        output Spice3.Internal.Mos2.Mos2Calc out_c 
          "输出记录Mos2计算的值";

      algorithm
        // 计算漏极电阻
        out_c.m_drainResistance := if  (in_p.m_drainResistanceIsGiven > 0.5) then 
             in_p.m_drainResistance else 
             in_p.m_sheetResistance * in_m.m_drainSquares;

        // 计算源极电阻
        out_c.m_sourceResistance := if  (in_p.m_sourceResistanceIsGiven > 0.5) then 
             in_p.m_sourceResistance else 
             in_p.m_sheetResistance * in_m.m_sourceSquares;

        // 计算有效长度
        out_c.m_lEff := in_m.m_len - 2 * in_p.m_latDiff;

        // 如果有效长度过小，则设为一个较小值
        if ( abs( out_c.m_lEff) < 1e-18) then
          out_c.m_lEff := 1e-6;
        end if;

        // 计算重叠电容
        out_c.m_capGSovl := in_p.m_gateSourceOverlapCapFactor * in_m.m_width;
        out_c.m_capGDovl := in_p.m_gateDrainOverlapCapFactor * in_m.m_width;
        out_c.m_capGBovl := in_p.m_gateBulkOverlapCapFactor * out_c.m_lEff;

        // 计算氧化层电容
        out_c.m_capOx    := in_p.m_oxideCapFactor * out_c.m_lEff * in_m.m_width;

        annotation (Documentation(info="<html>
<p>mos2CalcInitEquationsRevised进行MOSFET参数的初始预计算(二级)。</p>
</html>"                  ));
      end mos2CalcInitEquationsRevised;

      function mos2CalcCalcTempDependenciesRevised 
        "与温度相关的预计算"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mos2.Mos2ModelLineParams in_p 
          "输出记录os1计算的值";
        input Spice3.Internal.Mosfet.Mosfet in_m 
          "输入记录MOSFET参数";
        input Spice3.Internal.Mos2.Mos2Calc in_c "输入记录Mos2Calc";
        input Integer in_m_type "MOS晶体管的类型";

        output Spice3.Internal.Mos2.Mos2Calc out_c 
          "带有计算值的输出记录";

      protected
         Real ratio;
         Real ratio4;
         Real res;

      algorithm
        out_c := in_c;

        // 计算比例
        ratio                     := in_m.m_dTemp / in_p.m_tnom;
        ratio4                    := ratio * sqrt(ratio);
        out_c.m_tTransconductance := in_p.m_transconductance / ratio4;
        out_c.m_Beta              := out_c.m_tTransconductance * in_m.m_width / out_c.m_lEff;

        // 计算表面迁移率
        out_c.m_tSurfMob          := in_p.m_surfaceMobility / ratio4;

        // 计算结势
        out_c.m_tPhi := Spice3.Internal.Functions.junctionPotDepTemp(
          in_p.m_phi, 
          in_m.m_dTemp, 
          in_p.m_tnom);

        // 计算内建电压
        out_c.m_tVbi := in_p.m_vt0 - in_m_type*(in_p.m_gamma*sqrt(in_p.m_phi)) + 0.5*(
          Spice3.Internal.Functions.energyGapDepTemp(in_p.m_tnom) - 
          Spice3.Internal.Functions.energyGapDepTemp(in_m.m_dTemp)) + in_m_type*0.5*(
          out_c.m_tPhi - in_p.m_phi);
        out_c.m_tVto := out_c.m_tVbi + in_m_type * in_p.m_gamma * sqrt(out_c.m_tPhi);

        // 计算体势
        out_c.m_tBulkPot := Spice3.Internal.Functions.junctionPotDepTemp(
          in_p.m_bulkJctPotential, 
          in_m.m_dTemp, 
          in_p.m_tnom);
        out_c.m_tDepCap  := in_p.m_fwdCapDepCoeff * out_c.m_tBulkPot;

        // 如果未给出电容值，则计算电容
        if (in_p.m_jctSatCurDensity == 0.0 or in_m.m_sourceArea == 0.0 or in_m.m_drainArea == 0.0) then
          out_c.m_tDrainSatCur := Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
            in_p.m_jctSatCur, 
            in_m.m_dTemp, 
            in_p.m_tnom);
          out_c.m_tSourceSatCur := out_c.m_tDrainSatCur;
          out_c.m_VBScrit := Spice3.Internal.Functions.junctionVCrit(
            in_m.m_dTemp, 
            1.0, 
            out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := out_c.m_VBScrit;
        else
          out_c.m_tSatCurDens := 
            Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
            in_p.m_jctSatCurDensity, 
            in_m.m_dTemp, 
            in_p.m_tnom);
          out_c.m_tDrainSatCur  := out_c.m_tSatCurDens * in_m.m_drainArea;
          out_c.m_tSourceSatCur := out_c.m_tSatCurDens * in_m.m_sourceArea;
          out_c.m_VBScrit := Spice3.Internal.Functions.junctionVCrit(
            in_m.m_dTemp, 
            1.0, 
            out_c.m_tSourceSatCur);
          out_c.m_VBDcrit := Spice3.Internal.Functions.junctionVCrit(
            in_m.m_dTemp, 
            1.0, 
            out_c.m_tDrainSatCur);
        end if;

        // 如果未给出电容，则计算电容值
        if ( not (in_p.m_capBDIsGiven > 0.5) or not (in_p.m_capBSIsGiven > 0.5)) then
          (res,out_c.m_tCj) := Spice3.Internal.Functions.junctionParamDepTempSPICE3(
            in_p.m_bulkJctPotential, 
            in_p.m_bulkCapFactor, 
            in_p.m_bulkJctBotGradingCoeff, 
            in_m.m_dTemp, 
            in_p.m_tnom);
          (res,out_c.m_tCjsw) := Spice3.Internal.Functions.junctionParamDepTempSPICE3(
            in_p.m_bulkJctPotential, 
            in_p.m_sideWallCapFactor, 
            in_p.m_bulkJctSideGradingCoeff, 
            in_m.m_dTemp, 
            in_p.m_tnom);
          (out_c.m_f1s,out_c.m_f2s,out_c.m_f3s) := 
            Spice3.Internal.Functions.junctionCapCoeffs(
            in_p.m_bulkJctSideGradingCoeff, 
            in_p.m_fwdCapDepCoeff, 
            out_c.m_tBulkPot);
        end if;

        // 如果已给出电容，则直接使用
        if (in_p.m_capBDIsGiven > 0.5) then
          (res,out_c.m_tCBDb) := Spice3.Internal.Functions.junctionParamDepTempSPICE3(
            in_p.m_bulkJctPotential, 
            in_p.m_capBD, 
            in_p.m_bulkJctBotGradingCoeff, 
            in_m.m_dTemp, 
            in_p.m_tnom);
          out_c.m_tCBDs          := 0.0;
        else
          out_c.m_tCBDb := out_c.m_tCj * in_m.m_drainArea;
          out_c.m_tCBDs := out_c.m_tCjsw * in_m.m_drainPerimeter;
        end if;

        // 如果已给出电容，则直接使用
        if (in_p.m_capBSIsGiven > 0.5) then
          (res,out_c.m_tCBSb) := Spice3.Internal.Functions.junctionParamDepTempSPICE3(
            in_p.m_bulkJctPotential, 
            in_p.m_capBS, 
            in_p.m_bulkJctBotGradingCoeff, 
            in_m.m_dTemp, 
            in_p.m_tnom);
          out_c.m_tCBSs          := 0.0;
        else
          out_c.m_tCBSb := out_c.m_tCj * in_m.m_sourceArea;
          out_c.m_tCBSs := out_c.m_tCjsw * in_m.m_sourcePerimeter;
        end if;
        (out_c.m_f1b,out_c.m_f2b,out_c.m_f3b) := 
          Spice3.Internal.Functions.junctionCapCoeffs(
          in_p.m_bulkJctBotGradingCoeff, 
          in_p.m_fwdCapDepCoeff, 
          out_c.m_tBulkPot);
        out_c.m_dVt := in_m.m_dTemp*Spice3.Internal.SpiceConstants.CONSTKoverQ;

        annotation (Documentation(info="<html>
<p>mos2CalcCalcTempDependenciesRevised进行与温度相关的预计算(二级)。</p>
</html>"            ));
      end mos2CalcCalcTempDependenciesRevised;

      function mos2CalcNoBypassCodeRevised 
        "计算电流和电容(级别2)"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mosfet.Mosfet in_m 
          "输入记录MOSFET参数";
        input Integer in_m_type "MOS 晶体管的类型";
        input Spice3.Internal.Mos2.Mos2Calc in_c "输入记录 Mos2Calc";
        input Spice3.Internal.Mos2.Mos2ModelLineParams in_p 
          "输入记录模型线参数";
        input Boolean in_m_bInit;
        input SI.Voltage[4] in_m_pVoltageValues; // 栅、扩散、漏极、源极

        output Modelica.Electrical.Spice3.Internal.Mos.CurrrentsCapacitances out_cc 
          "计算得到的电流和电容";

      protected
        SI.Voltage vbd "漏极-扩散电压";
        SI.Voltage vgd "栅-漏极电压";
        SI.Voltage vgb "栅-扩散电压";
        Modelica.Electrical.Spice3.Internal.Mos.DEVqmeyer qm 
          "Qmeyer电容";
        Spice3.Internal.Mos2.Mos2Calc int_c "记录Mos2Calc";
        Real hlp;

      algorithm
        int_c := in_c;

        int_c.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[4]); // (G, SP)
        int_c.m_vbs := in_m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // (B, SP)
        int_c.m_vds := in_m_type * (in_m_pVoltageValues[3] - in_m_pVoltageValues[4]); // (DP, SP)

        if (in_m.m_uic and in_m.m_dICVBSIsGiven > 0.5) then
          int_c.m_vbs := in_m_type * in_m.m_dICVBS;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          int_c.m_vbs := if (in_m.m_off == 1)  then 0. else int_c.m_VBScrit;
        end if;
        if (in_m.m_uic and in_m.m_dICVDSIsGiven > 0.5) then
          int_c.m_vds := in_m_type * in_m.m_dICVDS;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          int_c.m_vds := if (in_m.m_off == 1)  then 0. else (int_c.m_VBDcrit - int_c.m_VBScrit);
        end if;
        if (in_m.m_uic and in_m.m_dICVGSIsGiven > 0.5) then
          int_c.m_vgs := in_m_type * in_m.m_dICVGS;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          if (in_m.m_off == 1) then
            int_c.m_vgs := 0.;
          end if;
        end if;

        if (int_c.m_vds == 0 and int_c.m_vgs == 0 and int_c.m_vbs == 0 and not (
            in_m.m_uic) and (in_m.m_off == 0)) then
          int_c.m_vbs := -1;
          int_c.m_vgs := in_m_type * int_c.m_tVto;
          int_c.m_vds := 0;
        end if;

        vbd := int_c.m_vbs - int_c.m_vds;
        vgd := int_c.m_vgs - int_c.m_vds;

        if (int_c.m_vds >= 0) then
          int_c.m_vbs := Spice3.Internal.SpiceRoot.limitJunctionVoltageRevised(int_c.m_vbs);
          vbd         := int_c.m_vbs - int_c.m_vds;
        else
          vbd := Spice3.Internal.SpiceRoot.limitJunctionVoltageRevised(vbd);
          int_c.m_vbs := vbd + int_c.m_vds;
        end if;

        vgb := int_c.m_vgs - int_c.m_vbs;

        (int_c.m_cbd,int_c.m_gbd) := Spice3.Internal.Functions.junction2SPICE3MOSFETRevised(
          vbd, 
          in_m.m_dTemp, 
          1.0, 
          int_c.m_tDrainSatCur);
        out_cc.iBD                := in_m_type * int_c.m_cbd;
        (int_c.m_cbs,int_c.m_gbs) := Spice3.Internal.Functions.junction2SPICE3MOSFETRevised(
          int_c.m_vbs, 
          in_m.m_dTemp, 
          1.0, 
          int_c.m_tSourceSatCur);
        out_cc.iBS                := in_m_type * int_c.m_cbs;

        int_c.m_mode := if (int_c.m_vds >= 0) then 1 else -1; // 1: 正常模式,-1: 反向模式

        if (int_c.m_mode == 1) then
          int_c := Spice3.Internal.Mos2.drainCurRevised(
            int_c.m_vbs, 
            int_c.m_vgs, 
            int_c.m_vds, 
            in_m, 
            int_c, 
            in_p, 
            in_m_type);
        else
          int_c := Spice3.Internal.Mos2.drainCurRevised(
            vbd, 
            vgd, 
            -int_c.m_vds, 
            in_m, 
            int_c, 
            in_p, 
            in_m_type);
        end if;
        out_cc.idrain := in_m_type * int_c.m_cdrain * int_c.m_mode;

        int_c.m_capbss    := 0.0;
        int_c.m_chargebss := 0.0;
        int_c.m_capbds    := 0.0;
        int_c.m_chargebds := 0.0;
        (int_c.m_capbsb,int_c.m_chargebsb) := Spice3.Internal.Functions.junctionCapRevised(
          int_c.m_tCBSb, 
          int_c.m_vbs, 
          int_c.m_tDepCap, 
          in_p.m_bulkJctBotGradingCoeff, 
          int_c.m_tBulkPot, 
          int_c.m_f1b, 
          int_c.m_f2b, 
          int_c.m_f3b);

        (int_c.m_capbdb,int_c.m_chargebdb) := Spice3.Internal.Functions.junctionCapRevised(
          int_c.m_tCBDb, 
          vbd, 
          int_c.m_tDepCap, 
          in_p.m_bulkJctBotGradingCoeff, 
          int_c.m_tBulkPot, 
          int_c.m_f1b, 
          int_c.m_f2b, 
          int_c.m_f3b);

        if (not (in_p.m_capBSIsGiven > 0.5)) then
          (int_c.m_capbss,int_c.m_chargebss) := Spice3.Internal.Functions.junctionCapRevised(
            int_c.m_tCBSs, 
            int_c.m_vbs, 
            int_c.m_tDepCap, 
            in_p.m_bulkJctSideGradingCoeff, 
            int_c.m_tBulkPot, 
            int_c.m_f1s, 
            int_c.m_f2s, 
            int_c.m_f3s);
        end if;

        if (not (in_p.m_capBDIsGiven > 0.5)) then
          (int_c.m_capbds,int_c.m_chargebds) := Spice3.Internal.Functions.junctionCapRevised(
            int_c.m_tCBDs, 
            vbd, 
            int_c.m_tDepCap, 
            in_p.m_bulkJctSideGradingCoeff, 
            int_c.m_tBulkPot, 
            int_c.m_f1s, 
            int_c.m_f2s, 
            int_c.m_f3s);
        end if;

        out_cc.cBS := if (in_m_bInit) then 1e-15 else (int_c.m_capbsb + int_c.m_capbss);
        out_cc.cBD := if (in_m_bInit) then 1e-15 else (int_c.m_capbdb + int_c.m_capbds);

        if (int_c.m_mode > 0) then
          qm := Modelica.Electrical.Spice3.Internal.Mos.mosCalcDEVqmeyer(
                  int_c.m_vgs, 
                  vgd, 
                  vgb, 
                  int_c);
        else
          qm := Modelica.Electrical.Spice3.Internal.Mos.mosCalcDEVqmeyer(
                  vgd, 
                  int_c.m_vgs, 
                  vgb, 
                  int_c);
          // Inverser Betrieb -> Drain und Source vertauschen
          // Tausch der Spannungen bei Aufruf von DEVqmeyer
          // Tausch der Kapazitaeten GD und GS
          hlp         := qm.qm_capgd;
          qm.qm_capgd := qm.qm_capgs;
          qm.qm_capgs := hlp;
        end if;

        int_c.m_capgd := 2 * qm.qm_capgd + int_c.m_capGDovl;
        int_c.m_capgs := 2 * qm.qm_capgs + int_c.m_capGSovl;
        int_c.m_capgb := 2 * qm.qm_capgb + int_c.m_capGBovl;

        out_cc.cGB := if (in_m_bInit) then -1e40 else int_c.m_capgb;
        out_cc.cGD := if (in_m_bInit) then -1e40 else int_c.m_capgd;
        out_cc.cGS := if (in_m_bInit) then -1e40 else int_c.m_capgs;

        annotation (Documentation(info="<html>
<p>mos2CalcNoBypassCodeRevised计算所需的电流(和电容)，以便在顶层模型(二级)中对电流进行求和。</p>
</html>"                  ));
      end mos2CalcNoBypassCodeRevised;

      annotation (Documentation(info="<html>
<p>这个Mos包含有关MOSFET模型级别1、2、3和6的函数和记录数据。</p>

</html>"      ));
    end Mos;

    package Mos1 "MOSFET级别1的记录和函数"
      extends Modelica.Icons.InternalPackage;

      record Mos1ModelLineParams 
        "MOSFET模型线参数记录(用于级别1)"
        extends Mos.MosModelLineParams(
         m_lambda( start = 0.0), 
         m_transconductance( start = 2.0e-5));

        annotation (Documentation(info="<html>
<p>Mos1ModelLineParams库包含了用于SPICE3中MOSFET晶体管级别1的模型线参数。</p>
</html>"                ));
      end Mos1ModelLineParams;

      record Mos1Calc "更多MOSFET变量(用于级别1)"
        extends Mos.MosCalc;

        annotation (Documentation(info="<html>
<p>Mos1Calc库包含了计算所需的更多MOSFET变量(用于级别1)。</p>
</html>"                ));
      end Mos1Calc;

      function mos1ModelLineParamsInitEquations "初始预计算"
        extends Modelica.Icons.Function;
        input Mos1ModelLineParams in_p 
          "输入记录MOS1的模型线参数";
        input SpiceConstants in_C "Spice常数";
        input Integer in_m_type "MOS晶体管的类型";

        output Mos.MosModelLineVariables out_v 
          "输出记录模型线变量";

      protected
        SI.Voltage vtnom;
        SI.Voltage fermis;
        Real fermig;
        Real wkfng;
        Real wkfngs;
        Real egfet1;
        Real vfb;

      algorithm
        out_v.m_oxideCapFactor   := in_p.m_oxideCapFactor;
        out_v.m_transconductance := in_p.m_transconductance;
        out_v.m_phi              := in_p.m_phi;
        out_v.m_gamma            := in_p.m_gamma;
        out_v.m_vt0              := in_p.m_vt0;

        vtnom  := in_p.m_tnom*SpiceConstants.CONSTKoverQ;
        egfet1 := 1.16 - (7.02e-4*in_p.m_tnom*in_p.m_tnom)/(in_p.m_tnom + 1108);

        if (not (in_p.m_oxideThicknessIsGiven > 0.5) or in_p.m_oxideThickness == 0) then
          if 
            (in_p.m_oxideThickness == 0) then
            out_v.m_oxideCapFactor := 0;
          end if;
        else
          out_v.m_oxideCapFactor := 3.9 * 8.854214871e-12 / in_p.m_oxideThickness;

          if (out_v.m_oxideCapFactor <> 0) then

            if (not (in_p.m_transconductanceIsGiven > 0.5)) then
              out_v.m_transconductance := in_p.m_surfaceMobility * out_v.m_oxideCapFactor * 1e-4; // (m**2/cm**2)
            end if;
            if (in_p.m_substrateDopingIsGiven > 0.5) then
              if (in_p.m_substrateDoping * 1e6 > 1.45e16) then // (cm**3/m**3)
                if (not (in_p.m_phiIsGiven > 0.5)) then
                  out_v.m_phi := 2*vtnom*Modelica.Math.log(in_p.m_substrateDoping*1e6/1.45e16); // (cm**3/m**3)
                  out_v.m_phi := max(0.1, out_v.m_phi);
                end if;
                fermis := in_m_type *0.5  * out_v.m_phi;
                wkfng  := 3.2;
                if (in_p.m_gateType <> 0) then
                  fermig := in_m_type * in_p.m_gateType *0.5  * egfet1;
                  wkfng  := 3.25 +0.5  * egfet1 - fermig;
                end if;
                wkfngs := wkfng - (3.25 +0.5  * egfet1 + fermis);
                if (not (in_p.m_gammaIsGiven > 0.5)) then
                  out_v.m_gamma := sqrt(2 * 11.70 * 8.854214871e-12 * SpiceConstants.CHARGE * 
                                   in_p.m_substrateDoping * 1e6 / out_v.m_oxideCapFactor);         // (cm**3/m**3)
                end if;
                if (not (in_p.m_vtOIsGiven > 0.5)) then
                  vfb         := wkfngs - in_p.m_surfaceStateDensity * 1e4 * SpiceConstants.CHARGE / out_v.m_oxideCapFactor; // (cm**2/m**2)
                  out_v.m_vt0 := vfb + in_m_type * (out_v.m_gamma * sqrt(out_v.m_phi) + out_v.m_phi);
                 end if;
              end if;
            end if;
          end if;
        end if;

        annotation (Documentation(info="<html>
<p>mos1ModelLineParamsInitEquation对级别1的MOSFET模型线参数进行初始预计算。</p>
</html>"                ));
      end mos1ModelLineParamsInitEquations;

      function drainCur "漏极电流计算"
        extends Modelica.Icons.Function;
        input SI.Voltage vb;
        input SI.Voltage vg;
        input SI.Voltage vds;

        input Mos1Calc in_c "输入记录Mos1Calc";
        input Mos1ModelLineParams in_p 
          "用于MOS1的输入记录模型线参数";
        input SpiceConstants in_C "Spice常数";
        input Mos.MosModelLineVariables in_vp 
          "输入记录模型线变量";
        input Integer in_m_type "MOS晶体管的类型";

        output Mos1Calc out_c "输出记录Mos1Calc";

      protected
        Real arg;
        Real betap;
        Real sarg;
        SI.Voltage vgst;

      algorithm
        out_c := in_c;

         if (vb <= 0) then
            sarg := sqrt( out_c.m_tPhi - vb);
         else
            sarg := sqrt( out_c.m_tPhi);
            sarg := sarg - vb / (sarg + sarg);
            sarg := max( 0., sarg);
         end if;

         out_c.m_von   := (out_c.m_tVbi * in_m_type) + in_vp.m_gamma * sarg;
         vgst          := vg - out_c.m_von;
         out_c.m_vdsat := max( vgst, 0.);
         arg           := if (sarg <= 0) then 0 else in_vp.m_gamma / (sarg + sarg);

         if (vgst <= 0) then
            /* 截止区 */
            out_c.m_cdrain := 0;
            out_c.m_gm     := 0;
            out_c.m_gds    := 0;
            out_c.m_gmbs   := 0;

         else
            betap := out_c.m_Beta*(1 + in_p.m_lambda*vds);

            if (vgst <= vds) then
               /* 饱和区 */
               out_c.m_cdrain := betap * vgst * vgst * 0.5;
               out_c.m_gm     := betap * vgst;
               out_c.m_gds    := in_p.m_lambda * out_c.m_Beta * vgst * vgst * 0.5;
               out_c.m_gmbs   := out_c.m_gm * arg;
            else
               /* 线性区 */
               out_c.m_cdrain := betap * vds * (vgst - 0.5 * vds);
               out_c.m_gm     := betap * vds;
               out_c.m_gds    := betap * (vgst - vds) + in_p.m_lambda * out_c.m_Beta * vds * (vgst - 0.5  * vds);
               out_c.m_gmbs   := out_c.m_gm * arg;
            end if;
         end if;

        annotation (Documentation(info="<html>
<p>drainCur计算从漏极节点到源极节点流动的主要电流(级别1)。</p>
</html>"                ));
      end drainCur;

      function mos1RenameParameters "参数重命名为内部名称"
      extends Modelica.Icons.Function;
        input ModelcardMOS ex "带有技术参数的模型卡";
        input SpiceConstants con "Spice常数";

        output Mos.MosModelLineParams intern 
          "输出记录模型线参数";

      algorithm
        intern.m_cgboIsGiven := 0;
        intern.m_cgdoIsGiven := 0;
        intern.m_cgsoIsGiven := 0;
        intern.m_mjswIsGiven := 0;
      intern.m_pbIsGiven := 0;
        intern.m_surfaceStateDensityIsGiven := 0;

          intern.m_oxideCapFactor := 0;

          intern.m_vtOIsGiven := if          (ex.VTO > -1e40) then 1 else 0;
          intern.m_vt0 := if         (ex.VTO > -1e40) then ex.VTO else 0;

          intern.m_capBDIsGiven := if          (ex.CBD > -1e40) then 1 else 0;
          intern.m_capBD := if         (ex.CBD > -1e40) then ex.CBD else 0;

          intern.m_capBSIsGiven := if          (ex.CBS > -1e40) then 1 else 0;
          intern.m_capBS := if         (ex.CBS > -1e40) then ex.CBS else 0;

            intern.m_bulkCapFactorIsGiven := if          (ex.CJ > -1e40) then 1 else 0;
          intern.m_bulkCapFactor := if         (ex.CJ > -1e40) then ex.CJ else 0;

          intern.m_sideWallCapFactor := ex.CJSW 
          "每米结周长的零偏二极管侧壁电容(默认0)";
          intern.m_fwdCapDepCoeff := ex.FC 
          "正向偏压耗尽电容公式的系数(默认0.5)";

          intern.m_phiIsGiven := if          (ex.PHI > -1e40) then 1 else 0;
          intern.m_phi := if         (ex.PHI > -1e40) then ex.PHI else 0.6;

           intern.m_gammaIsGiven := if          (ex.GAMMA > -1e40) then 1 else 0;
          intern.m_gamma := if         (ex.GAMMA > -1e40) then ex.GAMMA else 0;

          intern.m_lambda := ex.LAMBDA 
          "1/V 通道长度调制 (默认0)";

          intern.m_substrateDopingIsGiven := if          (ex.NSUB > -1e40) then 1 else 0;
          intern.m_substrateDoping := if         (ex.NSUB > -1e40) then ex.NSUB else 0;

          intern.m_gateType := ex.TPG 
          "栅极材料类型：+1相反于衬底，-1与衬底相同，0铝栅 (默认1)";
          intern.m_surfaceStateDensity := ex.NSS 
          "每平方厘米表面态密度 (默认0)";
          intern.m_surfaceMobility := ex.UO 
          "每平方厘米每秒表面迁移率 (默认600)";
          intern.m_latDiff := ex.LD "横向扩散(默认0)";
          intern.m_jctSatCur := ex.IS 
          "体结饱和电流(默认1e-14)";

          intern.m_drainResistanceIsGiven := if 
                                               (ex.RD > -1e40) then 1 else 0;
          intern.m_drainResistance := if 
                                       (ex.RD > -1e40) then ex.RD else 0;

          intern.m_sourceResistanceIsGiven := if 
                                               (ex.RS > -1e40) then 1 else 0;
          intern.m_sourceResistance := if 
                                       (ex.RS > -1e40) then ex.RS else 0;

          intern.m_transconductanceIsGiven := if          (ex.KP > -1e40) then 1 else 0;
          intern.m_transconductance := if         (ex.KP > -1e40) then ex.KP else 2e-5;

          intern.m_tnom := if (ex.TNOM > -1e40) then ex.TNOM + SpiceConstants.CONSTCtoK else 300.15 
          "参数测量温度(默认27摄氏度)";

         intern.m_jctSatCurDensity := ex.JS 
          "每平方米结区域的体结饱和电流(默认0)";
         intern.m_sheetResistance := ex.RSH 
          "欧姆漏极和源极扩散片电阻(默认0)";
         intern.m_bulkJctPotential := ex.PB 
          "V 体结电势(默认0.8)";
         intern.m_bulkJctBotGradingCoeff := ex.MJ 
          "体结底部分级系数(默认0.5)";
         intern.m_bulkJctSideGradingCoeff := ex.MJSW 
          "体结侧壁分级系数(默认0.5)";

         intern.m_oxideThicknessIsGiven := if          (ex.TOX > -1e40) then 1 else 0;
          intern.m_oxideThickness := if         (ex.TOX > -1e40) then ex.TOX else 0;

         intern.m_gateSourceOverlapCapFactor := ex.CGSO 
          "每米通道宽度的栅源重叠电容(默认0)";
         intern.m_gateDrainOverlapCapFactor := ex.CGDO 
          "每米通道宽度的栅漏重叠电容(默认0)";
         intern.m_gateBulkOverlapCapFactor := ex.CGBO 
          "每米通道宽度的栅衬重叠电容(默认0)";
         intern.m_fNcoef := ex.KF "闪烁噪声系数(默认0)";
         intern.m_fNexp := ex.AF "闪烁噪声指数(默认1)";

        annotation (Documentation(info="<html>
<p>mos1RenameParameters将外部(由用户提供，例如RD)技术参数分配给内部参数(例如m_drainResistance)。它还分析了IsGiven值(级别1)。</p>
</html>"                ));
      end mos1RenameParameters;

      function mos1RenameParametersDev 
        "将设备参数重命名为内部名称"
        extends Modelica.Icons.Function;
        input ModelcardMOS ex;
        input Integer mtype;
        input SI.Length W "通道宽度";
        input SI.Length L "通道长度";
        input SI.Area AD "漏极扩散区面积";
        input SI.Area AS "源极扩散区面积";
        input SI.Length PD "漏极结周长";
        input SI.Length PS "源极结周长";
        input Real NRD "漏极扩散区的方块数";
        input Real NRS "源极扩散区的方块数";
        input Integer OFF 
          "可选的初始条件：0-未使用IC，1-使用IC，尚未实现";
        input Real IC "初始条件值，尚未实现";
        input Modelica.Units.NonSI.Temperature_degC TEMP "温度";

        output Mosfet.Mosfet dev "输出记录Mosfet";

      algorithm
      /*设备参数*/
        dev.m_len := L "L，通道区域的长度";
        dev.m_width := W "W，通道区域的宽度";
        dev.m_drainArea := AD "AD，漏极扩散区的面积";
        dev.m_sourceArea := AS "AS，源极扩散区的面积";
        dev.m_drainSquares := NRD "NRD，漏极方块的长度";
        dev.m_sourceSquares := NRS "NRS，源极方块的长度";
        dev.m_drainPerimeter := PD "PD，漏极周长";
        dev.m_sourcePerimeter := PS "PS，源极周长";

          dev.m_dICVDSIsGiven := if          (IC > -1e40) then 1 else 0 
          "ICVDS是否给定值";
          dev.m_dICVDS := if         (IC > -1e40) then IC else 0 
          "VDS的初始条件";

          dev.m_dICVGSIsGiven := if          (IC > -1e40) then 1 else 0 
          "ICVGS是否给定值";
          dev.m_dICVGS := if         (IC > -1e40) then IC else 0 
          "VGS的初始条件";

          dev.m_dICVBSIsGiven := if          (IC > -1e40) then 1 else 0 
          "ICVBS是否给定值";
          dev.m_dICVBS := if         (IC > -1e40) then IC else 0 
          "VBS的初始条件";

        dev.m_off := OFF "非零表示设备在直流分析中关闭";
        dev.m_bPMOS := mtype "P 型 MOSFET 模型";
        dev.m_nLevel := ex.LEVEL "级别";
        assert(ex.LEVEL== 1, "仅实现了 MOS Level1");
        dev.m_dTemp :=TEMP + SpiceConstants.CONSTCtoK "设备温度";

        dev.m_uic := false;

        annotation (Documentation(info="<html>
<p>mos1RenameParametersDev将外部(由用户提供的)设备参数分配给内部参数。它还分析了IsGiven值(级别1)。</p>
</html>"                ));
      end mos1RenameParametersDev;
      annotation (Documentation(info="<html>
<p>Mos1库包含了MOSFET模型级别1的函数和记录以及相关数据。</p>

</html>"          ));
    end Mos1;

    package Mos2 "用于MOSFET级别2的记录和函数"
      extends Modelica.Icons.InternalPackage;


      record Mos2ModelLineParams 
        "用于MOSFET模型线参数的记录(用于级别2)"
        extends Spice3.Internal.Mos.MosModelLineParams(
          m_lambda(start=0.0), 
          m_transconductance(start=2.0e-5), 
          m_bulkJctSideGradingCoeff(start=0.33), 
          m_oxideThickness(start=1.0e-7));

        Real m_narrowFactor( start = 0.0) "DELTA，门限电压的宽度效应";
        Real m_critFieldExp( start = 0.0) "UEXP，迁移率退化的临界场指数";
        Types.ElectricFieldStrength_cm m_critField( start = 1.0e4) 
          "UCRIT，迁移率退化的临界场";
        SI.Velocity m_maxDriftVel( start = 0.0) 
          "VMAX，最大载流子漂移速度";
        SI.Length m_junctionDepth( start = 0.0) "XJ，结深度";
        SI.Charge m_channelCharge( start = 1.0) 
          "NEFF，总通道电荷系数";
        Modelica.Units.NonSI.PerArea_cm m_fastSurfaceStateDensity( start = 0.0) 
          "NFS，快速表面态密度";
        Real m_xd; // 单位 m/V(-0.5) -> m/Wurzel V
        annotation (Documentation(info="<html>
<p>Mos2ModelLineParams包含了用MOSFET晶体管Level2SPICE3的模型线参数。</p>
</html>"                      ));
      end Mos2ModelLineParams;

      record Mos2ModelLineVariables 
        "用于MOSFET模型线变量的记录(用于级别2)"
        extends Spice3.Internal.Mos.MosModelLineVariables;

        Real m_bulkCapFactor;
        Real m_substrateDoping;
        Real m_xd;

        annotation (Documentation(info="<html>
<p>Mos2ModelLineVariables包含了用于MOSFET晶体管Level2SPICE3的模型线变量。</p>
</html>"                      ));
      end Mos2ModelLineVariables;

      record Mos2Calc "更多MOSFET变量(用于级别2)"
        extends Spice3.Internal.Mos.MosCalc;

        annotation (Documentation(info="<html>
<p>Mos2Calc包含了进一步的MOSFET变量(用于Level2), 用于计算。</p>
</html>"                      ));
      end Mos2Calc;

      function mos2ModelLineParamsInitEquationsRevised "初始预计算"
        extends Modelica.Icons.Function;
        input Modelica.Electrical.Spice3.Internal.Mos2.Mos2ModelLineParams in_p 
          "输入用于MOS2的模型线参数记录";
        input Integer in_m_type "MOS晶体管类型";

        output Modelica.Electrical.Spice3.Internal.Mos2.Mos2ModelLineParams out_p 
          "输入用于MOS2的模型线参数记录";

      protected
        SI.Voltage vtnom;
        SI.Voltage fermis;
        Real fermig;
        Real wkfng;
        Real wkfngs;
        Real egfet1;
        Real vfb;

      algorithm
        out_p := in_p;

        vtnom := out_p.m_tnom * Spice3.Internal.SpiceConstants.CONSTKoverQ;
        egfet1 := Spice3.Internal.MaterialParameters.EnergyGapSi - (Modelica.Electrical.Spice3.Internal.MaterialParameters.FirstBandCorrFactorSi 
          * out_p.m_tnom * out_p.m_tnom) / (out_p.m_tnom + Spice3.Internal.MaterialParameters.SecondBandCorrFactorSi);
        out_p.m_oxideCapFactor := Spice3.Internal.SpiceConstants.EPSOX / out_p.m_oxideThickness;

        if (not (out_p.m_transconductanceIsGiven > 0.5)) then
          out_p.m_transconductance := out_p.m_surfaceMobility * 1.0e-4 * out_p.m_oxideCapFactor;
        end if;

        if (out_p.m_substrateDopingIsGiven > 0.5) then
          if (out_p.m_substrateDoping * 1.0e6 > Modelica.Electrical.Spice3.Internal.MaterialParameters.IntCondCarrDensity) then
            if (not (out_p.m_phiIsGiven > 0.5)) then
              out_p.m_phi := 2 * vtnom * Modelica.Math.log(out_p.m_substrateDoping * 1.0e6 
                / Spice3.Internal.MaterialParameters.IntCondCarrDensity);
              out_p.m_phi := max(0.1, out_p.m_phi);
            end if;
            fermis := in_m_type * 0.5 * out_p.m_phi;
            wkfng := 3.2;
            if (out_p.m_gateType <> 0) then
              fermig := in_m_type * out_p.m_gateType * 0.5 * egfet1;
              wkfng := 3.25 + 0.5 * egfet1 - fermig;
            end if;
            wkfngs := wkfng - (3.25 + 0.5 * egfet1 + fermis);
            if (not (out_p.m_gammaIsGiven > 0.5)) then
              out_p.m_gamma := sqrt(2.0 * Spice3.Internal.SpiceConstants.EPSSIL * 
                Spice3.Internal.SpiceConstants.CHARGE * out_p.m_substrateDoping * 1.0e6) 
                / out_p.m_oxideCapFactor;
            end if;
            if (not (out_p.m_vtOIsGiven > 0.5)) then
              vfb := wkfngs - out_p.m_surfaceStateDensity * 1.0e4 * Spice3.Internal.SpiceConstants.CHARGE 
                / out_p.m_oxideCapFactor;
              out_p.m_vt0 := vfb + in_m_type * (out_p.m_gamma * sqrt(out_p.m_phi) + out_p.m_phi);
            else
              vfb := out_p.m_vt0 - in_m_type * (out_p.m_gamma * sqrt(out_p.m_phi) + out_p.m_phi);
            end if;
            out_p.m_xd := sqrt((Spice3.Internal.SpiceConstants.EPSSIL + Spice3.Internal.SpiceConstants.EPSSIL) 
              / (Spice3.Internal.SpiceConstants.CHARGE * out_p.m_substrateDoping * 1.0e6));
          else
            out_p.m_substrateDoping := 0.0;
          end if;
        end if;

        if (not (out_p.m_bulkCapFactorIsGiven > 0.5)) then
          out_p.m_bulkCapFactor := sqrt(Spice3.Internal.SpiceConstants.EPSSIL * 
            Spice3.Internal.SpiceConstants.CHARGE * out_p.m_substrateDoping * 1e6 / (2 
            * out_p.m_bulkJctPotential));
        end if;

        annotation (Documentation(info="<html>
<p>该函数mos2ModelLineParamsInitEquationsRevised对级别2的MOSFET模型线参数进行初始预计算。</p>
</html>"                ));
      end mos2ModelLineParamsInitEquationsRevised;

      function drainCurRevised "漏极电流计算"
        extends Modelica.Icons.Function;
        input SI.Voltage vbs "栅极-源极电压";
        input SI.Voltage vgs "栅极-漏极电压";
        input SI.Voltage vds "漏极-源极电压";

        input Spice3.Internal.Mosfet.Mosfet in_m "MOSFET记录";
        input Modelica.Electrical.Spice3.Internal.Mos2.Mos2Calc in_c 
          "输入记录Mos2Calc";
        input Modelica.Electrical.Spice3.Internal.Mos2.Mos2ModelLineParams in_p 
          "MOS2模型线参数的输入记录";
        input Integer in_m_type "MOS晶体管的类型";

        output Modelica.Electrical.Spice3.Internal.Mos2.Mos2Calc out_c 
          "输出记录Mos2Calc";

      protected
        Real vt;      // K * T / Q
        Real beta1;
        Real dsrgdb;
        Real d2sdb2;
        Real sphi = 0.0;
        Real sphi3 = 1.0;    // square root of phi
        Real barg;
        Real sarg;
        Real bsarg = 0.0;
        Real sarg3;
        Real d2bdb2;
        Real factor;
        Real dbrgdb;
        Real eta;
        Real vbin;
        Real vth;
        Real dgddb2;
        Real dgddvb;
        Real dgdvds;
        Real gamasd;
        Real gammad;
        Real xn =   1.0;
        Real argg = 0.0;
        Real vgst;
        Real vgsx;
        Real dgdvbs;
        Real body;
        Real bodys = 0.0;
        Real gdbdv;
        Real dodvbs;
        Real dodvds = 0.0;
        Real dxndvd = 0.0;
        Real dxndvb = 0.0;
        Real dudvgs;
        Real dudvds;
        Real dudvbs;
        Real ufact;
        Real ueff;
        Real dsdvgs;
        Real dsdvbs;
        Real dbsrdb = 0.0;
        Real gdbdvs = 0.0;
        Real dldvgs;
        Real dldvds;
        Real dldvbs;
        Real clfact;
        Real xleff;
        Real deltal;
        Real xwb;
        Real xld;
        Real xlamda = in_p.m_lambda;
        Real phiMinVbs;
        Real tmp;

        Real argss;
        Real argsd;
        Real args = 0.0;
        Real argd = 0.0;
        Real argxs = 0.0;
        Real argxd = 0.0;
        Real dbargs;
        Real dbargd;
        Real dbxws;
        Real dbxwd;
        Real xwd;
        Real xws;
        Real daddb2;
        Real dasdb2;
        Real ddxwd;
        Real cfs;
        Real cdonco;
        Real argv;
        Real gammd2;
        Real arg;
        Real y3;
        Real xvalid = 0.0;
        Real[4] sig1;
        Real[4] sig2;
        Real[4] a4;
        Real[4] b4;
        Real[8] x4 = fill(0.0, 8);
        Real[8] poly4;
        Real delta4;
        Integer j;
        Integer iknt = 0;
        Integer i;
        Integer jknt = 0;
        Real v1;
        Real v2;
        Real xv;
        Real a1;
        Real b1;
        Real c1;
        Real d1;
        Real b2;
        Real r1;
        Real s1;
        Real s2;
        Real p1;
        Real p0;
        Real p2;
        Real a3;
        Real b3;
        Real sargv;
        Real dldsat;
        Real xlfact;
        Real xdv;
        Real xlv;
        Real vqchan;
        Real dqdsat;
        Real vl;
        Real dfunds;
        Real dfundg;
        Real dfundb;
        Real xls;
        Real dfact;
        Real vdson;
        Real cdson;
        Real gdson;
        Real didvds;
        Real gmw;
        Real gbson;
        Real expg;

      algorithm
        out_c := in_c;

        vt := Spice3.Internal.SpiceConstants.CONSTKoverQ*Spice3.Internal.SpiceConstants.REFTEMP;

        phiMinVbs := out_c.m_tPhi - vbs;
        if ( vbs <= 0.0) then
          sarg   := sqrt( phiMinVbs);
          dsrgdb := -0.5 / sarg;
          d2sdb2 := 0.5 * dsrgdb / phiMinVbs;
        else
          sphi   :=sqrt(out_c.m_tPhi);
          sphi3  :=out_c.m_tPhi*sphi;
          sarg   :=sphi/(1.0 + 0.5*vbs/out_c.m_tPhi);
          tmp    :=sarg/sphi3;
          dsrgdb :=-0.5*sarg*tmp;
          d2sdb2 :=-dsrgdb*tmp;
        end if;

        if ( (vds-vbs) >= 0) then
          barg   := sqrt( phiMinVbs + vds);
          dbrgdb := -0.5 / barg;
          d2bdb2 := 0.5 * dbrgdb / (phiMinVbs + vds);
        else
          barg   := sphi / (1.0 + 0.5 * (vbs - vds) / out_c.m_tPhi);
          tmp    := barg / sphi3;
          dbrgdb := -0.5 * barg * tmp;
          d2bdb2 := -dbrgdb * tmp;
        end if;

        factor := 0.125*in_p.m_narrowFactor*2.0*Modelica.Constants.pi*Spice3.Internal.SpiceConstants.EPSSIL 
          /out_c.m_capOx*out_c.m_lEff;

        eta    := 1.0 + factor;
        vbin   := out_c.m_tVbi * in_m_type + factor * phiMinVbs;
        if ( (in_p.m_gamma > 0.0) or (in_p.m_substrateDoping > 0.0)) then
          xwd := in_p.m_xd * barg;
          xws := in_p.m_xd * sarg;

          argss  := 0.0;
          argsd  := 0.0;
          dbargs := 0.0;
          dbargd := 0.0;
          dgdvds := 0.0;
          dgddb2 := 0.0;
          if ( in_p.m_junctionDepth > 0) then
            tmp   := 2.0 / in_p.m_junctionDepth;
            argxs := 1.0 + xws * tmp;
            argxd := 1.0 + xwd * tmp;
            args  := sqrt( argxs);
            argd  := sqrt( argxd);
            tmp   := 0.5 * in_p.m_junctionDepth / out_c.m_lEff;
            argss := tmp * (args - 1.0);
            argsd := tmp * (argd - 1.0);
          end if;
          gamasd := in_p.m_gamma * (1.0 - argss - argsd);
          dbxwd  := in_p.m_xd * dbrgdb;
          dbxws  := in_p.m_xd * dsrgdb;
          if ( in_p.m_junctionDepth > 0) then
            tmp    := 0.5 / out_c.m_lEff;
            dbargs := tmp * dbxws / args;
            dbargd := tmp * dbxwd / argd;
            dasdb2 := -in_p.m_xd * (d2sdb2 + dsrgdb * dsrgdb * in_p.m_xd 
                      / (in_p.m_junctionDepth * argxs)) / (out_c.m_lEff * args);
            daddb2 := -in_p.m_xd * (d2bdb2 + dbrgdb * dbrgdb * in_p.m_xd 
                      / (in_p.m_junctionDepth * argxd)) 
                      / (out_c.m_lEff * argd);
            dgddb2 := -0.5 * in_p.m_gamma * (dasdb2 + daddb2);
          end if;
          dgddvb := -in_p.m_gamma * (dbargs + dbargd);
          if ( in_p.m_junctionDepth > 0) then
            ddxwd  := -dbxwd;
            dgdvds := -in_p.m_gamma * 0.5 * ddxwd / (out_c.m_lEff * argd);
          end if;
        else
          gamasd := in_p.m_gamma;
          gammad := in_p.m_gamma;
          dgddvb := 0.0;
          dgdvds := 0.0;
          dgddb2 := 0.0;
        end if;

        out_c.m_von   := vbin + gamasd * sarg;
        vth           := out_c.m_von;
        out_c.m_vdsat := 0.0;
        if ( in_p.m_fastSurfaceStateDensity <> 0.0 and out_c.m_capOx <> 0.0) then
          cfs := Spice3.Internal.SpiceConstants.CHARGE*in_p.m_fastSurfaceStateDensity* 
            1.0e4;
          cdonco       := -(gamasd * dsrgdb + dgddvb * sarg) + factor;
          xn           := 1.0 + cfs / out_c.m_capOx * in_m.m_width * out_c.m_lEff + cdonco;
          tmp          := vt * xn;
          out_c.m_von  := out_c.m_von + tmp;
          argg         := 1.0 / tmp;
          vgst         := vgs - out_c.m_von;
        else
          vgst := vgs - out_c.m_von;
          if ( vgs <= out_c.m_von) then
            // cutoff region
            out_c.m_gds    := 0.0;
            out_c.m_cdrain := 0.0;
            out_c.m_gm     := 0.0;
            out_c.m_gmbs   := 0.0;
            return;
          end if;
        end if;

        sarg3  := sarg * sarg * sarg;
        gammad := gamasd;
        dgdvbs := dgddvb;
        body   := barg * barg * barg - sarg3;
        gdbdv  := 2.0 * gammad * (barg * barg * dbrgdb - sarg * sarg * dsrgdb);
        dodvbs := -factor + dgdvbs * sarg + gammad * dsrgdb;

        if ( (in_p.m_fastSurfaceStateDensity <> 0.0) and (out_c.m_capOx <> 0.0)) then
          dxndvb := 2.0 * dgdvbs * dsrgdb + gammad * d2sdb2 + dgddb2 * sarg;
          dodvbs := dodvbs + vt * dxndvb;
          dxndvd := dgdvds * dsrgdb;
          dodvds := dgdvds * sarg + vt * dxndvd;
        end if;

        // evaluate effective mobility and its derivatives
        ufact  := 1.0;
        ueff   := in_p.m_surfaceMobility * 1e-4;
        dudvgs := 0.0;
        dudvds := 0.0;
        dudvbs := 0.0;
        if (out_c.m_capOx > 0.0) then
          tmp := in_p.m_critField*Spice3.Internal.SpiceConstants.EPSSIL*100/in_p.m_oxideCapFactor;
          if (vgst > tmp) then
            ufact  := exp( in_p.m_critFieldExp * Modelica.Math.log( tmp / vgst));
            ueff   := in_p.m_surfaceMobility * 1.0e-4 * ufact;
            dudvgs := -ufact * in_p.m_critFieldExp / vgst;
            dudvds := 0.0;
            dudvbs := in_p.m_critFieldExp * ufact * dodvbs / vgst;
          end if;
        end if;

        // evaluate saturation voltage and its derivatives according to
        // Grove-Frohman equation
        vgsx   := vgs;
        gammad := gamasd / eta;
        dgdvbs := dgddvb;
        if (in_p.m_fastSurfaceStateDensity <> 0 and out_c.m_capOx <> 0) then
          vgsx := max( vgs, out_c.m_von);
        end if;
        if (gammad > 0) then
          gammd2 := gammad * gammad;
          argv   := (vgsx - vbin) / eta + phiMinVbs;
          if (argv <= 0.0) then
            out_c.m_vdsat := 0.0;
            dsdvgs        := 0.0;
            dsdvbs        := 0.0;
          else
            arg           := sqrt( 1.0 + 4.0 * argv / gammd2);
            out_c.m_vdsat := (vgsx - vbin) / eta + gammd2 * (1.0 - arg) / 2.0;
            out_c.m_vdsat := max( out_c.m_vdsat, 0.0);
            dsdvgs        := (1.0 - 1.0 / arg) / eta;
            dsdvbs        := (gammad * (1.0 - arg) + 2.0 * argv / (gammad * arg)) 
                             / eta * dgdvbs + 1.0 / arg + factor * dsdvgs;
          end if;
        else
          out_c.m_vdsat := (vgsx - vbin) / eta;
          out_c.m_vdsat := max( out_c.m_vdsat, 0.0);
          dsdvgs        := 1.0;
          dsdvbs        := 0.0;
        end if;

        if (in_p.m_maxDriftVel > 0) then
          // evaluate saturation voltage and its derivatives
          // according to Baum's theory of scattering velocity saturation
          v1 := (vgsx - vbin) / eta + phiMinVbs;
          v2 := phiMinVbs;
          xv := in_p.m_maxDriftVel * out_c.m_lEff / ueff;
          a1 := gammad / 0.75;
          b1 := -2.0 * (v1 + xv);
          c1 := -2.0 * gammad * xv;
          d1 := 2.0 * v1 * (v2 + xv) - v2 * v2 - 4.0 / 3.0 * gammad * sarg3;
          b2 := a1 * c1 - 4.0 * d1;
          r1 := -b1 * b1 / 3.0 + b2;
          s1 := 2.0 * b1 * b1 * (-b1) / 27.0 + b1 * b2 / 3.0 + (-d1) * (a1 * a1 - 4.0 * b1) - c1 * c1;
          s2 := s1 * s1;
          p1 := s2 / 4.0 + r1 * r1 * r1 / 27.0;
          p0 := abs( p1);
          p2 := sqrt( p0);

          sig1[1] :=  1.0;
          sig1[2] := -1.0;
          sig1[3] :=  1.0;
          sig1[4] := -1.0;
          sig2[1] :=  1.0;
          sig2[2] :=  1.0;
          sig2[3] := -1.0;
          sig2[4] := -1.0;

          if (p1 < 0) then
            y3 := 2.0 * exp( Modelica.Math.log( sqrt( s2 / 4.0 + p0)) / 3.0) 
                  * cos( Modelica.Math.atan( -2.0 * p2 / s1) / 3.0) + b1 / 3.0;
          else
            y3 := exp( Modelica.Math.log( abs( -s1 / 2.0 + p2)) / 3.0) 
                  + exp( Modelica.Math.log( abs( -s1 / 2.0 - p2)) / 3.0) 
                  + b1 / 3.0;
          end if;

          a3 := sqrt( a1 * a1 / 4.0 - b1 + y3);
          b3 := sqrt( y3 * y3 / 4.0 - d1);

          for i in 1:4 loop
            a4[i]  := a1/2.0+sig1[i]*a3;
            b4[i]  := y3/2.0+sig2[i]*b3;
            delta4 := a4[i]*a4[i]/4.0-b4[i];
            if (delta4 >= 0) then
              iknt     := iknt+1;
              tmp      := sqrt(delta4);
              x4[iknt] := -a4[i]/2.0+tmp;
              iknt     := iknt+1;
              x4[iknt] := -a4[i]/2.0-tmp;
            end if;
          end for;
          jknt := 0;
          for j in 1:iknt loop
            if (x4[j] > 0) then
              poly4[j] := x4[j]*x4[j]*x4[j]*x4[j]+a1*x4[j]*x4[j]*x4[j];
              poly4[j] := poly4[j]+b1*x4[j]*x4[j]+c1*x4[j]+d1;
              if (abs(poly4[j]) <= 1.0e-6) then
                jknt := jknt+1;
                if (jknt <= 1) then
                  xvalid := x4[j];
                end if;
                if (x4[j] <= xvalid) then
                  xvalid := x4[j];
                end if;
              end if;
            end if;
          end for;

          if (jknt > 0) then
            out_c.m_vdsat := xvalid * xvalid - phiMinVbs;
          end if;
        end if;

        // evaluate effective channel length and its derivatives
        dldvgs := 0.0;
        dldvds := 0.0;
        dldvbs := 0.0;
        if (vds <> 0.0) then
          gammad :=gamasd;
          if ((vbs - out_c.m_vdsat) <= 0) then
            bsarg  := sqrt(out_c.m_vdsat + phiMinVbs);
            dbsrdb := -0.5 / bsarg;
          else
            bsarg  :=sphi/(1.0 + 0.5*(vbs - out_c.m_vdsat)/out_c.m_tPhi);
            dbsrdb :=-0.5*bsarg*bsarg/sphi3;
          end if;
          bodys  := bsarg * bsarg * bsarg - sarg3;
          gdbdvs := 2.0 * gammad * (bsarg * bsarg * dbsrdb - sarg * sarg * dsrgdb);
          if (in_p.m_maxDriftVel <= 0) then
            if (in_p.m_substrateDoping <> 0.0 and (xlamda <= 0.0)) then
              argv   := (vds - out_c.m_vdsat) / 4.0;
              sargv  := sqrt(1.0 + argv * argv);
              arg    := sqrt(argv + sargv);
              xlfact := in_p.m_xd / (out_c.m_lEff * vds);
              xlamda := xlfact * arg;
              dldsat := vds * xlamda / (8.0 * sargv);

              dldvgs := dldsat * dsdvgs;
              dldvds := -xlamda + dldsat;
              dldvbs := dldsat * dsdvbs;
            end if;
          else
            argv   := (vgsx - vbin) / eta - out_c.m_vdsat;
            xdv    := in_p.m_xd / sqrt(in_p.m_channelCharge);
            xlv    := in_p.m_maxDriftVel * xdv / (2.0 * ueff);
            vqchan := argv - gammad * bsarg;
            dqdsat := -1.0 + gammad * dbsrdb;
            vl     := in_p.m_maxDriftVel *out_c. m_lEff;
            dfunds := vl * dqdsat - ueff * vqchan;
            dfundg := (vl - ueff * out_c.m_vdsat) / eta;
            dfundb := -vl * (1.0 + dqdsat - factor / eta) + ueff * 
               (gdbdvs - dgdvbs * bodys / 1.5) / eta;
            dsdvgs := -dfundg / dfunds;
            dsdvbs := -dfundb / dfunds;
            if ((in_p.m_substrateDoping <> 0.0) and (xlamda <= 0.0)) then
              argv   := vds - out_c.m_vdsat;
              argv   := max(argv,0.0);
              xls    := sqrt(xlv * xlv + argv);
              dldsat := xdv / (2.0 * xls);
              xlfact := xdv / (out_c.m_lEff * vds);
              xlamda := xlfact * (xls - xlv);
              dldsat := dldsat / out_c.m_lEff;

              dldvgs := dldsat * dsdvgs;
              dldvds := -xlamda + dldsat;
              dldvbs := dldsat * dsdvbs;
            end if;
          end if;
        end if;

        // limit channel shortening at punch-through
        xwb    :=in_p.m_xd*sqrt(out_c.m_tBulkPot);
        xld    :=out_c.m_lEff - xwb;
        clfact :=1.0 - xlamda*vds;
        dldvds :=-xlamda - dldvds;
        xleff  :=out_c.m_lEff*clfact;
        deltal :=xlamda*vds*out_c.m_lEff;
        if (in_p.m_substrateDoping == 0.0) then
          xwb := 0.25e-6;
        end if;
        if (xleff < xwb) then
          xleff  := xwb / (1.0 + (deltal - xld) / xwb);
          clfact := xleff / out_c.m_lEff;
          dfact  := xleff * xleff / (xwb * xwb);
          dldvgs := dfact * dldvgs;
          dldvds := dfact * dldvds;
          dldvbs := dfact * dldvbs;
        end if;

        // evaluate effective beta (effective kp)
        beta1 := out_c.m_Beta * ufact / clfact;

        // test for mode of operation and branch appropriately
        gammad := gamasd;
        dgdvbs := dgddvb;
        if (vds <= 1.0e-10) then
          if (vgs <= out_c.m_von) then
            if ((in_p.m_fastSurfaceStateDensity == 0.0) or (out_c.m_capOx == 0.0)) then
              out_c.m_gds := 0.0;
            else
              out_c.m_gds := beta1 * (out_c.m_von - vbin - gammad * sarg) * exp(argg * (vgs - out_c.m_von));
            end if;
          else
            out_c.m_gds :=beta1*(vgs - vbin - gammad*sarg);
          end if;
          out_c.m_cdrain :=0.0;
          out_c.m_gm     :=0.0;
          out_c.m_gmbs   :=0.0;
          return;
        end if;

        if (vgs <= out_c.m_von) then
          // subthreshold region
          if (out_c.m_vdsat <= 0) then
            out_c.m_gds    := 0.0;
            if (vgs > vth) then
              return;
            end if;
            out_c.m_cdrain := 0.0;
            out_c.m_gm     := 0.0;
            out_c.m_gmbs   := 0.0;
            return;
          end if;
          vdson := min(out_c.m_vdsat, vds);
          if (vds > out_c.m_vdsat) then
            barg   := bsarg;
            dbrgdb := dbsrdb;
            body   := bodys;
            gdbdv  := gdbdvs;
          end if;
          cdson  := beta1 * ((out_c.m_von - vbin - eta * vdson * 0.5) * vdson - gammad * body / 1.5);
          didvds := beta1 * (out_c.m_von - vbin - eta * vdson - gammad * barg);
          gdson  := -cdson * dldvds / clfact - beta1 * dgdvds * body / 1.5;
          if (vds < out_c.m_vdsat) then
            gdson := gdson + didvds;
          end if;
          gbson := -cdson * dldvbs / clfact + beta1 * 
                   (dodvbs * vdson + factor * vdson - dgdvbs * body / 1.5 - gdbdv);
          if (vds > out_c.m_vdsat) then
            gbson := gbson + didvds * dsdvbs;
          end if;
          expg           := exp(argg * (vgs - out_c.m_von));
          out_c.m_cdrain := cdson * expg;
          gmw            := out_c.m_cdrain * argg;
          out_c.m_gm     := gmw;
          if (vds > out_c.m_vdsat) then
            out_c.m_gm := gmw + didvds * dsdvgs * expg;
          end if;
          tmp          := gmw * (vgs - out_c.m_von) / xn;
          out_c.m_gds  := gdson * expg - out_c.m_gm * dodvds - tmp * dxndvd;
          out_c.m_gmbs := gbson * expg - out_c.m_gm * dodvbs - tmp * dxndvb;
        elseif (vds <= out_c.m_vdsat) then
          // linear region
          out_c.m_cdrain := beta1 * ((vgs - vbin - eta * vds / 2.0) * vds - gammad * body / 1.5);
          arg            := out_c.m_cdrain * (dudvgs / ufact - dldvgs / clfact);
          out_c.m_gm     := arg + beta1 * vds;
          arg            := out_c.m_cdrain * (dudvds / ufact - dldvds / clfact);
          out_c.m_gds    := arg + beta1 * (vgs - vbin - eta * 
                            vds - gammad * barg - dgdvds * body / 1.5);
          arg            := out_c.m_cdrain * (dudvbs / ufact - dldvbs / clfact);
          out_c.m_gmbs   := arg - beta1 * (gdbdv + dgdvbs * body / 1.5 - factor * vds);
        else
          // saturation region
          out_c.m_cdrain := beta1 * ((vgs - vbin - eta * 
                           out_c.m_vdsat / 2.0) * out_c.m_vdsat - gammad * bodys / 1.5);
          arg            := out_c.m_cdrain * (dudvgs / ufact - dldvgs / clfact);
          out_c.m_gm     := arg + beta1 * out_c.m_vdsat 
                           + beta1 * (vgs - vbin - eta * out_c.m_vdsat - gammad * bsarg) * dsdvgs;
          out_c.m_gds    := -out_c.m_cdrain * dldvds / clfact - beta1 * dgdvds * bodys / 1.5;
          arg            := out_c.m_cdrain * (dudvbs / ufact - dldvbs / clfact);
          out_c.m_gmbs   := arg - beta1 * (gdbdvs + dgdvbs * bodys / 1.5 - factor * out_c.m_vdsat) 
                           + beta1 *  (vgs - vbin - eta * out_c.m_vdsat - gammad * bsarg) * dsdvbs;
        end if;

        annotation (Documentation(info="<html>
<p>该函数drainCurRevised计算从漏极节点到源极节点(级别2)的主要电流。</p>
</html>"                ));
      end drainCurRevised;

      function mos2RenameParametersRevised 
        "参数重命名为内部名称"
        extends Modelica.Icons.Function;
        input Spice3.Internal.ModelcardMOS2 ex 
          "带有技术参数的模型卡";

        output Modelica.Electrical.Spice3.Internal.Mos2.Mos2ModelLineParams intern 
          "输出记录模型线参数";

      algorithm
        intern.m_narrowFactor := ex.DELTA;           // DELTA，阈值的宽度影响
        intern.m_critFieldExp := ex.UEXP;            // UEXP，电迁移度退化的临界场指数
        intern.m_critField := ex.UCRIT;              // UCRIT，电迁移度退化的临界场
        intern.m_maxDriftVel := ex.VMAX;             // VMAX，最大载流子漂移速度
        intern.m_junctionDepth := ex.XJ;             // XJ，结深度
        intern.m_channelCharge := ex.NEFF;           // NEFF，总沟道电荷系数
        intern.m_fastSurfaceStateDensity := ex.NFS;  // NFS，快速表面态密度

        // MosModelLineParams
        intern.m_oxideCapFactor := 0;
        intern.m_vtOIsGiven := if (ex.VTO > -1e40) then 1 else 0;
        intern.m_vt0 := if (ex.VTO > -1e40) then ex.VTO else 0;
        intern.m_capBDIsGiven := if (ex.CBD > -1e40) then 1 else 0;
        intern.m_capBD := if (ex.CBD > -1e40) then ex.CBD else 0;
        intern.m_capBSIsGiven := if (ex.CBS > -1e40) then 1 else 0;
        intern.m_capBS := if (ex.CBS > -1e40) then ex.CBS else 0;
        intern.m_bulkCapFactor := ex.CJ;           // F/(m*m)零偏体结底部每平方米的结面积电容(默认为0)
        intern.m_sideWallCapFactor := ex.CJSW;     // F/m零偏体结侧壁每米结周长的电容(默认为0)
        intern.m_fwdCapDepCoeff := ex.FC;          // 正偏脱空电容公式的系数(默认为0.5)
        intern.m_phiIsGiven := if (ex.PHI > -1e40) then 1 else 0;
        intern.m_phi := if (ex.PHI > -1e40) then ex.PHI else 0.6;
        intern.m_gammaIsGiven := if (ex.GAMMA > -1e40) then 1 else 0;
        intern.m_gamma := if (ex.GAMMA > -1e40) then ex.GAMMA else 0;
        intern.m_lambda := ex.LAMBDA;              // 1/V的沟道长度调制(默认为0)
        intern.m_substrateDopingIsGiven := if (ex.NSUB > -1e40) then 1 else 0;
        intern.m_substrateDoping := if (ex.NSUB > -1e40) then ex.NSUB else 0;
        intern.m_gateType := ex.TPG;               // 门材料的类型：+1与基片相反，-1与基片相同，0为铝门(默认为1)
        intern.m_surfaceStateDensity := ex.NSS;    // 1/(cm*cm)表面态密度(默认为0)
        intern.m_surfaceMobility := ex.UO;         // (cm*cm)/(Vs)表面迁移率(默认为600)
        intern.m_latDiff := ex.LD;                 // m横向扩散(默认为0)
        intern.m_jctSatCur := ex.IS;               // A体结饱和电流(默认为1e-14)
        intern.m_drainResistanceIsGiven := if (ex.RD > -1e40) then 1 else 0;
        intern.m_drainResistance := if (ex.RD > -1e40) then ex.RD else 0;
        intern.m_sourceResistanceIsGiven := if (ex.RS > -1e40) then 1 else 0;
        intern.m_sourceResistance := if (ex.RS > -1e40) then ex.RS else 0;
        intern.m_transconductanceIsGiven := if (ex.KP > -1e40) then 1 else 0;
        intern.m_transconductance := if (ex.KP > -1e40) then ex.KP else 2e-5;
        intern.m_tnom := ex.TNOM + Spice3.Internal.SpiceConstants.CONSTCtoK;

        // MosfetModelLineParams
        intern.m_jctSatCurDensity := ex.JS;             // A/(m*m)每平方米结区域的体结饱和电流(默认为0)
        intern.m_sheetResistance := ex.RSH;             // 漏极和源极扩散面电阻(默认为0)
        intern.m_bulkJctPotential := ex.PB;             // V零偏体结电势(默认为0.8)
        intern.m_bulkJctBotGradingCoeff := ex.MJ;       // 零偏体结底部分级系数(默认为0.5)
        intern.m_bulkJctSideGradingCoeff := ex.MJSW;    // 零偏体结侧壁分级系数(默认为0.5)
        intern.m_oxideThickness := if (ex.TOX > -1e40) then ex.TOX else 1e-7; // m氧化层厚度(默认为1e-7)
        intern.m_gateSourceOverlapCapFactor := ex.CGSO; // F/m每米沟道宽度的门源重叠电容(默认为0)
        intern.m_gateDrainOverlapCapFactor := ex.CGDO;  // F/m每米沟道宽度的门漏重叠电容(默认为0)
        intern.m_gateBulkOverlapCapFactor := ex.CGBO;   // F/m每米沟道宽度的门基重叠电容(默认为0)
        intern.m_fNcoef := ex.KF;                       // 闪烁噪声系数(默认为0)
        intern.m_fNexp := ex.AF;                        // 闪烁噪声指数(默认为1)

        annotation (Documentation(info="<html>
<p>此函数mos2RenameParametersRevised将外部(由用户提供，例如RD)技术参数分配给内部参数(例如 m_drainResistance)。
它还对IsGiven值(级别 2)进行了分析。</p>
</html>"                ));
      end mos2RenameParametersRevised;

      function mos2RenameParametersDev 
        "将设备参数重命名为内部名称"
        extends Modelica.Icons.Function;
        input Spice3.Internal.ModelcardMOS2 ex; // 带有技术参数的模型卡

        input Integer mtype; // N沟道型或P沟道型
        input SI.Length W "沟道区域宽度";
        input SI.Length L "沟道区域长度";
        input SI.Area AD "漏极扩散区面积";
        input SI.Area AS "源极扩散区面积";
        input SI.Length PD "漏极周长";
        input SI.Length PS "源极周长";
        input Real NRD "漏极方格长度";
        input Real NRS "源极方格长度";
        input Integer OFF 
          "可选的初始条件：0-不使用 IC，1-使用 IC，尚未实现";
        input Real IC "初始条件值，尚未实现";
        input Modelica.Units.NonSI.Temperature_degC TEMP "温度";

        output Spice3.Internal.Mosfet.Mosfet dev "输出记录 Mosfet";

      algorithm
      /* 设备参数 */
        dev.m_len := L;               // L，沟道区域长度
        dev.m_width := W;             // W，沟道区域宽度
        dev.m_drainArea := AD;        // AD，漏极扩散区面积
        dev.m_sourceArea := AS;       // AS，源极扩散区面积
        dev.m_drainSquares := NRD;    // NRD，漏极方格长度
        dev.m_sourceSquares := NRS;   // NRS，源极方格长度
        dev.m_drainPerimeter := PD;   // PD，漏极周长
        dev.m_sourcePerimeter := PS;  // PS，源极周长

        dev.m_dICVDSIsGiven := if          (IC > -1e40) then 1 else 0;
        dev.m_dICVDS := if         (IC > -1e40) then IC else 0;

        dev.m_dICVGSIsGiven := if          (IC > -1e40) then 1 else 0;
        dev.m_dICVGS := if         (IC > -1e40) then IC else 0;

        dev.m_dICVBSIsGiven := if          (IC > -1e40) then 1 else 0;
        dev.m_dICVBS := if         (IC > -1e40) then IC else 0;

        dev.m_off := OFF;             // 非零表示设备在直流分析中处于关断状态
        dev.m_bPMOS := mtype;         // P型MOSFET 模型
        dev.m_nLevel := ex.LEVEL;
        assert(ex.LEVEL== 1, "only MOS Level1 implemented"); // 仅实现了MOS Level1
        dev.m_dTemp := TEMP + Spice3.Internal.SpiceConstants.CONSTCtoK;

        annotation (Documentation(info="<html>
<p>此函数mos2RenameParametersDev将外部(由用户提供的)设备参数分配给内部参数。它还对IsGiven值(级别2)进行了分析。</p>
</html>"                ));
      end mos2RenameParametersDev;

      annotation (Documentation(info="<html>
<p>Mos2库包含了MOSFET模型Level2的函数和记录数据。</p>

</html>"          ));
    end Mos2;

    package Diode "二极管模型的记录和函数"
      extends Modelica.Icons.InternalPackage;


      record DiodeModelLineParams "二极管模型线参数记录"
        extends Modelica.Icons.Record;
        SI.Current m_satCur( start = 1.0e-14) "IS, 饱和电流";
        SI.Resistance m_resist( start = 0.0) "RS, 欧姆电阻";
        Real m_emissionCoeff( start = 1.0) "N, 发射系数";
        SI.Time m_transitTime( start = 0.0) "TT, 过渡时间";
        Types.Capacitance m_junctionCap( start = 0.0) "CJO, 结电容";
        SI.Voltage m_junctionPot( start = 1.0) "VJ, 结电位";
        SI.LinearTemperatureCoefficient m_gradingCoeff( start = 0.5) 
          "M, 掺杂系数";
        SI.ActivationEnergy m_activationEnergy( start = 1.11) 
          "EG, 激活能";
        Real m_saturationCurrentExp( start = 3.0) 
          "XTI, 饱和电流温度指数";
        Real m_depletionCapCoeff( start = 0.5) 
          "FC, 正偏结拟合参数";
        SI.Voltage m_breakdownVoltage "BV, 反向击穿电压";
        Real m_pBvIsGiven "BV是给定值";
        SI.Current m_breakdownCurrent( start = 1.0e-3) 
          "IBV, 反向击穿电流";
        SI.Temperature m_nomTemp( start=SpiceConstants.CKTnomTemp) 
          "TNOM, 参数测量温度";
        Real m_fNcoef( start = 0.0) "KF, 闪烁噪声系数";
        Real m_fNexp( start = 1.0) "AF, 闪烁噪声指数";
        SI.Conductance m_conductance "G, 欧姆导纳";

        annotation (Documentation(info="<html>
<p>此记录包含了在SPICE3中用于二极管模型的模型线(也称为模型卡)参数。</p>
</html>"            ));
      end DiodeModelLineParams;

      record DiodeModelLineVariables "二极管模型线变量记录"
        extends Modelica.Icons.Record;
        Real m_gradingCoeff; // 掺杂系数
        Real m_activationEnergy; // 激活能
        Real m_depletionCapCoeff; // 耗尽电容系数
        SI.Conductance m_conductance; // 导纳

        annotation (Documentation(info="<html>
<p>此记录包含了在SPICE3中用于二极管模型的模型线(也称为模型卡)变量。</p>
</html>"            ));
      end DiodeModelLineVariables;

      record DiodeParams "二极管设备参数记录"
        extends Modelica.Icons.Record;
        Real m_area(start = 1.0) "AREA, 面积因子";
        Boolean m_bOff(start = false) "OFF, 初始关闭状态";
        SI.Voltage m_dIC(start = 0.0) "IC, 初始设备电压";
        Real m_pIcIsGiven "IC是给定值";
        Boolean m_bSensArea(start = false) 
          "SENS_AREA, 请求相对于面积的灵敏度标志";

        annotation (Documentation(info="<html>
<p>此记录包含了在SPICE3中用于二极管模型的设备参数。</p>
</html>"            ));
      end DiodeParams;

      record DiodeVariables "二极管模型的变量"
        extends Modelica.Icons.Record;
        Real m_pBvIsGiven "额外BV是否给定的变量";

        annotation (Documentation(info="<html>
<p>此记录包含了在SPICE3中用于二极管模型的模型变量。</p>
</html>"            ));
      end DiodeVariables;

      record DiodeCalc "二极管变量"
        extends Modelica.Icons.Record;
        SI.Voltage m_tJctPot; // 结势
        Types.Capacitance m_tJctCap; // 结电容
        Real m_tF1;
        Real m_f2;
        Real m_f3;
        SI.Current m_tSatCur; // 饱和电流
        SI.Voltage m_tVcrit; // 临界电压
        Real m_dVte; // 热电压
        SI.Voltage m_tBrkdwnV; // 击穿电压

        annotation (Documentation(info="<html>
<p>此记录包含了在SPICE3中用于二极管模型的模型变量。</p>
</html>"            ));
      end DiodeCalc;

      record CurrentsCapacitances "二极管变量"
        extends Modelica.Icons.Record;
        SI.Current m_dCurrent; // 电流

        annotation (Documentation(info="<html>
<p>此记录包含了在SPICE3中用于二极管模型的模型变量。</p>
</html>"            ));
      end CurrentsCapacitances;

      function diodeModelLineInitEquations 
        "模型线参数的初始预计算"
        extends Modelica.Icons.Function;
        input DiodeModelLineParams in_p 
          "带有二极管模型线参数的输入记录";

        output DiodeModelLineVariables out_v 
          "带有二极管模型线变量的输出记录";

      algorithm
        // 限制掺杂系数的最大值为0.9
        if (in_p.m_gradingCoeff > 0.9) then
          out_v.m_gradingCoeff := 0.9;
        end if;
        // 限制激活能的最小值为0.1
        if (in_p.m_activationEnergy < 0.1) then
          out_v.m_activationEnergy := 0.1;
        end if;
        // 限制耗尽电容系数的最大值为0.95
        if (in_p.m_depletionCapCoeff > 0.95) then
          out_v.m_depletionCapCoeff := 0.95;
        end if;

        out_v.m_conductance := if (in_p.m_resist == 0.0) then 0.0 else 1.0 / in_p.m_resist; // 导纳的计算

        annotation (Documentation(info="<html>
<p>在此函数中，从模型线参数中预先计算了一些参数。</p>
</html>"            ));
      end diodeModelLineInitEquations;

      function diodeInitEquations "初始计算"
        extends Modelica.Icons.Function;
        input DiodeModelLineParams in_p 
          "带有二极管模型线参数的输入记录";

        output DiodeVariables out_v "带有二极管变量的输出记录";

      algorithm
       out_v.m_pBvIsGiven := in_p.m_pBvIsGiven; // 设置BV是否已给定
        if (out_v.m_pBvIsGiven > 0.5) then
          if (in_p.m_breakdownVoltage > 1.0e+100) then
            out_v.m_pBvIsGiven := 1.0e-41; // 设置为false
          end if;
        end if;

        annotation (Documentation(info="<html>
<p>在此函数中，对二极管模型进行了一些初始计算，特别是关于处理击穿电压的。</p>
</html>"            ));
      end diodeInitEquations;

      function diodeCalcTempDependencies "温度依赖性计算"
        extends Modelica.Icons.Function;
        input DiodeModelLineParams in_p 
          "二极管模型线参数的输入记录";
        input DiodeParams in_dp "二极管参数的输入记录";
        input Model.Model in_m "模型的输入记录";
        input DiodeVariables in_v "二极管变量的输入记录";

        output DiodeCalc out_c "带有计算值的输出记录";

      algorithm
        (out_c.m_tJctPot,out_c.m_tJctCap) := 
          Modelica.Electrical.Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                in_p.m_junctionPot, 
                in_p.m_junctionCap, 
                in_p.m_gradingCoeff, 
                in_m.m_dTemp, 
                in_p.m_nomTemp); // 计算结势和结电容的温度依赖性
        out_c.m_tJctCap := in_dp.m_area * out_c.m_tJctCap; // 结电容乘以面积
        (out_c.m_tF1,out_c.m_f2,out_c.m_f3) := 
          Modelica.Electrical.Spice3.Internal.Functions.junctionCapCoeffs(
                in_p.m_gradingCoeff, 
                in_p.m_depletionCapCoeff, 
                out_c.m_tJctPot); // 计算结电容系数
        out_c.m_tSatCur := 
          Modelica.Electrical.Spice3.Internal.Functions.saturationCurDepTempSPICE3(
                in_p.m_satCur, 
                in_m.m_dTemp, 
                in_p.m_nomTemp, 
                in_p.m_emissionCoeff, 
                in_p.m_activationEnergy, 
                in_p.m_saturationCurrentExp); // 计算饱和电流的温度依赖性
        out_c.m_tVcrit := 
          Modelica.Electrical.Spice3.Internal.Functions.junctionVCrit(
                in_m.m_dTemp, 
                in_p.m_emissionCoeff, 
                out_c.m_tSatCur); // 计算临界电压
        out_c.m_dVte := in_m.m_dTemp*SpiceConstants.CONSTKoverQ*in_p.m_emissionCoeff; // 计算热电压
        if (in_v.m_pBvIsGiven > 0.5) then
          out_c.m_tBrkdwnV := 
            Modelica.Electrical.Spice3.Internal.Functions.junctionVoltage23SPICE3(
                  in_p.m_breakdownVoltage, 
                  in_p.m_breakdownCurrent, 
                  out_c.m_tSatCur, 
                  in_m.m_dTemp, 
                  in_p.m_emissionCoeff); // 如果给定了击穿电压，则计算击穿电压
        end if;
        out_c.m_tSatCur := in_dp.m_area * out_c.m_tSatCur; // 饱和电流乘以面积

        annotation (Documentation(info="<html>
<p>在此函数中，通过使用方程式库中的温度处理函数计算了二极管模型的温度依赖性。</p>
</html>"            ));
      end diodeCalcTempDependencies;

      function diodeNoBypassCode "电流计算"
        extends Modelica.Icons.Function;
        input DiodeModelLineParams in_p 
          "二极管模型线参数的输入记录";
        input DiodeParams in_dp "二极管参数的输入记录";
        input DiodeCalc in_c "DiodeCalc的输入记录";
        input Model.Model in_m "模型的输入记录";
        input Boolean in_m_mbInit;
        input SI.Voltage[2] in_m_pVoltageValues; /* DPP, DN */

        output CurrentsCapacitances out_cc 
          "带有计算得到的电流和电容的输出记录";

        output Types.Capacitance m_dCap "输出电容";

      protected
        SI.Voltage m_dPNVoltage "电压";
        SI.Current m_dCurrent "电流";
        SI.Conductance m_dCond "导纳";
        SI.Charge m_dCharge "电荷";
        SI.Current m_dCapCurrent "电流";

      algorithm
        m_dPNVoltage := in_m_pVoltageValues[1] - in_m_pVoltageValues[2]; // 计算PN电压

        if (SpiceRoot.useInitialConditions() and in_dp.m_pIcIsGiven > 0.5) then // 使用初始条件
          m_dPNVoltage := in_dp.m_dIC;
        elseif (SpiceRoot.initJunctionVoltagesRevised()) then
          if (in_dp.m_bOff) then // 关断状态
            m_dPNVoltage := 0.0;
          else
            m_dPNVoltage := in_c.m_tVcrit;
          end if;
        end if;

        if (in_p.m_pBvIsGiven > 0.5) then // 如果给定了击穿电压
          (out_cc.m_dCurrent,m_dCond) := 
            Modelica.Electrical.Spice3.Internal.Functions.junction3(
                  m_dPNVoltage, 
                  in_m.m_dTemp, 
                  in_p.m_emissionCoeff, 
                  in_c.m_tSatCur, 
                  in_c.m_tBrkdwnV);
        else
          (out_cc.m_dCurrent,m_dCond) := 
            Modelica.Electrical.Spice3.Internal.Functions.junction2(
                  m_dPNVoltage, 
                  in_m.m_dTemp, 
                  in_p.m_emissionCoeff, 
                  in_c.m_tSatCur);
        end if;

         m_dCurrent := out_cc.m_dCurrent; // 电流赋值

        (m_dCap,m_dCharge) := 
          Modelica.Electrical.Spice3.Internal.Functions.junctionCapTransTime(
                in_c.m_tJctCap, 
                m_dPNVoltage, 
                in_c.m_tJctPot*in_p.m_depletionCapCoeff, 
                in_p.m_gradingCoeff, 
                in_p.m_junctionPot, 
                in_c.m_tF1, 
                in_c.m_f2, 
                in_c.m_f3, 
                in_p.m_transitTime, 
                m_dCond, 
                m_dCurrent); // 电容计算

        annotation (Documentation(info="<html>
<p>此函数diodeNoBypassCode计算了必要的电流(和电容)，
以便将电流用于顶层模型。</p>
</html>"            ));
      end diodeNoBypassCode;

      function diodeCalcAdditionalValues "额外值的计算"
        extends Modelica.Icons.Function;
        input DiodeVariables in_v "带有二极管变量的输入记录";
        input DiodeModelLineParams in_p 
          "带有二极管模型线参数的输入记录";
        input DiodeParams in_dp "带有二极管参数的输入记录";
        input SI.Voltage[2] in_m_pVoltageValues; /* DP, DPP */

        output DiodeVariables out_v "带有二极管变量的输出记录";

      algorithm
        out_v := in_v; // 将输入赋值给输出

        annotation (Documentation(info="<html>
<p>此函数为额外计算而准备，但在实际版本的此库中它的功能较为简单(将输入写入输出)。</p>
</html>"            ));
      end diodeCalcAdditionalValues;

      function diodeRenameParameters "技术参数重命名"
        extends Modelica.Icons.Function;
        input ModelcardDIODE ex "带有技术参数的模型卡";
        input SpiceConstants con "Spice常数";

        output DiodeModelLineParams intern 
          "输出记录，二极管模型线参数";

      algorithm
         intern.m_satCur := ex.IS; // 饱和电流
         intern.m_resist:=ex.RS; // 串联电阻
         intern.m_emissionCoeff := ex.N; // 发射系数
         intern.m_transitTime := ex.TT; // 迁移时间
         intern.m_junctionCap := ex.CJO; // 结电容
         intern.m_junctionPot := ex.VJ; // 结势

         intern.m_gradingCoeff := if (ex.M > 0.9) then 0.9 else ex.M; // 掺杂系数
         intern.m_activationEnergy := if (ex.EG < 0.1) then 0.1 else ex.EG; // 激活能
         intern.m_saturationCurrentExp := ex.XTI; // 饱和电流指数
         intern.m_depletionCapCoeff := if (ex.FC > 0.95) then 0.95 else ex.FC; // 耗尽电容系数

         intern.m_pBvIsGiven := if (ex.BV > -1e40) then 1 else 0; // BV是否已给定
         intern.m_breakdownVoltage := if (ex.BV > -1e40) then ex.BV else 0; // 破坏电压

         intern.m_breakdownCurrent := ex.IBV; // 破坏电流
         intern.m_nomTemp := ex.TNOM + SpiceConstants.CONSTCtoK; // 标称温度
         intern.m_fNcoef := ex.KF; // 负指数系数
         intern.m_fNexp := ex.AF; // 负指数指数

         intern.m_conductance := if (ex.RS == 0) then  0 else 1/ex.RS; // 导纳

        annotation (Documentation(info="<html>
<p>此函数将外部(由用户提供，例如IS)技术参数分配给内部参数(例如m_satCur)。
还对IsGiven值进行分析。</p>
</html>"            ));
      end diodeRenameParameters;

      function diodeRenameParametersDev "温度计算"
        extends Modelica.Icons.Function;
        input SI.Temperature TEMP "温度";
        input Real AREA "面积因子";
        input Real IC "初始条件值(VD，尚未实现";
        input Boolean OFF 
          "可选的初始条件：false-IC未使用，true-使用IC，尚未实现";
        input Boolean SENS_AREA 
          "请求相对于面积的敏感度的标志，尚未实现";

        output DiodeParams dev "输出记录，带有计算得到的二极管参数";

      algorithm
      /*设备参数*/
        dev.m_area := AREA; // 面积

        dev.m_pIcIsGiven := if (IC > -1e40) then 1 else 0; // IC是否已给定
        dev.m_dIC := if 
                       (IC > -1e40) then IC else 0; // 初始条件
        dev.m_bOff := OFF; // 关断
        dev.m_bSensArea := SENS_AREA; // 相对于面积的敏感度

        annotation (Documentation(info="<html>
<p>此函数将外部(由用户提供，例如AREA)设备参数分配给内部参数(例如m_area)。
还对IsGiven值进行分析。</p>
</html>"            ));
      end diodeRenameParametersDev;

      function diodeRenameParametersDevTemp "温度计算"
        extends Modelica.Icons.Function;
        input Modelica.Units.NonSI.Temperature_degC TEMP "温度";
        output Model.Model dev_temp "输入记录模型";

      algorithm
        dev_temp.m_dTemp := TEMP + SpiceConstants.CONSTCtoK; // 设备温度

        annotation (Documentation(info="<html>
<p>此函数计算温度相关的器件参数。</p>
</html>"            ));
      end diodeRenameParametersDevTemp;
    annotation (Documentation(info="<html>
<p>此Diode库包含半导体二极管模型的函数和记录数据。</p>
</html>"      ));
    end Diode;

    package Rsemiconductor 
      "半导体电阻器模型的记录和函数"
        extends Modelica.Icons.InternalPackage;


      record ResistorParams "电阻器器件参数"
        extends Modelica.Icons.Record;
        SI.Resistance m_dResist( start=1000) "器件为电阻模型";
        Real m_dResIsGiven "电阻为给定值";
        SI.Length m_dWidth( start=0) "宽度";
        Real m_dWidthIsGiven "宽度为给定值";
        SI.Length m_dLength "长度";
        Real m_dLengthIsGiven "长度为给定值";
        Boolean m_bSensResist( start = false) 
          "请求相对于电阻的敏感度的标志";
        Modelica.Units.NonSI.Temperature_degC m_dTemp(start = 27) "电阻器件温度";

        annotation (Documentation(info="<html>
<p>此记录包含用于SPICE3中电阻器模型的器件参数。</p>
</html>"            ));
      end ResistorParams;

      record ResistorModelLineParams "电阻器模型线参数记录"
        extends Modelica.Icons.Record;
        SI.LinearTemperatureCoefficientResistance m_dTC1 "一阶温度系数";
        SI.QuadraticTemperatureCoefficientResistance m_dTC2 "二阶温度系数";
        SI.Resistance m_dRsh "片状电阻";
        Real m_dRshIsGiven; // 是否给定片状电阻
        SI.Length m_dDefW "默认器件宽度";
        SI.Length m_dNarrow "电阻缩窄";
        Modelica.Units.NonSI.Temperature_degC m_dTnom "参数测量温度";

        annotation (Documentation(info="<html>
<p>此记录包含用于SPICE3中电阻器模型的模型线(也称为模型卡)参数。</p>
</html>"            ));
      end ResistorModelLineParams;

      record ResistorVariables "电阻器模型的变量"
        extends Modelica.Icons.Record;
        SI.Length m_dWidth; // 宽度
        SI.Length m_dLength; // 长度
        SI.Resistance m_dResist; // 电阻
        SI.Conductance m_dConduct; // 导纳
        Modelica.Units.NonSI.Temperature_degC m_dCond_dTemp; // 条件温度
        annotation (Documentation(info="<html>
<p>此记录包含用于SPICE3中电阻器模型的模型变量。</p>
</html>"            ));
      end ResistorVariables;

      function resistorRenameParameters "技术参数重命名"
        extends Modelica.Icons.Function;
        input ModelcardR ex "带有技术参数的模型卡";
        input SpiceConstants con "Spice常数";

        output ResistorModelLineParams intern 
          "带有电阻器模型线参数的输出记录";

      algorithm
        intern.m_dTC1 := ex.TC1; // 温度系数1
        intern.m_dTC2 := ex.TC2; // 温度系数2

        intern.m_dRshIsGiven := if (ex.RSH > -1e40) then 1 else 0; // Rsh是否已给定
        intern.m_dRsh := if (ex.RSH > -1e40) then ex.RSH else 0; // 平行电阻

        intern.m_dDefW := ex.DEFW; // 默认宽度
        intern.m_dNarrow := ex.NARROW; // 窄度
        intern.m_dTnom := if (ex.TNOM > -1e40) then ex.TNOM + SpiceConstants.CONSTCtoK else 
                300.15; // 标称温度

        annotation (Documentation(info="<html>
<p>此函数将外部(由用户提供，例如N)技术参数分配给内部参数(例如m_emissionCoeff)。
还对IsGiven值进行分析。</p>
</html>"            ));
      end resistorRenameParameters;

      function resistorRenameParametersDev "设备参数重命名"
        extends Modelica.Icons.Function;
        input SI.Resistance R "电阻";
        input SI.Length W "宽度";
        input SI.Length L "长度";
        input Modelica.Units.NonSI.Temperature_degC TEMP "温度";
        input Boolean SENS_AREA 
          "用于敏感性分析的参数，尚未实现";

       input SpiceConstants con "SPICE常数";

       output ResistorParams intern "具有电阻参数的输出记录";

      algorithm
         intern.m_dResIsGiven := if 
                                   (R > -1e40) then 1 else 0;
                                    //如果电阻大于-1e40，则设为1，否则设为0
         intern.m_dResist := if 
                               (R > -1e40) then R else 0;
                                //如果电阻大于-1e40，则设为输入的电阻值，否则设为0

         intern.m_dWidthIsGiven := if 
                                     (W >-1e40) then 1 else 0;
                                      //如果宽度大于-1e40，则设为1，否则设为0
         intern.m_dWidth := if 
                              (W > -1e40) then W else 0;
                                //如果宽度大于-1e40，则设为输入的宽度值，否则设为0

         intern.m_dLengthIsGiven := if 
                                     (L >-1e40) then 1 else 0;
                                      //如果长度大于-1e40，则设为1，否则设为0
         intern.m_dLength := if 
                              (L > -1e40) then L else 0;
                                //如果长度大于-1e40，则设为输入的长度值，否则设为0
         intern.m_bSensResist := SENS_AREA;
                                    //设置敏感电阻

        intern.m_dTemp := if (TEMP > -1e40) then TEMP + SpiceConstants.CONSTCtoK else 
                300.15;
                               //如果温度大于-1e40，则设为输入的温度值加上常数转换为开尔文，否则设为300.15

        annotation (Documentation(info="<html>
<p>此函数将外部(由用户提供，例如AREA)设备参数分配给内部参数(例如m_area)。还分析了IsGiven值。</p>
</html>"            ));
      end resistorRenameParametersDev;

      function resistorInitEquations "初始计算"
        extends Modelica.Icons.Function;
        input ResistorParams in_p "输入电阻参数记录";
        input ResistorModelLineParams in_p2 
          "输入电阻模型线参数记录";
        output ResistorVariables out "输出电阻变量记录";

      algorithm
        out.m_dLength := 0;
                               //长度
        out.m_dConduct := 0;
                               //导电性
        out.m_dCond_dTemp := 0;
                               //温度导电性

        out.m_dWidth := in_p.m_dWidth;
                               //宽度
        if (in_p.m_dResIsGiven < 0.5) then
          if (abs(in_p.m_dLength)>1e-8) and (abs(in_p2.m_dRsh)>1e-25) then
            if (not (in_p.m_dWidthIsGiven > 0.5)) then
              out.m_dWidth :=in_p2.m_dDefW;
                                 //默认宽度
            end if;

            (out.m_dResist) := 
              Modelica.Electrical.Spice3.Internal.Functions.resDepGeom(
                    in_p2.m_dRsh, 
                    out.m_dWidth, 
                    in_p.m_dLength, 
                    in_p2.m_dNarrow);
                                //电阻值
          else
            out.m_dResist :=1000;
                                //默认电阻值
          end if;
        end if;

        if (in_p.m_dResist < 1e-12) and (in_p.m_dResIsGiven > 0.5) then
          out.m_dResist :=1e-12;
                                //电阻小于1e-12时设定为1e-12
        end if;

        if (in_p.m_dResist > 1e-12) and (in_p.m_dResIsGiven > 0.5) then
          out.m_dResist := in_p.m_dResist;
                                //电阻大于1e-12时设定为输入的电阻值
        end if;

        annotation (Documentation(info="<html>
<p>此函数对电阻模型进行了一些初始计算，特别是关于处理击穿电压的处理。</p>
</html>"            ));
      end resistorInitEquations;

    annotation (Documentation(info="<html>
<p>Rsemiconductor库包含半导体电阻器模型的数据的函数和记录。</p>
</html>"      ));

    end Rsemiconductor;

    package Bjt "双极晶体管模型的记录和函数"
      extends Modelica.Icons.InternalPackage;


      record Bjt "用于bjt设备参数的记录"
        extends Spice3.Internal.Model.Model;

        Real m_area(  start = 1.0) "面积";
        Boolean m_bOff(  start = false) "关闭";
        SI.Voltage m_dICvbe(start=0.0) "IC_VBE";
        Real m_bICvbeIsGiven( start = 0.0) "给定的IC_VBE";
        SI.Voltage m_dICvce(start=0.0) "IC_VCE";
        Real m_bICvceIsGiven( start = 0.0) "给定的IC_VCE";
        Boolean m_uic "使用初始条件，UIC";
        Boolean m_bSensArea( start = false) "SENS_AREA";

        SI.Current m_transitTimeHighCurrentF(start=0.0) "过渡时间高电流";
        Types.InverseElectricCurrent m_invRollOffF(start=0) "invRollOffF";
        Types.InverseElectricCurrent m_invRollOffR(start=0) "invRollOffR";

        Types.Capacitance m_CScap(start=0) "CScap";
        annotation (Documentation(info="<html>
<p>此记录包含SPICE3中双极晶体管bjt模型使用的设备参数。</p>
</html>"            ));
      end Bjt;

      record BjtModelLineParams "用于双极晶体管模型线参数的记录"
        extends Modelica.Icons.Record;
        Real m_type( start = 1) "器件类型：1=n，-1=p";

        SI.Temperature m_tnom(start=Spice3.Internal.SpiceConstants.CKTnomTemp) 
          "TNOM，参数测量温度";
        SI.Current m_satCur(start=1.0e-16) "IS，饱和电流";
        Real m_betaF( start = 100.0) "BF，理想前向增益";
        Real m_emissionCoeffF(  start = 1.0) "NF，前向发射系数";
        Real m_leakBEemissionCoeff( start = 1.5) 
          "NE，B-E泄漏发射系数";
        SI.Current m_leakBEcurrent(start=0.) 
          "ISE，B-E泄漏饱和电流";
        Real m_c2( start = 0.) "C2，已废弃的参数名称";
        SI.Current m_leakBCcurrent(start=0.) 
          "ISC，B-C泄漏饱和电流";
        Real m_c4( start = 0.) "C4，已废弃的参数名称";
        Real m_leakBEcurrentIsGiven;
        Real m_c2IsGiven;
        Real m_leakBCcurrentIsGiven;
        Real m_c4IsGiven;
        Real m_betaR( start = 1.0) "BR，理想反向增益";
        Real m_emissionCoeffR( start = 1.0) "NR，反向发射系数";
        Real m_leakBCemissionCoeff( start = 2.0) 
          "NC，B-C泄漏发射系数";
        SI.Voltage m_earlyVoltF(start=0.0) "VAF，前向早期电压";
        SI.Current m_rollOffF(start=0.0) 
          "IKF，前向增益下降角频率";
        SI.Voltage m_earlyVoltR(start=0.0) "VAR，反向早期电压";
        SI.Current m_rollOffR(start=0.0) 
          "IKR，反向增益下降角频率";
        SI.Resistance m_emitterResist(start=0.0) "RE，发射极电阻";
        SI.Resistance m_collectorResist(start=0.0) "RC，集电极电阻";
        SI.Current m_baseCurrentHalfResist(start=0.0) 
          "IRB，基极电阻=(rb+rbm)/2 的电流";
        SI.Resistance m_baseResist(start=0.0) "RB，零偏基极电阻";
        SI.Resistance m_minBaseResist(start=0.0) "RBM，最小基极电阻";
        Real m_minBaseResistIsGiven;
        Types.Capacitance m_depletionCapBE(start=0.0) 
          "CJE，零偏B-E耗尽电容";
        SI.Voltage m_potentialBE(start=0.75) "VJE，B-E内建电势";
        Real m_junctionExpBE( start = 0.33) "MJE，B-E内建电势";
        SI.Time m_transitTimeF(start=0.0) "TF，理想前向过渡时间";
        Real m_transitTimeBiasCoeffF( start = 0.0) 
          "XTF，TF的偏压系数";
        SI.Current m_transitTimeHighCurrentF(start=0.0) 
          "ITF，TF的高电流依赖";
        SI.Voltage m_transitTimeFVBC(start=0.0) 
          "VTF，给定VBC依赖的电压";
        SI.Frequency m_excessPhase(start=0.0) "PTF，过剩相位";
        Types.Capacitance m_depletionCapBC(start=0.0) 
          "CJC，零偏B-C耗尽电容";
        SI.Voltage m_potentialBC(start=0.75) "VJC，B-C内建电势";
        Real m_junctionExpBC( start = 0.33) 
          "MJC，B-C结分级系数";
        Real m_baseFractionBCcap( start = 1.0) 
          "XCJC，B-C电容到内部基极的比例";
        SI.Time m_transitTimeR(start=0.0) "TR，理想反向过渡时间";
        Types.Capacitance m_capCS(start=0.0) "CJS，零偏C-S电容";
        SI.Voltage m_potentialSubstrate(start=0.75) 
          "VJS，零偏C-S电势";
        Real m_exponentialSubstrate( start = 0.0) 
          "MJS，基板结分级系数";
        Real m_betaExp( start = 0.0) "XTB，前向和反向增益的温度系数";
        SI.GapEnergy m_energyGap(start=1.11) 
          "EG，IS温度依赖的能隙";
        Real m_tempExpIS( start = 3.0) "XTI，IS的温度指数";
        Real m_fNcoef( start = 0.0) "KF，闪烁噪声系数";
        Real m_fNexp( start = 1.0) "AF，闪烁噪声指数";
        Real m_depletionCapCoeff( start = 0.5) 
          "FC，正偏结拟合参数";

        SI.Conductance m_collectorConduct(start=0.0);
        SI.Conductance m_emitterConduct(start=0.0);
        SI.InversePotential m_transitTimeVBCFactor(start=0.0);
        Real m_excessPhaseFactor( start = 0.0);
        SI.InversePotential m_invEarlyVoltF(start=0.0);
        Types.InverseElectricCurrent m_invRollOffF(start=0.0);
        SI.InversePotential m_invEarlyVoltR(start=0.0);
        Types.InverseElectricCurrent m_invRollOffR(start=0.0);

        // 废弃
        Real m_bNPN= 1;
        Real m_bPNP= 1;

        Real m_area = 1.0;
        Boolean m_bOff = false;
        SI.Voltage m_dICvbe = 0;
        Real m_bICvbeIsGiven = 0;
        SI.Voltage m_dICvce = 0;
        Real m_bICvceIsGiven = 0;
        Boolean m_bSensArea = false;
        Real m_dTemp = 1;

        annotation (Documentation(info="<html>
<p>此记录包含SPICE3中双极晶体管模型的模型线参数(也称为模型卡片参数)。</p>
</html>"            ));
      end BjtModelLineParams;

      record BjtCalc "Bjt变量"
        extends Modelica.Icons.Record;
        SI.Current m_tSatCur(start=0);
                                   // 饱和电流
        Real m_tBetaF( start = 1);
                                   // 前向电流放大系数
        Real m_tBetaR( start = 1);
                                   // 反向电流放大系数
        SI.Current m_tBEleakCur(start=1e-14);
                                   // 基-发射区漏电流
        SI.Current m_tBCleakCur(start=1e-14);
                                   // 基 - 集电区漏电流
        Types.Capacitance m_tBEcap(start=0);
                                   // 基-发射区电容
        SI.Voltage m_tBEpot(start=0.7);
                                   // 基-发射区势垒电压
        Types.Capacitance m_tBCcap(start=0);
                                   // 基-集电区电容
        SI.Voltage m_tBCpot(start=0.7);
                                   // 基-集电区势垒电压
        SI.Voltage m_tDepCapBE(start=0.7);
                                   // 基-发射区耗尽电容
        SI.Voltage m_tDepCapBC(start=0.7);
                                   // 基-集电区耗尽电容
        SI.Voltage m_tVcrit(start=0.7);
                                   // 临界电压
        SI.Voltage m_dVt(start=0.025);
                                   // 热电压
        SI.Voltage m_tF1c(start=0);
                                   // 集电区电容系数
        Real m_f2c( start = 0);
                                   // 集电区电容系数
        Real m_f3c( start = 0);
                                   // 集电区电容系数
        SI.Voltage m_tF1e(start=0);
                                   // 发射区电容系数
        Real m_f2e( start = 0);
                                   // 发射区电容系数
        Real m_f3e( start = 0);
                                   // 发射区电容系数

        annotation (Documentation(info="<html>
<p>此记录包含SPICE3中用于双极晶体管模型的模型变量。</p>
</html>"            ));
      end BjtCalc;

      record CurrentsCapacitances "Bjt变量"
        extends Modelica.Icons.Record;
        SI.Current iBE(start=0.0);
                                   // 通过二极管dE1(理想部分)的电流
        SI.Current iBEN(start=0.0);
                                   // 通过二极管dE2(非理想部分)的电流
        SI.Current iBC(start=0.0);
                                   // 通过二极管dC1(理想部分)的电流
        SI.Current iBCN(start=0.0);
                                   // 通过二极管dC2(非理想部分)的电流
        SI.Current iCC(start=0.0);
                                   // 通道电流
        Types.Capacitance capbc(start=0.0);
        Types.Capacitance capbe(start=0.0);
        Types.Capacitance capbx(start=0.0);
        Types.Capacitance captt(start=0.0);
        Types.Capacitance capcs(start=0.0);
        SI.Resistance rx(start=0.0);

        // 废弃
        Real iXX;

        annotation (Documentation(info="<html>
<p>此记录包含SPICE3中用于双极晶体管模型的模型变量。</p>
</html>"            ));
      end CurrentsCapacitances;

      function bjtModelLineInitEquations "初始计算"
        extends Modelica.Icons.Function;
        input BjtModelLineParams in_p 
          "带有Bjt模型线参数的输入记录";

        output BjtModelLineParams out_p 
          "带有Bjt模型线变量的输出记录";

      algorithm
        out_p := in_p;

        if ( not (out_p.m_leakBEcurrentIsGiven > 0.5) and (out_p.m_c2IsGiven > 0.5)) then
          out_p.m_leakBEcurrent := out_p.m_c2 * out_p.m_satCur;
        end if;
        if ( not (out_p.m_leakBCcurrentIsGiven > 0.5) and (out_p.m_c4IsGiven > 0.5)) then
          out_p.m_leakBCcurrent := out_p.m_c4 * out_p.m_satCur;
        end if;
        if (out_p.m_earlyVoltF <> 0) then
          out_p.m_invEarlyVoltF := 1 / out_p.m_earlyVoltF;
        end if;
        if (out_p.m_rollOffF <> 0) then
          out_p.m_invRollOffF := 1 / out_p.m_rollOffF;
        end if;
        if (out_p.m_earlyVoltR <> 0) then
          out_p.m_invEarlyVoltR := 1 / out_p.m_earlyVoltR;
        end if;
        if (out_p.m_rollOffR <> 0) then
          out_p.m_invRollOffR := 1 / out_p.m_rollOffR;
        end if;
        if (out_p.m_collectorResist <> 0) then
          out_p.m_collectorConduct := 1 / out_p.m_collectorResist;
        end if;
        if (out_p.m_emitterResist <> 0) then
          out_p.m_emitterConduct := 1 / out_p.m_emitterResist;
        end if;
        if (out_p.m_transitTimeFVBC <> 0) then
          out_p.m_transitTimeVBCFactor := 1 / (out_p.m_transitTimeFVBC * 1.44);
        end if;
        out_p.m_excessPhaseFactor := (out_p.m_excessPhase/(180.0/ 
          Modelica.Constants.pi))*out_p.m_transitTimeF;
        if (out_p.m_depletionCapCoeff > 0.9999) then
          out_p.m_depletionCapCoeff := 0.9999;
        end if;
        annotation (Documentation(info="<html>
<p>在此函数中，一些参数从模型线参数中最初预先计算。</p>
</html>"            ));
      end bjtModelLineInitEquations;

      function bjtInitEquations "初始计算"
        extends Modelica.Icons.Function;
        input Bjt in_p "输入记录Bjt";
        input BjtModelLineParams in_pml 
          "带有Bjt模型线参数的输入记录";

        output Bjt out_v "带有Bjt的输出记录";

      algorithm
        out_v := in_p;

        // 计算依赖于面积因子的参数
        out_v.m_transitTimeHighCurrentF := in_pml.m_transitTimeHighCurrentF * out_v.m_area;
        out_v.m_invRollOffF             := in_pml.m_invRollOffF / out_v.m_area;
        out_v.m_invRollOffR             := in_pml.m_invRollOffR / out_v.m_area;
        out_v.m_CScap                   := in_pml.m_capCS * out_v.m_area;

        annotation (Documentation(info="<html>
<p>在此函数中，一些参数从模型线参数中最初预先计算。</p>
</html>"            ));
      end bjtInitEquations;

      function bjtCalcTempDependencies "温度依赖性计算"
        extends Modelica.Icons.Function;
        input Bjt in_p3 "输入记录Bjt";
        input BjtModelLineParams in_p 
          "带有Bjt模型线参数的输入记录";

        output BjtCalc out_c "输出记录BjtCalc";

      protected
        Real fact1;
        Real fact2;
        SI.Voltage vt;
        SI.GapEnergy egfet;
        Types.GapEnergyPerEnergy arg;
        SI.Voltage pbfact;
        Real ratlog;
        Real ratio1;
        Real factlog;
        Real factor;
        Real bfactor;
        SI.Voltage pbo;
        Real gmanew;
        Real gmaold;

      algorithm
        fact1 := in_p.m_tnom/Spice3.Internal.SpiceConstants.REFTEMP;
        vt := in_p3.m_dTemp*Spice3.Internal.SpiceConstants.CONSTKoverQ;
        fact2 := in_p3.m_dTemp/Spice3.Internal.SpiceConstants.REFTEMP;

        egfet := Spice3.Internal.MaterialParameters.EnergyGapSi - (Spice3.Internal.MaterialParameters.FirstBandCorrFactorSi 
          *in_p3.m_dTemp*in_p3.m_dTemp)/(in_p3.m_dTemp + Spice3.Internal.MaterialParameters.SecondBandCorrFactorSi);

        arg := -egfet/(2*Spice3.Internal.SpiceConstants.CONSTboltz*in_p3.m_dTemp) 
           + Spice3.Internal.MaterialParameters.BandCorrFactorT300/(Spice3.Internal.SpiceConstants.CONSTboltz 
          *(Spice3.Internal.SpiceConstants.REFTEMP + Spice3.Internal.SpiceConstants.REFTEMP));
        pbfact := -2*vt*(1.5*Modelica.Math.log(fact2) + Spice3.Internal.SpiceConstants.CHARGE 
          *arg);

        ratlog  := Modelica.Math.log(in_p3.m_dTemp/in_p.m_tnom);
        ratio1  := in_p3.m_dTemp / in_p.m_tnom - 1;
        factlog := ratio1 * in_p.m_energyGap / vt + in_p.m_tempExpIS * ratlog;
        factor  := exp( factlog);
        bfactor := exp(ratlog * in_p.m_betaExp);
        pbo     := (in_p.m_potentialBE - pbfact) / fact1;
        gmaold  := (in_p.m_potentialBE - pbo) / pbo;

        out_c.m_tSatCur    := in_p.m_satCur * factor * in_p3.m_area;
        out_c.m_tBetaF     := in_p.m_betaF * bfactor;
        out_c.m_tBetaR     := in_p.m_betaR * bfactor;
        out_c.m_tBEleakCur := in_p.m_leakBEcurrent * exp(factlog / in_p.m_leakBEemissionCoeff) / bfactor 
                              * in_p3.m_area;
        out_c.m_tBCleakCur := in_p.m_leakBCcurrent * exp(factlog / in_p.m_leakBCemissionCoeff) / bfactor 
                              * in_p3.m_area;

        out_c.m_tBEcap := in_p.m_depletionCapBE/(1 + in_p.m_junctionExpBE*(4e-4*(
          in_p.m_tnom - Spice3.Internal.SpiceConstants.REFTEMP) - gmaold));
        out_c.m_tBEpot := fact2 * pbo + pbfact;

        gmanew := (out_c.m_tBEpot - pbo) / pbo;

        out_c.m_tBEcap := out_c.m_tBEcap*(1 + in_p.m_junctionExpBE*(4e-4*(in_p3.m_dTemp 
           - Spice3.Internal.SpiceConstants.REFTEMP) - gmanew));

        pbo    := (in_p.m_potentialBC - pbfact) / fact1;
        gmaold := (in_p.m_potentialBC - pbo) / pbo;

        out_c.m_tBCcap := in_p.m_depletionCapBC/(1 + in_p.m_junctionExpBC*(4e-4*(
          in_p.m_tnom - Spice3.Internal.SpiceConstants.REFTEMP) - gmaold));
        out_c.m_tBCpot := fact2 * pbo + pbfact;

        gmanew := (out_c.m_tBCpot - pbo) / pbo;

        out_c.m_tBCcap := out_c.m_tBCcap*(1 + in_p.m_junctionExpBC*(4e-4*(in_p3.m_dTemp 
           - Spice3.Internal.SpiceConstants.REFTEMP) - gmanew));

        out_c.m_tDepCapBE := in_p.m_depletionCapCoeff * out_c.m_tBEpot;
        out_c.m_tDepCapBC := in_p.m_depletionCapCoeff * out_c.m_tBCpot;
        out_c.m_tVcrit := vt*Modelica.Math.log(vt/(Spice3.Internal.SpiceConstants.CONSTroot2 
          *in_p.m_satCur));
        out_c.m_dVt       := vt;

        // 计算依赖于面积因子的参数
        out_c.m_tBEcap := out_c.m_tBEcap * in_p3.m_area;
        out_c.m_tBCcap := out_c.m_tBCcap * in_p3.m_area;
        (out_c.m_tF1c,out_c.m_f2c,out_c.m_f3c) := 
          Spice3.Internal.Functions.junctionCapCoeffs(
            in_p.m_junctionExpBC, 
            in_p.m_depletionCapCoeff, 
            out_c.m_tBCpot);
        (out_c.m_tF1e,out_c.m_f2e,out_c.m_f3e) := 
          Spice3.Internal.Functions.junctionCapCoeffs(
            in_p.m_junctionExpBE, 
            in_p.m_depletionCapCoeff, 
            out_c.m_tBEpot);

        annotation (Documentation(info="<html>
<p>在此函数中，使用方程库中的温度处理函数计算双极晶体管模型的温度依赖性。</p>
</html>"            ));
      end bjtCalcTempDependencies;

      function bjtNoBypassCode "电流计算"
        extends Modelica.Icons.Function;
        input Bjt in_p3 "输入记录Bjt";
        input BjtModelLineParams in_p 
          "带有Bjt模型线参数的输入记录";
        input BjtCalc in_c "输入记录BjtCalc";
        input SI.Voltage[6] in_m_pVoltageValues;
                                                   /* 1 Col; 2 Base; 3 Emit; 4 ColP; 5 BaseP; 6 EmitP */

        output CurrentsCapacitances out_cc 
          "带有计算出的电流和电容的输出记录";

      protected
        SI.Voltage vce;
        SI.Voltage vbe;
        SI.Voltage vbx;
        SI.Voltage vbc;
        SI.Conductance gbe;
       // SI.Current cbe;
        Real cbe;
        SI.Conductance gbc;
        SI.Current cbc;
        SI.Conductance gben;
        SI.Current cben;
        SI.Conductance gbcn;
        SI.Current cbcn;
        SI.Current cjbe;
        SI.Current cjbc;
        Real dqbdve;
        Real dqbdvc;
        Real qb;
        Real q1;
        Real q2;
        Real arg;
        Real sqarg;
        Real cc;
        SI.Current cex;
        SI.Conductance gex;
        SI.Time ttime;
        Real step;
        Real laststep;
        SI.Current bcex0;
        SI.Current bcex1;
        Real arg1;
        Real arg2;
        Real denom;
        Real arg3;
        Real rbpr;
        Real rbpi;
        Real gx;
        Real xjrb;
        Real go;
        Real gm;
        Types.Capacitance captt;
        SI.Charge chargebe;
        SI.Charge chargebc;
        SI.Charge chargebx;
        Real argtf;
        Real exponent;
        Real temp;

        Real aux1;
        Real aux2;
        SI.Charge chargecs;
        SI.Voltage vcs;
        Real sarg;

      algorithm
        temp := 0;

        vce := in_p.m_type * (in_m_pVoltageValues[4] - in_m_pVoltageValues[6]); // ( ColP, EmitP);
        vbe := in_p.m_type * (in_m_pVoltageValues[5] - in_m_pVoltageValues[6]); // ( BaseP, EmitP);
        vbx := in_p.m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( Base, ColP);

        if (in_p3.m_uic) then
          if (in_p3.m_bICvbeIsGiven > 0.5) then
            vbe := in_p.m_type * in_p3.m_dICvbe;
          end if;
          if (in_p3.m_bICvceIsGiven > 0.5) then
            vce := in_p.m_type * in_p3.m_dICvce;
          end if;
          vbx := vbe - vce;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          if (in_p3.m_bOff) then
            vbe := 0.0;
            vce := 0.0;
            vbx := 0.0;
          else
            vbe := in_c.m_tVcrit;
            vce := vbe;
            vbx := 0.0;
          end if;
        end if;

        vbc := vbe - vce;

        // 简并极间的电流
        (cbe,gbe,cben,gben) := Spice3.Internal.Functions.junction2SPICE3BJT(
            vbe, 
            in_p3.m_dTemp, 
            in_p.m_emissionCoeffF, 
            in_p.m_leakBEemissionCoeff, 
            in_c.m_tSatCur, 
            in_c.m_tBEleakCur);
        out_cc.iBE  := in_p.m_type * cbe / in_c.m_tBetaF;
        out_cc.iBEN := in_p.m_type * cben;
        (cbc,gbc,cbcn,gbcn) := Spice3.Internal.Functions.junction2SPICE3BJT(
            vbc, 
            in_p3.m_dTemp, 
            in_p.m_emissionCoeffR, 
            in_p.m_leakBCemissionCoeff, 
            in_c.m_tSatCur, 
            in_c.m_tBCleakCur);
        out_cc.iBC  := in_p.m_type * cbc / in_c.m_tBetaR;
        out_cc.iBCN := in_p.m_type * cbcn;
        cjbe        := cbe / in_c.m_tBetaF + cben;
        cjbc        := cbc / in_c.m_tBetaR + cbcn;

        // 确定基极电荷项
        q1 := 1.0/(1.0 - in_p.m_invEarlyVoltF * vbc - in_p.m_invEarlyVoltR * vbe);
        if (in_p.m_invRollOffF == 0 and in_p.m_invRollOffR == 0) then
          qb     := q1;
          dqbdve := q1*qb*in_p.m_invEarlyVoltR;
          dqbdvc := q1*qb*in_p.m_invEarlyVoltF;
        else
          q2    := in_p.m_invRollOffF*cbe + in_p.m_invRollOffR*cbc;
          arg   := max( 0.0, 1+4*q2);
          sqarg := 1;
          if (arg <> 0) then
            sqarg := sqrt(arg);
          end if;
          qb     := q1*(1+sqarg)/2;
          dqbdve := q1*(qb*in_p.m_invEarlyVoltR + in_p.m_invRollOffF*gbe/sqarg);
          dqbdvc := q1*(qb*in_p.m_invEarlyVoltF + in_p.m_invRollOffR*gbc/sqarg);
        end if;

        // 确定直流增量电导-威尔近似
        cc    := 0.0;
        cex   := cbe;
        gex   := gbe;
        ttime := 1;
        if ((in_p.m_excessPhaseFactor <> 0) and (ttime > 0.0)) then
          step     :=0;
          laststep :=1;
          bcex0    :=0;
          bcex1    :=0;
          if ( bcex1 == 0.0) then
               bcex1 := cbe / qb;
               bcex0 := bcex1;

          end if;
          arg1  := step / in_p.m_excessPhaseFactor;
          arg2  := 3 * arg1;
          arg1  := arg2 * arg1;
          denom := 1 + arg1 + arg2;
          arg3  := arg1 / denom;
          cc    := (bcex0 * (1 + step / laststep + arg2) - 
                   bcex1 * step / laststep) / denom;
          cex   := cbe * arg3;
          gex   := gbe * arg3;

        end if;
        cc := cc+(cex-cbc)/qb;

        // 电阻
        rbpr := in_p.m_minBaseResist / in_p3.m_area;
        rbpi := in_p.m_baseResist / in_p3.m_area-rbpr;
        gx   := rbpr + rbpi / qb;
        xjrb := in_p.m_baseCurrentHalfResist * in_p3.m_area;
        if (xjrb <> 0) then
          arg1 := max( (cjbe + cjbc) / xjrb, 1e-9);
          arg2 := (-1 + sqrt( 1 + 14.59025 * arg1)) / 2.4317 / sqrt( arg1); // z s. Gl. (11-44a)
          arg1 := tan(arg2);
          gx   := rbpr + 3 * rbpi * (arg1-arg2) / arg2 / arg1 / arg1;
        end if;
        // 如果 gx 用作顶层的电阻，则不需要 if-case！！！
        // -----------------------------------------------------------
        if (gx <> 0) then
          gx := 1 / gx;
        end if;
        out_cc.rx := gx;

        // 确定直流增量电导
        go := (gbc+(cex-cbc)*dqbdvc/qb)/qb;
        gm := (gex-(cex-cbc)*dqbdve/qb)/qb - go;
        out_cc.iCC := in_p.m_type * cc;

        // 电荷存储元件和传输时间计算
        captt := 0.0;
        if (in_p.m_transitTimeF <> 0.0 and vbe > 0.0) then
          argtf := 0.0;
          arg2  := 0.0;
          arg3  := 0.0;
          if (in_p.m_transitTimeBiasCoeffF <> 0.0) then
            argtf := in_p.m_transitTimeBiasCoeffF;
            if (in_p.m_transitTimeVBCFactor <> 0.0) then
              exponent := min( 50., vbc * in_p.m_transitTimeVBCFactor);
              argtf    := argtf * exp( exponent);
            end if;
              arg2 := argtf;
              if (in_p.m_transitTimeHighCurrentF <> 0) then
               temp := cbe / (cbe + in_p.m_transitTimeHighCurrentF);
                argtf := argtf * temp * temp;
                arg2  := argtf * (3-temp-temp);
              end if;
              arg3 := cbe * argtf * in_p.m_transitTimeVBCFactor;
          end if;
          cbe   := cbe * (1 + argtf) / qb;
          gbe   := (gbe * (1 + arg2) - cbe * dqbdve) / qb;
          captt := in_p.m_transitTimeF * (arg3 - cbe * dqbdvc) / qb;
        end if;
        out_cc.captt := captt; // (BaseP, ColP)

        (out_cc.capbe,chargebe) := Spice3.Internal.Functions.junctionCapTransTime(
            in_c.m_tBEcap, 
            vbe, 
            in_c.m_tDepCapBE, 
            in_p.m_junctionExpBE, 
            in_c.m_tBEpot, 
            in_c.m_tF1e, 
            in_c.m_f2e, 
            in_c.m_f3e, 
            in_p.m_transitTimeF, 
            gbe, 
            cbe);

        aux1 := in_c.m_tBCcap*in_p.m_baseFractionBCcap;
        (out_cc.capbc,chargebc) := Spice3.Internal.Functions.junctionCapTransTime(
            aux1, 
            vbc, 
            in_c.m_tDepCapBC, 
            in_p.m_junctionExpBC, 
            in_c.m_tBCpot, 
            in_c.m_tF1c, 
            in_c.m_f2c, 
            in_c.m_f3c, 
            in_p.m_transitTimeR, 
            gbc, 
            cbc);

        aux2:= in_c.m_tBCcap*(1. - in_p.m_baseFractionBCcap);
        (out_cc.capbx,chargebx) := Spice3.Internal.Functions.junctionCapRevised(
            aux2, 
            vbx, 
            in_c.m_tDepCapBC, 
            in_p.m_junctionExpBC, 
            in_c.m_tBCpot, 
            in_c.m_tF1c, 
            in_c.m_f2c, 
            in_c.m_f3c);

        out_cc.capcs := 0;
        chargecs := 0;
        vcs      := in_p.m_type * (0- in_m_pVoltageValues[4]); // ( Subst,  ColP);
        if (vcs < 0) then
          arg          := 1 - vcs / in_p.m_potentialSubstrate;
          sarg := exp(-in_p.m_exponentialSubstrate*Modelica.Math.log(
            arg));
          out_cc.capcs := in_p3.m_CScap * sarg;
          chargecs     := in_p.m_potentialSubstrate * in_p3.m_CScap * 
                         (1-arg*sarg)/(1-in_p.m_exponentialSubstrate);
        else
          out_cc.capcs := in_p3.m_CScap * (1 + in_p.m_exponentialSubstrate * vcs / in_p.m_potentialSubstrate);
          chargecs     := vcs * in_p3.m_CScap *(1+in_p.m_exponentialSubstrate*vcs/ 
                                       (2*in_p.m_potentialSubstrate));
        end if;

        // 过时 --> 为了向后兼容性

        out_cc.iXX :=1;

      annotation (smoothOrder(normallyConstant=in_p3)=1,Documentation(info="<html>
<p>此函数bjtNoBypassCode计算所需的电流(和电容)，
以便在顶层模型中使用这些电流。</p>
</html>"            ));
      end bjtNoBypassCode;

      function bjtRenameParameters "技术参数重命名"
        extends Modelica.Icons.Function;

        input Modelica.Electrical.Spice3.Internal.ModelcardBJT2 
                                           ex 
          "包含技术参数的模型卡片";
        input Real TBJT;

        output BjtModelLineParams intern 
          "带有Bjt模型线参数的输出记录";

      algorithm
        intern.m_minBaseResistIsGiven := 0;
        intern.m_collectorConduct := 0;
        intern.m_emitterConduct := 0;
        intern.m_transitTimeVBCFactor := 0;
        intern.m_excessPhaseFactor := 0;
        intern.m_invEarlyVoltF := 0;
        intern.m_invRollOffF := 0;
        intern.m_invEarlyVoltR := 0;
        intern.m_invRollOffR := 0;

      //已过时
        intern.m_bNPN := 1;
        intern.m_bPNP:=1;

        intern.m_area := 1.0;
        intern.m_bOff := false;
        intern.m_dICvbe := 0;
        intern.m_bICvbeIsGiven := 0;
        intern.m_dICvce := 0;
        intern.m_bICvceIsGiven := 0;
        intern.m_bSensArea := false;
        intern.m_dTemp := 1;

        intern.m_satCur := ex.IS;
        intern.m_betaF := ex.BF;
        intern.m_emissionCoeffF := ex.NF;
        intern.m_leakBEemissionCoeff := ex.NE;

        intern.m_leakBEcurrentIsGiven := if (ex.ISE > -1e40) then 1 else 0;
        intern.m_leakBEcurrent := if (ex.ISE > -1e40) then ex.ISE else 0;

        intern.m_c2IsGiven := if (ex.C2 > -1e40) then 1 else 0;
        intern.m_c2 := if (ex.C2 > -1e40) then ex.C2 else 0;

        intern.m_leakBCcurrentIsGiven := if (ex.ISC > -1e40) then 1 else 0;
        intern.m_leakBCcurrent := if (ex.ISC > -1e40) then ex.ISC else 0;

        intern.m_c4IsGiven := if (ex.C4 > -1e40) then 1 else 0;
        intern.m_c4 := if (ex.C4 > -1e40) then ex.C4 else 0;

        intern.m_betaR := ex. BR;
        intern.m_emissionCoeffR := ex.NR;
        intern.m_leakBCemissionCoeff := ex.NC;
        intern.m_earlyVoltF := ex.VAF;
        intern.m_rollOffF := ex.IKF;
        intern.m_earlyVoltR := ex.VAR;
        intern.m_rollOffR := ex.IKR;
        intern.m_emitterResist := ex.RE;
        intern.m_collectorResist := ex.RC;
        intern.m_baseCurrentHalfResist := ex.IRB;
        intern.m_baseResist := ex.RB;
        intern.m_minBaseResist := if (ex.RBM > -1e40) then ex.RBM else intern.m_baseResist;
        intern.m_depletionCapBE := ex.CJE;
        intern.m_potentialBE := ex.VJE;
        intern.m_junctionExpBE := ex.MJE;
        intern.m_transitTimeF := ex.TF;
        intern.m_transitTimeBiasCoeffF := ex.XTF;
        intern.m_transitTimeHighCurrentF := ex.ITF;
        intern.m_transitTimeFVBC :=ex.VTF;
        intern.m_excessPhase := ex.PTF;
        intern.m_depletionCapBC := ex.CJC;
        intern.m_potentialBC := ex.VJC;
        intern.m_junctionExpBC := ex.MJC;
        intern.m_baseFractionBCcap := ex.XCJC;
        intern.m_transitTimeR := ex.TR;
        intern.m_capCS := ex.CJS;
        intern.m_potentialSubstrate := ex.VJS;
        intern.m_exponentialSubstrate := ex.MJS;
        intern.m_betaExp := ex.XTB;
        intern.m_energyGap := ex.EG;
        intern.m_tempExpIS := ex.XTI;
        intern.m_fNcoef := ex.KF;
        intern.m_fNexp := ex.AF;
        intern.m_depletionCapCoeff := ex.FC;
        intern.m_tnom := ex.TNOM + Spice3.Internal.SpiceConstants.CONSTCtoK;

        intern.m_type := TBJT;

        annotation (Documentation(info="<html>
<p>此函数将外部(由用户提供的，例如IS)技术参数</p>
<p>分配给内部参数(例如m_satCur)。它还分析了IsGiven值。</p>
</html>"            ));
      end bjtRenameParameters;

      function bjtRenameParametersDev "温度计算"
        extends Modelica.Icons.Function;

        input Real AREA "面积因子";
        input Boolean OFF 
          "可选的初始条件：false-未使用 IC，true-使用IC，尚未实现";
        input SI.Voltage IC_VBE "初始条件值，尚未实现";
        input SI.Voltage IC_VCE "初始条件值，尚未实现";
        input Boolean UIC "使用初始条件，UIC";
        input Boolean SENS_AREA 
          "敏感性分析标志，尚未实现";
        input Modelica.Units.NonSI.Temperature_degC TEMP "温度";

        output Bjt dev "输出记录Bjt";

      algorithm
        dev.m_area := AREA;
        dev.m_bOff := OFF;

        dev.m_bICvbeIsGiven := if (IC_VBE > -1e40) then 1 else 0;
        dev.m_dICvbe := if (IC_VBE > -1e40) then IC_VBE else 0;

        dev.m_bICvceIsGiven := if (IC_VCE > -1e40) then 1 else 0;
        dev.m_dICvce := if (IC_VCE > -1e40) then IC_VCE else 0;

        dev.m_uic := UIC;
        dev.m_bSensArea := SENS_AREA;
        dev.m_dTemp := TEMP + Spice3.Internal.SpiceConstants.CONSTCtoK 
          "器件温度";

        dev.m_transitTimeHighCurrentF := 0;
       dev.m_invRollOffF := 0;
       dev.m_invRollOffR := 0;
       dev.m_CScap := 0;
        annotation (Documentation(info="<html>
<p>此函数将外部(由用户提供的，例如 AREA)设备参数</p>
<p>分配给内部参数(例如m_area)。它还分析了IsGiven值。</p>
</html>"            ));
      end bjtRenameParametersDev;
      annotation (Documentation(info="<html>
<p>此Bjt库包含Bjt双极晶体管模型的函数和记录数据。</p>
</html>"      ));


    end Bjt;

    package Fet"扩展内部库"
        extends Modelica.Icons.InternalPackage; // 扩展内部库

      record Fet "Fet参数记录"
        extends Modelica.Electrical.Spice3.Internal.Model.Model; // 扩展电气模型

        Real m_area(start = 1.0) "AREA，面积因子";
        Boolean m_off(start = false) "OFF，设备初始关闭";
        SI.Voltage m_dICVDS(start = 0.0) "IC_VDS";
        Real m_bICVDSIsGiven "IC_VDS，IsGivenValue";
        SI.Voltage m_dICVGS(start = 0.0) "IC_VGS";
        Real m_bICVGSIsGiven "IC_VGS，IsGivenValue";
        Boolean m_uic "使用初始条件，UIC";

        SI.Current m_tSatCur(start = 0);
        SI.Voltage m_tGatePot(start = 0);
        Types.Capacitance m_tCGS(start = 0);
        Types.Capacitance m_tCGD(start = 0);
        SI.Voltage m_corDepCap(start = 0);
        SI.Voltage m_vcrit(start = 0);
        SI.Voltage m_f1(start = 0);
        Real m_f2(start = 0);
        Real m_f3(start = 0);
        SI.Voltage m_dVt(start = 0);

        SI.Voltage m_vgs "Vgs，栅源电压";
        SI.Voltage m_vgd "Vgd，栅漏电压";
        SI.Voltage m_vds "Vds";
        SI.Current m_cgd "Igd";
        SI.Conductance m_ggd "Ggd";
        SI.Current m_cgs "Igs";
        SI.Conductance m_ggs "Ggs";
        SI.Charge m_chargegd "Qgd";
        Types.Capacitance m_capgd "Cgd，栅漏结电容";
        SI.Charge m_chargegs "Qgs";
        Types.Capacitance m_capgs "Cgs，栅源结电容";
        SI.Current m_cdrain "Idrain";
        SI.Conductance m_gm "Gm";
        SI.Conductance m_gds "Gds";
        annotation();

      end Fet;

      record FetModelLine "Fet模型线参数记录"
        extends Modelica.Icons.Record; // 扩展记录图标

        SI.Voltage m_threshold(start = -2.0) "VTO";
        Real m_beta(start = 1e-4) "BETA";
        SI.InversePotential m_lModulation(start = 0.0) "LAMBDA";
        SI.Resistance m_drainResist(start = 0.0) "RD";
        SI.Resistance m_sourceResist(start = 0) "RS";
        Types.Capacitance m_capGS(start = 0) "CGS";
        Types.Capacitance m_capGD(start = 0) "CGD";
        SI.Voltage m_gatePotential(start = 1.0) "PB";
        SI.Current m_gateSatCurrent(start = 1e-14) "IS";
        Real m_depletionCapCoeff(start = 0.5) "FC";
        Real m_b(start = 1.0) "B";
        Real m_fNcoef(start = 0.0) "KF";
        Real m_fNexp(start = 1.0) "AF";

        SI.Conductance m_drainConduct(start = 0);
        SI.Conductance m_sourceConduct(start = 0);
        SI.Temperature m_tnom(start=Modelica.Electrical.Spice3.Internal.SpiceConstants.CKTnomTemp) "TNOM";
        annotation();

      end FetModelLine;

      record CurrrentsCapacitances "电流和电容"
        extends Modelica.Icons.Record; // 扩展记录图标

        SI.Current idrain(start=0);
        SI.Current iGD(start=0);
        SI.Current iGS(start=0);
        Types.Capacitance cGS(start=0);
        Types.Capacitance cGD(start=0);

        annotation (Documentation(info="<html>
<p>CurrentsCapacities包含了Jfet模型内部的电流和电容的值。</p>
</html>"            ));
      end CurrrentsCapacitances;

    function fetRenameParametersDev 
        "设备参数重命名为内部名称"

    extends Modelica.Icons.Function; // 扩展函数图标

      input Real AREA "平行连接相同元素的数量";
      input Boolean OFF 
          "可选的初始条件：0-未使用IC，1-使用IC，尚未实现";
      input SI.Voltage IC_VDS 
          "初始条件值VDS，尚未实现";
      input SI.Voltage IC_VGS 
          "初始条件值VGS，尚未实现";
      input Boolean UIC "使用初始条件，UIC";
      input Modelica.Units.NonSI.Temperature_degC TEMP "温度";

      output Fet dev "输出记录MESFET";
      annotation();

    algorithm
      dev.m_capgd := 0;
      dev.m_capgs := 0;
      dev.m_cdrain := 0;
      dev.m_cgd := 0;
      dev.m_cgs := 0;
      dev.m_chargegd := 0;
      dev.m_chargegs := 0;
      dev.m_corDepCap := 0;
      dev.m_dVt := 0;
      dev.m_f1 := 0;
      dev.m_f2 := 0;
      dev.m_f3 := 0;
      dev.m_gds := 0;
      dev.m_ggd := 0;
      dev.m_ggs := 0;
      dev.m_gm := 0;
      dev.m_tCGD := 0;
      dev.m_tCGS := 0;
      dev.m_tGatePot := 0;
      dev.m_tSatCur := 0;
      dev.m_vcrit := 0;
      dev.m_vds := 0;
      dev.m_vgd := 0;
      dev.m_vgs := 0;

      dev.m_bICVDSIsGiven := if ( IC_VDS > -1e40) then 1 else 0;
      dev.m_dICVDS := if ( IC_VDS > -1e40) then IC_VDS else 0;

      dev.m_bICVGSIsGiven := if ( IC_VGS > -1e40) then 1 else 0;
      dev.m_dICVGS := if ( IC_VGS > -1e40) then IC_VGS else 0;

      dev.m_off   := OFF;           // 非零表示设备关闭以进行直流分析
      dev.m_uic   := UIC;
      dev.m_dTemp := TEMP + Modelica.Electrical.Spice3.Internal.SpiceConstants.CONSTCtoK;
      dev.m_area  := AREA;          // 平行连接相同元素的数量

    end fetRenameParametersDev;
      annotation();

    end Fet;

      package Jfet "Jfet的记录和函数"
          extends Modelica.Icons.InternalPackage; // 扩展模型图标为内部库


      record JfetModelLine "Jfet模型线参数的记录"
        extends Modelica.Electrical.Spice3.Internal.Fet.FetModelLine; // 继承自Fet模型线参数

        SI.InversePotential m_bFac; //逆电位
        annotation();
      end JfetModelLine;

        function jfetInitEquations "FET初始预计算"
        extends Modelica.Icons.Function; //扩展函数图标

          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f; // 输入FET参数
          input JfetModelLine in_fm; // 输入JfetModelLine参数

          output JfetModelLine out_fm; // 输出JfetModelLine参数
          annotation();

        algorithm
          out_fm := in_fm;

          out_fm.m_beta           := in_fm.m_beta * in_f.m_area; // beta 值
          out_fm.m_drainConduct   := in_fm.m_drainConduct * in_f.m_area; // 漏极导电
          out_fm.m_sourceConduct  := in_fm.m_sourceConduct * in_f.m_area; // 源极导电
          out_fm.m_gateSatCurrent := in_fm.m_gateSatCurrent * in_f.m_area; // 栅极饱和电流

        end jfetInitEquations;

        function jfetModelLineInitEquations "初始预计算"
        extends Modelica.Icons.Function; // 扩展函数图标

          input JfetModelLine in_fm; // 输入JfetModelLine参数

          output JfetModelLine out_fm; // 输出JfetModelLine参数
          annotation();

        algorithm
          out_fm := in_fm;

          // Fet_Model_Line::InitEquations();
          // 从FET.fetModelLineInitEquations复制算法而不是调用函数
          if (in_fm.m_drainResist <> 0) then // 如果漏极电阻不等于0
            out_fm.m_drainConduct := 1 / in_fm.m_drainResist; // 漏极导电
          end if;
          if (in_fm.m_sourceResist <> 0) then // 如果源极电阻不等于0
            out_fm.m_sourceConduct := 1 / in_fm.m_sourceResist; // 源极导电
          end if;

          if (out_fm.m_depletionCapCoeff > 0.95) then // 如果耗尽电容系数大于0.95
            out_fm.m_depletionCapCoeff := 0.95; // 耗尽电容系数
          end if;
          out_fm.m_bFac := (1 - out_fm.m_b) / (out_fm.m_gatePotential - out_fm.m_threshold); // 逆电位

        end jfetModelLineInitEquations;

        function drainCur "漏极电流计算"
        extends Modelica.Icons.Function; // 扩展函数图标

          input SI.Voltage vds; // 漏极-源极电压
          input SI.Voltage vgs; // 栅极-源极电压
          input SI.Voltage vgd; // 栅极-漏极电压

          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f; // 输入 FET 参数
          input JfetModelLine in_fm; // 输入 JfetModelLine 参数

          output Modelica.Electrical.Spice3.Internal.Fet.Fet out_f; // 输出 FET 参数

        protected
          SI.Voltage vto; // 阈值电压
          SI.Voltage vgst; // 栅-源电压
          Real betap; // beta值
          Real Bfac; // B系数
          Real apart; // 一部分
          Real cpart; // 一部分
          SI.Voltage vgdt; // 栅-漏电压
          annotation();

        algorithm
          out_f := in_f;

          // 悉尼大学JFET模型的修改
          vto := in_fm.m_threshold;

          if (vds >= 0) then // 如果漏极-源极电压大于等于0
            vgst := vgs - vto;
            // 计算正常模式下的漏极电流和导数
            if (vgst <= 0) then // 如果栅-源电压小于等于0
              // 正常模式，截止区
              out_f.m_cdrain := 0; // 漏极电流
              out_f.m_gm     := 0; // 转导
              out_f.m_gds    := 0; // 漏-源导纳
            else
              betap := in_fm.m_beta*(1 + in_fm.m_lModulation*vds);
              Bfac  := in_fm.m_bFac;
              if (vgst >= vds) then // 如果栅-源电压大于等于漏极-源极电压
                // 正常模式，线性区
                apart          := 2*in_fm.m_b + 3*Bfac*(vgst - vds);
                cpart          := vds*(vds*(Bfac*vds - in_fm.m_b)+vgst*apart);
                out_f.m_cdrain := betap*cpart;
                out_f.m_gm     := betap*vds*(apart + 3*Bfac*vgst);
                out_f.m_gds    := betap*(vgst - vds)*apart + in_fm.m_beta*in_fm.m_lModulation*cpart;
              else
                Bfac       := vgst*Bfac;
                out_f.m_gm := betap*vgst*(2*in_fm.m_b+3*Bfac);
                // 正常模式，饱和区
                cpart          := vgst*vgst*(in_fm.m_b+Bfac);
                out_f.m_cdrain := betap*cpart;
                out_f.m_gds    := in_fm.m_lModulation*in_fm.m_beta*cpart;
              end if;
            end if;
          else
            vgdt := vgd - vto;
            // 计算反向模式下的漏极电流和导数
            if (vgdt <= 0) then // 如果栅-漏电压小于等于0
              // 反向模式，截止区
              out_f.m_cdrain := 0; // 漏极电流
              out_f.m_gm     := 0; // 转导
              out_f.m_gds    := 0; // 漏-源导纳
            else
              betap := in_fm.m_beta*(1 - in_fm.m_lModulation*vds);
              Bfac  := in_fm.m_bFac;
              if (vgdt + vds >= 0) then // 如果栅-漏电压加上漏极-源极电压大于等于0
                // 反向模式，线性区
                apart := 2*in_fm.m_b + 3*Bfac*(vgdt + vds);
                cpart := vds*(-vds*(-Bfac*vds-in_fm.m_b)+vgdt*apart);
                out_f.m_cdrain := betap*cpart;
                out_f.m_gm     := betap*vds*(apart + 3*Bfac*vgdt);
                out_f.m_gds    := betap*(vgdt + vds)*apart - in_fm.m_beta*in_fm.m_lModulation*cpart - out_f.m_gm;
              else
                Bfac :=vgdt*Bfac;
                out_f.m_gm     := -betap*vgdt*(2*in_fm.m_b+3*Bfac);
                // 反向模式，饱和区
                cpart          := vgdt*vgdt*(in_fm.m_b+Bfac);
                out_f.m_cdrain := - betap*cpart;
                out_f.m_gds    := in_fm.m_lModulation*in_fm.m_beta*cpart - out_f.m_gm;
              end if;
            end if;
          end if;

        end drainCur;

        function calculateGateCap "栅极电容计算"
        extends Modelica.Icons.Function; // 扩展函数图标

          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f; // 输入 FET 参数
          input SI.Voltage vgs "输入电压 栅-源"; // 输入栅-源电压
          input SI.Voltage vgd "输入电压 栅-漏"; // 输入栅-漏电压

          output Types.Capacitance capgs "输出电容 栅-源"; // 输出栅-源电容
          output SI.Charge chargegs "输出电荷 栅-源"; // 输出栅-源电荷
          output Types.Capacitance capgd "输出电容 栅-漏"; // 输出栅-漏电容
          output SI.Charge chargegd "输出电荷 栅-漏"; // 输出栅-漏电荷
          annotation();

        algorithm
          (capgs,chargegs) := Modelica.Electrical.Spice3.Internal.Functions.junctionCapRevised(
                  in_f.m_tCGS, // 栅-源时间常数
                  vgs, // 栅-源电压
                  in_f.m_corDepCap, // 耗尽电容
                  0.5, // 系数
                  in_f.m_tGatePot, // 栅压
                  in_f.m_f1, // 系数
                  in_f.m_f2, // 系数
                  in_f.m_f3); // 系数
          (capgd,chargegd) := Modelica.Electrical.Spice3.Internal.Functions.junctionCapRevised(
                  in_f.m_tCGD, // 栅-漏时间常数
                  vgd, // 栅-漏电压
                  in_f.m_corDepCap, // 耗尽电容
                  0.5, // 系数
                  in_f.m_tGatePot, // 栅压
                  in_f.m_f1, // 系数
                  in_f.m_f2, // 系数
                  in_f.m_f3); // 系数

        end calculateGateCap;

        function jfetCalcTempDependencies 
        "与温度相关的预计算"
        extends Modelica.Icons.Function; // 扩展函数图标

          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f; // 输入FET参数
          input JfetModelLine in_fm; // 输入JfetModelLine参数

          output Modelica.Electrical.Spice3.Internal.Fet.Fet out_f; // 输出FET参数
          annotation();

        algorithm
          out_f := in_f;

          (out_f.m_tGatePot,out_f.m_tCGS) := 
            Modelica.Electrical.Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_fm.m_gatePotential, // 栅极电势
                  in_fm.m_capGS, // 栅-源电容
                  0.5, // 系数
                  out_f.m_dTemp, // 温度
                  in_fm.m_tnom); // 标称温度
          out_f.m_tCGS := out_f.m_area * out_f.m_tCGS; // 调整面积
          (out_f.m_tGatePot,out_f.m_tCGD) := 
            Modelica.Electrical.Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_fm.m_gatePotential, // 栅极电势
                  in_fm.m_capGD, // 栅-漏电容
                  0.5, // 系数
                  out_f.m_dTemp, // 温度
                  in_fm.m_tnom); // 标称温度
          out_f.m_tCGD := out_f.m_area * out_f.m_tCGD; // 调整面积
          (out_f.m_f1,out_f.m_f2,out_f.m_f3) := 
            Modelica.Electrical.Spice3.Internal.Functions.junctionCapCoeffs(
                  0.5, // 系数
                  in_fm.m_depletionCapCoeff, // 耗尽电容系数
                  out_f.m_tGatePot); // 栅极电势

          out_f.m_tSatCur := 
            Modelica.Electrical.Spice3.Internal.Functions.saturationCurDepTempSPICE3JFET(
                  in_fm.m_gateSatCurrent, // 栅-源电流
                  out_f.m_dTemp, // 温度
                  in_fm.m_tnom); // 标称温度
          out_f.m_vcrit := Modelica.Electrical.Spice3.Internal.Functions.junctionVCrit(
                  out_f.m_dTemp, // 温度
                  1.0, // 参数
                  out_f.m_tSatCur); // 饱和电流
          out_f.m_dVt := out_f.m_dTemp*Modelica.Electrical.Spice3.Internal.SpiceConstants.CONSTKoverQ; // Vt（温度）
          out_f.m_corDepCap := in_fm.m_depletionCapCoeff * out_f.m_tGatePot; // 耗尽电容

        end jfetCalcTempDependencies;

        function jfetNoBypassCode 
        "电流和电容的计算"
        extends Modelica.Icons.Function; // 扩展函数图标

          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f 
          "输入记录fet参数";
          input JfetModelLine in_fm "输入记录模型线参数";
          input Integer in_m_type "MOS 晶体管的类型";
          input Boolean in_m_bInit; // 是否初始化
          input SI.Voltage[3] in_m_pVoltageValues; // 栅极、漏极、源极

          output Modelica.Electrical.Spice3.Internal.Fet.CurrrentsCapacitances out_cc 
          "计算得到的电流和电容";

        protected
          Modelica.Electrical.Spice3.Internal.Fet.Fet int_f "记录 Fet";
          annotation();

        algorithm
          int_f := in_f;

          int_f.m_vgd := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[2]); // （G, DP）
          int_f.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[3]); // （G, SP）

          if (in_f.m_uic and int_f.m_bICVGSIsGiven > 0.5) then
            int_f.m_vgs := in_m_type * int_f.m_dICVGS;
          elseif (Modelica.Electrical.Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
            if (int_f.m_off == true) then
              int_f.m_vgs := 0;
            else
              int_f.m_vgs := int_f.m_vcrit;
            end if;
          end if;
          if (in_f.m_uic and int_f.m_bICVDSIsGiven > 0.5) then
            int_f.m_vgd := in_m_type * int_f.m_dICVDS + int_f.m_vgs;
          elseif (Modelica.Electrical.Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
            if (int_f.m_off == true) then
              int_f.m_vgd := 0;
            else
              int_f.m_vgd := int_f.m_vcrit;
            end if;
          end if;

          int_f.m_vgs := 
            Modelica.Electrical.Spice3.Internal.SpiceRoot.limitJunctionVoltageRevised(int_f.m_vgs);
          int_f.m_vgd := 
            Modelica.Electrical.Spice3.Internal.SpiceRoot.limitJunctionVoltageRevised(int_f.m_vgd);
          int_f.m_vds := int_f.m_vgs - int_f.m_vgd;

          //////////////////////////////////////////////////////////////////////
          // 节点电流
          (int_f.m_cgd,int_f.m_ggd) := 
            Modelica.Electrical.Spice3.Internal.Functions.junction2(
                  int_f.m_vgd, 
                  int_f.m_dTemp, 
                  1.0, 
                  int_f.m_tSatCur);
          out_cc.iGD := in_m_type * int_f.m_cgd;
          (int_f.m_cgs,int_f.m_ggs) := 
            Modelica.Electrical.Spice3.Internal.Functions.junction2(
                  int_f.m_vgs, 
                  int_f.m_dTemp, 
                  1.0, 
                  int_f.m_tSatCur);
          out_cc.iGS := in_m_type * int_f.m_cgs;

          //////////////////////////////////////////////////////////////////////
          // 通道电流计算
          // 由实际实例计算值
          int_f := drainCur(
                      int_f.m_vds, 
                      int_f.m_vgs, 
                      int_f.m_vgd, 
                      int_f, 
                      in_fm);
          out_cc.idrain := in_m_type * int_f.m_cdrain;

          //////////////////////////////////////////////////////////////////////
          // 通道电荷计算
          if (not in_m_bInit) then
            (int_f.m_capgs,int_f.m_chargegs,int_f.m_capgd,int_f.m_chargegd) 
              := calculateGateCap(
                        int_f, 
                        int_f.m_vgs, 
                        int_f.m_vgd);
            out_cc.cGD := if (in_m_bInit) then -1e40 else int_f.m_capgd;
            out_cc.cGS := if (in_m_bInit) then -1e40 else int_f.m_capgs;
          end if;

        end jfetNoBypassCode;

        function jfetRenameParameters "参数重命名为内部名称"
        extends Modelica.Icons.Function; // 扩展函数图标

          input Modelica.Electrical.Spice3.Internal.ModelcardJFET ex 
          "带有技术参数的模型卡";

          output JfetModelLine intern "输出记录模型线参数";

        algorithm
          intern.m_drainConduct := 0;
        intern.m_sourceConduct := 0;
        intern.m_bFac := 0;

          intern.m_capGS := if ( ex.CGS > -1e40) then ex.CGS else 0;
          // 零偏压 G-S 结电容，默认为 0
          intern.m_capGD := if ( ex.CGD > -1e40) then ex.CGD else 0;
          // 零偏压 G-D 结电容，默认为 0
          intern.m_gateSatCurrent := ex.IS;
          // pn 结的饱和电流
          intern.m_depletionCapCoeff := ex.FC;
          // 正向偏置耗尽电容公式的系数
          intern.m_drainResist := if ( ex.RD > -1e40) then ex.RD else 0;
          // 漏极欧姆电阻， 默认为 0
          intern.m_sourceResist := if ( ex.RS > -1e40) then ex.RS else 0;
          // 源极欧姆电阻，默认为 0
          intern.m_tnom := ex.TNOM + Modelica.Electrical.Spice3.Internal.SpiceConstants.CONSTCtoK;
          // 参数测量温度，默认为 27
          intern.m_threshold := if ( ex.VTO > -1e40) then ex.VTO else -2.0;
          // 零偏压阈值电压，默认为 -2
          intern.m_b := if ( ex.B > -1e40) then ex.B else 1.0;
          // 掺杂变化参数，默认为 1
          intern.m_beta := if ( ex.BETA > -1e40) then ex.BETA else 1e-4;
          // 输出导纳参数，默认为 1e4
          intern.m_lModulation := ex.LAMBDA;
          // 通道长度调制，默认为 0
          intern.m_gatePotential := ex.PB;
          // pn 结的结电位
          intern.m_fNexp := ex.AF;
          // 抖动噪声指数
          intern.m_fNcoef := ex.KF;
          // 抖动噪声系数

          annotation (Documentation(info="<html>
<p>该函数jfetRenameParameters将外部(由用户提供，例如RD)技术参数赋值给内部参数(例如 m_drainResistance)。
它还分析了IsGiven值。</p>
</html>"                ));
        end jfetRenameParameters;
        annotation();

      end Jfet;

      package Csemiconductor"半导体组件"
          extends Modelica.Icons.InternalPackage;
        record Capacitor"电容器"
          extends Modelica.Electrical.Spice3.Internal.Model.Model;

            Types.Capacitance m_dCapac(start=1e-9) "设备是电容器模型";
            Real m_dCapIsGiven "电容器给定的值";
            SI.Length  m_dWidth(start=0) "宽度";
            SI.Length  m_dLength(start=0) "长度";
            Boolean m_bSensCapac( start = false) 
          "请求关于电容器的灵敏度的标志";
          annotation();

        end Capacitor;

        record CapacitorModelLineParams 
        "电容器模型线参数的记录"
          extends Modelica.Icons.Record;

            SI.CapacitancePerArea m_dCj "结底电容";
            SI.Permittivity m_dCjsw "结旁电容";
            SI.Length  m_dDefW "默认设备宽度";
            SI.Length  m_dNarrow "由侧蚀窄化";
          annotation();

        end CapacitorModelLineParams;

        function capacitorInitEquations"电容器初始化方程"
        extends Modelica.Icons.Function;
          input Capacitor in_p "带有电容器参数的输入记录";
          input CapacitorModelLineParams in_p2 
          "带有电容器模型线参数的输入记录";

          output Capacitor out "带有电容器变量的输出记录";
          annotation();

        algorithm
          out := in_p;

          if (in_p.m_dCapIsGiven < 0.5) then
            if (abs(in_p.m_dLength)>1e-18 and abs(in_p2.m_dCj)>1e-25) then
              out.m_dCapac := Modelica.Electrical.Spice3.Internal.Functions.capDepGeom(
                      in_p2.m_dCj, 
                      in_p2.m_dCjsw, 
                      out.m_dWidth, 
                      in_p.m_dLength, 
                      in_p2.m_dNarrow);
            end if;
          end if;

        end capacitorInitEquations;

        function capacitorRenameParameters"对电容器的参数进行重命名操作"
        extends Modelica.Icons.Function;
          input Modelica.Electrical.Spice3.Internal.ModelcardC ex 
          "带有技术参数的模型卡";

          output CapacitorModelLineParams intern 
          "带有电容器模型线参数的输出记录";
          annotation();

        algorithm
          intern.m_dCj := ex.CJ;
          intern.m_dCjsw := ex.CJSW;
          intern.m_dDefW := ex.DEFW;
          intern.m_dNarrow := ex.NARROW;

        end capacitorRenameParameters;

        function capacitorRenameParametersDev"电容器参数重命名开发"
        extends Modelica.Icons.Function;
          input Types.Capacitance C "电容";
          input SI.Length  W "宽度";
          input SI.Length  L "长度";
          input Modelica.Units.NonSI.Temperature_degC TEMP "温度";
          input Boolean SENS_AREA 
          "用于灵敏度分析的参数，尚未实现";
          input CapacitorModelLineParams p;

          output Capacitor intern "带有电容器参数的输出记录";
          annotation();

        algorithm
          intern.m_dCapIsGiven := if (C > -1e40) then 1 else 0;
          intern.m_dCapac := if (C > -1e40) then C else 1e-9;

          intern.m_dWidth := if (W > -1e40) then W else p.m_dDefW;

          intern.m_dLength := L;
          intern.m_bSensCapac := SENS_AREA;
          intern.m_dTemp := TEMP + Modelica.Electrical.Spice3.Internal.SpiceConstants.CONSTCtoK;

        end capacitorRenameParametersDev;
        annotation();

      end Csemiconductor;
    annotation (Documentation(info="<html>
<p>Internal库包含了对Spice3模型必要的函数和辅助模型。该库不应该被Spice3库的用户使用。</p>


</html>"  ));
  end Internal;

    annotation (Documentation(info="<html>

<p>Spice3库包含电子模拟器SPICE3的模型。这些模型是通过重新编写SPICE3模型代码后转换为Modelica语言的。</p>

</p>

</html>"), Icon(graphics={
          Line(points={{-20,40},{-20,-40}}), 
          Line(points={{-90,0},{-20,0}}), 
          Line(points={{0,0},{90,0}}), 
          Line(points={{20,90},{20,40},{0,40},{0,-40},{20,-40},{20,-90}})}));
end Spice3;