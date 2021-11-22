useRes = True
intRes = 3
min = a if a < b else b
stratRes    = '60'
//
basisType   =  "SMMA" # input(defval = "SMMA", title = "MA Type: ", options=["SMA", "EMA", "DEMA", "TEMA", "WMA", "VWMA", "SMMA", "HullMA", "LSMA", "ALMA", "SSMA", "TMA"])
basisLen    = 8 #input(defval = 8, title = "MA Period", minval = 1)
offsetSigma = 6 #input(defval = 6, title = "Offset for LSMA / Sigma for ALMA", minval = 0)
offsetALMA  = 0.85 #input(defval = 0.85, title = "Offset for ALMA", minval = 0, step = 0.01)
delayOffset = 0 # input(defval = 0, title = "Delay Open/Close MA (Forces Non-Repainting)", minval = 0, step = 1)
//
uDiv = False # input(false,"Show Divergence Channel")
multi = 0.5 # input(0.5,minval=0.0,maxval=3.0,title="Divergence Channel Width Factor (Stddev)")
uHid = False #      input(false, title="Show Hidden Divergence")
uReg = False #      input(false, title="Show Regular Divergence")
uDiv = uDiv if(uReg or uHid) else False



#  === /INPUTS ===

#  - variant(type, src, len)
#  Returns MA input selection variant, default to SMA if blank or typo.

#  Returns MA input selection variant, default to SMA if blank or typo.
def variant(type, src, len, offSig, offALMA):
    v1 = sma(src, len)                                                  // Simple
    v2 = ema(src, len)                                                  // Exponential
    v3 = 2 * v2 - ema(v2, len)                                          // Double Exponential
    v4 = 3 * (v2 - ema(v2, len)) + ema(ema(v2, len), len)               // Triple Exponential
    v5 = wma(src, len)                                                  // Weighted
    v6 = vwma(src, len)                                                 // Volume Weighted
    v7 = 0.0
    v7 := na(v7[1]) ? sma(src, len) : (v7[1] * (len - 1) + src) / len    // Smoothed
    v8 = wma(2 * wma(src, len / 2) - wma(src, len), round(sqrt(len)))   // Hull
    v9 = linreg(src, len, offSig)                                       // Least Squares
    v10 = alma(src, len, offALMA, offSig)                               // Arnaud Legoux
    v11 = sma(v1,len)                                                   // Triangular (extreme smooth)
    // SuperSmoother filter
    // © 2013  John F. Ehlers
    a1 = exp(-1.414*3.14159 / len)
    b1 = 2*a1*cos(1.414*3.14159 / len)
    c2 = b1
    c3 = (-a1)*a1
    c1 = 1 - c2 - c3
    v12 = 0.0
    v12 := c1*(src + nz(src[1])) / 2 + c2*nz(v12[1]) + c3*nz(v12[2])
    type=="EMA"?v2 : type=="DEMA"?v3 : type=="TEMA"?v4 : type=="WMA"?v5 : type=="VWMA"?v6 : type=="SMMA"?v7 : type=="HullMA"?v8 : type=="LSMA"?v9 : type=="ALMA"?v10 : type=="TMA"?v11: type=="SSMA"?v12: v1

#  security wrapper for repeat calls
def reso(exp, use, res):
    if(use):
        return security(tickerid, res, exp, gaps=barmerge.gaps_off, lookahead=barmerge.lookahead_on)
    else: 
        return exp
