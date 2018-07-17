#include <fstream>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <sstream>
#include <vector>

unsigned int genrand() {
  static unsigned int x = 5;
  x ^= x << 13;
  x ^= x >> 17;
  x ^= x << 5;
  return x;
}

int main(int argc, char const* argv[]) {
  // Input question number
  std::cout << "解く問題の番号を入力してください（1〜9）" << std::endl;
  std::string quest_num;
  std::cin >> quest_num;

  // Open question file
  std::stringstream quest_ss;
  quest_ss << "input/Q" << quest_num << ".txt";
  std::ifstream f_in(quest_ss.str());
  if (f_in.fail()) {
    std::cerr << "ファイルを開けません\n";
    exit(1);
  }

  // Output file
  std::ofstream f_out("answer.txt");

  // Read first line
  size_t n_nodes, n_edges;
  f_in >> n_nodes >> n_edges;

  // Read from the second row
  std::vector<unsigned int> nodes(n_nodes);
  std::vector<std::pair<size_t, size_t>> edges(n_edges);
  for (size_t i = 0; i < n_edges; i++) {
    f_in >> edges[i].first >> edges[i].second;
  }

  // Solve
#if 0
  // Base algorithm
  unsigned int loop_cnt = 0;
  while (true) {
    loop_cnt++;
    bool valid_pattern = true;
    for (size_t i_node = 0; i_node < n_nodes; i_node++) {

      for (int try_cnt = 0; try_cnt < 10; try_cnt++) {
        nodes[i_node] = genrand() & 3;

        // Check for each edge
        valid_pattern = true;
        for (auto&& edge: edges) {
          // Consider only current node
          if (edge.first != i_node && edge.second != i_node) {
            continue;
          }
          // Ignore edge for later node
          if (i_node < edge.first || i_node < edge.second) {
            continue;
          }
          // Check color validness
          if (nodes[edge.first] == nodes[edge.second]) {
            valid_pattern = false;
            // break;
          }
        }
        if (valid_pattern) {
          break;
        }
      }

      if (!valid_pattern) {
        break;  // Go to the first
      }
    }
    if (valid_pattern) {
      break;  // found
    }

    // Search from the first again...
  }
#elif 1
  // Flatten algorithm
  uint32_t loop_cnt;
  uint32_t n_nodes_l, n_edges_l;
  uint32_t cond1, cond2;
  uint32_t edge1, edge2;
  uint32_t edge_cnt;
  uint32_t node_cnt;
  uint32_t node_try_cnt;
  uint32_t valid_color;
  uint32_t n_node_try;

  loop_cnt = 0;
  n_nodes_l = n_nodes;
  n_edges_l = n_edges;
  n_node_try = 10;
first: loop_cnt++;  // (debug)
  node_cnt = -1;
node_loop: node_cnt = node_cnt + 1;
  if (node_cnt == n_nodes_l) goto node_loop_post;
  node_try_cnt = 0;  // Decide one node color
node_try_loop: cond1 = genrand();
  cond1 = cond1 & 3;
  nodes[node_cnt] = cond1;
  valid_color = 1;  // Check for each edge
  edge_cnt = -1;
edge_loop: edge_cnt = edge_cnt + 1;
  if (edge_cnt == n_edges_l) goto edge_loop_post;
  edge1 = edges[edge_cnt].first;
  edge2 = edges[edge_cnt].second;
  cond1 = edge1 - node_cnt;  // Consider only current node
  cond2 = edge2 - node_cnt;
  cond1 = cond1 & cond2;
  if (cond1 != 0) goto edge_loop;
  cond1 = node_cnt < edge1;  // Ignore edge for later node
  cond2 = node_cnt < edge2;
  cond1 = cond1 | cond2;
  if (cond1 != 0) goto edge_loop;
  cond1 = nodes[edge1];  // Check color validness
  cond2 = nodes[edge2];
  cond1 = cond1 - cond2;
  if (cond1 != 0) goto edge_loop;
  valid_color = 0;
  goto edge_loop;
edge_loop_post: node_try_cnt++;
  cond1 = (n_node_try - node_try_cnt);
  cond1 = !cond1 & !valid_color;
  if (cond1 != 0) goto first; // Search from the first again...
  if (valid_color == 0) goto node_try_loop;
  goto node_loop;
node_loop_post:

#else

#endif

  std::cout << "答えは以下になります．" << loop_cnt << "回目で成功しました．"
            << std::endl;

  // output file
  for (size_t i = 0; i < n_nodes; i++) {
    std::cout << nodes[i] << std::endl;
    f_out << nodes[i] << std::endl;
  }

  return 0;
}
