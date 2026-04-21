#include <chrono>
#include <ctime>
#include <iomanip>
#include <iostream>

namespace nexflow {

void log_message(const std::string& level, const std::string& message) {
    auto now    = std::chrono::system_clock::now();
    auto time_t = std::chrono::system_clock::to_time_t(now);
    std::cout << "[" << std::put_time(std::localtime(&time_t), "%Y-%m-%d %H:%M:%S") << "] ["
              << level << "] " << message << std::endl;
}

}  // namespace nexflow
