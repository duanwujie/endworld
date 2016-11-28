#property copyright "whoever"
#property link "whatever"

#property indicator_separate_window
#property indicator_buffers 5
#property indicator_color1 LimeGreen
#property indicator_color2 Red
#property indicator_color3 Gold
#property indicator_color4 LimeGreen
#property indicator_color5 Red
#property indicator_width3 2
#property indicator_width4 2
#property indicator_width5 2

extern int period = 35;
extern int smooth = 10;

double ExtBuffer0[];
double ExtBuffer1[];
double ExtBuffer2[];
double ExtBuffer3[];
double ExtBuffer4[];
double ExtBuffer5[];
double ExtBufferh1[];
double ExtBufferh2[];

#define LinesIdentifier "signalLines"
int init() {
    IndicatorBuffers(8);
    SetIndexBuffer(0, ExtBufferh1);
    SetIndexStyle(0, DRAW_HISTOGRAM);
    SetIndexBuffer(1, ExtBufferh2);
    SetIndexStyle(1, DRAW_HISTOGRAM);
    SetIndexBuffer(2, ExtBuffer3);
    SetIndexBuffer(3, ExtBuffer4);
    SetIndexBuffer(4, ExtBuffer5);
    SetIndexBuffer(5, ExtBuffer0);
    SetIndexBuffer(6, ExtBuffer1);
    SetIndexBuffer(7, ExtBuffer2);

    IndicatorShortName("Solar wind joy :)");
    return (0);
}
int deinit() {
    int lookForLength = StringLen(LinesIdentifier);
    for (int i = ObjectsTotal(); i >= 0; i--) {
        string name = ObjectName(i);
        if (StringSubstr(name, 0, lookForLength) == LinesIdentifier) ObjectDelete(name);
    }
    return (0);
}


int start() {
    //int     period=10;
    int limit;
    double prev, current, old;
    double Value = 0, Value1 = 0, Value2 = 0, Fish = 0, Fish1 = 0, Fish2 = 0;
    double price;
    double MinL = 0;
    double MaxH = 0;


    limit = Bars - 1;


    for (int i = 0; i < limit; i++) {
        MaxH = High[Highest(NULL, 0, MODE_HIGH, period, i)];
        MinL = Low[Lowest(NULL, 0, MODE_LOW, period, i)];
        price = (High[i] + Low[i]) / 2;
        Value = 0.33 * 2 * ((price - MinL) / (MaxH - MinL) - 0.5) + 0.67 * Value1;
        Value = MathMin(MathMax(Value, -0.999), 0.999);
        ExtBuffer0[i] = 0.5 * MathLog((1 + Value) / (1 - Value)) + 0.5 * Fish1;
        Value1 = Value;
        Fish1 = ExtBuffer0[i];
        if (ExtBuffer0[i] > 0) ExtBuffer1[i] = 10;
        else ExtBuffer1[i] = -10;
    }

    for (i = limit; i >= 0; i--) {
        double sum = 0;
        double sumw = 0;

        for (int k = 0; k < smooth && (i + k) < Bars; k++) {
            double weight = smooth - k;
            sumw += weight;
            sum += weight * ExtBuffer1[i + k];
        }
        if (sumw != 0)
            ExtBuffer2[i] = sum / sumw;
        else ExtBuffer2[i] = 0;
    }
    for (i = 0; i <= limit; i++) {
        sum = 0;
        sumw = 0;

        for (k = 0; k < smooth && (i - k) >= 0; k++) {
            weight = smooth - k;
            sumw += weight;
            sum += weight * ExtBuffer2[i - k];
        }
        if (sumw != 0)
            ExtBuffer3[i] = sum / sumw;
        else ExtBuffer3[i] = 0;
    }
    for (i = limit; i >= 0; i--) {
        ExtBuffer4[i] = EMPTY_VALUE;
        ExtBuffer5[i] = EMPTY_VALUE;
        ExtBufferh1[i] = EMPTY_VALUE;
        ExtBufferh2[i] = EMPTY_VALUE;
        if (ExtBuffer3[i] > 0) {
            ExtBuffer4[i] = ExtBuffer3[i];
            ExtBufferh1[i] = ExtBuffer3[i];
        }
        if (ExtBuffer3[i] < 0) {
            ExtBuffer5[i] = ExtBuffer3[i];
            ExtBufferh2[i] = ExtBuffer3[i];
        }
    }
    return (0);
}