## See http://ethanschoonover.com/solarized
## L*a*b values are canonical (White D65, Reference D50), other values are matched in sRGB space.

## SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      RGB         HSB
## --------- ------- ---- -------  ----------- ---------- ----------- -----------
## base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
## base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
## base01    #586e75 10/7 brgreen  240 #585858 45 -07 -07  88 110 117 194  25  46
## base00    #657b83 11/7 bryellow 241 #626262 50 -07 -07 101 123 131 195  23  51
## base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
## base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
## base2     #eee8d5  7/7 white    254 #e4e4e4 92 -00  10 238 232 213  44  11  93
## base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
## yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
## orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
## red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
## magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
## violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
## blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
## cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
## green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

##' Solarized colors
##'
##' Names and RGB values of the Solarized palette. \url{http://ethanschoonover.com/solarized}
##'
##' @format Named \code{character} vector of the solarized colors' hex
##' RGB values.
##' @export
COLORS_SOLARIZED <-
 c(base03 = "#002b36",
   base02 = "#073642",
   base01 = "#586e75",
   base00 = "#657b83",
   base0 = "#839496",
   base1 = "#93a1a1",
   base2 = "#eee8d5",
   base3 = "#fdf6e3",
   yellow = "#b58900",
   orange = "#cb4b16",
   red = "#dc322f",
   magenta = "#d33682",
   violet = "#6c71c4",
   blue = "#268bd2",
   cyan = "#2aa198",
   green = "#859900")

##' Base colors for Solarized light and dark themes
##'
##' @param light \code{logical} Light theme?
##'
##' Creates the base colors for a light or dark solarized theme. See
##' \url{http://ethanschoonover.com/solarized}. The idea for this
##' function comes from the CSS style example.
solarized_rebase <- function(light=TRUE) {
    if (light) {
        rebase <- COLORS_SOLARIZED[c('base3', 'base2', 'base1', 'base0',
                                   'base00', 'base01', 'base02', 'base03')]
    } else {
        rebase <- COLORS_SOLARIZED[c('base03', 'base02', 'base01', 'base00',
                                     'base0', 'base1', 'base2', 'base3')]
    }
    names(rebase) <- paste('rebase', c('03', '02', '01', '00', 0:3), sep="")
    rebase
}

##' Solarized color palette (discrete)
##'
##' Solarized accents palette from
##' \url{http://ethanschoonover.com/solarized}.
##'
##' @param colors \code{character} vector of the names of Solarized
##' colors to use and their order.
##' @export
##' @examples
##' show_col(solarized_pal())
solarized_pal <- function(colors=NULL) {
    colorsall <- COLORS_SOLARIZED[!grepl("^base", names(COLORS_SOLARIZED))]
    if (is.null(colors)) {
        colors <- names(colorsall)
    }
    colorlist <- c(colorsall[colors],
                   colorsall[setdiff(colors, names(colorsall))])
    manual_pal(unname(colorlist))
}

##' Solarized color scales
##'
##' Accent color theme for Solarized.
##' Primarily for use with
##' \code{\link{theme_solarized}}.
##'
##' @inheritParams ggplot2::scale_colour_hue
##' @inheritParams solarized_pal
##' @family colour scales
##' @rdname scale_solarized
##' @export
##' @examples
##' dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
##' (d <- qplot(carat, price, data=dsamp, colour=clarity)
##'                + theme_solarized()
##'                + scale_colour_solarized() )
scale_fill_solarized <- function(colors=NULL, ...) {
    discrete_scale("fill", "solarized", solarized_pal(colors), ...)
}

#' @export
#' @rdname scale_solarized
scale_colour_solarized <- function(colors=NULL, ...) {
    discrete_scale("colour", "solarized", solarized_pal(colors), ...)
}
#' @export
#' @rdname scale_solarized
scale_color_solarized <- scale_colour_solarized

##' ggplot color theme based on the Solarized palette
##'
##' See \url{http://ethanschoonover.com/solarized} for a
##' description of the Solarized palette.
##'
##' @param base_size base font size
##' @param base_family base font family
##' @param light \code{logical}. Light or dark theme?
##' @export
##' @family themes
##' @examples
##' dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
##' (d <- qplot(carat, price, data=dsamp, colour=clarity)
##'                + theme_economist()
##'                + scale_colour_economist() )
theme_solarized <- function(base_size = 12, base_family="", light=TRUE) {
    rebase <- solarized_rebase(light)
    ret <- (theme_bw(base_size=base_size, base_family=base_family) +
            theme(text = element_text(colour=rebase['rebase0']),
                  title = element_text(color=rebase['rebase1']),
                  line = element_line(color=rebase['rebase0']),
                  rect = element_rect(fill=rebase['rebase03'], color=rebase['rebase0']),
                  axis.ticks = element_line(color=rebase['rebase0']),
                  legend.background = element_rect(fill=NULL, color=NA),
                  legend.key = element_rect(fill=NULL, color=rebase['rebase01']),
                  panel.background = element_rect(fill=rebase['rebase03'], color=rebase['rebase01']),
                  panel.grid = element_line(color=rebase['rebase01']),
                  panel.grid.major = element_line(color=rebase['rebase01']),
                  panel.grid.minor = element_line(color=rebase['rebase01']),
                  panel.border = element_rect(color=rebase['rebase01']),
                  strip.background = element_rect(fill=rebase['rebase02'])
            ))
    ret
}
