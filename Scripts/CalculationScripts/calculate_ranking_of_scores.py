import sys


def create_ranking_numbers(ms_scores):
    score_dict = {}
    for ms, v in ms_scores.items():
        if '-' in v:
            scores = v.split('-')
        else:
            scores = [v]
        for score in scores:    
            if score in score_dict:
                score_dict[score].append(ms)
            else:
                score_dict[score] = [ms]
    rank_dict = {}
    rank = 1
    count = 1
    for k in reversed(sorted(score_dict.keys())):
        for v in score_dict[k]:
            if not v in rank_dict:
                rank_dict[v] = str(rank)
                count += 1
            else:
                old_val = rank_dict[v]
                if not ',' in old_val:
                    if int(old_val) != rank - 1:
                        new_rank = True
                    else:
                        new_rank = False
                else:
                    new_rank = True
                    for ov in old_val.split(','):
                        if int(ov) == rank - 1:
                            new_rank = False
                if new_rank:
                    new_val = old_val + ',' + str(rank)
                    rank_dict[v] = new_val 
                    count += 1 
        rank = count
    return rank_dict    



def determine_rankings(r_dictionary):
    my_dicts = [{}, {}, {}, {}, {}, {},{},{},{},{},{},{},{},{},{},{},{},{}]
    for k, v in r_dictionary.items():
        i = 0
        for d in my_dicts:
            d[k] = v[i]
            i += 1
    my_r_dicts = []
    for d in my_dicts: 
        r_d = create_ranking_numbers(d)
        my_r_dicts.append(r_d)
    return my_r_dicts

def create_ranking_per_score(input_f, output_f):
    my_input = open(input_f, 'r')
    meas_score = {}
    sc_list = []
    measure = ''
    spear_man = False
    for line in my_input:
        if '::' in line:
            if measure and not 'random' in measure:
                meas_score[measure] = sc_list
            measure = line.split('::')[1]
            sc_list = []
        elif 'RG:' in line or 'MC:' in line:
            scores = line.split('\t')
            for n in range(2, len(scores)):
                if scores[n].rstrip():
                    sc_list.append(scores[n].rstrip())
    meas_score[measure] = sc_list
    my_input.close()
    
    outf = open(output_f, 'w')
    r_ds = determine_rankings(meas_score)
    ranks = {}
    for k, v in meas_score.items():
        if 'vector_pairs' in k:
            outf.write(k + "\t")
        else:
            outf.write(k + "\t")
        i = 0
        tot_v = set()
        for val in v:
            r_d = r_ds[i]
            outf.write("\t" + val + "\t" + r_d.get(k))
            tot_v.add(r_d.get(k))
            i += 1
        ranks[k] = tot_v
        outf.write("\n")    

    outf.write("\n\n")
    outf.write("Ranks:\n\n")
    for k, v in ranks.items():
        outf.write(k + "\t\t")
        my_rs = ''
        for val in v:
            my_rs += str(val) + ", "
        my_rs = my_rs.rstrip(", ")
        outf.write(my_rs + "\n")    
    outf.close()    
  #  r_ds = determine_rankings(meas_score)
  #  for rd in r_ds:
  #      for k, v, in rd.items():
  #          outf.write(k + "\t" + v + "\n")
  #  outf.close()




def main(argv=None):
    if argv is None:
        argv = sys.argv
    if len(argv) < 3:
        print 'Usage: python '
        print 'where measurements_file is the output of different measurements in format:\n w1 w2 jcn lesk path lch vector lin res random wup\n(i.e. the word pairs and list of measurements in the order above separated by spaces'
    else:
        create_ranking_per_score(argv[1], argv[2])


if __name__ == '__main__':
    main()














