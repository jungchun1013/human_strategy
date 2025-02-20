from datetime import datetime
import os
import logging
import argparse
import numpy as np
from random import choice, random, randint
import networkx as nx

from src.utils import setup_experiment_dir, setup_task_args
from src.utils import get_prior_SSUP, calculate_reward
from src.utils import save_strategy_graph, load_strategy_graph
from src.utils import draw_policies
from src.gaussian_policy import initialize_policy
import src.config as config
from copy import deepcopy
from pyGameWorld import ToolPicker
from pyGameWorld.helpers import centroidForPoly
from src.MCTS import StrategyGraphMCTS, StrategyGraphState
from src.MCTS_schema import StrategySchemaMCTS, StrategySchemaState

from src.utils import sample_ext_by_type
from src.utils import draw_path, calculate_reward, draw_samples, draw_ellipse, draw_policies

from src.strategy_v2 import get_obj_type, train_mechanism, MechanismSet, StrategyManager


def estimate_reward(tp, sample_obj, sample_pos, noisy=False):
    ''' estimate reward from PE given sample object and extrinsics 
    
    Args:
        sample_obj (str): object name (obj1, obj2, obj3)
        sample_pos (list): object position (x, y)
        noisy (bool): noisy or deterministic
    Returns:
        path_info (tuple): path information {path_dict, collisions, success}
        reward (float): reward
    '''
    path_dict, collisions, success, _ = tp.runStatePath(
        toolname=sample_obj,
        position=sample_pos,
        noisy=noisy
    )
    path_info = path_dict, collisions, success
    reward = calculate_reward(args, path_dict)
    return path_info, reward


def set_exp_dir(args):
    ''' record timestamp and set experiment directory
    Args:
        args (argparse.Namespace): command line arguments
    '''
    args.experiment_time = datetime.now()
    setup_experiment_dir(args)

def setup_config_before_experiment(args):
    ''' setup config before experiment
    Args:
        args (argparse.Namespace): command line arguments
    '''
    args.trial_dir_name = os.path.join(args.main_dir_name, str(args.trial_count).zfill(3))
    os.makedirs(args.trial_dir_name)
    logger = logging.getLogger()
    if logger.hasHandlers():
        logger.handlers.clear()
    logging.basicConfig(
        filename=os.path.join(args.trial_dir_name, 'output.log'),
        format='%(levelname)s:%(message)s',
        level=logging.INFO
    )
    # add console handler
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    logging.getLogger().addHandler(console_handler)      

    # NOTE - log all args
    for arg in vars(args):
        if not arg[-1] == '0':
            logging.info('%20s %-s', arg, args.__dict__[arg])

def load_args(args):
    ''' load algorithm config
    Args:
        args (argparse.Namespace): command line arguments
    '''
    if args.algorithm in ['SSUP']:
        cfg = config.SSUP_config
    elif args.algorithm in ['GPR', 'GPR_GEN', 'GPR_SSUP', 'GPR_SSUP_GEN']:
        cfg = config.GPR_SSUP_config
    elif args.algorithm in ['GPR_MECH']:
        cfg = config.OURS_config
    else:
        cfg = config.SSUP_config
    
    # load task config
    # args.__dict__['task'] = config.task_config[args.tnm]
    args.__dict__['training_tasks'] = config.task_config[args.tnm]['training']
    args.__dict__['testing_task'] = config.task_config[args.tnm]['testing']
    
    if not args.tsnm:
        args.__dict__['tsnm'] = config.task2series[args.tnm]
        
    args.__dict__['trial_stats'] = []

    if not args.train_tnm:
        # training task is same as testing task
        args.__dict__['train_tnm'] = args.tnm
        
    # load config from src.config
    for c in cfg:
        if c not in args:
            args.__dict__[c] = cfg[c]
    
    # load config from command args
    for arg in vars(args):
        if args.__dict__[arg] is None and arg in cfg:
            args.__dict__[arg] = cfg[arg]
    
    return args

def sample(args, strategy_graph, training_strategy_graphs=None, action=None, method='GPR'):
    ''' sample an action (tool, position) from strategy graph
    Args:
        args (argparse.Namespace): command line arguments
        strategy_graph (StrategyGraph): StrategyManager
        training_strategy_graphs (list): training strategy graphs
        method (str): sampling method (schema or GPR)
    Returns:
        sample_object (str): sample object
        sample_position (list): sample position
    '''
    # FIXME - variable name not consistent
    if method == 'schema':
        sample_object, sample_position = sample_from_schema3(args, strategy_graph, action)
    elif method == 'GPR':
        sample_object, sample_position = sample_from_strategy_graph(args, strategy_graph, training_strategy_graphs)
    return sample_object, sample_position

def match_mechanism(pre_nd, cur_nd, training_strategy_graphs):
    ''' find matched mechanism by object type from training strategy graphs
    Args:
        pre_nd (str): previous node
        cur_nd (str): current node
        training_strategy_graphs (list): training strategy graphs
    Returns:
        mechanism_list (list): mechanism list
    '''
    
    # FIXME - use defined group to catagorize objects
    mechanism_list = []
    obj_group_dict = {
        **dict.fromkeys(['Ball', 'Ball1', 'Ball2', 'CataBall', 'KeyBall'], 'ball'),
        **dict.fromkeys(['Support', 'Catapult', 'Plate', 'PLACED'], 'blue')
    }
    for graph in training_strategy_graphs:
        for edge in graph.edges():
            pre_nd_train, cur_nd_train = edge
            if obj_group_dict[pre_nd] == obj_group_dict[pre_nd_train] and obj_group_dict[cur_nd] == obj_group_dict[cur_nd_train]:
                mechanism_list.append(pre_nd_train, cur_nd_train)
                       
    return choice(mechanism_list)

def sample_from_schema(args, strategy_graph):
    ''' sample an action (tool, position) from schema
    Now we only work on GapCatapult
    Args:
        args (argparse.Namespace): command line arguments
        strategy_graph (StrategyGraph): StrategyManager
    Returns:
        sample_object (str): sample object
        sample_position (list): sample position
    '''
    schema_list = [m for model in strategy_graph.schema.values() for m in model.values()]  # collect nested dict items as list
    schema = choice(schema_list)
    
    graph_list = [g for graph in strategy_graph.strategy_graphs.values() for path, g in graph.items()]
    g = choice(graph_list)
    goal_prev_node = next(nd for nd in g.predecessors("Goal"))
    print((goal_prev_node, "Goal"))
    goal_gpr = g.edges[(goal_prev_node, "Goal")]['model']
    
    placed_succ_node = next(nd for nd in g.successors("PLACED"))
    placed_gpr = g.edges[("PLACED", placed_succ_node)]['model']
    
    goal_pos = centroidForPoly(args.btr0['world']['objects']['Goal']['points'])
    obj_pos = goal_pos
    
    obj_ext =[goal_pos[0], goal_pos[1], 0, 0, 0]
    cur_nd = "Goal"
    prev_target_ext = list(goal_pos) + [0, 0, 0]
    tool_init_pos = args.tp0.objects[goal_prev_node].position
    target_init_pos = goal_pos
    x = [list(obj_ext[2:]) + list(prev_target_ext) + list(tool_init_pos) + list(target_init_pos)]
    

    sample_poss = []
    # FIXME - take possible model from training task
    # pre_nd_train, cur_nd_train = match_mechanism(pre_nd, cur_nd, training_strategy_graphs)
    sample_poss = goal_gpr.sample_y(x, n_samples=10, random_state=None)

    
    if len(sample_poss) == 0: # failed to sample from GPR
        return None, None
    sample_poss = [list(item)
    for sublist in np.transpose(np.array(sample_poss), (0, 2, 1))
    for item in sublist]
    obj_ext = list(np.array(sample_poss).mean(axis=0))
    for s in sample_poss:
        args.sequence_sample_poss.setdefault(cur_nd, []).append([obj_pos[0] + s[0], obj_pos[1] + s[1], s[2], s[3], s[4]])
    obj_pos = [obj_pos[0] + obj_ext[0], obj_pos[1] + obj_ext[1], obj_ext[2], obj_ext[3], obj_ext[4]]
    
    
    
    print(goal_prev_node,'goal', obj_pos)

    cur_nd = goal_prev_node
    obj = args.tp0.objects[cur_nd]
    prev_target_ext = (list(obj.position) + [0] + list(obj.velocity))
    tool_init_pos = args.tp0.objects[placed_succ_node].position
    target_init_pos = args.tp0.objects[goal_prev_node].position
    x = [list(obj_ext[2:]) + list(prev_target_ext) + list(tool_init_pos) + list(target_init_pos)]
    
    

    sample_poss = schema.sample_y(x, n_samples=10, random_state=None)



    if len(sample_poss) == 0: # failed to sample from GPR
        return None, None
    sample_poss = [list(item)
    for sublist in np.transpose(np.array(sample_poss), (0, 2, 1))
    for item in sublist]
    obj_ext = list(np.array(sample_poss).mean(axis=0))
    for s in sample_poss:
        args.sequence_sample_poss.setdefault(cur_nd, []).append([obj_pos[0] + s[0], obj_pos[1] + s[1], s[2], s[3], s[4]])
    obj_pos = [obj_pos[0] + obj_ext[0], obj_pos[1] + obj_ext[1], obj_ext[2], obj_ext[3], obj_ext[4]]
    
    print('schema', obj_pos)
    
    
    
    
    cur_nd = placed_succ_node
    prev_target_ext = None
    target_init_pos = args.tp0.objects[placed_succ_node].position
    x = [obj_ext[2:] + list(target_init_pos)]


    sample_poss = placed_gpr.sample_y(x, n_samples=10, random_state=None)

    if len(sample_poss) == 0: # failed to sample from GPR
        return None, None
    sample_poss = [list(item)
    for sublist in np.transpose(np.array(sample_poss), (0, 2, 1))
    for item in sublist]
    obj_ext = list(np.array(sample_poss).mean(axis=0))
    for s in sample_poss:
        args.sequence_sample_poss.setdefault(cur_nd, []).append([obj_pos[0] + s[0], obj_pos[1] + s[1], s[2], s[3], s[4]])
    obj_pos = [obj_pos[0] + obj_ext[0], obj_pos[1] + obj_ext[1], obj_ext[2], obj_ext[3], obj_ext[4]]
    
    tool = choice(list(args.tp0.toolNames))
    print('placed', obj_pos)
    
    img_name = os.path.join(args.trial_dir_name,
        'schema_seq.png'
    )
    img_poss = [v for v in args.sequence_sample_poss.values()]
    draw_samples(args.tp0, img_poss, '', img_name)
    

    
    return tool, obj_pos

def sample_from_schema2(args, strategy_graph):
    ''' sample an action (tool, position) from schema
    Now we only work on GapCatapult
    Args:
        args (argparse.Namespace): command line arguments
        strategy_graph (StrategyGraph): StrategyManager
    Returns:
        sample_object (str): sample object
        sample_position (list): sample position
    '''
    schema_list = [m for model in strategy_graph.schema.values() for m in model.values()]  # collect nested dict items as list
    schema, graph, object_types = choice(schema_list)
    
    obj_pos = centroidForPoly(args.btr0['world']['objects']['Goal']['points'])
    
    obj_pos_list = []
    cur_nd = "PLACED"
    nd = "PLACED"
    while nd != "Goal":
        nd = next(nd for nd in graph.successors(nd))
        pos = args.tp0.objects[nd].position if nd != "Goal" else centroidForPoly(args.btr0['world']['objects']['Goal']['points'])
        obj_pos_list.extend(list(pos))
        print(nd, get_obj_type(nd))
    print(obj_pos_list)
    
    x = [obj_pos_list]

    sample_poss = schema.sample_y(x, n_samples=10, random_state=None)



    if len(sample_poss) == 0: # failed to sample from GPR
        return None, None
    sample_poss = [list(item)
    for sublist in np.transpose(np.array(sample_poss), (0, 2, 1))
    for item in sublist]
    obj_ext = list(np.array(sample_poss).mean(axis=0))
    for s in sample_poss:
        args.sequence_sample_poss.setdefault(cur_nd, []).append([obj_pos[0] + s[0], obj_pos[1] + s[1]])
    obj_pos = [obj_pos[0] + obj_ext[0], obj_pos[1] + obj_ext[1]]
    
    print('schema sampled pos:', obj_pos)
    
    
    tool = choice(list(args.tp0.toolNames))
    print('placed', obj_pos)
    
    img_name = os.path.join(args.trial_dir_name,
        'schema_seq.png'
    )
    img_poss = [v for v in args.sequence_sample_poss.values()]
    draw_samples(args.tp0, img_poss, '', img_name)
    

    
    return tool, obj_pos

def sample_from_schema3(args, strategy_graph, action):
    ''' sample an action (tool, position) from schema
    Args:
        args (argparse.Namespace): command line arguments
        strategy_graph (StrategyGraph): StrategyManager
    Returns:
        sample_object (str): sample object
        sample_position (list): sample position
    '''
    print(action.edges(data=True))
    
    for act in action.edges():
        # act.schema is edge, act.schema[2] is data
        u, v = act
        task_type, strat_type, sampled_obj = action[u][v]['schema'].split(';')

        schema, graph, object_types = strategy_graph.schema[task_type][strat_type]
        
        
    
    
        obj_pos = centroidForPoly(args.btr0['world']['objects']['Goal']['points'])
        
        obj_pos_list = []
        cur_nd = "PLACED"
        nd = "PLACED"
        while nd != "Goal":
            nd = next(nd for nd in graph.successors(nd))
            pos = args.tp0.objects[nd].position if nd != "Goal" else centroidForPoly(args.btr0['world']['objects']['Goal']['points'])
            obj_pos_list.extend(list(pos))
            print(nd, get_obj_type(nd))
        print(obj_pos_list)
        
        x = [obj_pos_list]

        sample_poss = schema.sample_y(x, n_samples=10, random_state=None)



        if len(sample_poss) == 0: # failed to sample from GPR
            return None, None
        sample_poss = [list(item)
        for sublist in np.transpose(np.array(sample_poss), (0, 2, 1))
        for item in sublist]
        obj_ext = list(np.array(sample_poss).mean(axis=0))
        for s in sample_poss:
            args.sequence_sample_poss.setdefault(cur_nd, []).append([obj_pos[0] + s[0], obj_pos[1] + s[1]])
        obj_pos = [obj_pos[0] + obj_ext[0], obj_pos[1] + obj_ext[1]]
    
    print('schema sampled pos:', obj_pos)
    
    
    tool = choice(list(args.tp0.toolNames))
    print('placed', obj_pos)
    
    img_name = os.path.join(args.trial_dir_name,
        'schema_seq.png'
    )
    img_poss = [v for v in args.sequence_sample_poss.values()]
    draw_samples(args.tp0, img_poss, '', img_name)
    

    
    return tool, obj_pos


def sample_from_strategy_graph(args, strat_graph, idx=0, training_strategy_graphs=None):
    ''' sample an action (tool, position) from gaussian process model in graph

    Args:
        strat_graph (StrategyGraph): strategy graph or action in MCTS
        idx (int): index
    Returns:
        tool (str): tool name
        obj_pos (list): object placement position
    '''
    if isinstance(strat_graph, StrategyManager):
        graph_list = [graph for graph in strat_graph.strategy_graphs.values() for path, graph in graph.items()]
        g = choice(graph_list)
   
    else:
        g = strat_graph
    
    # print("Sampled graph", g.edges())
    cur_nd = 'Goal'
    pre_nd = None
    img_poss = [[],[]]
    goal_pos = centroidForPoly(args.btr0['world']['objects']['Goal']['points'])
    # obj_ext: for sampling
    obj_ext =[goal_pos[0], goal_pos[1], 0, randint(-5, 5), randint(-5 ,5)]
    # for backtracking
    obj_pos = goal_pos
    args.sequence_sample_poss.setdefault(cur_nd, []).append(list(obj_pos))
    # while cur_nd != 'PLACED' or g.predecessors(cur_nd):

    while list(g.predecessors(cur_nd)):
        # relative extrinsics
        pre_nd = choice(list(g.predecessors(cur_nd)))
        if pre_nd != 'PLACED' and cur_nd == 'Goal':
            prev_target_ext = list(goal_pos)
            target_init_pos = goal_pos
            tool_init_pos = args.tp0.objects[pre_nd].position
            x = [prev_target_ext + list(tool_init_pos) + list(target_init_pos)]
        elif pre_nd != 'PLACED' and cur_nd != 'Goal':
            obj = args.tp0.objects[cur_nd]
            # prev_target_ext = (list(obj.position) + [0] + list(obj.velocity))
            # prev_target_ext = list(obj.position)
            prev_target_ext = obj_pos
            target_init_pos = args.tp0.objects[cur_nd].position
            tool_init_pos = args.tp0.objects[pre_nd].position
            x = [prev_target_ext + list(tool_init_pos) + list(target_init_pos)]
        else: # pre_nd == 'PLACED'
            tool_init_pos = None
            prev_target_ext = obj_pos
            target_init_pos = args.tp0.objects[cur_nd].position
            x = [prev_target_ext + list(target_init_pos)]

        # sample_poss = g.edges[(pre_nd, cur_nd)]['model'].sample_y(x, n_samples=10, random_state=None)
        sample_poss = []
        # FIXME - take possible model from training task
        if g.edges[(pre_nd, cur_nd)]['mech'].model:
            sample_poss = g.edges[(pre_nd, cur_nd)]['mech'].model.sample_y(x, n_samples=10, random_state=None)
        if len(sample_poss) == 0: # failed to sample from GPR
            return None, None
        sample_poss = [list(item)
        for sublist in np.transpose(np.array(sample_poss), (0, 2, 1))
        for item in sublist]
        obj_ext = list(np.array(sample_poss).mean(axis=0))
        for s in sample_poss:
            args.sequence_sample_poss.setdefault(cur_nd, []).append([obj_pos[0] + s[0], obj_pos[1] + s[1]])
        obj_pos = [obj_pos[0] + obj_ext[0], obj_pos[1] + obj_ext[1]]
        cur_nd = pre_nd

    img_name = os.path.join(args.trial_dir_name,
        'strat_seq.png'
    )
    img_poss = [v for v in args.sequence_sample_poss.values()]
    draw_samples(args.tp0, img_poss, '', img_name)
    tool = choice(list(args.tp0.toolNames))
    # if cur_nd == 'PLACED' and 'tools' in g.nodes[cur_nd]:
    #     tool = choice(list(g.nodes[cur_nd]['tools']))
    #     print(tool)
    # elif cur_nd == 'PLACED' and 'tools' not in g.nodes[cur_nd]:
    #     tool = choice(list(args.tp0.toolNames))
    # else:
    #     tool = cur_nd
    return tool, obj_pos # only return one sample

def random_tool_testing(args):
    action_count = 0
    sim_count = 0
    success = False
    while action_count < 40:
        sample_obj = choice(args.tool_objects)
        sample_pos = get_prior_SSUP(args.tp0, args.movable_objects)
        path_dict, collisions, success, _ = args.tp0.runStatePath(
            sample_obj,
            sample_pos,
            noisy=args.noisy
        )
        sim_count += 1
        reward = calculate_reward(args, path_dict)
        logging.info('Simlation %d %d: %s (%d, %d), %s %f',
            action_count, sim_count, sample_obj, sample_pos[0], sample_pos[1], success, reward)
        if reward > args.attempt_success_threshold:
            path_dict, collisions, success, _ = args.tp0.runStatePath(
                sample_obj,
                sample_pos
            )
            action_count += 1
            logging.info('Attempt %d %d: %s (%d, %d), %s',
                action_count, sim_count, sample_obj, sample_pos[0], sample_pos[1], success)
            if success:
                logging.info('Success')
                args.trial_stats.append([action_count, sim_count])
                break

#############################################################
#                                                           #
# SSUP functions                                            #
#                                                           #
#############################################################

def initialize_SSUP_policy(policies):
    tp = args.tp0
    get_prior = args.get_prior
    for tool in tp.toolNames:
        rewards = []
        samples = []
        for i in range(args.num_init):
            sample_pos = get_prior(tp, args.movable_objects)
            reward = []
            for j in range(args.num_sim):
                _, r = estimate_reward(
                    tp, tool, sample_pos, noisy=True
                )
                reward.append(r)
            reward = np.mean(reward)
            rewards.append(reward)
            samples.append([sample_pos[0], sample_pos[1], int(tool[3])-1])
        print(samples, rewards)
        for i in range(args.num_init):
            policies.update([samples[i]], [rewards[i]], learning_rate=args.lr)
    logging.info('Policies\n%s', policies)
    return policies

def counterfactual_update(sample, sample_obj, sample_pos, reward, policies):
    tp = args.tp0
    for tool in tp.toolNames:
        cf_sample = [sample[0], sample[1], int(tool[3])-1]
        if tool == sample_obj:
            cf_reward = reward
        else:
            path_dict, _, _, _ = tp.runStatePath(
                toolname=tool,
                position=sample_pos,
                noisy=True
            )
            cf_reward = calculate_reward(args, path_dict)
        policies.update([cf_sample], [cf_reward], learning_rate=args.lr)
    # img_name = os.path.join(args.trial_dir_name,
    #         'plot'+str(args.sim_count)+'.png'
    #     )
    # plot_policies(args, policies, sample_pos, int(sample_obj[3])-1, img_name)
    return policies

def SSUP_testing(args, policies):
    '''Sample, simulate, update policy
    
    Args:
        policies (GaussianPolicies): policy for three tools
    Returns:
        trial_stats (dict): trial stats
    '''
    tp = args.tp0
    get_prior = args.get_prior
    epsilon = args.eps
    action_count = 0
    sim_count = 0
    # Sample ninit points from prior pi(s) for each tool
    # Simulate actions to get noisy rewards rˆ using internal model
    # initialize policy parameters theta using policy gradient on initial points
    policies = initialize_SSUP_policy(policies)

    # plot]
    if not os.path.exists(os.path.join(args.trial_dir_name,'plot')):
        os.makedirs(os.path.join(args.trial_dir_name,'plot'))
    img_name = os.path.join(args.trial_dir_name,'plot/plot_init.png')
    # plot_policies(args, policies, None, 0, img_name)
    draw_policies(tp, policies, img_name)
    sample_poss = []
    success = False
    iter_count = 0
    best_reward = -1
    best_pos = None
    best_obj = None
    while not success:
        # SECTION - Sample action
        acting = False
        sample_type = 'GM'
        if random.random() < epsilon:
            # NOTE - sample from prior
            sample_type = 'prior'
            sample_obj = choice(list(tp.toolNames))
            sample_pos = get_prior(args.tp0, args.movable_objects)
            sample = [sample_pos[0], sample_pos[1], int(sample_obj[3])-1]
            # Estimate noisy reward rˆ from internal model on action a
            path_info, reward = estimate_reward(
                tp, sample_obj, sample_pos, noisy=True
            )
            sim_count += 1
        else:
            # Sample from policy (at most sample 100 times)
            sample = policies.action()
            sample_obj = 'obj'+str(sample[2]+1)
            sample_pos = list(sample[0:2])
            rewards = []
            for _ in range(args.num_sim):
                # Estimate noisy reward rˆ from internal model on action a
                path_info, reward = estimate_reward(
                    tp, sample_obj, sample_pos, noisy=True
                )
                rewards.append(reward)
                sim_count += 1
            reward = np.mean(rewards)
            iter_count += 1
        logging.info('Simulation %d %d: %s %s (%d, %d), %s, %f',
            action_count, sim_count, sample_obj, sample_type,
            sample_pos[0], sample_pos[1], success, reward)
        sample_poss.append([sample_pos, reward])
        # best action
        if reward > best_reward:
            best_reward = reward
            best_pos = sample_pos
            best_obj = sample_obj
        # try_action = reward > args.attempt_success_threshold
        if reward > args.attempt_success_threshold:
            acting = True
        elif iter_count >= args.num_iter:
            acting = True
            reward = best_reward
            sample_pos = best_pos
            sample_obj = best_obj
            # reset
            best_reward = -1
            best_pos = None
            best_obj = None
            iter_count = 0
        # !SECTION
        success = False
        if acting:
            logging.info('Sample %d %d: %s %s (%d, %d), %s, %f',
            action_count, sim_count, sample_obj, sample_type,
            sample_pos[0], sample_pos[1], success, reward)
            # Observe r from environment on action a.
            path_info, reward = estimate_reward(
                tp, sample_obj, sample_pos, noisy=False
            )
            logging.info('Policies\n %s', policies)
            success = path_info[2]
            # epsilon *= args.eps_decay_rate
            action_count += 1
            # If successful, exit.
            logging.info('Attempt %d %d: %s %s (%d, %d), %f',
                action_count, sim_count, sample_obj, sample_type,
                sample_pos[0], sample_pos[1], reward)
            if success:
                logging.info("Success! %d %d", action_count, sim_count)
                img_name = os.path.join(args.trial_dir_name,
                    'plot/plot_final.png'
                )
                # plot_policies(args, policies, sample_pos, int(sample_obj[3])-1, img_name)
                draw_policies(tp, policies, img_name)
                args.trial_stats.append([action_count, sim_count])
                break
            # Simulate rˆ assuming other two tool choices.
            # Update policy based on all three estimates and actions.
            args.sim_count = sim_count
            policies = counterfactual_update(sample, sample_obj, sample_pos, reward, policies)
            img_name = os.path.join(args.trial_dir_name,
                'plot/plot_'+str(action_count)+'.png'
            )
            # plot_policies(args, policies, sample_pos, int(sample_obj[3])-1, img_name)
            draw_policies(tp, policies, img_name)
        else:
            # Update policy using policy gradient
            policies.update([sample], [reward], learning_rate=args.lr)

        if action_count >= args.max_attempts or sim_count >= args.max_simulations:
            logging.info("Out of max attempt! %d %d", action_count, sim_count)
            args.trial_stats.setdefault('SSUP', []).append([action_count, sim_count])
            break
    sample_pos = [sample_pos[0], sample_pos[1], 0, 0, 0]
    return sample_obj, sample_pos, path_info


def GPR_sample_testing(args, strategy_graph):
    setup_task_args(args, args.tnm)
    info = []
    for i in range(100):
        sample_object, sample_position = sample(args, strategy_graph)
        path_info, reward = estimate_reward(args.tp0, sample_object, sample_position, noisy=False)

def schema_testing(args, strategy_graph):
    setup_task_args(args, args.testing_task)
    info = []
    for i in range(1):
        sample_object, sample_position = sample(args, strategy_graph, method='schema')
        path_info, reward = estimate_reward(args.tp0, sample_object, sample_position, noisy=False)
        print(sample_object, sample_position, reward)

def build_Strategy_MCTS(args, strategy_graph, num_sim=100):
    strategy_MCTS = StrategyGraphMCTS(10, args, strategy_graph)
    StrategyGraphState.set_mechanisms(strategy_graph.mechanism_set)
    for i in range(num_sim):
        action, node = strategy_MCTS.sample()
        sample_object, sample_position = sample(args, strategy_graph, action=action)
        path_info, reward = estimate_reward(args.tp0, sample_object, sample_position, noisy=False)
        strategy_MCTS.update_reward(node, reward)
        print(list(action.edges())[::-1], sample_object, int(sample_position[0]), int(sample_position[1]), reward)
        strategy_MCTS.print_simple_graph()

    strategy_MCTS.print_graph()
    return strategy_MCTS

def build_Strategy_schema_MCTS(args, strategy_graph, num_sim=20):
    strategy_MCTS = StrategySchemaMCTS(10, args, strategy_graph)
    StrategySchemaState.set_schema(strategy_graph.schema)
    for i in range(num_sim):
        action, node = strategy_MCTS.sample()
        sample_object, sample_position = sample(args, strategy_graph, action=action, method="schema")
        path_info, reward = estimate_reward(args.tp0, sample_object, sample_position, noisy=False)
        strategy_MCTS.update_reward(node, reward)
        print(list(action.edges())[::-1], sample_object, int(sample_position[0]), int(sample_position[1]), reward)
        strategy_MCTS.print_simple_graph()

    strategy_MCTS.print_graph()
    return strategy_MCTS

def GPR_MCTS_testing(args, strategy_graph):
    tnm = args.testing_task
    setup_task_args(args, tnm)
    strategy_MCTS = build_Strategy_MCTS(args, strategy_graph, num_sim=50)
    
    # FIXED - UCB implemented in MCTS update() and estimate_value()
    action, node = strategy_MCTS.sample()
    sample_object, sample_position = sample(args, action)
    gaussian_policies = initialize_policy(sample_position[0], sample_position[1], 50)
    sample_obj, sample_pos, path_info = SSUP_testing(args,gaussian_policies)

def schema_MCTS_testing(args, strategy_graph):
    tnm = args.testing_task
    setup_task_args(args, tnm)
    strategy_schema_MCTS = build_Strategy_schema_MCTS(args, strategy_graph, num_sim=20)
    
    # FIXED - UCB implemented in MCTS update() and estimate_value()
    action, node = strategy_schema_MCTS.sample()
    sample_object, sample_position = sample(args, strategy_graph, action=action, method='schema')
    gaussian_policies = initialize_policy(sample_position[0], sample_position[1], 50)
    sample_obj, sample_pos, path_info = SSUP_testing(args,gaussian_policies)
def GPR_SSUP_testing(args, strategy_graph):
    # tnm = args.tnm
    tnm = args.testing_task
    setup_task_args(args, tnm)

    sample_object, sample_position = sample(args, strategy_graph)
    print("sampled_action:", sample_object, sample_position)
    gaussian_policies = initialize_policy(sample_position[0], sample_position[1], 50)
    sample_obj, sample_pos, path_info = SSUP_testing(args,gaussian_policies)


def build_strategy_graph(task_series, strategy_graph, start_tool = 'PLACED'):
    sim_count = 0
    img_name = os.path.join(args.trial_dir_name,
        'collision.png'
    )
    while sim_count < args.num_demos: # loop based on number of sim in PE
        args.btr = deepcopy(args.btr0)
        args.tp = ToolPicker(args.btr0)
        success = False
        # SECTION - sample from noisy PE
        while not success:
            if start_tool != 'PLACED':
                sample_type = 'CF'
                sample_objs = [start_tool]
            else:
                sample_type = 'tool'
                sample_objs = None
            sample_obj, sample_ext, ext_info, path_info = sample_ext_by_type(
                    args,
                    sample_type,
                    strategy_graph,
                    sample_objs = sample_objs
                )
            path_dict, collisions, success = path_info

            if success:
                args.sim_count = sim_count
                graph = strategy_graph.build_path(args, task_series, sample_obj, sample_ext, path_info)
                # FIXME - all result should count
                # if graph:
                sim_count += 1
               
    
        # !SECTION
    return strategy_graph


def gaussian_program_learning(args):
    strategy_graphs = []
    tasks = args.training_tasks
    start_tool = config.task_config[args.tsnm]['start_tool']
    strategy_graph = None
    if args.train:
        strategy_graph = StrategyManager(args)
        for tnm in tasks:
            logging.info('Generalize: Training task %s', tnm)
            setup_task_args(args, tnm)
            start_tool = config.task_config[config.task2series[tnm]]['start_tool']
            strategy_graph = build_strategy_graph(config.task2series[tnm], strategy_graph=strategy_graph, start_tool=start_tool)
            strategy_graph.merge_path_info(args)
        strategy_graph.build_mechanisms(args)
        file_path = os.path.join('data/strategy', 'strat_'+args.tnm+'.pkl')
        save_strategy_graph(strategy_graph, file_path)
    else:
        setup_task_args(args, args.testing_task)
        file_path = os.path.join('data/strategy', 'strat_'+args.tnm+'.pkl')
        strategy_graph = load_strategy_graph(None, file_path)
        strategy_graph.build_mechanisms(args)
        
    print("Strategy Graph Parameters")
    print(strategy_graph)
    return strategy_graph


def schema_learning(args):
    strategy_graphs = []
    tasks = args.training_tasks
    start_tool = config.task_config[args.tsnm]['start_tool']
    strategy_graph = None
    if args.train:
        strategy_graph = StrategyManager(args)
        for tnm in tasks:
            logging.info('Generalize: Training task %s', tnm)
            setup_task_args(args, tnm)
            start_tool = config.task_config[config.task2series[tnm]]['start_tool']
            strategy_graph = build_strategy_graph(config.task2series[tnm], strategy_graph=strategy_graph, start_tool=start_tool)
            strategy_graph.merge_path_info(args)
        # NOTE - learn schema
        file_path = os.path.join('data/strategy', 'strat_'+args.algorithm+'_'+args.tnm+'.pkl')
        save_strategy_graph(strategy_graph, file_path)
        strategy_graph.build_mechanisms(args)
        strategy_graph.build_schema(args)
        strategy_graph.build_forward_schema(args)
    else:
        setup_task_args(args, args.testing_task)
        file_path = os.path.join('data/strategy', 'strat_'+args.algorithm+'_'+args.tnm+'.pkl')
        strategy_graph = load_strategy_graph(None, file_path)
        strategy_graph.build_mechanisms(args)
        strategy_graph.build_schema(args)
        strategy_graph.build_forward_schema(args)
        
    print("Strategy Graph Parameters")
    print(strategy_graph)
    return strategy_graph


def run_algorithm(args):
    # NOTE - training stage
    if args.algorithm == 'random':
        pass
    elif args.algorithm == 'SSUP':
        pass
    elif args.algorithm == 'GPR':
        strategy_graph = gaussian_program_learning(args)
    elif args.algorithm == 'ours':
        strategy_graph = schema_learning(args)

    # Testing stage
    if args.algorithm == 'random':
        random_tool_testing(args)
    elif args.algorithm == 'SSUP':
        setup_task_args(args)
        gaussian_policies = initialize_policy(300, 300, 50)
        SSUP_testing(args, gaussian_policies)
    elif args.algorithm == 'GPR':
        if args.SSUP:
            if args.MCTS:
                GPR_MCTS_testing(args, strategy_graph)
            else:
                GPR_SSUP_testing(args, strategy_graph)
        else:
            sample_poss = []
            # NOTE - only test sample 30 times without update
            for i in range(100):
                sample_object, sample_position = sample(args, strategy_graph)
                path_info, reward = estimate_reward(args.tp0, sample_object, sample_position, noisy=False)
                sample_poss.append([sample_position[0:2]])
                print(sample_object, sample_position, reward)
    elif args.algorithm == 'ours':
        if args.MCTS:
            schema_MCTS_testing(args, strategy_graph)
        else:
            schema_testing(args, strategy_graph)
    
def main(args):
    set_exp_dir(args)
    for trial_count in range(args.num_trials):
        args.trial_count = trial_count
        setup_config_before_experiment(args)
        run_algorithm(args)    
    

# SECTION - main program
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Run SSUP')
    parser.add_argument('-a', '--algorithm',
                        help='SSUP/ours', default='SSUP')
    parser.add_argument('-t', '--num-trials',
                        help='number of trials', type=int, default=10)
    parser.add_argument('--num-demos',
                        help='number of demos for training', type=int, default=10)
    # parser.add_argument('--num-experiments',
    #                     help='number of experiments', type=int, default=10)
    parser.add_argument('--tnm',
                        help='task name for testing performance', type=str, default='CatapultAlt')
    parser.add_argument('--train-tnm',
                        help='task name for train', type=str, default=None)
    parser.add_argument('--tsnm',
                        help='task series name', type=str, default=None)
    parser.add_argument('--json_dir',
                        help='json dir name', type=str,
                        default='./environment/Trials/Strategy/')
    parser.add_argument('--SSUP',
                        help='use SSUP for testing else only sampling', action='store_true')
    parser.add_argument('-u', '--update',
                        help='use SSUP for testing else only sampling', action='store_true')
    parser.add_argument('--MCTS',
                        help='use SSUP for testing else only sampling', action='store_true')
    parser.add_argument('--train',
                        help='use SSUP for testing else only sampling', action='store_true')
    parser.add_argument('-v', '--verbose',
                        help='Increase output verbosity', action='store_true')
    parser.add_argument('--eps',
                        help='epsilon', type=float, default=None)
    parser.add_argument('--eps-decay-rate',
                        help='epsilon decay rate', type=int, default=None)
    parser.add_argument('--lr',
                        help='learning rate', type=float, default=None)
    parser.add_argument('--max-attempts',
                        help='max number of attempt', type=int, default=None)
    parser.add_argument('--attempt-threshold',
                        help='attempt threshold', type=float, default=None)
    parser.add_argument('-d', '--deterministic',
                        help='whether deterministic or noisy in collecting data',
                        action='store_true')
    parser.add_argument('--strategy-type',
                        help='strategy type', type=str, default='list')
    # parse args and update config
    args = parser.parse_args()
    args = load_args(args)
    
    import random
    import numpy as np

    # Set seed for reproducibility
    # seed_value = 42  # You can change this value for different seeds
    # random.seed(seed_value)
    # np.random.seed(seed_value)
    main(args)
    
# !SECTION - main program
    
