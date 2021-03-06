//+------------------------------------------------------------------+
//|                                                     HumbleMA.mq4 |
//|                                        Copyright 2016, Humble AI |
//|                                          http://www.humbleai.com |
//+------------------------------------------------------------------+

#property copyright   "2016, Humble AI"
#property link        "http://www.humbleai.com"
#property description "Humble Tide"

#property indicator_separate_window

#property indicator_buffers 5

#property indicator_color1 DeepPink
#property indicator_color2 DodgerBlue
#property indicator_color3 Black
#property indicator_color4 DeepPink
#property indicator_color5 DodgerBlue

#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 2
#property indicator_width4 1
#property indicator_width5 1

#property indicator_level1    0.0

input int ADXPeriod = 1440;

double ADXBuffer[];
double ADXHBuffer[];
double ADXLBuffer[];

double diffhbuffer[];
double difflbuffer[];
double diffadxbuffer[];

double diffhbuffer2[];
double difflbuffer2[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   SetLevelStyle(STYLE_SOLID, 1, MediumSlateBlue);

   IndicatorBuffers(8);

   SetIndexStyle(1, DRAW_HISTOGRAM, STYLE_DOT);
   SetIndexStyle(0, DRAW_HISTOGRAM, STYLE_DOT);
   
   SetIndexBuffer(0, diffhbuffer);
   SetIndexBuffer(1, difflbuffer);
   SetIndexBuffer(2, diffadxbuffer);
   SetIndexBuffer(3, diffhbuffer2);
   SetIndexBuffer(4, difflbuffer2);
      
   SetIndexBuffer(5, ADXBuffer);
   SetIndexBuffer(6, ADXHBuffer);
   SetIndexBuffer(7, ADXLBuffer);
   
   IndicatorShortName("Humble Tide");

//----
   SetIndexDrawBegin(0, ADXPeriod);
   SetIndexDrawBegin(1, ADXPeriod);
   SetIndexDrawBegin(2, ADXPeriod);
   SetIndexDrawBegin(3, ADXPeriod);
   SetIndexDrawBegin(4, ADXPeriod);
//----
   return(0);
  }


int start()
  {

   int i, Counted_bars;
   
   Counted_bars = IndicatorCounted(); // Number of counted bars
   i = Bars-Counted_bars - 1;           // Index of the first uncounted
   
   while(i >= 0)
     {
     
      ADXBuffer[i] = iADX(NULL, 0, ADXPeriod, PRICE_TYPICAL, MODE_MAIN, i);
      ADXHBuffer[i] = iADX(NULL, 0, ADXPeriod, PRICE_HIGH, MODE_MAIN, i);
      ADXLBuffer[i] = iADX(NULL, 0, ADXPeriod, PRICE_LOW, MODE_MAIN, i);
      
      diffhbuffer[i] = (ADXHBuffer[i + 1] - ADXHBuffer[i]) * 100;
      difflbuffer[i] = (ADXLBuffer[i + 1] - ADXLBuffer[i]) * 100;
      
      diffhbuffer2[i] = diffhbuffer[i];
      difflbuffer2[i] = difflbuffer[i];
      
      diffadxbuffer[i] = (ADXBuffer[i + 1] - ADXBuffer[i]) * 100;     
      
      i--;
     }
     
   return(0);
  }