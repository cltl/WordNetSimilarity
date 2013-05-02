import sys
import decimal


#for each score a list of kendall values and a list of spearman rank values
scores = {'hso':[[],[]], 'jcn' : [[],[]], 'lch' : [[],[]], 'lesk' : [[],[]], 'lin' : [[],[]], 'path' : [[],[]], 'random' : [[],[]], 'res' : [[],[]], 'vector' : [[],[]], 'vector_pairs' : [[],[]], 'wup' : [[],[]]}

#dictionary that defines for each data-pos-combi where in the scores list it is
location_in_scores = {'mc-apc':0,'mc-api':1, 'mc-no':2,'rg-apc':3, 'rg-api':4, 'rg-no':5, 'mc-mc-apc':6, 'mc-mc-api':7, 'mc-mc-no':8}


def get_pos_stat(description):
    if 'cross' in description:
        return 'apc'
    if 'id' in description:
        return 'api'
    if 'noun' in description:
        return 'no'
    print 'Problem interpreting', description
    return description


def get_values(val):
    output1 = ''
    output2 = ''
    output3 = ''
    i = 0
    for vlist in val:
        score = ''
        for v in set(vlist):
            score += str(v) + '-'
        i += 1
        #first three are set mc
        if i < 4:
            output1 += '\t' + score.rstrip('-')
        #last three are set rg
        elif i < 7:
            output2 += '\t' + score.rstrip('-')
        else:
            output3 += '\t' + score.rstrip('-')
    return [output1, output2, output3]

def retrieve_scores(input_f, output_f):
    ifile = open(input_f, 'r')
    for line in ifile:
        if ',' in line:
            indications = line.split(',')
            data_set = indications[0]
            if len(indications) < 5:
                conf = indications[1].rstrip(" ").lstrip(" ")
                key = indications[2].lstrip(" ")
                pos_stat = get_pos_stat(indications[3])
            else:
                conf = indications[2].lstrip(" ")
                key = indications[3].lstrip(" ")
                pos_stat = get_pos_stat(indications[4])
        elif ':' in line:
            ranks = line.split(':')
            spearm_r = decimal.Decimal(ranks[1].split(" ")[1])
            kendall_t = decimal.Decimal(ranks[2].split(" ")[1])
            loc = location_in_scores.get(data_set + '-' + pos_stat)
            spear_r_l = scores.get(key)[0]
            kend_t_l = scores.get(key)[1]
            #introducing 9 variations in scores
            if len(spear_r_l) == 0:
                spear_r_l = [[],[],[],[],[],[],[],[],[]]
                kend_t_l = [[],[],[],[],[],[],[],[],[]]
            spear_r_l[loc].append(round(spearm_r,4))
            kend_t_l[loc].append(round(kendall_t,4))
            scores[key] = [spear_r_l, kend_t_l]

    ifile.close()

    outf = open(output_f, 'w')
    for k, v in scores.items():
        outf.write("::" + k + "::\n")
        sp_l = get_values(v[0])
        outf.write("Spearman ranking:\n")
        outf.write("\tMC_from_RG:"+ sp_l[0] + "\n")
        outf.write("\tRG:\t"+ sp_l[1] + "\n")
        outf.write("\tMC_from_MC:"+ sp_l[2] + "\n")
        k_l = get_values(v[1])
        outf.write("Kendall tau:\n")
        outf.write("\tMC_from_RG:"+ k_l[0] + "\n")
        outf.write("\tRG:\t"+ k_l[1] + "\n")
        outf.write("\tMC_from_MC:"+ k_l[2] + "\n")
    outf.close()


def main(argv=None):
    if argv is None:
        argv = sys.argv
    if len(argv) < 3:
        print 'Usage: python retrieve_score_over.py results_overview_file_name\n'
    else:
        retrieve_scores(argv[1], argv[2])









if __name__ == '__main__':
    main()
