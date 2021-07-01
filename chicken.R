library(readxl)
library(dplyr)
library(descr)
library(treemap)
library(stringi)

ck <- read_excel("Total_Address.xlsx")
View(sort(ck$소재지전체주소))

# Total
addr <- stri_extract_first_regex(ck$소재지전체주소, "^\\S+(시|도)\\s")
# In Seoul, do
# addr <- stri_extract_first_regex(ck$소재지전체주소, "\\s.+?\\s")
# In si
# addr <- stri_extract_first_regex(ck$소재지전체주소, "시\\s.+?((동|로)(\\s|\\d)|\\d\\S)")
# In gu
# addr <- stri_extract_first_regex(ck$소재지전체주소, "구\\s.+?((동|로)(\\s|\\d)|\\d\\S)")
sort(unique(addr))

# Total ver.1
addr_trim <- gsub("\\s+$", "", gsub("특별자치", "\n특별자치", addr))
# Total ver.2
# addr_trim <- gsub("\\s+$", "", gsub("(남|북)", "", addr))
# Total ver.3
'
addr_trim <- gsub("\\s+$", "", gsub("(남|북)", "", addr))
addr_trim <- gsub("(광역|특별자치)시", "도", addr_trim)
addr_trim <- gsub("부산", "경상", addr_trim)
addr_trim <- gsub("대구", "경상", addr_trim)
addr_trim <- gsub("인천", "경기", addr_trim)
addr_trim <- gsub("광주", "전라", addr_trim)
addr_trim <- gsub("대전", "충청", addr_trim)
addr_trim <- gsub("울산", "경상", addr_trim)
addr_trim <- gsub("세종", "충청", addr_trim)
'
# In Seoul, do
# addr_trim <- gsub("(\\d가)?(\\s|\\d)*$", "", gsub("^\\s+", "", addr))
# In si, gu
# addr_trim <- gsub("(\\d가)?(\\s|\\d)*$", "", gsub("^\\s+", "", gsub("\\d동", "동", gsub("^(시|구)", "", addr))))
sort(unique(addr_trim))

addr_count <- addr_trim %>% table() %>% data.frame()
addr_count$. <- paste(addr_count$., "\n", addr_count$Freq, "곳", sep = "")
arrange(addr_count, desc(Freq))

treemap(addr_count, index = ".", vSize = "Freq", title = "대한민국 치느님 분포도 1 (2018/12) by Unchun Yang")