export WNHOME=/usr/local/WordNet-3.0/
#set variable configs back to basics

cp ../PerlScripts/config-files/config-lesk.conf-default ../PerlScripts/config-files/config-lesk.conf
cp ../PerlScripts/config-files/config-lch.conf-default ../PerlScripts/config-files/config-lch.conf
cp ../PerlScripts/config-files/config-wup.conf-default ../PerlScripts/config-files/config-wup.conf

#run programs with default configuration files

[ -d ../../Output/AllPosCross ] || mkdir -p ../../Output/AllPosCross

perl ../PerlScripts/similarity_scores_config_allPosCross.pl ../../Data/mc.txt ../../Output/AllPosCross/mc-conf-wn3_ws_2.05.txt
perl ../PerlScripts/similarity_scores_config_allPosCross.pl ../../Data/rg.txt ../../Output/AllPosCross/rg-conf-wn3_ws_2.05.txt

[ -d ../../Output/AllPosId ] || mkdir -p ../../Output/AllPosId

perl ../PerlScripts/similarity_scores_config_all_id_pos.pl ../../Data/mc.txt ../../Output/AllPosId/mc-conf-wn3_ws_2.05.txt
perl ../PerlScripts/similarity_scores_config_all_id_pos.pl ../../Data/rg.txt ../../Output/AllPosId/rg-conf-wn3_ws_2.05.txt


[ -d ../../Output/NounsOnly ] || mkdir -p ../../Output/NounsOnly

perl ../PerlScripts/similarity_scores_config_n_only.pl ../../Data/mc.txt ../../Output/NounsOnly/mc-conf-wn3_ws_2.05.txt
perl ../PerlScripts/similarity_scores_config_n_only.pl ../../Data/rg.txt ../../Output/NounsOnly/rg-conf-wn3_ws_2.05.txt

#changing configurations for those scores where this has impact and run scores

cp ../PerlScripts/config-files/config-lesk.conf-6 ../PerlScripts/config-files/config-lesk.conf
cp ../PerlScripts/config-files/config-lch.conf-6 ../PerlScripts/config-files/config-lch.conf
cp ../PerlScripts/config-files/config-wup.conf-6 ../PerlScripts/config-files/config-wup.conf


#loop with one measure program

for ms in lesk lch wup
    do
        perl ../PerlScripts/similarity_scores_config_allPosCross_one_measurement.pl ../../Data/mc.txt ../../Output/AllPosCross/mc-conf6-wn3_ws_2.05-$ms.txt $ms
        perl ../PerlScripts/similarity_scores_config_allPosCross_one_measurement.pl ../../Data/rg.txt ../../Output/AllPosCross/rg-conf6-wn3_ws_2.05-$ms.txt $ms

        perl ../PerlScripts/similarity_scores_config_all_id_pos_one_measurement.pl ../../Data/mc.txt ../../Output/AllPosId/mc-conf6-wn3_ws_2.05-$ms.txt $ms
        perl ../PerlScripts/similarity_scores_config_all_id_pos_one_measurement.pl ../../Data/rg.txt ../../Output/AllPosId/rg-conf6-wn3_ws_2.05-$ms.txt $ms

        perl ../PerlScripts/similarity_scores_config_n_only_one_measurement.pl ../../Data/mc.txt ../../Output/NounsOnly/mc-conf6-wn3_ws_2.05-$ms.txt $ms
        perl ../PerlScripts/similarity_scores_config_n_only_one_measurement.pl ../../Data/rg.txt ../../Output/NounsOnly/rg-conf6-wn3_ws_2.05-$ms.txt $ms
    done

cp ../PerlScripts/config-files/config-lch.conf-default ../PerlScripts/config-files/config-lch.conf
cp ../PerlScripts/config-files/config-wup.conf-default ../PerlScripts/config-files/config-wup.conf

#changing lesk configuration that has impact & run scores


cp ../PerlScripts/config-files/config-lesk.conf-9 ../PerlScripts/config-files/config-lesk.conf

perl ../PerlScripts/similarity_scores_config_allPosCross_one_measurement.pl ../../Data/mc.txt ../../Output/AllPosCross/mc-conf9-wn3_ws_2.05.txt lesk
perl ../PerlScripts/similarity_scores_config_allPosCross_one_measurement.pl ../../Data/rg.txt ../../Output/AllPosCross/rg-conf9-wn3_ws_2.05.txt lesk

perl ../PerlScripts/similarity_scores_config_all_id_pos_one_measurement.pl ../../Data/mc.txt ../../Output/AllPosId/mc-conf9-wn3_ws_2.05.txt lesk
perl ../PerlScripts/similarity_scores_config_all_id_pos_one_measurement.pl ../../Data/rg.txt ../../Output/AllPosId/rg-conf9-wn3_ws_2.05.txt lesk


perl ../PerlScripts/similarity_scores_config_n_only_one_measurement.pl ../../Data/mc.txt ../../Output/NounsOnly/mc-conf9-wn3_ws_2.05.txt lesk
perl ../PerlScripts/similarity_scores_config_n_only_one_measurement.pl ../../Data/rg.txt ../../Output/NounsOnly/rg-conf9-wn3_ws_2.05.txt lesk

#changing final lesk config (combi 6 and 9) and run experiment

cp ../PerlScripts/config-files/config-lesk.conf-10 ../PerlScripts/config-files/config-lesk.conf

perl ../PerlScripts/similarity_scores_config_allPosCross_one_measurement.pl ../../Data/mc.txt ../../Output/AllPosCross/mc-conf6-9-wn3_ws_2.05.txt lesk
perl ../PerlScripts/similarity_scores_config_allPosCross_one_measurement.pl ../../Data/rg.txt ../../Output/AllPosCross/rg-conf6-9-wn3_ws_2.05.txt lesk

perl ../PerlScripts/similarity_scores_config_all_id_pos_one_measurement.pl ../../Data/mc.txt ../../Output/AllPosId/mc-conf6-9-wn3_ws_2.05.txt lesk
perl ../PerlScripts/similarity_scores_config_all_id_pos_one_measurement.pl ../../Data/rg.txt ../../Output/AllPosId/rg-conf6-9-wn3_ws_2.05.txt lesk


perl ../PerlScripts/similarity_scores_config_n_only_one_measurement.pl ../../Data/mc.txt ../../Output/NounsOnly/mc-conf6-9-wn3_ws_2.05.txt lesk
perl ../PerlScripts/similarity_scores_config_n_only_one_measurement.pl ../../Data/rg.txt ../../Output/NounsOnly/rg-conf6-9-wn3_ws_2.05.txt lesk

cp ../PerlScripts/config-files/config-lesk.conf-default ../PerlScripts/config-files/config-lesk.conf



