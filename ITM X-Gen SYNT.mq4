#property copyright "ITM Financial, 2012"
#property link      "support@forexsocialsignals.com"

#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 Gold
#property indicator_style1 1
#property indicator_color2 Magenta
#property indicator_style2 2
#property indicator_color3 DodgerBlue
#property indicator_style3 2
#property indicator_color4 Aqua
#property indicator_width4 3
#property indicator_color5 Magenta
#property indicator_width5 3

extern string TimeFrame = "Do Not Change Anything";
extern bool AlertOnTradeSignal = TRUE;
extern  bool Alert_1=true; // алерты о стрелке на первом баре
extern  bool Alert_0=false; // алерты о стрелке на нулевом баре
int HalfLength = 56;
int g_applied_price_92 = PRICE_WEIGHTED;
double gd_96 = 2.5;
bool gi_104 = TRUE;
bool gi_108 = FALSE;
bool gi_112 = FALSE;
bool g_bool_116 = FALSE;
bool gi_120 = FALSE;
bool gi_124 = FALSE;
bool gi_128 = FALSE;
double tmBuffer[];
double gda_unused_136[];
double upBuffer[];
double dnBuffer[];
double wuBuffer[];
double wdBuffer[];
double upArrow[];
double dnArrow[];
string IndicatorFileName;
string gs_172;
string gs_dummy_180;
bool calculatingTma = FALSE;
bool returningBars = FALSE;
int timeFrame;
extern int BrokerDigits = 5;
string gs_204 = "";
datetime g_time_212;

int init() {
   g_bool_116 = AlertOnTradeSignal;
   timeFrame = f0_1(TimeFrame);
   HalfLength = MathMax(HalfLength, 1);
   IndicatorBuffers(7);
   SetIndexBuffer(0, tmBuffer);
   SetIndexDrawBegin(0, HalfLength);
   SetIndexBuffer(1, upBuffer);
   SetIndexDrawBegin(1, HalfLength);
   SetIndexBuffer(2, dnBuffer);
   SetIndexDrawBegin(2, HalfLength);
   SetIndexBuffer(3, dnArrow);
   SetIndexStyle(3, DRAW_ARROW);
   SetIndexArrow(4, SYMBOL_ARROWDOWN);
   SetIndexBuffer(4, upArrow);
   SetIndexStyle(4, DRAW_ARROW);
   SetIndexArrow(3, SYMBOL_ARROWUP);
   SetIndexBuffer(5, wuBuffer);
   SetIndexBuffer(6, wdBuffer);
   if (TimeFrame == "calculateTma") {
      calculatingTma = TRUE;
      return (0);
   }
   if (TimeFrame == "returnBars") {
      returningBars = TRUE;
      return (0);
   }
   IndicatorFileName = WindowExpertName();
   return (0);
}


int deinit() {
   return (0);
}

int start() {
   string ls_0;
   int li_8;
   int limit;
   int shift1;
   int time1;
   double factor;
   int e;
   if (Period() > PERIOD_M1) {
      if (tmBuffer[1] < tmBuffer[2]) gs_172 = "SHORT\n\n-------------------------------------------\n** IMPORTANT ADVICE **\n-------------------------------------------\n1) DO NOT Enter LONG Trades.\n2) ENTER Trade AFTER DOWN (BLUE) Arrows on the previous few bars, AND if the Chart Market Direction is SHORT";
      else {
         if (tmBuffer[1] > tmBuffer[2]) gs_172 = "LONG\n\n-------------------------------------------\n** IMPORTANT ADVICE **\n-------------------------------------------\n1) DO NOT Enter SHORT Trades.\n2) ENTER Trade AFTER UP (RED) Arrows on the previous few bars, AND if the Chart Market Direction is LONG!";
         else gs_172 = "Unknown / Possibly in Whipsaw Mode";
      }
 
      li_8 = IndicatorCounted();
      if (li_8 < 0) return (-1);
      if (li_8 > 0) li_8--;
      limit = MathMin(Bars - 1, Bars - li_8 + HalfLength);
      if (returningBars) {
         tmBuffer[0] = limit;
         return (0);
      }
      if (calculatingTma) {
         f0_3(limit);
         return (0);
      }
      if (timeFrame == Period()) limit = MathMax(limit, MathMin(Bars - 1, iCustom(NULL, timeFrame, IndicatorFileName, "returnBars", 0, 0) * timeFrame / Period()));
      for (int i = limit; i >= 0; i--) {
         shift1 = iBarShift(NULL, timeFrame, Time[i]);
         time1 = iTime(NULL, timeFrame, shift1);
         tmBuffer[i] = iCustom(NULL, timeFrame, IndicatorFileName, "calculateTma", 0, shift1);
         upBuffer[i] = iCustom(NULL, timeFrame, IndicatorFileName, "calculateTma", 1, shift1);
         dnBuffer[i] = iCustom(NULL, timeFrame, IndicatorFileName, "calculateTma", 2, shift1);
         upArrow[i] = EMPTY_VALUE;
         dnArrow[i] = EMPTY_VALUE;
         if (High[i + 1] > upBuffer[i + 1] && Close[i + 1] > Open[i + 1] && Close[i] < Open[i]) upArrow[i] = High[i] + iATR(NULL, 0, 20, i);
         if (Low[i + 1] < dnBuffer[i + 1] && Close[i + 1] < Open[i + 1] && Close[i] > Open[i]) dnArrow[i] = Low[i] - iATR(NULL, 0, 20, i);
         if (timeFrame <= Period() || shift1 == iBarShift(NULL, timeFrame, Time[i - 1])) continue;
         if (gi_104) {
            for (int n = 1; i + n < Bars && Time[i + n] >= time1; n++) {
            }
            factor = 1.0 / n;
            for (int a = 1; a < n; a++) {
               tmBuffer[i + a] = a * factor * (tmBuffer[i + n]) + (1.0 - a * factor) * tmBuffer[i];
               upBuffer[i + a] = a * factor * (upBuffer[i + n]) + (1.0 - a * factor) * upBuffer[i];
               dnBuffer[i + a] = a * factor * (dnBuffer[i + n]) + (1.0 - a * factor) * dnBuffer[i];
            }
         }
      }
      if (!(gi_108)) return (0);
      if (gi_112) e = 0;
      else e = 1;
      if (g_bool_116) {
         if (High[e] > upBuffer[e] && High[e + 1] < upBuffer[e + 1]) doAlert("ALERT: Upper Sentiment Band Broken by CURRENT HIGH!");
         if (Low[e] < dnBuffer[e] && Low[e + 1] > dnBuffer[e + 1]) doAlert("ALERT: Lower Sentiment Band Broken by CURRENT LOW!");
      } else {
         if (Close[e] > upBuffer[e] && Close[e + 1] < upBuffer[e + 1]) doAlert("ALERT: Upper Sentiment Band Broken by CURRENT CLOSE!");
         if (Close[e] < dnBuffer[e] && Close[e + 1] > dnBuffer[e + 1]) doAlert("ALERT: Lower Sentiment Band Broken by CURRENT CLOSE!");
      }
            	   if(Alert_1){
      if(Close[e + 1] > upBuffer[e + 1] && Close[e + 2] < upBuffer[e + 2]){
         static int lt1=0;
            if(lt1!=Time[0]){
               lt1=Time[0];
               Alert("ITM ("+Symbol()+","+fTimeFrameName(Period())+"): SELL (Bar 1), Bid="+DS(Bid));
            }
      }
      if(Close[e + 1] < dnBuffer[e + 1] && Close[e + 2] > dnBuffer[e + 2]){
         static int lt2=0;
            if(lt2!=Time[0]){
               lt2=Time[0];
               Alert("ITM ("+Symbol()+","+fTimeFrameName(Period())+"): BUY (Bar 1), Bid="+DS(Bid));
            }         
      }      
   }
   if(Alert_0){
      if(Close[e] > upBuffer[e] && Close[e + 1] < upBuffer[e + 1]){
         static int lt3=0;
            if(lt3!=Time[0]){
               lt3=Time[0];
               Alert("ITM ("+Symbol()+","+fTimeFrameName(Period())+"): SELL (Bar 0), Bid="+DS(Bid));
            }            
      }
      if(Close[e] < dnBuffer[e] && Close[e + 1] > dnBuffer[e + 1]){
         static int lt4=0;
            if(lt4!=Time[0]){
               lt4=Time[0];
               Alert("ITM ("+Symbol()+","+fTimeFrameName(Period())+"): BUY (Bar 0), Bid="+DS(Bid));
            }          
      }     
   }      
      return (0);
   }

   return (0);
}

void f0_3(int ai_0) {
   int li_8;
   double ld_24;
   double factor;
   double ld_40;
   double ld_16 = 2.0 * HalfLength + 1.0;
   for (int li_4 = ai_0; li_4 >= 0; li_4--) {
      ld_24 = (HalfLength + 1) * iMA(NULL, 0, 1, 0, MODE_SMA, g_applied_price_92, li_4);
      factor = HalfLength + 1;
      li_8 = 1;
      for (int i = HalfLength; li_8 <= HalfLength; i--) {
         ld_24 += i * iMA(NULL, 0, 1, 0, MODE_SMA, g_applied_price_92, li_4 + li_8);
         factor += i;
         if (li_8 <= li_4) {
            ld_24 += i * iMA(NULL, 0, 1, 0, MODE_SMA, g_applied_price_92, li_4 - li_8);
            factor += i;
         }
         li_8++;
      }
      tmBuffer[li_4] = ld_24 / factor;
      ld_40 = iMA(NULL, 0, 1, 0, MODE_SMA, g_applied_price_92, li_4) - tmBuffer[li_4];
      if (li_4 <= Bars - HalfLength - 1) {
         if (li_4 == Bars - HalfLength - 1) {
            upBuffer[li_4] = tmBuffer[li_4];
            dnBuffer[li_4] = tmBuffer[li_4];
            if (ld_40 >= 0.0) {
               wuBuffer[li_4] = MathPow(ld_40, 2);
               wdBuffer[li_4] = 0;
               continue;
            }
            wdBuffer[li_4] = MathPow(ld_40, 2);
            wuBuffer[li_4] = 0;
            continue;
         }
         if (ld_40 >= 0.0) {
            wuBuffer[li_4] = ((wuBuffer[li_4 + 1]) * (ld_16 - 1.0) + MathPow(ld_40, 2)) / ld_16;
            wdBuffer[li_4] = (wdBuffer[li_4 + 1]) * (ld_16 - 1.0) / ld_16;
         } else {
            wdBuffer[li_4] = ((wdBuffer[li_4 + 1]) * (ld_16 - 1.0) + MathPow(ld_40, 2)) / ld_16;
            wuBuffer[li_4] = (wuBuffer[li_4 + 1]) * (ld_16 - 1.0) / ld_16;
         }
         upBuffer[li_4] = tmBuffer[li_4] + gd_96 * MathSqrt(wuBuffer[li_4]);
         dnBuffer[li_4] = tmBuffer[li_4] - gd_96 * MathSqrt(wdBuffer[li_4]);
      }
   }
}

void doAlert(string as_0) {
   string str_concat_8;
   if (gs_204 != as_0 || g_time_212 != Time[0]) {
      gs_204 = as_0;
      g_time_212 = Time[0];
      str_concat_8 = StringConcatenate(Symbol(), " at ", TimeToStr(TimeLocal(), TIME_SECONDS), " ITM : ", as_0);
      if (gi_120) Alert(str_concat_8);
      if (gi_128) SendMail(StringConcatenate(Symbol(), "ITM "), str_concat_8);
      if (gi_124) PlaySound("alert2.wav");
   }
}

int f0_1(string as_0) {
   int i;
   for (int li_8 = StringLen(as_0) - 1; li_8 >= 0; li_8--) {
      i = StringGetChar(as_0, li_8);
      if ((i > '`' && i < '{') || (i > 'Я' && i < 256)) as_0 = StringSetChar(as_0, 1, i - 32);
      else
         if (i > -33 && i < 0) as_0 = StringSetChar(as_0, 1, i + 224);
   }
   int timeframe_16 = 0;
   if (as_0 == "M1" || as_0 == "1") timeframe_16 = 1;
   if (as_0 == "M2" || as_0 == "2") timeframe_16 = 2;
   if (as_0 == "M3" || as_0 == "3") timeframe_16 = 3;
   if (as_0 == "M4" || as_0 == "4") timeframe_16 = 4;
   if (as_0 == "M5" || as_0 == "5") timeframe_16 = 5;
   if (as_0 == "M15" || as_0 == "15") timeframe_16 = 15;
   if (as_0 == "M30" || as_0 == "30") timeframe_16 = 30;
   if (as_0 == "H1" || as_0 == "60") timeframe_16 = 60;
   if (as_0 == "H4" || as_0 == "240") timeframe_16 = 240;
   if (as_0 == "D1" || as_0 == "1440") timeframe_16 = 1440;
   if (as_0 == "W1" || as_0 == "10080") timeframe_16 = 10080;
   if (as_0 == "MN" || as_0 == "43200") timeframe_16 = 43200;
   if (timeframe_16 == 0 || timeframe_16 < Period()) timeframe_16 = Period();
   return (timeframe_16);
}
string DS(double v){return(DoubleToStr(v, Digits));}

string fTimeFrameName(int arg){

   // fTimeFrameName();

   int v;
      if(arg==0){
         v=Period();
      }
      else{
         v=arg;
      }
      switch(v){
         case 0:
            return("0");
         case 1:
            return("M1");
         case 2:
            return("M2");
         case 3:
            return("M3");
         case 4:
            return("M4");
         case 5:
            return("M5");                  
         case 15:
            return("M15");
         case 30:
            return("M30");             
         case 60:
            return("H1");
         case 240:
            return("H4");                  
         case 1440:
            return("D1");
         case 10080:
            return("W1");          
         case 43200:
            return("MN1");
         default:
            return("Wrong TimeFrame");          
      }
}

