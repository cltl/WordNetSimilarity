#!usr/bin/python

import sys

m_dict = {'jcn':2, 'lesk':3, 'path':4, 'lch':5, 'vector':6, 'lin':7, 'res':8, 'random':9, 'wup':10, 'vector_pairs':11, 'hso':12}



def create_ranking_numbers(wds_scs, i):
    score_dict = {}
    for ws in wds_scs:
        score = float(ws[i])
        if score in score_dict:
            score_dict[score].append(ws[0] + '-' + ws[1])
        else:
            score_dict[score] = [ws[0] + '-' + ws[1]]
    rank_dict = {}
    rank = 1
    count = 1
    for k in sorted(score_dict.keys()):
        for v in score_dict[k]:
            rank_dict[v] = str(rank)
            count += 1
        rank = count
    return rank_dict    
    


def create_output_file(wds_scs, i, outf_name):
    my_out = open(outf_name, 'w')
    my_out.write(str(len(wds_scs)) + "\n")
    ranks = create_ranking_numbers(wds_scs, i)
    for ws in wds_scs:
        rank = ranks.get(ws[0] + '-' + ws[1])
        my_out.write('<>' + ws[0] + '<>' + ws[1] + '<>' + rank + ' ' + ws[i] + "\n")
    my_out.close()

def create_files_per_measurement(inputf, prefix):

    my_input = open(inputf, 'r')
    words_scores = []
    for line in my_input:
        words_scores.append(line.split(' '))
    my_input.close()
    for k, v in m_dict.items():
        outf_name = prefix + '-' + k + '.txt'
        create_output_file(words_scores, v, outf_name)






def main(argv=None):
    if argv is None:
        argv = sys.argv
    if len(argv) < 3:
        print 'Usage: python convert_all_score_2_per_measurement.py measurements_file prefix'
        print 'where measurements_file is the output of different measurements in format:\n w1 w2 jcn lesk path lch vector lin res random wup\n(i.e. the word pairs and list of measurements in the order above separated by spaces'
    else:
        create_files_per_measurement(argv[1], argv[2])

if __name__ == '__main__':
    main()
