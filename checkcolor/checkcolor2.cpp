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
  unsigned int quest_num;
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

  std::cout << "答えは以下になります．" << loop_cnt << "回目で成功しました．"
            << std::endl;

  // output file
  for (size_t i = 0; i < n_nodes; i++) {
    std::cout << nodes[i] << std::endl;
    f_out << nodes[i] << std::endl;
  }

  return 0;
}
