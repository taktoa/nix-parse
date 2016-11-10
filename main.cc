#include <sstream>

#include <nix/globals.hh>
#include <nix/shared.hh>
#include <nix/eval.hh>
#include <nix/eval-inline.hh>
#include <nix/get-drvs.hh>
#include <nix/attr-path.hh>
#include <nix/value-to-xml.hh>
#include <nix/value-to-json.hh>
#include <nix/util.hh>
#include <nix/store-api.hh>
#include <nix/common-opts.hh>
#include <nix/misc.hh>

#include <map>
#include <iostream>

using namespace nix;

static Path gcRoot;

template <typename T>
int parse_files(std::vector<const char*> args, const T& callback) {
    initNix();
    initGC();
    settings.readOnlyMode = true;
    store = openStore();

    Strings files;
    Strings searchPath;
    Strings attrPaths;
    attrPaths.push_back("");

    for(const char* arg : args) { files.push_back(arg); }

    EvalState state(searchPath);
    state.repair = false;

    for (auto& i : files) {
        try {
            Path p = resolveExprPath(lookupFileArg(state, i));
            callback(state.parseExprFromFile(p));
        } catch(...) {
            printf("error occurred\n");
        }
    }

    return 0;
}


int main(int argc, char** argv) {
    std::vector<const char*> args { argv + 1, argv + argc };

    if (args.empty()) {
        args.push_back("./default.nix");
    }

    parse_files(args, [](nix::Expr* e) {
            printf("DEBUG: %p\n", e);
            // std::cout << format("%1%\n") % *e;
        });
}
