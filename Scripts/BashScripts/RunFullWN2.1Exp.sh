#create output directories
mkdir -p ../../Output/AllPosCross
mkdir ../../Output/AllPosId
mkdir ../../Output/NounsOnly
mkdir ../../Output/PairWise

bash ./calculateScores_MC_RG_WN2.1_WNSIM_1.02.sh
bash ./ConvertToPairWiseWN2.1.sh
bash ./CalculateRankCoefficientsWN2.1.sh > ../../Output/results_wn2.1.txt
python ../ConversionScripts/retrieve_score_overview.py ../../Output/results_wn2.1.txt ../../Output/results_wn2.1_overview.txt
python ../ConversionScripts/create_score_output.py ../../Output/results_wn2.1_overview.txt ../../Output/score_overview_wn2.1.txt
python ../CalculationScripts/calculate_ranking_of_scores.py ../../Output/results_wn2.1_overview.txt ../../Output/ranking_wn2.1_results.txt
