#!/usr/bin/env bash
#
#                        _              _              _              
#   ___ _ __ _   _ _ __ | |_ ___       | | ___ __ __ _| | _____ _ __  
#  / __| '__| | | | '_ \| __/ _ \ _____| |/ / '__/ _` | |/ / _ \ '_ \ 
# | (__| |  | |_| | |_) | || (_) |_____|   <| | | (_| |   <  __/ | | |
#  \___|_|   \__, | .__/ \__\___/      |_|\_\_|  \__,_|_|\_\___|_| |_|
#            |___/|_|                                                 
#
# ****************************************************************************
#
# NAME        : crypto-kraken.sh
#
# VERSION     : 0.1
#
# TESTED on   : Debian Jessie 9 (amd64) 
#
# DESCRIPTION : - Display the last value of cryptos by category from the kraken exchange.
#               - Show the last value of a crypto from the kraken exchange. 
#
# USAGE	      : - (without arguments) ./crypto_kraken
#               - (with one argument) ./crypto_kraken XBTEUR
#				      
#
#
check_last_eur_value ()
{
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XBTEUR | sed -e 's/.*"c":."\([^"]*\).*/XBTEUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHEUR | sed -e 's/.*"c":."\([^"]*\).*/ETHEUR=\1€\n/'	
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=DASHEUR | sed -e 's/.*"c":."\([^"]*\).*/DASHEUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETCEUR | sed -e 's/.*"c":."\([^"]*\).*/ETCEUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=GNOEUR | sed -e 's/.*"c":."\([^"]*\).*/GNOEUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=LTCEUR | sed -e 's/.*"c":."\([^"]*\).*/LTCEUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=REPEUR | sed -e 's/.*"c":."\([^"]*\).*/REPEUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XLMEUR | sed -e 's/.*"c":."\([^"]*\).*/XLMEUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XMREUR | sed -e 's/.*"c":."\([^"]*\).*/XMREUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XRPEUR | sed -e 's/.*"c":."\([^"]*\).*/XRPEUR=\1€\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ZECEUR | sed -e 's/.*"c":."\([^"]*\).*/ZECEUR=\1€\n/'
}

check_last_usd_value ()
{
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XBTUSD | sed -e 's/.*"c":."\([^"]*\).*/XBTUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHUSD | sed -e 's/.*"c":."\([^"]*\).*/ETHUSD=\1$\n/'	
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=DASHUSD | sed -e 's/.*"c":."\([^"]*\).*/DASHUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETCUSD | sed -e 's/.*"c":."\([^"]*\).*/ETCUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=GNOUSD | sed -e 's/.*"c":."\([^"]*\).*/GNOUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=LTCUSD | sed -e 's/.*"c":."\([^"]*\).*/LTCUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=REPUSD | sed -e 's/.*"c":."\([^"]*\).*/REPUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XLMUSD | sed -e 's/.*"c":."\([^"]*\).*/XLMUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XMRUSD | sed -e 's/.*"c":."\([^"]*\).*/XMRUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XRPUSD | sed -e 's/.*"c":."\([^"]*\).*/XRPUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ZECUSD | sed -e 's/.*"c":."\([^"]*\).*/ZECUSD=\1$\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=USDTUSD | sed -e 's/.*"c":."\([^"]*\).*/USDTUSD=\1$\n/'
}    

check_last_xbt_value ()
{
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XBTUSD | sed -e 's/.*"c":."\([^"]*\).*/XBTUSD=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XBTEUR | sed -e 's/.*"c":."\([^"]*\).*/XBTEUR=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XBTCAD | sed -e 's/.*"c":."\([^"]*\).*/XBTCAD=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XBTJPY | sed -e 's/.*"c":."\([^"]*\).*/XBTJPY=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XBTGBP | sed -e 's/.*"c":."\([^"]*\).*/XBTGBP=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHXBT | sed -e 's/.*"c":."\([^"]*\).*/ETHXBT=\1B\n/'	
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=DASHXBT | sed -e 's/.*"c":."\([^"]*\).*/DASHXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETCXBT | sed -e 's/.*"c":."\([^"]*\).*/ETCXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=GNOXBT | sed -e 's/.*"c":."\([^"]*\).*/GNOXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=LTCXBT | sed -e 's/.*"c":."\([^"]*\).*/LTCXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=REPXBT | sed -e 's/.*"c":."\([^"]*\).*/REPXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XLMXBT | sed -e 's/.*"c":."\([^"]*\).*/XLMXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XMRXBT | sed -e 's/.*"c":."\([^"]*\).*/XMRXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XRPXBT | sed -e 's/.*"c":."\([^"]*\).*/XRPXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ZECXBT | sed -e 's/.*"c":."\([^"]*\).*/ZECXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ICNXBT | sed -e 's/.*"c":."\([^"]*\).*/ICNXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=MLNXBT | sed -e 's/.*"c":."\([^"]*\).*/MLNXBT=\1B\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=XDGXBT | sed -e 's/.*"c":."\([^"]*\).*/XDGXBT=\1B\n/'
}     
check_last_eth_value ()
{
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHXBT | sed -e 's/.*"c":."\([^"]*\).*/ETHXBT=\1E\n/'	
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHUSD | sed -e 's/.*"c":."\([^"]*\).*/ETHUSD=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHEUR | sed -e 's/.*"c":."\([^"]*\).*/ETHEUR=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHGBP | sed -e 's/.*"c":."\([^"]*\).*/ETHGBP=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHJPY | sed -e 's/.*"c":."\([^"]*\).*/ETHJPY=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETHCAD | sed -e 's/.*"c":."\([^"]*\).*/ETHCAD=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ETCETH | sed -e 's/.*"c":."\([^"]*\).*/ETCETH=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=GNOETH | sed -e 's/.*"c":."\([^"]*\).*/GNOUSD=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=ICNETH | sed -e 's/.*"c":."\([^"]*\).*/ICNETH=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=MLNETH | sed -e 's/.*"c":."\([^"]*\).*/MLNETH=\1E\n/'
  wget -q -O - https://api.kraken.com/0/public/Ticker?pair=REPETH | sed -e 's/.*"c":."\([^"]*\).*/REPETH=\1E\n/'
}       

#start program
clear 

if [ "$#" = "1" ]; then
	wget -q -O - https://api.kraken.com/0/public/Ticker?pair="$1" | sed -e 's/.*"c":."\([^"]*\).*/'$1'=\1\n/'
else

echo -e "\033[44m-----------------------------------------\033[0m"
echo -e "\033[44m| Check last crypto price from Kraken ! |\033[0m"
echo -e "\033[44m-----------------------------------------\033[0m"
echo -e "\033[32mEnter 1 for all EURO prices\033[0m"
echo -e "\033[32mEnter 2 for all USD prices\033[0m"
echo -e "\033[32mEnter 3 for all XBT prices\033[0m"
echo -e "\033[32mEnter 4 for all ETH prices\033[0m"
echo -e "\\033[41mfollowed by [ENTER]:\033[0m"

read user_choice

	if [ "$user_choice" == "1" ]; then
		check_last_eur_value
	fi
	if [ "$user_choice" == "2" ]; then
		check_last_usd_value
	fi
	if [ "$user_choice" == "3" ]; then
		check_last_xbt_value
	fi
	if [ "$user_choice" == "4" ]; then
		check_last_eth_value
	fi
  
fi

