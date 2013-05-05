
import sys



#adapt so that it provides the exact scores that lead to the difference

def get_results_from_file(wnfile, max_tau, max_rho, rank_diff, rank_same, no_conf_infl, conf_infl, exact_scores):
    my_input = open(wnfile, 'r')
    for line in my_input:
        tabs = line.split('\t')
        if len(tabs) > 30:
            for i in range(2, 19, 2):
                if '-' in tabs[i]:
                    conf_infl += 1
                    my_scores_str = tabs[i].split('-')
                    my_scores = []
                    for my_s_str in my_scores_str:
                        if my_s_str:
                            my_scores.append(float(my_s_str))
                    diff = max(my_scores) - min(my_scores)
                    if diff > max_rho:
                        max_rho = diff
                        max_min_rank = [max(my_scores), min(my_scores), tabs[0]]
                        exact_scores[0] = max_min_rank
                    ranks = tabs[i+1]
                    if ',' in ranks:
                        all_ranks = ranks.split(',')
                        rank_diff += len(all_ranks)
                        rank_same += len(my_scores) - len(all_ranks)
                    else:
                        rank_same += len(my_scores)
                else:
                    no_conf_infl += 1
            for i in range(20, 37, 2):
                if '-' in tabs[i]:
                    conf_infl += 1
                    my_scores_str = tabs[i].split('-')
                    my_scores = []
                    for my_s_str in my_scores_str:
                        if my_s_str:
                            my_scores.append(float(my_s_str))
                    diff = max(my_scores) - min(my_scores)
                    if diff > max_tau:
                        max_tau = diff
                        max_min_rank = [max(my_scores), min(my_scores), tabs[0]]
                        exact_scores[1] = max_min_rank
                    ranks = tabs[i+1]
                    if ',' in ranks:
                        all_ranks = ranks.split(',')
                        rank_diff += len(all_ranks)
                        rank_same += len(my_scores) - len(all_ranks)
                    else:
                        rank_same += len(my_scores)
                else:
                    no_conf_infl += 1


    my_input.close()

    return [max_tau, max_rho, rank_diff, rank_same, no_conf_infl, conf_infl, exact_scores]








def compare_results_from_wns(wnf1, wnf2):

    max_rho = 0.0
    max_tau = 0.0
    rank_diff = 0
    rank_same = 0
    no_conf_infl = 0
    conf_infl = 0
    exact_scores = [[0,0,''],[0,0,'']]

    updated_ranks = get_results_from_file(wnf1, max_tau, max_rho, rank_diff, rank_same, no_conf_infl, conf_infl, exact_scores)
    final_ranks = get_results_from_file(wnf2, updated_ranks[0], updated_ranks[1], updated_ranks[2], updated_ranks[3],updated_ranks[4],updated_ranks[5], updated_ranks[6])


    print 'Max Diff rho', final_ranks[1]
    print 'Max Diff tau', final_ranks[0]
    print 'Different ranking for different config: ', final_ranks[2]
    print 'Same ranking two configs', final_ranks[3]
    print 'Influence of config', final_ranks[5]
    print 'No influence of config', final_ranks[4]
    print 'Tracing back indicatives', final_ranks[6]

def main(argv=None):
    if argv is None:
        argv = sys.argv
    if len(argv) < 3:
        print 'Usage: python retrieve_differences_based-on_versions.py wn2.1_rank_output wn3.0_rank_output'
    else:
        compare_results_from_wns(argv[1], argv[2])


if __name__ == '__main__':
    main()
