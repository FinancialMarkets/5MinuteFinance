
graph_highchart <- function(df, mode = "scatter", xtitle = "", ytitle = "", title = "", 
                            round_data = 4, axis_labels = 18, axis_text = 18, title_text = 20, 
                            theme = "default", percent = FALSE, log_ret = FALSE, convert = TRUE,
                            group = "normal") {
  # load the libraries needed
  library(highcharter)
  library(magrittr)
  library(RColorBrewer)
  library(reshape2)
  # save a copy of original dataframe
  df_orig <- df
  # if a cumline is requested, use cumsum_index to generate a price series
  if ((mode == "cumline") | (mode == "cumstock")) {
    df <- cumsum_index(df, 100, geometric = TRUE)
    df_orig_cum <- df
  }
  if (convert) {
    # convert the wide data format into long for graphing
    df <- melt_timeseries(df)
  } else {
    # convert the wide data format into long for graphing
    df <- melt_timeseries(df, xcol = colnames(df_orig)[1])
  }
  # if percent is TRUE then add % to the yaxis label & multiply all values by 100
  if (percent) {
    df[,"value"] <- df[,"value"] * 100
  }
  # round the data according to round_data
  df[,"value"] <- round(df[,"value"], round_data)
  if (length(theme) == 1) {
    # define colors properly if not using a theme
    theme_var <- switch(theme,
                    "default" = FALSE,
                    "538" = hc_theme_538(),
                    "economist" = hc_theme_economist(),
                    "ft" = hc_theme_ft(),
                    "db" = hc_theme_db(),
                    "google" = hc_theme_google(),
                    "flat" = hc_theme_flat(),
                    "flat_dark" = hc_theme_flatdark(),
                    "simple" = hc_theme_smpl(),
                    "grid_light" = hc_theme_gridlight(),
                    "sand_signika" = hc_theme_sandsignika(),
                    "dark_unica" = hc_theme_darkunica(),
                    "chalk" = hc_theme_chalk(),
                    "hand_drawn" = hc_theme_handdrawn(),
                    "null" = hc_theme_null())
  } else {
    colors <- theme
  }
  
  # create the first graph object according to mode
  if ((mode == "line") | (mode == "cumline")) {
    hc_graph <- hchart(df, "line", x = dates, y = value, group = variable)
  } else if ((mode == "stock") | (mode == "cumstock")) {
    xts_data <- convert_df_xts(df_orig_cum)
    xts_data <- round(xts_data, round_data)
    hc_graph <- hchart(xts_data[,1], name = colnames(xts_data)[1])
    if (ncol(df_orig_cum) > 2) {
      for (i in 2:(ncol(df_orig)-1)) {
        hc_graph <- hc_add_series_xts(hc_graph, xts_data[,i], name = colnames(xts_data)[i])
      }
    }
  } else if ((mode == "bar") | (mode == "bar_cont")) {
    hc_graph <- hchart(df, "column", x = dates, y = value, group = variable)
  } else if (mode == "area_cont") {
    hc_graph <- hchart(df, "area", x = dates, y = value, group = variable)
  } else if (mode == "scatter") {
    df_bench <- df[df[,'variable'] == colnames(df_orig)[2],]
    df_new <- df[df[,'variable'] != colnames(df_orig)[2],]
    df_total <- cbind(df_new,df_bench[,"value"])
    colnames(df_total)[ncol(df_total)] <- "bench"
    if (group == "first") {
      hc_graph <- hchart(df_total, "scatter", x = bench, y = value, group = Tickers)
    } else {
      hc_graph <- hchart(df_total, "scatter", x = bench, y = value, group = variable)
    }
    hc_graph <- hc_tooltip(hc_graph, pointFormat = paste('{point.x} ', as.character(unique(df[,"variable"]))[1], '<br> ', '{point.y} ', as.character(unique(df[,"variable"]))[2], sep = ""))
  } else if (mode == "cor") {
    hc_graph <- hchart(cor(df_orig[,-1]))
  } else if (mode == "density") {
    hc_graph <- hcdensity(df_orig[,2], area = TRUE, name = colnames(df_orig)[2])
    if (ncol(df_orig) > 2) {
      for (i in 3:(ncol(df_orig))) {
        hc_graph <- hc_add_series_density(hc_graph, df_orig[,i], area = TRUE, name = colnames(df_orig)[i])
      }
    }
  }
  # add title, xAxis & yAxis labels
  hc_graph <- hc_graph %>% hc_xAxis(title = list(text = xtitle, style = list(fontSize = paste(axis_text, "px", sep = ""))), 
                                     labels = list(style = list(fontSize = paste(axis_labels, "px", sep = "")))) 
  if (log_ret) {
    hc_graph <- hc_graph %>% hc_yAxis(title = list(text = ytitle, style = list(fontSize = paste(axis_text, "px", sep = ""))), 
                                       labels = list(style = list(fontSize = paste(axis_labels, "px", sep = ""))),
                                       type = 'logarithmic')
  } else {
    hc_graph <- hc_graph %>% hc_yAxis(title = list(text = ytitle, style = list(fontSize = paste(axis_text, "px", sep = ""))), 
                                       labels = list(style = list(fontSize = paste(axis_labels, "px", sep = ""))))
  }
  
  hc_graph <- hc_graph %>% hc_title(text = title,
                                     style = list(fontSize = paste(title_text, "px", sep = "")))
  # check if a theme is defined, otherwise just change the colors
  if (length(theme) == 1) {
    # add themes here
    if (theme_var != FALSE) {
      hc_graph <- hc_graph %>% hc_add_theme(theme_var)
    }
  } else {
    hc_graph <- hc_graph %>% hc_colors(colors)
  }
  if (mode == "bar") {
    hc_graph <- hc_graph %>% hc_plotOptions(column = list(grouping = FALSE))
  } else if (mode == "bar_cont") {
    hc_graph <- hc_graph %>% hc_plotOptions(column = list(grouping = FALSE, stacking = "normal"))
  } else if (mode == "area_cont") {
    hc_graph <- hc_graph %>% hc_plotOptions(area = list(stacking = "normal"), series = list(marker = list(enabled = FALSE)))
  }
  return(hc_graph)
}

## convert wide into long data
melt_timeseries <- function(df, xcol = "dates") {
  # put together contribution table
  if (xcol == "dates") {
    colnames(df)[1] <- xcol
    df[,paste(xcol)] <- df[,paste(xcol)] %>% as.Date
  }
  df_melt <- melt(df,id.vars=paste(xcol))
  return(df_melt)
}

## cumulative sum with nas removed
cum_na <- function(x, geometric = FALSE) {
  x[which(is.na(x))] <- 0
  if (geometric) {
    x <- cumprod(1 + x)
  } else {
    x <- cumsum(x)
  }
  return(x)
}

## cumulative sum done on a dataframe with a date column
cumsum_index <- function(df, base = 1, geometric = FALSE) {
  # ensure df is a dataframe
  if (!is.data.frame(df)) {
    stop('df must be a dataframe.')
  }
  # split off the date
  date <- df[,"Date",drop=F]
  # calculate the cumulative sums of each column beyond the first date column
  if (ncol(df) == 2) {
    df[,2] <- cum_na(df[,2], geometric = geometric)
    cumSum <- df[,2,drop=F]
  } else {
    cumSum <- apply(df[,2:ncol(df),drop=F],2, function(x) cum_na(x, geometric = geometric))
  }
  
  if (geometric) {
    if (base != 0) {
      cumSumF <- cumSum * base
    } else {
      cumSumF <- cumSum - 1
    }
  } else {
    if (base != 0) {
      # add one to every cell beyond the first date column to form an index
      cumSum1 <- cumSum + 1
      # multiply by the base number to get the base custum cumsum
      if (length(base) == 1) {
        cumSumF <- cumSum1 * base
      } else if (length(base) == (ncol(df)-1)) {
        cumSumF <- cumSum1 * base[col(cumSum1)]
      } else {
        stop("Base amount must match the amount of df data columns.")
      }
    } else {
      cumSumF <- cumSum
    }
  }
  cumSumF <- as.data.frame(cumSumF)
  cumSumF <- cbind(date[,,drop=F],cumSumF)
  return(cumSumF)
}

## convert dataframe into an xts object with a date index
convert_df_xts <- function(df) {
  # ensure the first column in properly formatted as a date
  df[,1] <- as.Date(df[,1])
  # convert from df to xts
  new_xts <- xts(df[,-1], order.by=df[,1])
  # ensure column name is set correctly
  colnames(new_xts) <- colnames(df)[2:ncol(df)]
  return(new_xts)
}