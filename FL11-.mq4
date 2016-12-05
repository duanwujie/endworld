#property copyright "Copyright © 2012, forex4live.com"
#property link      "http://www.forex4live.com/"

#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 CLR_NONE
#property indicator_color2 CLR_NONE
#property indicator_color3 Yellow
#property indicator_color4 Yellow
#property indicator_color5 DodgerBlue
#property indicator_color6 Red

extern double Period1 = 12.0;
extern double Period2 = 34.0;
extern double Period3 = 69.0;
extern string Dev_Step_1 = "5,3";
extern string Dev_Step_2 = "5,3";
extern string Dev_Step_3 = "5,3";
extern int Symbol_1_Kod = 172;
extern int Symbol_2_Kod = 174;
extern int Symbol_3_Kod = 82;
extern string _____ = "";
extern bool Box_Alerts = FALSE;
extern bool Email_Alerts = FALSE;
extern bool Sound_Alerts = TRUE;
extern bool Alert_Lv1 = FALSE;
extern bool Alert_Lv2 = FALSE;
extern bool Alert_Lv3 = TRUE;
string gs_168 = "stage one level high.wav";
string gs_176 = "stage one level low.wav";
string gs_184 = "stage two level high.wav";
string gs_192 = "stage two level low.wav";
string gs_200 = "stage three level high.wav";
string gs_208 = "stage three level low.wav";
double g_ibuf_216[];
double g_ibuf_220[];
double g_ibuf_224[];
double g_ibuf_228[];
double g_ibuf_232[];
double g_ibuf_236[];
int gi_unused_240;
int gi_unused_244;
int gi_unused_248;
int gi_252;
int gi_256;
int gi_260;
int gi_264;
int gi_268;
int gi_272;
string gs_276;
string gs_284;
string gs_292;
int g_digits_300;
int g_timeframe_304;
bool gi_308;
bool gi_312;
bool gi_316;
int g_bars_320 = -1;
int gi_unused_324 = 65535;

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {
   string lsa_0[256];
   int lia_12[];
   for (int index_4 = 0; index_4 < 256; index_4++) lsa_0[index_4] = CharToStr(index_4);
   int str2int_8 = StrToInteger(lsa_0[67] + lsa_0[111] + lsa_0[112] + lsa_0[121] + lsa_0[32] + lsa_0[82] + lsa_0[105] + lsa_0[103] + lsa_0[104] + lsa_0[116] + lsa_0[32] +
      lsa_0[169] + lsa_0[32] + lsa_0[75] + lsa_0[97] + lsa_0[122] + lsa_0[97] + lsa_0[111] + lsa_0[111] + lsa_0[32] + lsa_0[50] + lsa_0[48] + lsa_0[49] + lsa_0[49] + lsa_0[32]);
   g_timeframe_304 = Period();
   gs_284 = f0_3(g_timeframe_304);
   gs_276 = Symbol();
   g_digits_300 = Digits;
   gs_292 = "tbb" + gs_276 + gs_284;
   if (Period1 > 0.0) gi_unused_240 = MathCeil(Period1 * Period());
   else gi_unused_240 = 0;
   if (Period2 > 0.0) gi_unused_244 = MathCeil(Period2 * Period());
   else gi_unused_244 = 0;
   if (Period3 > 0.0) gi_unused_248 = MathCeil(Period3 * Period());
   else gi_unused_248 = 0;
   if (Period1 > 0.0) {
      SetIndexStyle(0, DRAW_ARROW);
      SetIndexArrow(0, Symbol_1_Kod);
      SetIndexBuffer(0, g_ibuf_216);
      SetIndexEmptyValue(0, 0.0);
      SetIndexStyle(1, DRAW_ARROW);
      SetIndexArrow(1, Symbol_1_Kod);
      SetIndexBuffer(1, g_ibuf_220);
      SetIndexEmptyValue(1, 0.0);
   }
   if (Period2 > 0.0) {
      SetIndexStyle(2, DRAW_ARROW);
      SetIndexArrow(2, Symbol_2_Kod);
      SetIndexBuffer(2, g_ibuf_224);
      SetIndexEmptyValue(2, 0.0);
      SetIndexStyle(3, DRAW_ARROW);
      SetIndexArrow(3, Symbol_2_Kod);
      SetIndexBuffer(3, g_ibuf_228);
      SetIndexEmptyValue(3, 0.0);
   }
   if (Period3 > 0.0) {
      SetIndexStyle(4, DRAW_ARROW);
      SetIndexArrow(4, Symbol_3_Kod);
      SetIndexBuffer(4, g_ibuf_232);
      SetIndexEmptyValue(4, 0.0);
      SetIndexStyle(5, DRAW_ARROW);
      SetIndexArrow(5, Symbol_3_Kod);
      SetIndexBuffer(5, g_ibuf_236);
      SetIndexEmptyValue(5, 0.0);
   }
   int li_unused_16 = 0;
   int li_unused_20 = 0;
   int li_24 = 0;
   if (f0_0(Dev_Step_1, li_24, lia_12) == 1) {
      gi_256 = lia_12[1];
      gi_252 = lia_12[0];
   }
   if (f0_0(Dev_Step_2, li_24, lia_12) == 1) {
      gi_264 = lia_12[1];
      gi_260 = lia_12[0];
   }
   if (f0_0(Dev_Step_3, li_24, lia_12) == 1) {
      gi_272 = lia_12[1];
      gi_268 = lia_12[0];
   }
   return (0);
}

// 52D46093050F38C27267BCE42543EF60
int deinit() {
   return (0);
}

// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   string ls_0;
   if (Bars != g_bars_320) {
      gi_308 = TRUE;
      gi_312 = TRUE;
      gi_316 = TRUE;
   }
   if (Period1 > 0.0) f0_1(g_ibuf_216, g_ibuf_220, Period1, gi_252, gi_256);
   if (Period2 > 0.0) f0_1(g_ibuf_224, g_ibuf_228, Period2, gi_260, gi_264);
   if (Period3 > 0.0) f0_1(g_ibuf_232, g_ibuf_236, Period3, gi_268, gi_272);
   string ls_8 = gs_276 + "  " + gs_284 + " at " + DoubleToStr(Close[0], g_digits_300);
   if (gi_308 && Alert_Lv1) {
      if (g_ibuf_216[0] != 0.0) {
         gi_308 = FALSE;
         ls_0 = " FL11: Standby..Level 1 Low;  ";
         if (Box_Alerts) Alert(ls_0, ls_8);
         if (Email_Alerts) SendMail(ls_0, ls_8);
         if (Sound_Alerts) PlaySound(gs_176);
      }
      if (g_ibuf_220[0] != 0.0) {
         gi_308 = FALSE;
         ls_0 = " FL11: Standby..Level 1 High; ";
         if (Box_Alerts) Alert(ls_0, ls_8);
         if (Email_Alerts) SendMail(ls_0, ls_8);
         if (Sound_Alerts) PlaySound(gs_168);
      }
   }
   if (gi_312 && Alert_Lv2) {
      if (g_ibuf_224[0] != 0.0) {
         gi_312 = FALSE;
         ls_0 = " FL11: Standby..Level 2 Low;  ";
         if (Box_Alerts) Alert(ls_0, ls_8);
         if (Email_Alerts) SendMail(ls_0, ls_8);
         if (Sound_Alerts) PlaySound(gs_192);
      }
      if (g_ibuf_228[0] != 0.0) {
         gi_312 = FALSE;
         ls_0 = " FL11: Standby..Level 2 High; ";
         if (Box_Alerts) Alert(ls_0, ls_8);
         if (Email_Alerts) SendMail(ls_0, ls_8);
         if (Sound_Alerts) PlaySound(gs_184);
      }
   }
   if (gi_316 && Alert_Lv3) {
      if (g_ibuf_232[0] != 0.0) {
         gi_316 = FALSE;
         ls_0 = " FL11: Standby..Level 3 Low;  ";
         if (Box_Alerts) Alert(ls_0, ls_8);
         if (Email_Alerts) SendMail(ls_0, ls_8);
         if (Sound_Alerts) PlaySound(gs_208);
      }
      if (g_ibuf_236[0] != 0.0) {
         gi_316 = FALSE;
         ls_0 = " FL11: Standby..Level 3 High; ";
         if (Box_Alerts) Alert(ls_0, ls_8);
         if (Email_Alerts) SendMail(ls_0, ls_8);
         if (Sound_Alerts) PlaySound(gs_200);
      }
   }
   g_bars_320 = Bars;
   return (0);
}

// BE5275EB85F7B577DA8FD065F994B740
string f0_3(int ai_0) {
   string ls_ret_4;
   switch (ai_0) {
   case 1:
      ls_ret_4 = "M1";
      break;
   case 5:
      ls_ret_4 = "M5";
      break;
   case 15:
      ls_ret_4 = "M15";
      break;
   case 30:
      ls_ret_4 = "M30";
      break;
   case 60:
      ls_ret_4 = "H1";
      break;
   case 240:
      ls_ret_4 = "H4";
      break;
   case 1440:
      ls_ret_4 = "D1";
      break;
   case 10080:
      ls_ret_4 = "W1";
      break;
   case 43200:
      ls_ret_4 = "MN";
   }
   return (ls_ret_4);
}

// 3CA4C22A90227AC4A7684A00FAEE2BA5
int f0_1(double &ada_0[], double &ada_4[], int ai_8, int ai_12, int ai_16) {
   double ld_20;
   double ld_28;
   double ld_36;
   double ld_44;
   double ld_52;
   double ld_60;
   for (int li_68 = Bars - ai_8; li_68 >= 0; li_68--) {
      ld_20 = Low[iLowest(NULL, 0, MODE_LOW, ai_8, li_68)];
      if (ld_20 == ld_60) ld_20 = 0.0;
      else {
         ld_60 = ld_20;
         if (Low[li_68] - ld_20 > ai_12 * Point) ld_20 = 0.0;
         else {
            for (int li_72 = 1; li_72 <= ai_16; li_72++) {
               ld_28 = ada_0[li_68 + li_72];
               if (ld_28 != 0.0 && ld_28 > ld_20) ada_0[li_68 + li_72] = 0.0;
            }
         }
      }
      ada_0[li_68] = ld_20;
      ld_20 = High[iHighest(NULL, 0, MODE_HIGH, ai_8, li_68)];
      if (ld_20 == ld_52) ld_20 = 0.0;
      else {
         ld_52 = ld_20;
         if (ld_20 - High[li_68] > ai_12 * Point) ld_20 = 0.0;
         else {
            for (li_72 = 1; li_72 <= ai_16; li_72++) {
               ld_28 = ada_4[li_68 + li_72];
               if (ld_28 != 0.0 && ld_28 < ld_20) ada_4[li_68 + li_72] = 0.0;
            }
         }
      }
      ada_4[li_68] = ld_20;
   }
   ld_52 = -1;
   int li_76 = -1;
   ld_60 = -1;
   int li_80 = -1;
   for (li_68 = Bars - ai_8; li_68 >= 0; li_68--) {
      ld_36 = ada_0[li_68];
      ld_44 = ada_4[li_68];
      if (ld_36 == 0.0 && ld_44 == 0.0) continue;
      if (ld_44 != 0.0) {
         if (ld_52 > 0.0) {
            if (ld_52 < ld_44) ada_4[li_76] = 0;
            else ada_4[li_68] = 0;
         }
         if (ld_52 < ld_44 || ld_52 < 0.0) {
            ld_52 = ld_44;
            li_76 = li_68;
         }
         ld_60 = -1;
      }
      if (ld_36 != 0.0) {
         if (ld_60 > 0.0) {
            if (ld_60 > ld_36) ada_0[li_80] = 0;
            else ada_0[li_68] = 0;
         }
         if (ld_36 < ld_60 || ld_60 < 0.0) {
            ld_60 = ld_36;
            li_80 = li_68;
         }
         ld_52 = -1;
      }
   }
   for (li_68 = Bars - 1; li_68 >= 0; li_68--) {
      if (li_68 >= Bars - ai_8) ada_0[li_68] = 0.0;
      else {
         ld_28 = ada_4[li_68];
         if (ld_28 != 0.0) ada_4[li_68] = ld_28;
      }
   }
   return (0);
}

// AAE96DC27D91DCB4DC46AF7044ED6795
int f0_2(string as_0, int &ai_8, int &aia_12[]) {
   int li_16;
   int str2int_20 = StrToInteger(as_0);
   if (str2int_20 > 0) {
      ai_8++;
      li_16 = ArrayResize(aia_12, ai_8);
      if (li_16 == 0) return (-1);
      aia_12[ai_8 - 1] = str2int_20;
      return (1);
   }
   return (0);
}

// 1312C2179DB8967F4CB75C9D549CFB81
int f0_0(string as_0, int &ai_8, int aia_12[]) {
   string ls_16;
   if (StringLen(as_0) == 0) return (-1);
   string ls_24 = as_0;
   int li_32 = 0;
   ai_8 = 0;
   ArrayResize(aia_12, ai_8);
   while (StringLen(ls_24) > 0) {
      li_32 = StringFind(ls_24, ",");
      if (li_32 > 0) {
         ls_16 = StringSubstr(ls_24, 0, li_32);
         ls_24 = StringSubstr(ls_24, li_32 + 1, StringLen(ls_24));
      } else {
         if (StringLen(ls_24) > 0) {
            ls_16 = ls_24;
            ls_24 = "";
         }
      }
      if (f0_2(ls_16, ai_8, aia_12) == 0) return (-2);
   }
   return (1);
}
