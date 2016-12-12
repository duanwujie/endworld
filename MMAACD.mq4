
#property copyright   "duanwujie(QQ 917357635)"
#property link        "dhacklove@163.com"
#property description "MMAACD"
#property strict


#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 Yellow
#property indicator_width1 2
#property indicator_width2 2

input string WorkedTimeframe ="-------------------------";//----The Timeframe Parameters-----
input int    ExtWorkedTimeFrame = PERIOD_H1;//The Worked timeframe

input string MAParameters = "-------------------------";//----The MoveAverage Parameters-----
input int    ExtShortMa   = 50;//The short Ma Peroid
input int    ExtLongMa    = 100;//The Long Ma Peroid
input string MxtMacdParameters = "-------------------------";//----The MACD Parameters-----
input int    ExtFastEma    = 12;//The MACD Fast Peroid
input int    ExtSlowEma    = 26;//The MACD Slow Peroid
input int    ExtSignalDiff = 9;//The MACD Signal Peroid
input int    ExtMACDBars   = 5;//The MACD Bars Count
input string WaringParameters = "-------------------------";//----The Waring Parameters-----
input bool   ExtMailNotice  = false;//Is Send Mail ?
input bool   ExtSoundNotice = false;//Is Send Sound ?
input string ExtTradingParameters ="-------------------------";//----The Trading Parameters----
input int    ExtStopLoss    = 50;//The Stoploss(pips)
input int    ExtTakeprofit  = 100;//The Takeprofit(pips)
input int    ExtTraingStop  = 30;//The Training stop(pips)

input int  ExtPipsRange   = 10;
input bool ExtExhaustion = false;

int    ExtMACDSignal = 0;
double ExtUpperBuffer[];
double ExtLowerBuffer[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(void) 
{
    //--- 1 additional buffer used for counting.
    IndicatorBuffers(2);
    IndicatorDigits(Digits);

    SetIndexStyle(0, DRAW_ARROW);
    SetIndexBuffer(0, ExtUpperBuffer);
    SetIndexStyle(1, DRAW_ARROW);
    SetIndexBuffer(1, ExtLowerBuffer);

    SetIndexArrow(0, 217);
    SetIndexArrow(1, 218);
    SetIndexDrawBegin(0, ExtLongMa);
    SetIndexDrawBegin(1, ExtLongMa);


    return (INIT_SUCCEEDED);
}


 
 
 
 
 
 int Cross(double c1, double c2, double p1, double p2) 
 {
     if (c1 > c2 && p1 < p2)
         return 1;
     if (c1 < c2 && p1 > p2)
         return -1;
     return 0;
 }
 
 
int MacdLevelsUp(int shift, int range) 
{
    int levels = 0;
    int i = 0;
    for (i = shift; i <= shift + range; i++) {
        if (iMACD(NULL, ExtWorkedTimeFrame, ExtFastEma, ExtSlowEma, ExtSignalDiff, PRICE_CLOSE, ExtMACDSignal, i) > 0) {
            levels++;
        }
    }
    double last = iMACD(NULL, ExtWorkedTimeFrame, ExtFastEma, ExtSlowEma, ExtSignalDiff, PRICE_CLOSE, ExtMACDSignal, i);

    if (levels == range && last < 0)
        return 1;
    return 0;
}

int MacdLevelsDown(int shift,int range)
{
   int levels = 0;
   int i = 0;
   for(i = shift;i<=shift+range;i++)
   {
      if(iMACD(NULL,ExtWorkedTimeFrame,ExtFastEma,ExtSlowEma,ExtSignalDiff,PRICE_CLOSE,ExtMACDSignal,i)<0)
      {
         levels++;
      }
   }
   double last  = iMACD(NULL,ExtWorkedTimeFrame,ExtFastEma,ExtSlowEma,ExtSignalDiff,PRICE_CLOSE,ExtMACDSignal,i);
   if(levels == range && last > 0)
      return 1;
   return 0;
}


int second_direction  = 0;
int first_direction = 0;
 
int start() 
{
    int counted_bars = IndicatorCounted();
    int shift, limit;
    if (counted_bars > 0) 
      counted_bars--;
    limit = Bars - counted_bars;

    //--- main cycle
    for (shift = limit - ExtLongMa; shift >= 0 && !IsStopped(); shift--) {
        ExtUpperBuffer[shift] = EMPTY_VALUE;
        ExtLowerBuffer[shift] = EMPTY_VALUE;
        double current_ma50 = iMA(NULL, ExtWorkedTimeFrame, ExtShortMa, 0, MODE_SMA, PRICE_CLOSE, shift);
        double current_ma100 = iMA(NULL, ExtWorkedTimeFrame, ExtLongMa, 0, MODE_SMA, PRICE_CLOSE, shift);
        double previous_ma50 = iMA(NULL, ExtWorkedTimeFrame, ExtShortMa, 0, MODE_SMA, PRICE_CLOSE, shift + 1);
        double previous_ma100 = iMA(NULL, ExtWorkedTimeFrame, ExtLongMa, 0, MODE_SMA, PRICE_CLOSE, shift + 1);
        double close = iMA(NULL, ExtWorkedTimeFrame, 1, 0, MODE_SMA, PRICE_CLOSE, shift);
        if (Cross(current_ma50, current_ma100, previous_ma50, previous_ma100) > 0) {
            first_direction = 1;
            // ExtUpperBuffer[shift]=Close[shift];
        }
        if (Cross(current_ma50, current_ma100, previous_ma50, previous_ma100) < 0) {
            first_direction = -1;
            // ExtLowerBuffer[shift] = Close[shift];
        }
        if (MacdLevelsUp(shift, ExtMACDBars)) {
            second_direction = Cross(current_ma50, current_ma50, previous_ma50, previous_ma100);
            if (second_direction == 0 && close > current_ma50 && current_ma50 > previous_ma100 && first_direction > 0) {
                //buy occur
                ExtUpperBuffer[shift] = Close[shift];
            }
        }
        if (MacdLevelsDown(shift, ExtMACDBars)) {
            second_direction = Cross(current_ma50, current_ma50, previous_ma50, previous_ma100);
            if (second_direction == 0 && close < current_ma50 && current_ma50 < previous_ma100 && first_direction < 0) {
                ExtLowerBuffer[shift] = Close[shift];
            }
        }
    }
    return (0);
}










  
  
  
 
 

 