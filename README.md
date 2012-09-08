# ggplotJrnold

Some extra themes and scales for [ggplot](http://had.co.nz/ggplot2/),

- The Economist theme and scales
- [Solarized](http://ethanschoonover.com/solarized) theme and scales
- Themes and scales based on Stata graph schemes
- Shape scales from William S. Cleveland's *Visualizing Data*

# Install 

It is probably easiest to use the **devtools** package to install the latest version:


```r
opts_knit$set(upload.fun = imgur_upload)
opts_chunk$set(fig.width = 5, fig.height = 5)
```


```r
library(devtools)
install_github('ggplotJrnold', 'jrnold')
```

# Examples


```r
library(ggplot2)
library(ggplotJrnold)
dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
```


## Economist theme

A theme that approximates the style of plots in The Economist
magazine.


```r
(qplot(carat, price, data = dsamp, colour = cut) + theme_economist() + 
    scale_colour_economist())
```

![plot of chunk unnamed-chunk-3](http://i.imgur.com/PMK0X.png) 


## Solarized theme

A theme and color and fill scales based on the Solarized palette.

A light theme with blue accents.


```r
(qplot(carat, price, data = dsamp, colour = cut) + theme_solarized() + 
    scale_colour_solarized("blue"))
```

![plot of chunk unnamed-chunk-4](http://i.imgur.com/pO0KN.png) 


A dark theme with yellow accents.


```r
(qplot(carat, price, data = dsamp, colour = cut) + theme_solarized(light = FALSE) + 
    scale_colour_solarized("red"))
```

![plot of chunk unnamed-chunk-5](http://i.imgur.com/gPBud.png) 


## Stata theme 

A theme and color/fill scales based on the graphs in Stata.


```r
(qplot(carat, price, data = dsamp, colour = cut) + theme_stata() + 
    scale_colour_stata())
```

![plot of chunk unnamed-chunk-6](http://i.imgur.com/FTYvI.png) 



