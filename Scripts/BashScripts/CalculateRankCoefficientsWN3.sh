# for each output file

# step 1: create similarity score output #ADAPT CODE TO INCLUDE LAST TWO
# step 2: calculate coefficient (write to file)
# step 3: cat outfiles coefficient




for set in mc mc-mc rg
    do
        if [ $set == "mc-mc" ]
            then
                set2=mc
        elif [ $set == "mc" ]
            then
                set2=mc
            else
                set2=rg
        fi
        for measurement in jcn lesk path lch vector lin res random wup vector_pairs hso
			do 
				echo $set, " conf ", $measurement, " all pos cross"
				python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/AllPosCross/$set2-conf-wn3_ws205-$measurement.txt
				echo $set, "  conf  ", $measurement, " all pos id"
				python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/AllPosId/$set2-conf-wn3_ws205-$measurement.txt
				echo $set, "  conf ", $measurement, " nouns only"
				python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/NounsOnly/$set2-conf-wn3_ws205-$measurement.txt
			done
        for measurement in lch lesk wup
            do
                echo $set, " conf6 ", $measurement, " all pos cross"
                python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/AllPosCross/$set2-conf6-wn3_ws205-$measurement.txt
                echo $set, "  conf6  ", $measurement, " all pos id"
                python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/AllPosId/$set2-conf-wn3_ws205-$measurement.txt
                echo $set, "  conf6 ", $measurement, " nouns only"
                python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/NounsOnly/$set2-conf-wn3_ws205-$measurement.txt
            done
        for prefix in conf6-9 conf6
            do
                echo $set, " ", $prefix, " lesk, all pos cross"
                python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/AllPosCross/$set2-$prefix-wn3_ws205-lesk.txt
                echo $set, " ", $prefix, " lesk, all pos id"
                python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/AllPosId/$set2-$prefix-wn3_ws205-lesk.txt
                echo $set, " ", $prefix, " lesk, nouns only"
                python ../CalculationScripts/calculate_rho_and_tau.py ../../Data/$set-key.txt ../../Output/PairWise/NounsOnly/$set2-$prefix-wn3_ws205-lesk.txt
            done
    done

