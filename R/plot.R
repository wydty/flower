#' plot flower plot
#'
#' This function plot a flower plot
#' @param sample a vector of sample names
#' @param value a vector of values
#' @param subvalue a vertor of valuer, default NULL
#' @param start init angle
#' @param a ellipse x length
#' @param b ellipse y length
#' @param ellipse_col flower colors
#' @param alpha ellipse color alpha, default .5
#' @param text_cex sample name cex
#' @param circle_col circle colors
#' @param circle_border circle colors
#' @param circle_r circle radius, default 1.1
#' @param circle_text_cex circle text cex
#' @param circle_text_col circle text color
#' @param circle_text circle text
#' @export
#' @examples
#' flower_plot(1:12, 1:12)


## Add an alpha value to a colour
add.alpha <- function(col, alpha=1){
  if(missing(col))
    stop("Please provide a vector of colours.")
  apply(sapply(col, col2rgb)/255, 2,
        function(x)
          rgb(x[1], x[2], x[3], alpha=alpha))
}

## flower plot
flower_plot <- function(sample, value, subvalue=NULL, start=90, a=0.5, b=2,
                        ellipse_col = rgb(135, 206, 235, 150, max = 255),
                        text_cex=1.2, alpha=.5,
                        circle_col = 'white',
                        circle_border=add.alpha('black',.5),
                        circle_r=1.1,
                        circle_text_cex = 1.5,
                        circle_text_col = add.alpha('black',.8),
                        circle_text='') {
  if (length(ellipse_col)<length(sample)){ellipse_col=rep(ellipse_col,length(sample))}
  if (is.null(circle_border)){circle_border=ellipse_col}
  if (is.null(subvalue)){mvalue=value
  }else{
    mvalue=paste(value,'\n(',subvalue,')',sep = '')
  }
  par( bty = "n", ann = F, xaxt = "n", yaxt = "n", mar = rep(.1,4))
  plot(c(1,9),c(1,9),type="n")
  n   <- length(sample); deg <- 360 / n
  res <- lapply(1:n, function(t){
    plotrix::draw.ellipse(x = 5 + cos((start + deg * (t - 1)) * pi / 180),
                 y = 5 + sin((start + deg * (t - 1)) * pi / 180),
                 col = add.alpha(ellipse_col[t],alpha),
                 border = ellipse_col[t],
                 a = a, b = b, angle = deg * (t - 1))
    text(x = 5 + 2.5 * cos((start + deg * (t - 1)) * pi / 180),
         y = 5 + 2.5 * sin((start + deg * (t - 1)) * pi / 180),mvalue[t])
    if (deg * (t - 1) < 180 && deg * (t - 1) > 0 ) {
      text(x = 5 + 3.3 * cos((start + deg * (t - 1)) * pi / 180),
           y = 5 + 3.3 * sin((start + deg * (t - 1)) * pi / 180),
           sample[t],#srt = deg * (t - 1) - start,
           adj = .7,cex = text_cex)
    } else {
      text(x = 5 + 3.3 * cos((start + deg * (t - 1)) * pi / 180),
           y = 5 + 3.3 * sin((start + deg * (t - 1)) * pi / 180),
           sample[t],#srt = deg * (t - 1) + start,
           adj = .4,cex = text_cex
      )}
  })
  plotrix::draw.circle(x = 5, y = 5, r = circle_r, col = circle_col, border = circle_border)
  text(x=5,y=5,labels = circle_text,col = circle_text_col,cex = circle_text_cex)
}

# test
#flower_plot2(paste('sp',1:22,sep = ''),1:22,ellipse_col = 1:22,circle_text = 'core=10')
