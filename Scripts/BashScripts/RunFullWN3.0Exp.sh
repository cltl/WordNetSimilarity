bash ./calculateScores_MC_RG_WN3.0_WNSIM_2.05.sh
bash ./ConvertToPairWiseWN3.sh
bash ./CalculateRankCoefficientsWN3.sh > ../../Output/results_wn3.txt
python ../ConversionScripts/retrieve_score_overview.py ../../Output/results_wn3.txt ../../Output/results_wn3_overview.txt
python ../ConversionScripts/create_score_output.py ../../Output/results_wn3_overview.txt ../../Output/score_wn3_overview.txt
python ../CalculationScripts/calculate_ranking_of_scores.py ../../Output/results_wn3_overview.txt ../../Output/ranking_wn3_results.txt

