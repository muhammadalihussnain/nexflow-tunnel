#ifndef NEXFLOW_LOGGING_H
#define NEXFLOW_LOGGING_H

#include <string>

namespace nexflow {
void log_message(const std::string& level, const std::string& message);
}

#define LOG_INFO(msg) nexflow::log_message("INFO", msg)
#define LOG_ERROR(msg) nexflow::log_message("ERROR", msg)
#define LOG_DEBUG(msg) nexflow::log_message("DEBUG", msg)

#endif
