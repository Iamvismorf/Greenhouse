// todo: pos and better error messages
#include <nix/expr/counter.hh>
#include <nix/expr/eval.hh>
#include <nix/expr/primops.hh>
#include <nix/util/util.hh>

using namespace nix;

namespace fs = std::filesystem;
namespace ranges = std::ranges;

static void listNixFilesRecursive(EvalState &state, const PosIdx pos,
                                  Value **args, Value &ret) {
  Value *passedAttrs = args[0];
  state.forceAttrs(*passedAttrs, noPos,
                   "while evaluating the first argument passed to "
                   "builtins.listNixFilesRecursive");

  const Attr *dirsAttr = state.getAttr(
      state.symbols.create("dirs"), passedAttrs->attrs(),
      "in the attrset passed as argument to builtins.listNixFilesRecursive");
  state.forceList(*dirsAttr->value, noPos, "while evaluating dirs attribute");
  for (const auto &[i, dir] : enumerate(dirsAttr->value->listView())) {
    state.forceValue(*dir, noPos);
    if (dir->type() != nPath) {
      state
          .error<TypeError>("expected a path but found %s at index %s",
                            showType(*dir), i)
          .debugThrow();
    }
  }

  std::vector<Value *> excludePrefixedWith;
  if (const Attr *attr = passedAttrs->attrs()->get(
          state.symbols.create("excludePrefixedWith"))) {
    state.forceList(*attr->value, noPos,
                    "while evaluating excludePrefixedWith attribute");
    for (Value *e : attr->value->listView()) {
      state.forceStringNoCtx(*e, noPos,
                             "while evaluating excludePrefixedWith attribute");
      excludePrefixedWith.push_back(e);
    }
  } else {
    Value *defaultPrefix = state.allocValue();
    defaultPrefix->mkString("_", state.mem);
    excludePrefixedWith.push_back(defaultPrefix);
  }

  // no guard needed because we force path
  std::vector<Value *> out;
  for (Value *dir : dirsAttr->value->listView()) {
    for (auto it = fs::recursive_directory_iterator(dir->pathStrView());
         it != fs::recursive_directory_iterator(); ++it) {

      auto filepath = it->path();
      if (it->is_regular_file() &&
          (filepath.extension() != ".nix" || it->file_size() == 0))
        continue;

      bool excluded =
          ranges::any_of(excludePrefixedWith, [&filepath](const Value *i) {
            return filepath.filename().string().starts_with(i->string_view());
          });
      if (excluded) {
        it.disable_recursion_pending();
        continue;
      }

      if (it->is_regular_file()) {
        Value *e = state.allocValue();
        e->mkPath(state.rootPath(CanonPath(filepath.string())), state.mem);
        out.push_back(e);
      }
    }
  }

  auto outList = state.buildList(out.size());
  for (const auto &[n, i] : enumerate(out)) {
    outList[n] = i;
  }
  ret.mkList(outList);
}

static RegisterPrimOp rp({.name = "__listNixFilesRecursive",
                          .args = {"attrs"},
                          .impl = &listNixFilesRecursive});
