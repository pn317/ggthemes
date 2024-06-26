#' Range Frames
#'
#' Axis lines which extend to the maximum and minimum of the plotted data.
#'
#' @section Aesthetics:
#' \itemize{
#' \item colour
#' \item size
#' \item linetype
#' \item alpha
#' }
#'
#' @inheritParams ggplot2::geom_point
#' @param sides A string that controls which sides of the plot the frames appear on.
#'   It can be set to a string containing any of \code{'trbl'}, for top, right,
#'   bottom, and left.
#' @export
#'
#' @details This should be used with `coord_cartesian(clip="off")` in order to
#'   correctly draw the lines.
#'
#' @references Tufte, Edward R. (2001) The Visual Display of
#' Quantitative Information, Chapter 6.
#'
#' @family geom tufte
#' @importFrom ggplot2 layer
#' @example inst/examples/ex-geom_rangeframe.R
geom_rangeframe <- function(mapping = NULL,
                            data = NULL,
                            stat = "identity",
                            position = "identity",
                            ...,
                            sides = "bl",
                            na.rm = FALSE, # nolint: object_name_linter
                            show.legend = NA, # nolint: object_name_linter
                            inherit.aes = TRUE # nolint: object_name_linter
) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomRangeFrame,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      sides = sides,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname geom_rangeframe
#' @usage NULL
#' @format NULL
#' @export
#' @importFrom ggplot2 Geom
#' @importFrom scales alpha
GeomRangeFrame <- ggplot2::ggproto("GeomRangeFrame", # nolint: object_name_linter
  ggplot2::Geom,
  setup_params = function(self, data, params) {
    .sides <- strsplit(params$sides, "")[[1]]
    if (!any(c("b", "l", "t", "r") %in% .sides)) {
      cli::cli_abort("{.field sides} must contain at least one of 'b', 'l', 't' and 'r'")
    }

    self$required_aes <- c()

    if (grepl("b|t", params$sides)) {
      self$required_aes <- c(self$required_aes, "x")
    }

    if (grepl("l|r", params$sides)) {
      self$required_aes <- c(self$required_aes, "y")
    }

    params
  },
  draw_panel = function(self, data, panel_params, coord, sides = "bl", na.rm = FALSE) {
    rugs <- list()

    data <- coord$transform(data, panel_params)

    gp <- gpar(
      col = alpha(data$colour, data$alpha),
      lty = data$linetype,
      lwd = data$size * ggplot2::.pt
    )
    if (!is.null(data$x)) {
      if (grepl("b", sides)) {
        rugs$x_b <- ggname(
          "range_x_b",
          segmentsGrob(
            x0 = unit(min(data$x), "native"),
            x1 = unit(max(data$x), "native"),
            y0 = unit(0, "npc"),
            y1 = unit(0, "npc"),
            gp = gp
          )
        )
      }

      if (grepl("t", sides)) {
        rugs$x_t <- ggname(
          "range_x_t",
          segmentsGrob(
            x0 = unit(min(data$x), "native"),
            x1 = unit(max(data$x), "native"),
            y0 = unit(1, "npc"),
            y1 = unit(1, "npc"),
            gp = gp
          )
        )
      }
    }

    if (!is.null(data$y)) {
      if (grepl("l", sides)) {
        rugs$y_l <- ggname(
          "range_y_l",
          segmentsGrob(
            y0 = unit(min(data$y), "native"),
            y1 = unit(max(data$y), "native"),
            x0 = unit(0, "npc"),
            x1 = unit(0, "npc"),
            gp = gp
          )
        )
      }

      if (grepl("r", sides)) {
        rugs$y_r <- ggname(
          "range_y_r",
          segmentsGrob(
            y0 = unit(min(data$y), "native"),
            y1 = unit(max(data$y), "native"),
            x0 = unit(1, "npc"),
            x1 = unit(1, "npc"),
            gp = gp
          )
        )
      }
    }
    ggname("geom_rangeframe", gTree(children = do.call("gList", rugs)))
  },
  default_aes = ggplot2::aes(
    colour = "black", size = 0.5,
    linetype = 1, alpha = NA
  ),
  draw_key = ggplot2::draw_key_path,
  extra_params = c("na.rm", "sides")
)
