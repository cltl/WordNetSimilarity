# for each output file

# 1 set of files with all scores (conf)
# for all others: contain files with scores for only one measurement


# creating output for complete set

for set in mc rg
    do
        python ../ConversionScripts/convert_all_score_2_per_measurement.py ../../Output/AllPosCross/$set-conf-wn2.1_ws_1.02.txt ../../Output/PairWise/AllPosCross/$set-conf-wn21_ws102
        python ../ConversionScripts/convert_all_score_2_per_measurement.py ../../Output/AllPosId/$set-conf-wn2.1_ws_1.02.txt ../../Output/PairWise/AllPosId/$set-conf-wn21_ws102
        python ../ConversionScripts/convert_all_score_2_per_measurement.py ../../Output/NounsOnly/$set-conf-wn2.1_ws_1.02.txt ../../Output/PairWise/NounsOnly/$set-conf-wn21_ws102
    done


for set in mc rg
    do
        for measurement in lch wup lesk
            do
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/AllPosCross/$set-conf6-wn2.1_ws_1.02-$measurement.txt ../../Output/PairWise/AllPosCross/$set-conf6-wn21_ws102
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/AllPosId/$set-conf6-wn2.1_ws_1.02-$measurement.txt ../../Output/PairWise/AllPosId/$set-conf6-wn21_ws102
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/NounsOnly/$set-conf6-wn2.1_ws_1.02-$measurement.txt ../../Output/PairWise/NounsOnly/$set-conf6-wn21_ws102
            done
        for prefix in conf9 conf6-9
            do
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/AllPosCross/$set-$prefix-wn2.1_ws_1.02.txt ../../Output/PairWise/AllPosCross/$set-$prefix-wn21_ws102
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/AllPosId/$set-$prefix-wn2.1_ws_1.02.txt ../../Output/PairWise/AllPosId/$set-$prefix-wn21_ws102
                python ../ConversionScripts/convert_1_score_2_gold_comp_output.py ../../Output/NounsOnly/$set-$prefix-wn2.1_ws_1.02.txt ../../Output/PairWise/NounsOnly/$set-$prefix-wn21_ws102
            done
    done

