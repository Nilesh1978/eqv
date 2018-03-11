GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                                 required_aes = c("x"),
                                 default_aes = ggplot2::aes(colour = "grey", size = 1.5, alpha = 0.5,
                                                            shape = 21, fill = "grey", stroke = 0.5),
                                 draw_key = ggplot2::draw_key_point,
                                 draw_panel = function(data, panel_scales, coord) {
                                   
                                   if (!("y" %in% colnames(data))) {
                                     data$y <- 0.15
                                   }
                                   
                                   coords <- coord$transform(data, panel_scales)
                                   
                                   points <- grid::pointsGrob(
                                     coords$x, coords$y,
                                     pch = coords$shape, 
                                     size = unit(coords$size/4, "char"),
                                     gp = grid::gpar(
                                       col = scales::alpha(coords$colour, coords$alpha),
                                       fill = scales::alpha(coords$colour, coords$alpha)
                                     )
                                   )
                                   y_lines <- unique(coords$y)
                                   
                                   lines <- grid::polylineGrob(
                                     x = unit(rep(c(0, 1), each = length(y_lines)), "npc"),
                                     y = unit(c(y_lines, y_lines), "npc"),
                                     id = rep(seq_along(y_lines), 2),
                                     gp = grid::gpar(col = "grey",
                                                     lwd = .pt)
                                   )
                                   
                                   grid::gList(points, lines)
                                 }
)
