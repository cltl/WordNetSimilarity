# for each output file

# 1 set of files with all scores (conf)
# for all others: contain files with scores for only one measurement


# creating output for complete set

for set in mc rg simlex-999
    do
        python ../ConversionScripts/convert_all_score_2_per_measurement.py ../../Output/AllPosCross/$set-conf-wn3_ws_2.05.txt ../../Output/PairWise/AllPosCross/$set-conf-wn3_ws205
        python ../ConversionScripts/convert_all_score_2_per_measurement.py ../../Output/AllPosId/$set-conf-wn3_ws_2.05.txt ../../Output/PairWise/AllPosId/$set-conf-wn3_ws205
        python ../ConversionScripts/convert_all_score_2_per_measurement.py ../../Output/NounsOnly/$set-conf-wn3_ws_2.05.txt ../../Output/PairWise/NounsOnly/$set-conf-wn3_ws205
    done


for set in mc rg simlex-999
    do
        for measurement in lch wup lesk
            do
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/AllPosCross/$set-conf6-wn3_ws_2.05-$measurement.txt ../../Output/PairWise/AllPosCross/$set-conf6-wn3_ws205
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/AllPosId/$set-conf6-wn3_ws_2.05-$measurement.txt ../../Output/PairWise/AllPosId/$set-conf6-wn3_ws205
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/NounsOnly/$set-conf6-wn3_ws_2.05-$measurement.txt ../../Output/PairWise/NounsOnly/$set-conf6-wn3_ws205
            done
        for prefix in conf9 conf6-9
            do
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/AllPosCross/$set-$prefix-wn3_ws_2.05.txt ../../Output/PairWise/AllPosCross/$set-$prefix-wn3_ws205
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/AllPosId/$set-$prefix-wn3_ws_2.05.txt ../../Output/PairWise/AllPosId/$set-$prefix-wn3_ws205
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/NounsOnly/$set-$prefix-wn3_ws_2.05.txt ../../Output/PairWise/NounsOnly/$set-$prefix-wn3_ws205
            done
    done

