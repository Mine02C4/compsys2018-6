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
#elif 0
  unsigned int loop_cnt = 0;

  // Flatten algorithm
  bool cond1, cond2;
  size_t edge1, edge2;
  int edge_cnt = -1;
  int node_cnt = -1;
  size_t node_try_cnt = 0;
  bool valid_color = true;
first:
  loop_cnt++;  // (debug)
  node_cnt = -1;

node_loop:
  node_cnt++;
  if (node_cnt == n_nodes) goto node_loop_post;

  // Decide one node color
  node_try_cnt = 0;
node_try_loop:
  nodes[node_cnt] = genrand() & 3;

  // Check for each edge
  valid_color = true;
  edge_cnt = -1;
edge_loop:
  edge_cnt++;
  if (edge_cnt == n_edges) goto edge_loop_post;
  edge1 = edges[edge_cnt].first;
  edge2 = edges[edge_cnt].second;

  // Consider only current node
  cond1 = edge1 != node_cnt;
  cond2 = edge2 != node_cnt;
  cond1 = cond1 & cond2;
  if (cond1) goto edge_loop;
  // Ignore edge for later node
  cond1 = node_cnt < edge1;
  cond2 = node_cnt < edge2;
  cond1 = cond1 | cond2;
  if (cond1) goto edge_loop;
  // Check color validness
  cond1 = (nodes[edge1] == nodes[edge2]);
  if (!cond1) goto edge_loop;
  valid_color = false;
  goto edge_loop;

edge_loop_post:
  node_try_cnt++;
  cond1 = (node_try_cnt == 10);
  cond2 = !valid_color;
  cond1 = cond1 & cond2;
  if (cond1) goto first; // Search from the first again...
  if (cond2) goto node_try_loop;
  goto node_loop;

node_loop_post:

#else
  unsigned int loop_cnt = 0;

  // Renamed algorithm
  uint32_t reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10,
           reg11;
  reg0 = 0;

  reg1 = n_nodes;
  reg2 = n_edges;
  reg11 = 10;  // node try count
first:
  loop_cnt++;  // (debug)
  reg8 = -1;
node_loop:
  reg8++;
  if (reg8 == reg1) goto node_loop_post;
  // Decide one node color
  reg9 = 0;
node_try_loop:
  reg3 = genrand();
  reg3 = reg3 & 3;
  nodes[reg8] = reg3;
  // Check for each edge
  reg10 = 1;
  reg7 = -1;
edge_loop:
  reg7++;
  if (reg7 == reg2) goto edge_loop_post;
  reg5 = edges[reg7].first;
  reg6 = edges[reg7].second;
  // Consider only current node
  reg3 = reg5 - reg8;
  reg4 = reg6 - reg8;
  reg3 = reg3 & reg4;
  if (reg3) goto edge_loop;
  // Ignore edge for later node
  reg3 = reg8 < reg5;
  reg4 = reg8 < reg6;
  reg3 = reg3 | reg4;
  if (reg3) goto edge_loop;
  // Check color validness
  reg3 = nodes[reg5];
  reg4 = nodes[reg6];
  if (reg3 != reg4) goto edge_loop;
  reg10 = 0;
  goto edge_loop;
edge_loop_post:
  reg9++;
  reg3 = (reg9 - reg11);
  reg3 = !reg3 & !reg10;
  if (reg3) goto first; // Search from the first again...
  if (!reg10) goto node_try_loop;
  goto node_loop;

node_loop_post:


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
