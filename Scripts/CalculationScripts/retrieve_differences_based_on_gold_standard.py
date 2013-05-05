import sys


def get_max_difference(numbs, tabs):
    my_scores = [tabs[numbs[0]], tabs[numbs[1]], tabs[numbs[2]]]
    tot_scores = []
    for s in my_scores:
        if '-' in s:
            for my_s in s.split('-'):
                if my_s:
                    tot_scores.append(float(my_s))
        else:
            tot_scores.append(float(s))
    lo = min(tot_scores)
    hi = max(tot_scores)
    return [hi,lo]


def same_ranks(numbs, tabs):
    same_ranks = 0
    r1 = numbs[0] + 1
    r2 = numbs[1] + 1
    r3 = numbs[2] + 1
    if tabs[r1] == tabs[r2]:
        same_ranks += 1
        if tabs[r1] == tabs[r3]:
            same_ranks += 2
    elif tabs[r1] == tabs[r3]:
        same_ranks += 1
    elif tabs[r2] == tabs[r3]:
        same_ranks += 1
    return same_ranks
    


def get_results_from_file(wnfile, max_tau, max_rho, rank_diff, rank_same, exact_scores):

    rho_comp = [[2,8,14],[4,10,16],[6,12,18]]
    tau_comp = [[20,26,32],[22,28,34],[24,30,36]]
    my_input = open(wnfile, 'r')
    for line in my_input:
        tabs = line.split('\t')
        if len(tabs) > 30:
            for rhc in rho_comp:
               hi_lo = get_max_difference(rhc, tabs)
               my_diff = hi_lo[0] - hi_lo[1]
               if my_diff > max_rho:
                   max_rho = my_diff
                   exact_scores[0] = [hi_lo[0], hi_lo[1], tabs[0]]
               id_ranks = same_ranks(rhc, tabs)
               rank_diff += (3 - id_ranks)
               rank_same += id_ranks
            for thc in tau_comp:
               hi_lo = get_max_difference(thc, tabs)
               my_diff = hi_lo[0] - hi_lo[1]
               if my_diff > max_tau:
                   max_tau = my_diff
                   exact_scores[1] = [hi_lo[0], hi_lo[1], tabs[0]]
               id_ranks = same_ranks(thc, tabs)
               rank_diff += (3 - id_ranks)
               rank_same += id_ranks
    my_input.close()
    return [max_tau, max_rho, rank_diff, rank_same, exact_scores]
            
            
        



def compare_results_from_wns(wnf1, wnf2):

    max_rho = 0.0
    max_tau = 0.0
    rank_diff = 0
    rank_same = 0
    exact_scores = [[0,0,''],[0,0,'']]

    updated_ranks = get_results_from_file(wnf1, max_tau, max_rho, rank_diff, rank_same, exact_scores)
    final_ranks = get_results_from_file(wnf2, updated_ranks[0], updated_ranks[1], updated_ranks[2], updated_ranks[3],updated_ranks[4])


    print 'Max Diff rho', final_ranks[1]
    print 'Max Diff tau', final_ranks[0]
    print 'Different ranking for different gold: ', final_ranks[2]
    print 'Same ranking two golds', final_ranks[3]
    print 'Tracing back indicatives', final_ranks[4]







def main(argv=None):
    if argv is None:
        argv = sys.argv
    if len(argv) < 3:
        print 'Usage: python retrieve_differences_based-on_versions.py wn2.1_rank_output wn3.0_rank_output'
    else:
        compare_results_from_wns(argv[1], argv[2])


if __name__ == '__main__':
    main()
