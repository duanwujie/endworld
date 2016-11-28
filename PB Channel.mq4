#property copyright "mladen"
#property link      "mladenfx@gmail.com"

#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 Black
#property indicator_color2 Red
#property indicator_color3 LimeGreen
#property indicator_color4 Purple
#property indicator_color5 Purple

extern string TimeFrame = "current time frame";
extern int HalfLength = 50;
extern int Price = 6;
extern double BandsDeviations = 3.0;
extern bool Interpolate = TRUE;
extern bool alertsOn = TRUE;
extern bool alertsOnCurrent = FALSE;
extern bool alertsOnHighLow = FALSE;
extern bool alertsMessage = TRUE;
extern bool alertsSound = FALSE;
extern bool alertsEmail = FALSE;
double G_ibuf_128[];
double G_ibuf_132[];
double G_ibuf_136[];
double G_ibuf_140[];
double G_ibuf_144[];
double G_ibuf_148[];
double G_ibuf_152[];
string Gs_156;
bool Gi_164 = FALSE;
bool Gi_168 = FALSE;
int G_timeframe_172;
string Gs_176 = "";
datetime G_time_184;

int init() {
   G_timeframe_172 = f0_0(TimeFrame);
   HalfLength = MathMax(HalfLength, 1);
   IndicatorBuffers(7);
   SetIndexBuffer(0, G_ibuf_128);
   SetIndexDrawBegin(0, HalfLength);
   SetIndexBuffer(1, G_ibuf_132);
   SetIndexDrawBegin(1, HalfLength);
   SetIndexBuffer(2, G_ibuf_136);
   SetIndexDrawBegin(2, HalfLength);
   SetIndexBuffer(3, G_ibuf_152);
   SetIndexStyle(3, DRAW_ARROW);
   SetIndexArrow(5, SYMBOL_ARROWDOWN);
   SetIndexBuffer(4, G_ibuf_148);
   SetIndexStyle(4, DRAW_ARROW);
   SetIndexArrow(6, SYMBOL_ARROWUP);
   SetIndexBuffer(5, G_ibuf_140);
   SetIndexBuffer(6, G_ibuf_144);
   if (TimeFrame == "calculateTma") {
      Gi_164 = TRUE;
      return (0);
   }
   if (TimeFrame == "returnBars") {
      Gi_168 = TRUE;
      return (0);
   }
   Gs_156 = WindowExpertName();
   return (0);
}


int deinit() {
   return (0);
}


int start() {
   int shift_12;
   int datetime_16;
   double Ld_24;
   int Li_36;
   int Li_0 = IndicatorCounted();
   if (Li_0 < 0) return (-1);
   if (Li_0 > 0) Li_0--;
   int Li_8 = MathMin(Bars - 1, Bars - Li_0 + HalfLength);
   if (Gi_168) {
      G_ibuf_128[0] = Li_8;
      return (0);
   }
   if (Gi_164) {
      f0_2(Li_8);
      return (0);
   }
   if (G_timeframe_172 > Period()) Li_8 = MathMax(Li_8, MathMin(Bars - 1, iCustom(NULL, G_timeframe_172, Gs_156, "returnBars", 0, 0) * G_timeframe_172 / Period()));
   for (int Li_4 = Li_8; Li_4 >= 0; Li_4--) {
      shift_12 = iBarShift(NULL, G_timeframe_172, Time[Li_4]);
      datetime_16 = iTime(NULL, G_timeframe_172, shift_12);
      G_ibuf_128[Li_4] = iCustom(NULL, G_timeframe_172, Gs_156, "calculateTma", HalfLength, Price, BandsDeviations, 0, shift_12);
      G_ibuf_132[Li_4] = iCustom(NULL, G_timeframe_172, Gs_156, "calculateTma", HalfLength, Price, BandsDeviations, 1, shift_12);
      G_ibuf_136[Li_4] = iCustom(NULL, G_timeframe_172, Gs_156, "calculateTma", HalfLength, Price, BandsDeviations, 2, shift_12);
      G_ibuf_148[Li_4] = EMPTY_VALUE;
      G_ibuf_152[Li_4] = EMPTY_VALUE;
      if (High[Li_4 + 1] > G_ibuf_132[Li_4 + 1] && Close[Li_4 + 1] > Open[Li_4 + 1] && Close[Li_4] < Open[Li_4]) G_ibuf_148[Li_4] = High[Li_4] + iATR(NULL, 0, 20, Li_4);
      if (Low[Li_4 + 1] < G_ibuf_136[Li_4 + 1] && Close[Li_4 + 1] < Open[Li_4 + 1] && Close[Li_4] > Open[Li_4]) G_ibuf_152[Li_4] = High[Li_4] - iATR(NULL, 0, 20, Li_4);
      if (G_timeframe_172 <= Period() || shift_12 == iBarShift(NULL, G_timeframe_172, Time[Li_4 - 1])) continue;
      if (Interpolate) {
         for (int Li_20 = 1; Li_4 + Li_20 < Bars && Time[Li_4 + Li_20] >= datetime_16; Li_20++) {
         }
         Ld_24 = 1.0 / Li_20;
         for (int Li_32 = 1; Li_32 < Li_20; Li_32++) {
            G_ibuf_128[Li_4 + Li_32] = Li_32 * Ld_24 * (G_ibuf_128[Li_4 + Li_20]) + (1.0 - Li_32 * Ld_24) * G_ibuf_128[Li_4];
            G_ibuf_132[Li_4 + Li_32] = Li_32 * Ld_24 * (G_ibuf_132[Li_4 + Li_20]) + (1.0 - Li_32 * Ld_24) * G_ibuf_132[Li_4];
            G_ibuf_136[Li_4 + Li_32] = Li_32 * Ld_24 * (G_ibuf_136[Li_4 + Li_20]) + (1.0 - Li_32 * Ld_24) * G_ibuf_136[Li_4];
         }
      }
   }
   if (alertsOn) {
      if (alertsOnCurrent) Li_36 = 0;
      else Li_36 = 1;
      if (alertsOnHighLow) {
         if (High[Li_36] > G_ibuf_132[Li_36] && High[Li_36 + 1] < G_ibuf_132[Li_36 + 1]) f0_1("high penetrated upper bar");
         if (Low[Li_36] < G_ibuf_136[Li_36] && Low[Li_36 + 1] > G_ibuf_136[Li_36 + 1]) f0_1("low penetrated lower bar");
      } else {
         if (Close[Li_36] > G_ibuf_132[Li_36] && Close[Li_36 + 1] < G_ibuf_132[Li_36 + 1]) f0_1("Exit buy");
         if (Close[Li_36] < G_ibuf_136[Li_36] && Close[Li_36 + 1] > G_ibuf_136[Li_36 + 1]) f0_1("Exit sell");
      }
   }
   return (0);
}

void f0_2(int Ai_0) {
   int Li_8;
   double Ld_24;
   double Ld_32;
   double Ld_40;
   double Ld_16 = 2.0 * HalfLength + 1.0;
   for (int Li_4 = Ai_0; Li_4 >= 0; Li_4--) {
      Ld_24 = (HalfLength + 1) * iMA(NULL, 0, 1, 0, MODE_SMA, Price, Li_4);
      Ld_32 = HalfLength + 1;
      Li_8 = 1;
      for (int Li_12 = HalfLength; Li_8 <= HalfLength; Li_12--) {
         Ld_24 += Li_12 * iMA(NULL, 0, 1, 0, MODE_SMA, Price, Li_4 + Li_8);
         Ld_32 += Li_12;
         if (Li_8 <= Li_4) {
            Ld_24 += Li_12 * iMA(NULL, 0, 1, 0, MODE_SMA, Price, Li_4 - Li_8);
            Ld_32 += Li_12;
         }
         Li_8++;
      }
      G_ibuf_128[Li_4] = Ld_24 / Ld_32;
      Ld_40 = iMA(NULL, 0, 1, 0, MODE_SMA, Price, Li_4) - G_ibuf_128[Li_4];
      if (Li_4 <= Bars - HalfLength - 1) {
         if (Li_4 == Bars - HalfLength - 1) {
            G_ibuf_132[Li_4] = G_ibuf_128[Li_4];
            G_ibuf_136[Li_4] = G_ibuf_128[Li_4];
            if (Ld_40 >= 0.0) {
               G_ibuf_140[Li_4] = MathPow(Ld_40, 2);
               G_ibuf_144[Li_4] = 0;
               continue;
            }
            G_ibuf_144[Li_4] = MathPow(Ld_40, 2);
            G_ibuf_140[Li_4] = 0;
            continue;
         }
         if (Ld_40 >= 0.0) {
            G_ibuf_140[Li_4] = ((G_ibuf_140[Li_4 + 1]) * (Ld_16 - 1.0) + MathPow(Ld_40, 2)) / Ld_16;
            G_ibuf_144[Li_4] = (G_ibuf_144[Li_4 + 1]) * (Ld_16 - 1.0) / Ld_16;
         } else {
            G_ibuf_144[Li_4] = ((G_ibuf_144[Li_4 + 1]) * (Ld_16 - 1.0) + MathPow(Ld_40, 2)) / Ld_16;
            G_ibuf_140[Li_4] = (G_ibuf_140[Li_4 + 1]) * (Ld_16 - 1.0) / Ld_16;
         }
         G_ibuf_132[Li_4] = G_ibuf_128[Li_4] + BandsDeviations * MathSqrt(G_ibuf_140[Li_4]);
         G_ibuf_136[Li_4] = G_ibuf_128[Li_4] - BandsDeviations * MathSqrt(G_ibuf_144[Li_4]);
      }
   }
}

void f0_1(string As_0) {
   string str_concat_8;
   if (Gs_176 != As_0 || G_time_184 != Time[0]) {
      Gs_176 = As_0;
      G_time_184 = Time[0];
      str_concat_8 = StringConcatenate(Symbol(), " at ", TimeToStr(TimeLocal(), TIME_SECONDS), " PB : ", As_0);
      if (alertsMessage) Alert(str_concat_8);
      if (alertsEmail) SendMail(StringConcatenate(Symbol(), "TMA "), str_concat_8);
      if (alertsSound) PlaySound("alert2.wav");
   }
}

int f0_0(string As_0) {
   int Li_12;
   for (int Li_8 = StringLen(As_0) - 1; Li_8 >= 0; Li_8--) {
      Li_12 = StringGetChar(As_0, Li_8);
      if ((Li_12 > '`' && Li_12 < '{') || (Li_12 > '?' && Li_12 < 256)) As_0 = StringSetChar(As_0, 1, Li_12 - 32);
      else
         if (Li_12 > -33 && Li_12 < 0) As_0 = StringSetChar(As_0, 1, Li_12 + 224);
   }
   int timeframe_16 = 0;
   if (As_0 == "M1" || As_0 == "1") timeframe_16 = 1;
   if (As_0 == "M5" || As_0 == "5") timeframe_16 = 5;
   if (As_0 == "M15" || As_0 == "15") timeframe_16 = 15;
   if (As_0 == "M30" || As_0 == "30") timeframe_16 = 30;
   if (As_0 == "H1" || As_0 == "60") timeframe_16 = 60;
   if (As_0 == "H4" || As_0 == "240") timeframe_16 = 240;
   if (As_0 == "D1" || As_0 == "1440") timeframe_16 = 1440;
   if (As_0 == "W1" || As_0 == "10080") timeframe_16 = 10080;
   if (As_0 == "MN" || As_0 == "43200") timeframe_16 = 43200;
   if (timeframe_16 == 0 || timeframe_16 < Period()) timeframe_16 = Period();
   return (timeframe_16);
}
