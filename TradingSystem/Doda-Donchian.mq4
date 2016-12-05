//+------------------------------------------------------------------+
//|                                                Doda-Donchian.mq4 |
//|                             Copyright © 2010, Gopal Krishan Doda |
//|                                        http://www.DodaCharts.com |
//+------------------------------------------------------------------+


#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 CLR_NONE
#property indicator_color2 CLR_NONE
#property indicator_color3 Red

#property indicator_color4 CLR_NONE  // Green
#property indicator_color5 CLR_NONE   // Red

#property indicator_style3 2



extern int ChannelPeriod=28; // from 28 to 20
extern int EMAPeriod=120;
extern int StartEMAShift=6;
extern int EndEMAShift=0;
extern double AngleTreshold=0.32;

double UpperLine[];
double LowerLine[];
double MidLine[];

double BuyBuffer[];
double SellBuffer[];

bool BuyAlert=false, SellAlert=false;

int init()
  {
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,UpperLine);
   SetIndexLabel(0,"UpperLine");

   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1,LowerLine);
   SetIndexLabel(1,"LowerLine");

   SetIndexStyle(2,DRAW_LINE);
   SetIndexBuffer(2,MidLine);
   SetIndexLabel(2,"MidLine");


   SetIndexStyle(3,DRAW_ARROW,EMPTY);
   SetIndexArrow(3,241);
   SetIndexBuffer(3,BuyBuffer);
   SetIndexLabel(3,"Buy");

   SetIndexStyle(4,DRAW_ARROW,EMPTY);
   SetIndexArrow(4,242);
   SetIndexBuffer(4,SellBuffer);
   SetIndexLabel(4,"Sell");
   


   IndicatorShortName("DonchianChannel("+ChannelPeriod+")");
   SetIndexDrawBegin(0,ChannelPeriod);
   SetIndexDrawBegin(1,ChannelPeriod);
   
   ObjectCreate("mywebsite",OBJ_LABEL,0,0,0);
   
   ObjectCreate("mysl",OBJ_LABEL,0,0,0);
   
   return(0);
  }
  
    int deinit()
{
  ObjectDelete("mysl");
  ObjectDelete("mywebsite");   

}
  
  
//+------------------------------------------------------------------+
//| Price Channel                                                         |
//+------------------------------------------------------------------+
int start()
  {
   int i, start ,counted_bars=IndicatorCounted();
   int    k;
   double high,low,price, fEndMA, fStartMA, fAngle;

   if(Bars<=ChannelPeriod) return(0);
   
   if(counted_bars>=ChannelPeriod) {
      start=Bars-counted_bars-1;
   } else {
      start=Bars-ChannelPeriod-1;
   }
   
   BuyBuffer[0]=0;
   SellBuffer[0]=0;
   
   for(i=start;i>=0;i--) {
      UpperLine[i]=High[Highest(NULL, 0, MODE_HIGH, ChannelPeriod, i)];
      LowerLine[i]=Low[Lowest(NULL, 0, MODE_LOW, ChannelPeriod, i)];
      MidLine[i]  =(UpperLine[i]+LowerLine[i])/2;

      // next 3 lines from jpkfox, EMAAngle.mq4 
      fEndMA=iMA(NULL,0,EMAPeriod,0,MODE_EMA,PRICE_MEDIAN,i+EndEMAShift);
      fStartMA=iMA(NULL,0,EMAPeriod,0,MODE_EMA,PRICE_MEDIAN,i+StartEMAShift);
      fAngle = 10000.0 * (fEndMA - fStartMA)/(StartEMAShift-EndEMAShift);

      
      if(UpperLine[i+1]<High[i] && fAngle > AngleTreshold) {
         BuyBuffer[i]=High[i];
      }
      if(LowerLine[i+1]>Low[i] && fAngle < -AngleTreshold) {
         SellBuffer[i]=Low[i];
      }
      
      
      
   }
   
   if (BuyBuffer[0]!=0 && BuyAlert==False) {
         Alert ("Doda-Donchian Buy Signal at " + BuyBuffer[0] + " -> " + Symbol() + "/" + Period());
         BuyAlert = True;
      SellAlert = False;

      }

      if (SellBuffer[0]!=0 && SellAlert==False) {
         Alert ("Doda-Donchian Sell Signal at " + SellBuffer[0] + " -> " + Symbol() + "/" + Period());
         BuyAlert = false;
      SellAlert = True;  

      }


ObjectSetText("mysl","Stop Loss: " + DoubleToStr( MidLine[0],Digits) , 10, "Arial", Red);
ObjectSet("mysl",OBJPROP_XDISTANCE,2);
ObjectSet("mysl",OBJPROP_YDISTANCE,138);
ObjectSet("mysl", OBJPROP_CORNER, 3);
   
ObjectSetText("mywebsite","Powered by www.DodaCharts.com", 10, "Arial", Red);
ObjectSet("mywebsite",OBJPROP_XDISTANCE,2);
ObjectSet("mywebsite",OBJPROP_YDISTANCE,84);
ObjectSet("mywebsite", OBJPROP_CORNER, 3);
   
   
   
  }
//+------------------------------------------------------------------+