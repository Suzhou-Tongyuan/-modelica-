within Modelica.Electrical.Machines.Utilities;
record DcBrakeSettings "用于直流电流制动的设置"
  parameter SI.Current INominal=100 "每相额定有效值电流";
  parameter String layout="Y3" "制动连接布局" 
    annotation (choices(
      choice="Y3" "Y3相", 
      choice="Y2" "Y2相", 
      choice="D2" "D2相", 
      choice="D3" "D3相"));
  parameter String terminalConnection= 
    if layout=="Y3" or layout=="Y2" then "Y" else "D" "端子连接" 
    annotation(Dialog(group="Results", enable=false));
  parameter Boolean connect3= 
    layout=="Y3" or layout=="D3" "连接第3个端子" 
    annotation(Dialog(group="Results", enable=false));
  parameter SI.Current Idc= 
    if     layout=="Y3" then INominal*sqrt(2) 
    elseif layout=="Y2" then INominal*sqrt(3/2) 
    elseif layout=="D2" then INominal*3/sqrt(2) 
    else                     INominal*sqrt(6) 
    "直流制动电流" annotation(Dialog(group="Results", enable=false));
  parameter SI.Current is[3]= 
    if     layout=="Y3" then Idc*{1,-1/2,-1/2} 
    elseif layout=="Y2" then Idc*{1,-1,0} 
    elseif layout=="D2" then Idc*{2/3,-1/3,-1/3} 
    else                     Idc*{1/2,-1/2,0} 
    "相电流" annotation(Dialog(group="Results", enable=false));
   annotation (defaultComponentPrefixes="parameter", 
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}}, 
        lineColor={0,0,127}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
        Text(
          extent={{-50,40},{0,10}}, 
          textColor={0,0,0}, 
          lineThickness=0.5, 
          textString="Y3"), 
        Text(
          extent={{-50,-60},{0,-90}}, 
          textColor={0,0,0}, 
          lineThickness=0.5, 
          textString="Y2"), 
        Text(
          extent={{0,40},{50,10}}, 
          textColor={0,0,0}, 
          lineThickness=0.5, 
          textString="D2"), 
        Text(
          extent={{0,-60},{50,-90}}, 
          textColor={0,0,0}, 
          lineThickness=0.5, 
          textString="D3"),             Text(
        extent={{-150,150},{150,110}}, 
        textString="%name", 
        textColor={0,0,255}), 
        Text(
          extent={{-150,-150},{150,-110}}, 
          textColor={0,0,0}, 
          textString="%layout"), 
        Line(
          points={{80,80},{80,20}}, 
          color={0,0,0}, 
          thickness=0.5), 
        Line(
          points={{0,30},{0,-30}}, 
          color={0,0,0}, 
          origin={54,65}, 
          rotation=120), 
        Line(
          points={{0,30},{0,-30}}, 
          color={0,0,0}, 
          origin={54,35}, 
          rotation=240), 
        Line(
          points={{80,80},{98,80}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{80,20},{98,20}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{0,30},{0,-30}}, 
          color={0,0,0}, 
          origin={54,-35}, 
          rotation=120, 
          pattern=LinePattern.Dash), 
        Line(
          points={{0,30},{0,-30}}, 
          color={0,0,0}, 
          thickness=0.5, 
          origin={54,-65}, 
          rotation=240), 
        Line(
          points={{80,-20},{80,-80}}, 
          color={0,0,0}, 
          thickness=0.5), 
        Line(
          points={{80,-80},{98,-80}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{80,-20},{98,-20}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{28,-50},{28,-20},{80,-20}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{-50,60},{-50,20}}, 
          color={0,0,0}, 
          thickness=0.5), 
        Line(
          points={{0,20},{0,-20}}, 
          color={0,0,0}, 
          origin={-33,70}, 
          rotation=120), 
        Line(
          points={{0,20},{0,-20}}, 
          color={0,0,0}, 
          origin={-67,70}, 
          rotation=240), 
        Line(
          points={{-84,80},{-16,80}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{-98,80},{-84,80}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{-98,20},{-50,20}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{0,20},{0,-20}}, 
          color={0,0,0}, 
          thickness=0.5, 
          origin={-67,-30}, 
          rotation=240), 
        Line(
          points={{-50,-40},{-50,-80}}, 
          color={0,0,0}, 
          thickness=0.5), 
        Line(
          points={{0,20},{0,-20}}, 
          color={0,0,0}, 
          origin={-33,-30}, 
          rotation=120, 
          pattern=LinePattern.Dash), 
        Line(
          points={{-98,-20},{-84,-20}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Line(
          points={{-98,-80},{-50,-80}}, 
          color={238,46,47}, 
          thickness=0.5), 
        Ellipse(
          extent={{-100,82},{-96,78}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5), 
        Ellipse(
          extent={{-100,22},{-96,18}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5), 
        Ellipse(
          extent={{-100,-18},{-96,-22}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5), 
        Ellipse(
          extent={{-100,-78},{-96,-82}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5), 
        Ellipse(
          extent={{96,-78},{100,-82}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5), 
        Ellipse(
          extent={{96,-18},{100,-22}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5), 
        Ellipse(
          extent={{96,22},{100,18}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5), 
        Ellipse(
          extent={{96,82},{100,78}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5)}), 
    Documentation(info="<html>
<p>
让用户选择布局，并确定感应电机的直流电流制动所需的直流电流。
</p>
<p>
图标显示了四种布局变体。
半电流的相用半线宽表示，
零电流的相用虚线表示。
</p>
</html>"));
end DcBrakeSettings;