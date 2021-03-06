<chart>
id=131251296077697333
symbol=XAUUSD
period=240
leftpos=2054
digits=2
scale=8
graph=2
fore=0
grid=0
volume=0
scroll=0
shift=1
ohlc=0
one_click=0
one_click_btn=1
askline=1
days=0
descriptions=0
shift_size=20
fixed_pos=0
window_left=104
window_top=104
window_right=1288
window_bottom=364
window_type=3
background_color=0
foreground_color=9470064
barup_color=65280
bardown_color=65280
bullcandle_color=0
bearcandle_color=16777215
chartline_color=4294967295
volumes_color=3329330
grid_color=10061943
askline_color=16443110
stops_color=255

<window>
height=172
fixed_height=0
<indicator>
name=main
<object>
type=23
object_name=mywebsite
period_flags=0
create_time=1480917596
description=Label
color=8421504
font=Arial
fontsize=10
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=200
y_distance=50
</object>
<object>
type=23
object_name=mysl
period_flags=0
create_time=1480917596
description=Stop Loss: 1177.63
color=255
font=Arial
fontsize=10
angle=0
anchor_pos=4
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=3
x_distance=2
y_distance=138
</object>
<object>
type=1
object_name=MarketPrice
period_flags=0
create_time=1480917596
color=17919
style=0
weight=1
background=0
filling=0
selectable=1
hidden=0
zorder=0
value_0=1177.300000
</object>
<object>
type=1
object_name=AvgBuyEntry
period_flags=0
create_time=1480917596
color=3329330
style=0
weight=1
background=0
filling=0
selectable=1
hidden=0
zorder=0
value_0=1176.510000
</object>
<object>
type=16
object_name=PipRectangle
period_flags=0
create_time=1480917596
color=9498256
style=0
weight=1
background=1
filling=0
selectable=1
hidden=0
zorder=0
time_0=1480914000
value_0=1176.510000
time_1=1481058000
value_1=1177.300000
ray=0
</object>
<object>
type=21
object_name=InfoString
period_flags=0
create_time=1480917596
description=1.58
color=8034025
font=Arial Black
fontsize=10
angle=0
anchor_pos=7
background=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1480986000
value_0=1176.955000
</object>
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\FL11
flags=275
window_num=0
<inputs>
Period1=12.0
Period2=34.0
Period3=69.0
Dev_Step_1=5,3
Dev_Step_2=5,3
Dev_Step_3=5,3
Symbol_1_Kod=172
Symbol_2_Kod=174
Symbol_3_Kod=82
_____=
Box_Alerts=false
Email_Alerts=false
Sound_Alerts=true
Alert_Lv1=false
Alert_Lv2=false
Alert_Lv3=true
</inputs>
</expert>
shift_0=0
draw_0=3
color_0=4294967295
style_0=0
weight_0=0
arrow_0=172
shift_1=0
draw_1=3
color_1=4294967295
style_1=0
weight_1=0
arrow_1=172
shift_2=0
draw_2=3
color_2=65535
style_2=0
weight_2=0
arrow_2=174
shift_3=0
draw_3=3
color_3=65535
style_3=0
weight_3=0
arrow_3=174
shift_4=0
draw_4=3
color_4=16748574
style_4=0
weight_4=3
arrow_4=82
shift_5=0
draw_5=3
color_5=255
style_5=0
weight_5=3
arrow_5=82
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\PBChannel
flags=275
window_num=0
<inputs>
TimeFrame=current time frame
HalfLength=50
Price=6
BandsDeviations=3.0
Interpolate=true
alertsOn=false
alertsOnCurrent=false
alertsOnHighLow=true
alertsMessage=true
alertsSound=false
alertsEmail=false
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=6908265
style_0=0
weight_0=0
shift_1=0
draw_1=0
color_1=255
style_1=0
weight_1=0
shift_2=0
draw_2=0
color_2=3329330
style_2=0
weight_2=0
shift_3=0
draw_3=3
color_3=16776960
style_3=242
weight_3=3
arrow_3=251
shift_4=0
draw_4=3
color_4=16711935
style_4=241
weight_4=3
arrow_4=251
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\FOREX STRATEGIST SR
flags=275
window_num=0
<inputs>
SR=3
SRZZ=12
MainRZZ=20
FP=21
SMF=3
DrawZZ=0
PriceConst=0
</inputs>
</expert>
shift_0=0
draw_0=3
color_0=16777215
style_0=0
weight_0=0
arrow_0=34
shift_1=0
draw_1=12
color_1=0
style_1=0
weight_1=0
shift_2=0
draw_2=12
color_2=0
style_2=0
weight_2=0
shift_3=0
draw_3=12
color_3=0
style_3=0
weight_3=0
shift_4=0
draw_4=3
color_4=65280
style_4=0
weight_4=0
arrow_4=59
shift_5=0
draw_5=3
color_5=255
style_5=0
weight_5=0
arrow_5=59
shift_6=0
draw_6=3
color_6=16777215
style_6=0
weight_6=0
arrow_6=59
shift_7=0
draw_7=3
color_7=65535
style_7=0
weight_7=0
arrow_7=59
period_flags=0
show_data=1
</indicator>
<indicator>
name=Ichimoku Kinko Hyo
tenkan=3
kijun=3
senkou=5
color=4294967295
style=0
weight=1
color2=4294967295
style2=0
weight2=1
color3=4294967295
style3=0
weight3=1
color4=12632256
style4=0
weight4=5
color5=12632256
style5=0
weight5=5
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\Doda-Donchian
flags=275
window_num=0
<inputs>
ChannelPeriod=28
EMAPeriod=120
StartEMAShift=6
EndEMAShift=0
AngleTreshold=0.32
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=4294967295
style_0=0
weight_0=0
shift_1=0
draw_1=0
color_1=4294967295
style_1=0
weight_1=0
shift_2=0
draw_2=0
color_2=255
style_2=2
weight_2=0
shift_3=0
draw_3=3
color_3=4294967295
style_3=0
weight_3=0
arrow_3=241
shift_4=0
draw_4=3
color_4=4294967295
style_4=0
weight_4=0
arrow_4=242
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\FL11
flags=275
window_num=0
<inputs>
Period1=12.0
Period2=34.0
Period3=69.0
Dev_Step_1=5,3
Dev_Step_2=5,3
Dev_Step_3=5,3
Symbol_1_Kod=172
Symbol_2_Kod=174
Symbol_3_Kod=82
_____=
Box_Alerts=false
Email_Alerts=false
Sound_Alerts=true
Alert_Lv1=false
Alert_Lv2=false
Alert_Lv3=true
</inputs>
</expert>
shift_0=0
draw_0=3
color_0=4294967295
style_0=0
weight_0=0
arrow_0=172
shift_1=0
draw_1=3
color_1=4294967295
style_1=0
weight_1=0
arrow_1=172
shift_2=0
draw_2=3
color_2=65535
style_2=0
weight_2=0
arrow_2=174
shift_3=0
draw_3=3
color_3=65535
style_3=0
weight_3=0
arrow_3=174
shift_4=0
draw_4=3
color_4=16748574
style_4=0
weight_4=0
arrow_4=82
shift_5=0
draw_5=3
color_5=255
style_5=0
weight_5=0
arrow_5=82
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\Heiken_Ashi
flags=275
window_num=0
<inputs>
ExtColor1=255
ExtColor2=16777215
ExtColor3=255
ExtColor4=16777215
</inputs>
</expert>
shift_0=0
draw_0=2
color_0=255
style_0=0
weight_0=1
shift_1=0
draw_1=2
color_1=16777215
style_1=0
weight_1=1
shift_2=0
draw_2=2
color_2=255
style_2=0
weight_2=3
shift_3=0
draw_3=2
color_3=16777215
style_3=0
weight_3=3
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\Show_AverageEntryPrice_v1
flags=275
window_num=0
<inputs>
ShowMarketPrice=1
ColorMarketPrice=17919
ShowAvgEntryPrice=1
ColorAvgBuyEntry=3329330
ColorAvgSellEntry=42495
ShowStopLoss=0
RiskFactor=5.00000000
ColorBuyStopLoss=16760576
ColorSellStopLoss=8421616
SwapColorLong=65280
SwapColorShort=255
ShowProfit=1
FontName=Arial Black
FontSize=10
ColorProfit=8034025
ShowLineLabels=0
ShowSwapInfo=0
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=0
style_0=0
weight_0=0
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=50
fixed_height=0
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\Solar Winds joy - histo (no repaint with alert)
flags=275
window_num=1
<inputs>
period=25
smooth=10
DoAlert=true
alertMail=false
</inputs>
</expert>
shift_0=0
draw_0=2
color_0=3329330
style_0=0
weight_0=0
shift_1=0
draw_1=2
color_1=255
style_1=0
weight_1=0
shift_2=0
draw_2=0
color_2=55295
style_2=0
weight_2=2
shift_3=0
draw_3=0
color_3=3329330
style_3=0
weight_3=2
shift_4=0
draw_4=0
color_4=255
style_4=0
weight_4=2
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TradingSystem\Renko-SignalAM
flags=275
window_num=1
<inputs>
FS30Range=5
FilterPeriod=17
MartFiltr=2.0
PriceConst=6
MaPeriod=5
MaMode=3
LevelsCross=0.95
Countbars=300
AlertOn=true
ArrowUp=108
ArrowDown=108
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=65535
style_0=0
weight_0=0
shift_1=0
draw_1=0
color_1=255
style_1=0
weight_1=0
shift_2=0
draw_2=3
color_2=16760576
style_2=0
weight_2=0
arrow_2=108
shift_3=0
draw_3=3
color_3=255
style_3=0
weight_3=0
arrow_3=108
shift_4=0
draw_4=3
color_4=16777215
style_4=0
weight_4=0
arrow_4=251
shift_5=0
draw_5=3
color_5=16777215
style_5=0
weight_5=0
arrow_5=251
min=-1.10000000
max=1.10000000
levels_color=12632256
levels_style=2
levels_weight=1
level_0=0.95000000
level_1=-0.95000000
level_2=0.00000000
period_flags=0
show_data=1
</indicator>
</window>
</chart>

