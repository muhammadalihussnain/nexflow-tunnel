#include <iostream>
#include <string>

#ifdef NEXFLOW_VERSION_STRING
#define VERSION NEXFLOW_VERSION_STRING
#else
#define VERSION "1.0.0"
#endif

int main(int argc, char* argv[]) {
    if (argc > 1 && std::string(argv[1]) == "--version") {
        std::cout << "nexflow-tunnel data plane version " << VERSION << std::endl;
        return 0;
    }
    
    std::cout << "nexflow-tunnel data plane started" << std::endl;
    return 0;
}
