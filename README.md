# ob-js-node-eval

Evaluate JavaScript snippets in Org Babel directly with Node.js, without any wrappers like the official implementation.

``` org
#+begin_src js :results node-eval :module esm
console.log('hello, world!')
#+end_src
```

The `:module` argument is optional if the script can be auto-detected as ESM (currently, detection only checks for the presence of `import` in the code. Handling top-level `await` would require more complex methods, which are not practical for such a small helper. Therefore, you must specify it explicitly with the `:module` argument if needed).

## Installation

Add `ob-js-node-eval.el` to your `load-path`, or use a package manager like `use-package`:

```elisp
(use-package ob-js-node-eval
  :vc (:url "https://github.com/cxa/ob-js-node-eval"))
```
