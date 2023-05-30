library(dplyr)
library(stringr)
library(tidytext)
library(tidyverse)
library(textdata)
library(ggplot2)
library(RColorBrewer)

all_comments <- read.csv("season_data.csv")

AFINN <- get_sentiments("afinn") %>%
    select(word, afinn_score = value)

s1 <- all_comments %>%
    filter(str_detect(body, regex("season 1", ignore_case = TRUE))) %>%
    select(body) %>%
    mutate(season = "season 1")
write.csv((s1), "season1_comments.csv")

s2 <- all_comments %>%
    filter(str_detect(body, regex("season 2", ignore_case = TRUE))) %>%
    select(body) %>%
    mutate(season = "season 2")
write.csv((s2), "season2_comments.csv")

s3 <- all_comments %>%
    filter(str_detect(body, regex("season 3", ignore_case = TRUE))) %>%
    select(body) %>%
    mutate(season = "season 3")
write.csv((s3), "season3_comments.csv")

s4 <- all_comments %>%
    filter(str_detect(body, regex("season 4", ignore_case = TRUE))) %>%
    select(body) %>%
    mutate(season = "season 4")
write.csv((s4), "season4_comments.csv")

s5 <- all_comments %>%
    filter(str_detect(body, regex("season 5", ignore_case = TRUE))) %>%
    select(body) %>%
    mutate(season = "season 5")
write.csv((s5), "season5_comments.csv")

s6 <- all_comments %>%
    filter(str_detect(body, regex("season 6", ignore_case = TRUE))) %>%
    select(body) %>%
    mutate(season = "season 6")
write.csv((s6), "season6_comments.csv")

s7 <- all_comments %>%
    filter(str_detect(body, regex("season 7", ignore_case = TRUE))) %>%
    select(body) %>%
    mutate(season = "season 7")
write.csv((s7), "season7_comments.csv")

s8 <- all_comments %>%
    filter(str_detect(body, regex("season 8", ignore_case = TRUE))) %>%
    select(body) %>%
    mutate(season = "season 8")
write.csv((s8), "season8_comments.csv")

merged_comments <- rbind(s1, s2, s3, s4, s5, s6, s7, s8)
write.csv((merged_comments), "merged_comments.csv")

merged_comments_mentions <- merged_comments

merged_comments_sentiment <- merged_comments_mentions %>%
    select(body, season) %>%
    unnest_tokens(word, body) %>%
    anti_join(stop_words) %>%
    inner_join(AFINN, by = "word") %>%
    group_by(season, word) %>%
    summarize(sentiment = mean(afinn_score)) %>%
    group_by(season) %>%
    summarize_at(vars(sentiment), list(total_sentiment = mean))

merged_comments_sentiment

write.csv((merged_comments_sentiment), "merged_comments_mentions.csv")

ggplot(merged_comments_sentiment, aes(x = season, y = total_sentiment, color = season)) +
    geom_boxplot()
ggsave("plot1.png")