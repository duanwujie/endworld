//************************************************
//*  Spread.mq4 (No Copyright)                   *
//*  Shows current absolute and relative Spread  *
//*  Written by: Totoro @ Forexfactory           *
//************************************************

#property indicator_chart_window

extern string FontName = "Fixedsys";
extern color FontColor = DeepPink;
extern int FontSize = 10;
extern int LabelPosX = 2;
extern int LabelPosY = 12;
extern bool RelShow = true;
extern int RelDigits = 2;
extern string RelText = " per mille";

#define OBJEKT_NAME "SpreadLabel"

int init() { SpreadAnzeigen(); }
int start() { SpreadAnzeigen(); }
int deinit() { ObjectDelete(OBJEKT_NAME); }

void SpreadAnzeigen()
{
   string s;
   double spread = MarketInfo(Symbol(), MODE_SPREAD);
   double bid = MarketInfo(Symbol(), MODE_BID);
   
   if(MarketInfo("EURUSD", MODE_DIGITS)==5)
      spread *= 0.1;

   string mehrzahl = "s";
   if(spread == 1) mehrzahl = "";

   if(RelShow) {
      double relative = 1000 * ( MarketInfo(Symbol(), MODE_ASK) - bid ) / bid;
      s = "Spread: "+DoubleToStr(spread, 0)+" Point"+mehrzahl+" ("+DoubleToStr(relative, RelDigits)+RelText+")";
   }
   else
      s = "Spread: "+DoubleToStr(spread, 0)+" Point"+mehrzahl;
   
   if(ObjectFind(OBJEKT_NAME) < 0)
   {
      ObjectCreate(OBJEKT_NAME, OBJ_LABEL, 0, 0, 0);
      ObjectSet(OBJEKT_NAME, OBJPROP_CORNER, 0);
      ObjectSet(OBJEKT_NAME, OBJPROP_XDISTANCE, LabelPosX);
      ObjectSet(OBJEKT_NAME, OBJPROP_YDISTANCE, LabelPosY);
      ObjectSetText(OBJEKT_NAME, s, FontSize, FontName, FontColor);
   }
   else
      ObjectSetText(OBJEKT_NAME, s);
   
   WindowRedraw();
}