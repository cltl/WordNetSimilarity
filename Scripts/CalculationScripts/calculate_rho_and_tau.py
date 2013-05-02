#!usr/bin/python

import nltk
from Pycluster.cluster import *
import sys
import scipy




def create_value_dict(input_file):
    pair_val_dict = {}
    my_if = open(input_file,'r')
    for line in my_if:
        if '<>' in line:
            parts = line.split('<>')
            key = parts[1] + '-' + parts[2]
            score = parts[3].split(' ')[1]
            pair_val_dict[key] = score
    my_if.close()
    return pair_val_dict


def create_comparative_rankings(gdict, cdict):
    gvals = []
    cvals = []
    for k, v in gdict.items():
        gv = gdict[k]
        cv = cdict[k]
        gvals.append(gv)
        cvals.append(cv)
    return [gvals, cvals]


def compute_rankings(input_f, gold_file):

    gold_values = create_value_dict(gold_file)
    comp_values = create_value_dict(input_f)
    
    my_comp_vals = create_comparative_rankings(gold_values, comp_values)
    gold = my_comp_vals[0]
    smes = my_comp_vals[1]
    spearman_value =1-distancematrix((gold,smes), dist="s")[1][0]
    tau_value = scipy.stats.stats.kendalltau(gold, smes)[0]
    print 'Spearman ranking: ' + str(spearman_value) + ' Kendall tau: ' + str(tau_value)


def main(argv=None):
    if argv is None:
        argv = sys.argv
    if len(argv) < 3:
        print 'Usage: python calculate_rho_and_tau.py measurement_file gold_file'
        print 'where measurements_file is the output of different measurements in format:\n w1 w2 jcn lesk path lch vector lin res random wup\n(i.e. the word pairs and list of measurements in the order above separated by spaces'
    else:
        compute_rankings(argv[1], argv[2])

if __name__ == '__main__':
    main()

    


