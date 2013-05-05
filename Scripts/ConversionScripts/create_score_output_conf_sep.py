import sys
import decimal



def create_overall_min_max(inputf, outputf):
    my_input = open(inputf, 'r')
    my_output = open(outputf, 'w')
    measure = ''
    spearman = True
#initiate min and max values by extremes
    s_min = 1.0
    s_max = -1.0
    k_min = 1.0
    k_max = -1.0
    my_output.write("measure\t\trho_min\trho_max\t\ttau_min\ttau_max\n\n")

    for line in my_input:
        if '::' in line:
            #if at least one measure is read, spearman will be false
            if not spearman:
                if measure == 'vector_pairs' or measure == 'lesk-6-9':
                    my_output.write(measure + "\t" + str(s_min) + "\t" + str(s_max) + "\t\t" + str(k_min) + "\t "+ str(k_max) + "\n")
                else:
                    my_output.write(measure + "\t\t" + str(s_min) + "\t" + str(s_max) + "\t\t" + str(k_min) + "\t "+ str(k_max) + "\n")
            #get measure name        
            measure = line.split('::')[1]
            #reset min and max values
            s_min = 1.0
            s_max = -1.0
            k_min = 1.0
            k_max = -1.0
        elif 'Spearman' in line:
            spearman = True
        elif 'Kendall' in line:
            spearman = False
        else:
            scores = line.split('\t')
            for i in range(len(scores)-3, len(scores)):
               if '-' in scores[i]:
                   allScores = scores[i].split('-')
               else:
                   allScores = [scores[i]] 
               for my_s in allScores:
                   if len(my_s):
                       my_s = float(my_s.rstrip("\n"))
                       if spearman:
                           if my_s < s_min:
                               s_min = my_s
                           if my_s > s_max:
                               s_max = my_s
                       else:
                           if my_s < k_min:
                               k_min = my_s
                           if my_s > k_max:
                               k_max = my_s
      #print out final measure
    
    my_output.write(measure + "\t\t" + str(s_min) + "\t" + str(s_max) + "\t\t" + str(k_min) + "\t "+ str(k_max) + "\n")
    my_output.close()
    my_input.close()

def main(argv=None):
    if argv is None:
        argv = sys.argv
    if len(argv) < 3:
        print 'Usage: python create_score_output.py results_overview.txt min_max_result.txt'
    else:
        create_overall_min_max(argv[1], argv[2])


if __name__ == '__main__':
    main()
