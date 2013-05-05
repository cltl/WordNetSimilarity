import sys



def create_score_dict_from_file(wnfile):
    my_input = open(wnfile, 'r')
    score_dict = {}
    for line in my_input:
        tabs = line.split('\t')
        rho_scores = []
        tau_scores = []
        ranks = []
        # range summary has only a few tabs, the full list about 38
        if len(tabs) > 30:
            measurename = tabs[0]
            # score and place in rank alternate....
            for i in range(2, 19, 2):
                rho_scores.append(tabs[i])
                ranks.append(tabs[i+1])
            for i in range(20, len(tabs),2):
                tau_scores.append(tabs[i])
                ranks.append(tabs[i+1])
            score_dict[measurename] = [rho_scores,tau_scores,ranks]
    my_input.close()
    return score_dict


def define_max_scores(sc2, sc3, wn2_gth_wn3_max, wn3_gth_wn2_max):

    for i in range(0, len(sc2)):
        if '-' in sc2[i]:
            sc2_scors = sc2[i].split('-')
        else:
            sc2_scors = [sc2[i]]
        if '-' in sc3[i]:
            sc3_scors = sc3[i].split('-')
        else:
            sc3_scors = [sc3[i]]
        for sc2_str in sc2_scors:
            if sc2_str:
                my_sc2 = float(sc2_str)
                for sc3_str in sc3_scors:
                    if sc3_str:
                        my_sc3 = float(sc3_str)
                        if my_sc2 - my_sc3 > wn2_gth_wn3_max:
                            wn2_gth_wn3_max = my_sc2 - my_sc3
                        elif my_sc3 - my_sc2 > wn3_gth_wn2_max:
                            wn3_gth_wn2_max = my_sc3 - my_sc2
    return [wn2_gth_wn3_max, wn3_gth_wn2_max]

def compare_results_from_wns(wnf1, wnf2):
    wn2_res = create_score_dict_from_file(wnf1)
    wn3_res = create_score_dict_from_file(wnf2)

    wn2_gth_wn3_max_rho = 0.0
    wn3_gth_wn2_max_rho = 0.0
    wn2_gth_wn3_max_tau = 0.0
    wn3_gth_wn2_max_tau = 0.0

    rank_diff = 0
    rank_same = 0

    for k, v in wn2_res.items():
        comp_v = wn3_res[k]
        sc2 = v[0]
        sc3 = comp_v[0]
        wn_scores = define_max_scores(sc2, sc3, wn2_gth_wn3_max_rho, wn3_gth_wn2_max_rho)
        wn2_gth_wn3_max_rho = wn_scores[0]
        wn3_gth_wn2_max_rho = wn_scores[1]
        sc2 = v[1]
        sc3 = comp_v[1]
        wn_scores = define_max_scores(sc2, sc3, wn2_gth_wn3_max_tau, wn3_gth_wn2_max_tau)
        wn2_gth_wn3_max_tau = wn_scores[0]
        wn3_gth_wn2_max_tau = wn_scores[1]


        rk2 = v[2]    
        rk3 = comp_v[2]
        for i in range(0, len(rk2)):
            if rk2[i] == rk3[i]:
                rank_same += 1
            else:
                rank_diff += 1

    print 'WordNet 2.1 > WordNet 3.0 setting. Max Diff rho', wn2_gth_wn3_max_rho
    print 'WordNet 3.0 > WordNet 2.1 setting. Max Diff rho', wn3_gth_wn2_max_rho
    print 'WordNet 2.1 > WordNet 3.0 setting. Max Diff tau', wn2_gth_wn3_max_tau
    print 'WordNet 3.0 > WordNet 2.1 setting. Max Diff tau', wn3_gth_wn2_max_tau
    print 'Different ranking for different WN: ', rank_diff
    print 'Same ranking both WNs', rank_same








def main(argv=None):
    if argv is None:
        argv = sys.argv
    if len(argv) < 3:
        print 'Usage: python retrieve_differences_based-on_versions.py wn2.1_rank_output wn3.0_rank_output'
    else:
        compare_results_from_wns(argv[1], argv[2])


if __name__ == '__main__':
    main()
